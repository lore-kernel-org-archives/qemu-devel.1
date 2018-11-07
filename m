Received: from eggs.gnu.org ([2001:4830:134:3::10]:41334)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gKOWc-0008WK-Uj
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 09:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gKOWY-0005va-UQ
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 09:09:42 -0500
References: <d9876015-2126-79fe-415f-ca7427ab3059@gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <d2313261-ac1c-4122-a49a-5fb521461118@gmx.com>
Date: Wed, 7 Nov 2018 15:10:28 +0100
MIME-Version: 1.0
In-Reply-To: <d9876015-2126-79fe-415f-ca7427ab3059@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rlitqKnF5scRhdhioQvdkBUbDBdoGIPAr"
Subject: Re: [Qemu-devel] [PATCH] Support u-boot noload images for arm as
 used by NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Hudson <nicholas.a.hudson@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rlitqKnF5scRhdhioQvdkBUbDBdoGIPAr
From: Kamil Rytarowski <n54@gmx.com>
To: Nick Hudson <nicholas.a.hudson@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Message-ID: <d2313261-ac1c-4122-a49a-5fb521461118@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] Support u-boot noload images for arm as used
 by NetBSD/evbarm GENERIC kernel.
References: <d9876015-2126-79fe-415f-ca7427ab3059@gmail.com>
In-Reply-To: <d9876015-2126-79fe-415f-ca7427ab3059@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I saw this thread, but from a NetBSD maintainer point of view, I will
defer review to ARM people.

On 07.11.2018 14:19, Nick Hudson wrote:
> noload kernels are loaded with the u-boot image header and as a result
> the header size needs adding to the entry point.=C2=A0 Fake up a hdr so=
 the
