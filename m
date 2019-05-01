Received: from eggs.gnu.org ([209.51.188.92]:56493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLjQ6-0005U7-II
	for qemu-devel@nongnu.org; Wed, 01 May 2019 03:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLjQ2-0002oC-Q0
	for qemu-devel@nongnu.org; Wed, 01 May 2019 03:12:46 -0400
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<aeb0e851e027a591eaba99c175011158b1012876.1556666645.git.alistair.francis@wdc.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e552115b-8fc2-1ff7-dc17-78d949b7f030@redhat.com>
Date: Wed, 1 May 2019 09:12:35 +0200
MIME-Version: 1.0
In-Reply-To: <aeb0e851e027a591eaba99c175011158b1012876.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>, "alistair23@gmail.com" <alistair23@gmail.com>

On 01/05/2019 01.28, Alistair Francis wrote:
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

Would it be possible to use an assert() instead? Something like

 g_assert((dataset->filename & 1) =3D=3D 0)

?

 Thomas
