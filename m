Received: from eggs.gnu.org ([2001:4830:134:3::10]:54606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cWmm6-000548-8c
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cWmm3-0004sO-42
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:19:50 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:33438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1cWmm2-0004rq-TN
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:19:47 -0500
Received: by mail-wj0-x242.google.com with SMTP id un2so5074659wjb.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 08:19:45 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <20170126101010.6375-1-pbonzini@redhat.com>
Date: Thu, 26 Jan 2017 18:19:41 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <46591E43-32ED-4CC0-8AF9-2D7A42402C22@daynix.com>
References: <20170126101010.6375-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] net: e1000e: fix dead code in
 e1000e_write_packet_to_guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

Good catch!

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>

> On 26 Jan 2017, at 12:10 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> Because is_first is declared inside a loop, it is always true.  The =
store
> is dead, and so is the "else" branch of "if (is_first)".  is_last is
> okay though.
>=20
> Reported by Coverity.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> hw/net/e1000e_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 2b11499..c99e2fb 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -1507,6 +1507,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
struct NetRxPkt *pkt,
>     const E1000E_RingInfo *rxi;
>     size_t ps_hdr_len =3D 0;
>     bool do_ps =3D e1000e_do_ps(core, pkt, &ps_hdr_len);
> +    bool is_first =3D true;
>=20
>     rxi =3D rxr->i;
>=20
> @@ -1514,7 +1515,6 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
struct NetRxPkt *pkt,
>         hwaddr ba[MAX_PS_BUFFERS];
>         e1000e_ba_state bastate =3D { { 0 } };
>         bool is_last =3D false;
> -        bool is_first =3D true;
>=20
>         desc_size =3D total_size - desc_offset;
>=20
> --=20
> 2.9.3
>=20
