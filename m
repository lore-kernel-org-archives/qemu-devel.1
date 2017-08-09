Received: from eggs.gnu.org ([2001:4830:134:3::10]:35174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfNO7-00060d-DH
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfNO6-0005Ib-AH
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:34:51 -0400
Date: Wed, 9 Aug 2017 10:34:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170809093442.GE18003@stefanha-x1.localdomain>
References: <20170808175711.12203-1-jsnow@redhat.com>
	<20170808175711.12203-2-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
In-Reply-To: <20170808175711.12203-2-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/4] IDE: Do not flush empty
 CDROM drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 01:57:08PM -0400, John Snow wrote:
> The block backend changed in a way that flushing empty CDROM drives
> is now an error. Amend IDE to avoid doing so until the root problem
> can be addressed for 2.11.
>=20
> Reported-by: Kieron Shorrock <kshorrock@paloaltonetworks.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 0b48b64..6cbca43 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -1053,17 +1053,21 @@ static void ide_flush_cb(void *opaque, int ret)
>      ide_set_irq(s->bus);
>  }
> =20
> -static void ide_flush_cache(IDEState *s)
> +static bool ide_flush_cache(IDEState *s)

Previously this function invoked ide_flush_cb() to complete the request
and raise an IRQ.  Now it may return true instead of invoking
ide_flush_cb().  It's no longer a helper function, it's more like an IDE
command handler.

cmd_set_features() must be updated:

  case 0x82: /* write cache disable */
      blk_set_enable_write_cache(s->blk, false);
      identify_data =3D (uint16_t *)s->identify_data;
      put_le16(identify_data + 85, (1 << 14) | 1);
      ide_flush_cache(s);
      return false;  <--- should be "return ide_flush_cache(s)"

To make the code clearer I suggest deleting ide_flush_cache() and
calling cmd_flush_cache() directly instead.  That way it's obvious that
this is an IDE command handler and it may return true to indicate the
the command completed immediately.

>  {
>      if (s->blk =3D=3D NULL) {
>          ide_flush_cb(s, 0);
> -        return;
> +        return false;
> +    } else if (!blk_bs(s->blk)) {
> +        /* Nothing to flush */

Please move information from the commit description into this comment if
you respin.  Someone looking at the code might think this is a nop that
is safe to remove.  Once blk_*() is fixed this code path can be removed
again.

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZitcyAAoJEJykq7OBq3PIx+EH/1EsgI878hOF0r73YpR/ZQ7e
d3baztms9tjWINvGa5eoC/nHgzQKppvzvTl14sIrEd1C+9BPgyhcb8qxD8BPa3yc
dYBHOIwII3ENdD2rJmoPhHeeW95I3PfQQMIbhiHzjU387qp6699PzAAQuNuVjbfe
/DvP03ct8M3ARolokz2u9XuOXsGDQNK6jI/KNFctBGTyJLGfYcJfAAqGCqDnKXED
07JVpIItpMdVX05Yz7dxBQewYW4YdYAZOn5mnaKG+tzSD3R02hLdNQsySRUVuuOm
tSsbivkH4Qclz+mz2STK7SB3iWIa/jfhpum+h2SF72u2FRI+gi89PnV8NF1QTyI=
=/6z0
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
