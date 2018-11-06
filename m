Received: from eggs.gnu.org ([2001:4830:134:3::10]:55443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJr4n-000137-Cz
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 21:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJqvC-0001j5-L3
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 21:16:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gJqvA-0001U3-NK
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 21:16:49 -0500
References: <20181029173437.32559-1-pbonzini@redhat.com>
	<20181029173437.32559-4-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <341d56df-d0f4-1730-57a9-89ebb02e5ec9@redhat.com>
Date: Tue, 6 Nov 2018 03:16:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181029173437.32559-4-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rov58XHRo05Q2ppvhrWjGesllKB6P0Glo"
Subject: Re: [Qemu-devel] [PATCH 3/4] scsi-generic: avoid invalid access to
 struct when emulating block limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rov58XHRo05Q2ppvhrWjGesllKB6P0Glo
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <341d56df-d0f4-1730-57a9-89ebb02e5ec9@redhat.com>
Subject: Re: [PATCH 3/4] scsi-generic: avoid invalid access to struct when
 emulating block limits
References: <20181029173437.32559-1-pbonzini@redhat.com>
 <20181029173437.32559-4-pbonzini@redhat.com>
In-Reply-To: <20181029173437.32559-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.10.18 18:34, Paolo Bonzini wrote:
> Emulation of the block limits VPD page called back into scsi-disk.c,
> which however expected the request to be for a SCSIDiskState and
> accessed a scsi-generic device outside the bounds of its struct
> (namely to retrieve s->max_unmap_size and s->max_io_size).
>=20
> To avoid this, move the emulation code to a separate function that
> takes a new SCSIBlockLimits struct and marshals it into the VPD
> response format.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/Makefile.objs       |  2 +-
>  hw/scsi/emulation.c         | 42 +++++++++++++++++
>  hw/scsi/scsi-disk.c         | 92 ++++++++-----------------------------=

>  hw/scsi/scsi-generic.c      | 22 +++++++--
>  include/hw/scsi/emulation.h | 16 +++++++
>  include/hw/scsi/scsi.h      |  1 -
>  6 files changed, 98 insertions(+), 77 deletions(-)
>  create mode 100644 hw/scsi/emulation.c
>  create mode 100644 include/hw/scsi/emulation.h
>=20

[...]

> diff --git a/hw/scsi/emulation.c b/hw/scsi/emulation.c
> new file mode 100644
> index 0000000000..94c2254bb4
> --- /dev/null
> +++ b/hw/scsi/emulation.c
> @@ -0,0 +1,42 @@
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/bswap.h"
> +#include "hw/scsi/emulation.h"
> +
> +int scsi_emulate_block_limits(uint8_t *outbuf, SCSIBlockLimits *bl)

I'd make @bl a const *, but it's not like qemu is the kind of code base
to complain about strict const-ness.

> +{
> +    /* required VPD size with unmap support */
> +    memset(outbuf, 0, 0x3C);

Upper case hex here...

> +
> +    outbuf[0] =3D bl->wsnz; /* wsnz */
> +
> +    if (bl->max_io_sectors) {
> +        /* optimal transfer length granularity.  This field and the op=
timal
> +         * transfer length can't be greater than maximum transfer leng=
th.
> +         */
> +        stw_be_p(outbuf + 2, MIN(bl->min_io_size, bl->max_io_sectors))=
;
> +
> +        /* maximum transfer length */
> +        stl_be_p(outbuf + 4, bl->max_io_sectors);
> +
> +        /* optimal transfer length */
> +        stl_be_p(outbuf + 8, MIN(bl->opt_io_size, bl->max_io_sectors))=
;
> +    } else {
> +        stw_be_p(outbuf + 2, bl->min_io_size);
> +        stl_be_p(outbuf + 8, bl->opt_io_size);
> +    }
> +
> +    /* max unmap LBA count */
> +    stl_be_p(outbuf + 16, bl->max_unmap_sectors);
> +
> +    /* max unmap descriptors */
> +    stl_be_p(outbuf + 20, bl->max_unmap_descr);
> +
> +    /* optimal unmap granularity; alignment is zero */
> +    stl_be_p(outbuf + 24, bl->unmap_sectors);
> +
> +    /* max write same size, make it the same as maximum transfer lengt=
h */
> +    stl_be_p(outbuf + 36, bl->max_io_sectors);
> +
> +    return 0x3c;

=2E..and lower case here?  (Sorry, I couldn't just bear it.)

> +}

[...]

> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index c5497bbea8..8fc74ef0bd 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -16,6 +16,7 @@
>  #include "qemu-common.h"
>  #include "qemu/error-report.h"
>  #include "hw/scsi/scsi.h"
> +#include "hw/scsi/emulation.h"
>  #include "sysemu/block-backend.h"
> =20
>  #ifdef __linux__
> @@ -209,9 +210,24 @@ static void scsi_handle_inquiry_reply(SCSIGenericR=
eq *r, SCSIDevice *s)
>      }
>  }
> =20
> -static int scsi_emulate_block_limits(SCSIGenericReq *r)
> +static int scsi_generic_emulate_block_limits(SCSIGenericReq *r, SCSIDe=
vice *s)
>  {
> -    r->buflen =3D scsi_disk_emulate_vpd_page(&r->req, r->buf);
> +    int len, buflen;

buflen is unused, so this does not compile for me.

> +    uint8_t buf[64];
> +
> +    SCSIBlockLimits bl =3D {
> +        .max_io_sectors =3D blk_get_max_transfer(s->conf.blk) / s->blo=
cksize
> +    };
> +
> +    memset(r->buf, 0, r->buflen);
> +    stb_p(buf, s->type);
> +    stb_p(buf + 1, 0xb0);
> +    len =3D scsi_emulate_block_limits(buf + 4, &bl);
> +    assert(len <=3D sizeof(buf) - 4);

Let's hope our stack grows downwards, otherwise we'll never get back
here if there was an overflow.  Maybe it would be better to pass the
buffer length to scsi_emulate_block_limits() and then move the assertion
there.

Or if you know that qemu does not support any architecture ABIs where
the stack can grow up, that's OK, too.


With buflen dropped, and you taking full responsibility for any future
bugs on ABIs with upwards stacks when someone extended
scsi_emulate_block_limits(), forgetting to adjust the buffer size here
(:-)):

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    stw_be_p(buf + 2, len);
> +
> +    memcpy(r->buf, buf, MIN(r->buflen, len + 4));
> +
>      r->io_header.sb_len_wr =3D 0;
> =20
>      /*


--rov58XHRo05Q2ppvhrWjGesllKB6P0Glo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvg+YsACgkQ9AfbAGHV
z0Bjawf+IL5Nko0kekAFCEmu0W5MQAQQwtPWsQsmyMjFEb3uWPJ0IMG68dZxw3QV
Ji4nMZs/OjQ0GB+hSc9gj+mTfl84W0tOaxx8OtVZqbp4S8G7UoNyLKmuSOB2F68a
VgpKnvqbsvN7KU6J4o3Vmki13xxTkiUnqwura4rh4mrrZFtR+0wHJT17DHHHH0LL
fcm3f+kj2z+bm2NXmlXOwc8SPy0BorCrPZmdoIkoerI+2BBZKUWclj/cO9/jjj3o
Fm733b+/kHu4lRNI/1gR4915iZNfc/HerVGkYwUZsPG56hXMD6pLZtF0eXZyrnAd
/+96Sz+B5m80ii4+y5GCSgC2jaWbSw==
=xsj7
-----END PGP SIGNATURE-----

--rov58XHRo05Q2ppvhrWjGesllKB6P0Glo--
