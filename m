Received: from eggs.gnu.org ([2001:4830:134:3::10]:36221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eH2yQ-0001ki-6O
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 02:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eH2yN-0000D8-0R
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 02:28:02 -0500
References: <20171120071423.11693-1-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9da2b91f-215d-654f-a05b-76a0f898e6a7@redhat.com>
Date: Tue, 21 Nov 2017 08:27:51 +0100
MIME-Version: 1.0
In-Reply-To: <20171120071423.11693-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: Implement bug in
 spapr-vty device to be compatible with PowerVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, lvivier@redhat.com, paulus@samba.org, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 20.11.2017 08:14, David Gibson wrote:
> The spapr-vty device implements the PAPR defined virtual console,
> which is also implemented by IBM's proprietary PowerVM hypervisor.
>=20
> PowerVM's implementation has a bug where it inserts an extra \0 after
> every \r going to the guest.  Because of that Linux's guest side
> driver has a workaround which strips \0 characters that appear
> immediately after a \r.

Ouch.

I wonder whether it would make more sense to change the guest side
driver to apply the workaround only if it's really running under
PowerVM...? E.g. what if the PowerVM bug ever gets fixed one day?

> That means that when running under qemu, sending a binary stream from
> host to guest via spapr-vty which happens to include a \r\0 sequence
> will get corrupted by that workaround.
>=20
> To deal with that, this patch duplicates PowerVM's bug, inserting an
> extra \0 after each \r.  Ugly, but the best option available.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/char/spapr_vty.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
> index 0fa416ca6b..a95e5e91a7 100644
> --- a/hw/char/spapr_vty.c
> +++ b/hw/char/spapr_vty.c
> @@ -58,6 +58,24 @@ static int vty_getchars(VIOsPAPRDevice *sdev, uint8_=
t *buf, int max)
> =20
>      while ((n < max) && (dev->out !=3D dev->in)) {
>          buf[n++] =3D dev->buf[dev->out++ % VTERM_BUFSIZE];
> +
> +        /* PowerVM's vty implementation has a bug where it inserts a
> +         * \0 after every \r going to the guest.  Existing guests have
> +         * a workaround for this which removes every \0 immediately
> +         * following a \r, so here we make ourselves bug-for-bug
> +         * compatible, so that the guest won't drop a real \0-after-\r
> +         * that happens to occur in a binary stream. */
> +        if (buf[n-1] =3D=3D '\r') {
> +            if (n < max) {
> +                buf[n++] =3D '\0';
> +            } else {
> +                /* No room for the extra \0, roll back and try again
> +                 * next time */
> +                dev->out--;
> +                n--;
> +                break;
> +            }
> +        }
>      }
> =20
>      qemu_chr_fe_accept_input(&dev->chardev);
>=20

Code looks fine to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
