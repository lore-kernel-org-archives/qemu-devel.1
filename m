Received: from eggs.gnu.org ([2001:4830:134:3::10]:58785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gZYof-0004ZK-E6
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gZYoe-0005tx-Fd
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:11:01 -0500
Date: Wed, 19 Dec 2018 11:10:34 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181219101034.2dgs2faryopmflnz@kamzik.brq.redhat.com>
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181218175122.3229-4-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/5] hw/acpi: Use QEMU_NONSTRING for non
 NUL-terminated arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, 1803872@bugs.launchpad.net, Igor Mammedov <imammedo@redhat.com>

On Tue, Dec 18, 2018 at 06:51:20PM +0100, Philippe Mathieu-Daud=E9 wrote:
> GCC 8 added a -Wstringop-truncation warning:
>=20
>   The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
>   bug 81117 is specifically intended to highlight likely unintended
>   uses of the strncpy function that truncate the terminating NUL
>   character from the source string.
>=20
> This new warning leads to compilation failures:
>=20
>     CC      hw/acpi/core.o
>   In function 'acpi_table_install', inlined from 'acpi_table_add' at qe=
mu/hw/acpi/core.c:296:5:
>   qemu/hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 equals =
destination size [-Werror=3Dstringop-truncation]
>            strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   make: *** [qemu/rules.mak:69: hw/acpi/core.o] Error 1
>=20
> Use the QEMU_NONSTRING attribute, since ACPI tables don't require the
> strings to be NUL-terminated.

Aren't we always starting with zero-initialized structures in ACPI code?
If so, then we should be able to change the strncpy's to memcpy's.

Thanks,
drew

>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  hw/acpi/core.c              | 8 ++++----
>  include/hw/acpi/acpi-defs.h | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index aafdc61648..f60f750c3d 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -35,14 +35,14 @@
>  struct acpi_table_header {
>      uint16_t _length;         /* our length, not actual part of the hd=
r */
>                                /* allows easier parsing for fw_cfg clie=
nts */
> -    char sig[4];              /* ACPI signature (4 ASCII characters) *=
/
> +    char sig[4] QEMU_NONSTRING; /* ACPI signature (4 ASCII characters)=
 */
>      uint32_t length;          /* Length of table, in bytes, including =
header */
>      uint8_t revision;         /* ACPI Specification minor version # */
>      uint8_t checksum;         /* To make sum of entire table =3D=3D 0 =
*/
> -    char oem_id[6];           /* OEM identification */
> -    char oem_table_id[8];     /* OEM table identification */
> +    char oem_id[6] QEMU_NONSTRING; /* OEM identification */
> +    char oem_table_id[8] QEMU_NONSTRING; /* OEM table identification *=
/
>      uint32_t oem_revision;    /* OEM revision number */
> -    char asl_compiler_id[4];  /* ASL compiler vendor ID */
> +    char asl_compiler_id[4] QEMU_NONSTRING; /* ASL compiler vendor ID =
*/
>      uint32_t asl_compiler_revision; /* ASL compiler revision number */
>  } QEMU_PACKED;
> =20
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index af8e023968..3bf0bec8ba 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -43,7 +43,7 @@ enum {
>  struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer *=
/
>      uint64_t signature;              /* ACPI signature, contains "RSD =
PTR " */
>      uint8_t  checksum;               /* To make sum of struct =3D=3D 0=
 */
> -    uint8_t  oem_id [6];             /* OEM identification */
> +    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */
>      uint8_t  revision;               /* Must be 0 for 1.0, 2 for 2.0 *=
/
>      uint32_t rsdt_physical_address;  /* 32-bit physical address of RSD=
T */
>      uint32_t length;                 /* XSDT Length in bytes including=
 hdr */
> @@ -62,10 +62,10 @@ typedef struct AcpiRsdpDescriptor AcpiRsdpDescripto=
r;
>      uint32_t length;                 /* Length of table, in bytes, inc=
luding header */ \
>      uint8_t  revision;               /* ACPI Specification minor versi=
on # */ \
>      uint8_t  checksum;               /* To make sum of entire table =3D=
=3D 0 */ \
> -    uint8_t  oem_id [6];             /* OEM identification */ \
> -    uint8_t  oem_table_id [8];       /* OEM table identification */ \
> +    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */ \
> +    uint8_t  oem_table_id [8] QEMU_NONSTRING; /* OEM table identificat=
ion */ \
>      uint32_t oem_revision;           /* OEM revision number */ \
> -    uint8_t  asl_compiler_id [4];    /* ASL compiler vendor ID */ \
> +    uint8_t  asl_compiler_id [4] QEMU_NONSTRING; /* ASL compiler vendo=
r ID */ \
>      uint32_t asl_compiler_revision;  /* ASL compiler revision number *=
/
> =20
> =20
> --=20
> 2.17.2
>=20
>=20
