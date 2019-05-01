Received: from eggs.gnu.org ([209.51.188.92]:50040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLliu-0004Kj-80
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLlir-0005Y2-6k
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:40:20 -0400
Date: Wed, 1 May 2019 10:40:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190501094006.GN29808@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<aeb0e851e027a591eaba99c175011158b1012876.1556666645.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeb0e851e027a591eaba99c175011158b1012876.1556666645.git.alistair.francis@wdc.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/5] hw/usb/dev-mtp: Fix GCC 9 build
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On Tue, Apr 30, 2019 at 11:28:41PM +0000, Alistair Francis wrote:
> Fix this warning with GCC 9 on Fedora 30:
> hw/usb/dev-mtp.c:1715:36: error: taking address of packed member of =E2=
=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointer valu=
e [-Werror=3Daddress-of-packed-member]
>  1715 |                             dataset->filename);
>       |                             ~~~~~~~^~~~~~~~~~
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/usb/dev-mtp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 99548b012d..8233beacab 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1711,9 +1711,22 @@ static void usb_mtp_write_metadata(MTPState *s, =
uint64_t dlen)
>      assert(!s->write_pending);
>      assert(p !=3D NULL);
> =20
> +/*
> + * We are about to access a packed struct. We are confident that the p=
ointer
> + * address won't be unaligned, so we ignore GCC warnings.
> + */

The data is mis-aligned as we're accessing an int16 array that
is immediately following an int8 field in a packed struct

This problem is fixed by the following series which Gerd has in the
USB queue:

  https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02524.html

> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
> +#endif
> +
>      filename =3D utf16_to_str(MIN(dataset->length, filename_chars),
>                              dataset->filename);
> =20
> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> +#pragma GCC diagnostic pop
> +#endif
> +
>      if (strchr(filename, '/')) {
>          usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
>                               0, 0, 0, 0);

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