> kernel image is loaded at the right address and the entry point is
> adjusted appropriately
>=20
> Signed-off-by: Nick Hudson <skrll@netbsd.org>
> ---
> =C2=A0hw/arm/boot.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 8 +++++---
> =C2=A0hw/core/loader.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +++++++++---
> =C2=A0hw/core/uboot_image.h |=C2=A0 1 +
> =C2=A03 files changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 586baa9b64..450267566a 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -30,8 +30,9 @@
> =C2=A0 * Documentation/arm/Booting and Documentation/arm64/booting.txt
> =C2=A0 * They have different preferred image load offsets from system R=
AM base.
> =C2=A0 */
> -#define KERNEL_ARGS_ADDR 0x100
> -#define KERNEL_LOAD_ADDR 0x00010000
> +#define KERNEL_ARGS_ADDR=C2=A0=C2=A0 0x100
> +#define KERNEL_NOLOAD_ADDR 0x00000000
> +#define KERNEL_LOAD_ADDR=C2=A0=C2=A0 0x00010000
> =C2=A0#define KERNEL64_LOAD_ADDR 0x00080000
>=20
> =C2=A0#define ARM64_TEXT_OFFSET_OFFSET=C2=A0=C2=A0=C2=A0 8
> @@ -1078,7 +1079,8 @@ void arm_load_kernel(ARMCPU *cpu, struct
> arm_boot_info *info)
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 entry =3D elf_entry;
> =C2=A0=C2=A0=C2=A0=C2=A0 if (kernel_size < 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_size =3D load_uimage=
_as(info->kernel_filename, &entry, NULL,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t loadaddr =3D info-=
>loader_start + KERNEL_NOLOAD_ADDR;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_size =3D load_uimage=
_as(info->kernel_filename, &entry,
> &loadaddr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 &is_linux, NULL, NULL, as);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64=
) && kernel_size < 0) {
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index aa0b3fc867..952562c2da 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -638,13 +638,19 @@ static int load_uboot_image(const char *filename,=

> hwaddr *ep, hwaddr *loadaddr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 if (hdr->ih_type !=3D image_type) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Wrong imag=
e type %d, expected %d\n",
> hdr->ih_type,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 image_type);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (image_type !=3D IH_TYPE=
_KERNEL && hdr->ih_type !=3D
> IH_TYPE_KERNEL_NOLOAD) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpr=
intf(stderr, "Wrong image type %d, expected %d\n",
> hdr->ih_type,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image_type);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 /* TODO: Implement other image types.=C2=A0 */=

> =C2=A0=C2=A0=C2=A0=C2=A0 switch (hdr->ih_type) {
> +=C2=A0=C2=A0=C2=A0 case IH_TYPE_KERNEL_NOLOAD:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr->ih_load =3D *loadaddr =
+ sizeof(*hdr);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdr->ih_ep +=3D hdr->ih_loa=
d;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 case IH_TYPE_KERNEL:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 address =3D hdr->ih_lo=
ad;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (translate_fn) {
> diff --git a/hw/core/uboot_image.h b/hw/core/uboot_image.h
> index 34c11a70a6..608022de6e 100644
> --- a/hw/core/uboot_image.h
> +++ b/hw/core/uboot_image.h
> @@ -124,6 +124,7 @@
> =C2=A0#define IH_TYPE_SCRIPT=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 6=C2=A0=
=C2=A0=C2=A0 /* Script file=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 */
> =C2=A0#define IH_TYPE_FILESYSTEM=C2=A0=C2=A0=C2=A0 7=C2=A0=C2=A0=C2=A0 =
/* Filesystem Image (any type)=C2=A0=C2=A0=C2=A0 */
> =C2=A0#define IH_TYPE_FLATDT=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 8=C2=A0=
=C2=A0=C2=A0 /* Binary Flat Device Tree Blob=C2=A0=C2=A0=C2=A0 */
> +#define IH_TYPE_KERNEL_NOLOAD=C2=A0 14=C2=A0=C2=A0=C2=A0 /* OS Kernel =
Image (noload)=C2=A0=C2=A0=C2=A0 */
>=20
> =C2=A0/*
> =C2=A0 * Compression Types



--rlitqKnF5scRhdhioQvdkBUbDBdoGIPAr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlvi8lQMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs034P/Ahj6p817nuGQboDH97YXC86apQxWCe4vlerY6QP
jXwPRZd98ATkmIf7AjL3JLY/9FXBr/l+89lTSdU/wk1Bea4KLikX2lngzkr5dQl2
9fxWSzKtQQzFCBwzJ7Da1PCKlBHRG4V2qLSaGdG1zNgiUPOSNvAWWz395AeNwhin
CmJyVNtVeKn59q12DU7YX7p7GSOmDgo5jP59W+2uITU2v0U5b+60GUZzssoCgTW+
6MiCllKWcr8l/qdEoqHrED2zMcfSlWBsfjZJ4EO+x2f0RDxXI9TSxcu79MY/G6Cg
Cafgm0Se930OyXy0B6ldR94hPGT4MOIq/nMAIogrLt1qYw/BlSrl3ks2WKU70C5B
BZp8zoS+rBO74j9aRU8Bt1pNUjOtt59xYnxmpte/8/8fXTuznwIxRN20cXRND4Ha
tvoQaWPgWYs4w9Zma/lpPWttSPrNoGrRmY1FlMpVN1jnoj6kPqaq/7UyoQ6vEMqb
/XkdC/MO+SbudHcUxmjJvr7UbfRmZD1du3r11ZOKdFQXbD54xJwhzpajZHb8gBUv
2cV2aRroxq2I94IPkPILSNnnmS2kez6OUv0R2shP+yGaGCTVfVNYDq5XVEiu8c1z
pZrJk4D+MdVLXenguLt6H6/WkFDAZB4nCSMRv6jcJtcRjJ6EGlQtUlv7Uh3lTVkw
+cIY
=3C++
-----END PGP SIGNATURE-----

--rlitqKnF5scRhdhioQvdkBUbDBdoGIPAr--
