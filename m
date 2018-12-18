Received: from eggs.gnu.org ([2001:4830:134:3::10]:36130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gZGNb-0001HR-GO
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gZGNa-0001EI-EW
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:51 -0500
Date: Tue, 18 Dec 2018 15:29:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181218152920.58913dfa@Igors-MacBook-Pro.local>
In-Reply-To: <20181218110333.22558-2-philmd@redhat.com>
References: <20181218110333.22558-1-philmd@redhat.com>
	<20181218110333.22558-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] hw/acpi: Replace strncpy() by
 strpadcpy(pad='\0')
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, 1803872@bugs.launchpad.net, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>

On Tue, 18 Dec 2018 12:03:31 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
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
>   In function 'acpi_table_install', inlined from 'acpi_table_add' at qemu=
/hw/acpi/core.c:296:5:
>   qemu/hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 equals de=
stination size [-Werror=3Dstringop-truncation]
>            strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   make: *** [qemu/rules.mak:69: hw/acpi/core.o] Error 1
>=20
> The ACPI tables don't require the strings to be NUL-terminated,
> therefore strncpy is the right function to use here.
>=20
> We could add a #pragma GCC diagnostic ignored "-Wstringop-truncation"
> around, disable the warning globally using -Wno-stringop-truncation,
> but since QEMU provides the strpadcpy() which does the same purpose,
> simply use it to avoid the annoying warning.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: reword commit subject and description]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/aml-build.c |  6 ++++--
>  hw/acpi/core.c      | 13 +++++++------
>  2 files changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1e43cd736d..397833462a 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -24,6 +24,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "qemu/bswap.h"
>  #include "qemu/bitops.h"
> +#include "qemu/cutils.h"
>  #include "sysemu/numa.h"
> =20
>  static GArray *build_alloc_array(void)
> @@ -1532,13 +1533,14 @@ build_header(BIOSLinker *linker, GArray *table_da=
ta,
>      h->revision =3D rev;
> =20
>      if (oem_id) {
> -        strncpy((char *)h->oem_id, oem_id, sizeof h->oem_id);
> +        strpadcpy((char *)h->oem_id, sizeof h->oem_id, oem_id, '\0');
>      } else {
>          memcpy(h->oem_id, ACPI_BUILD_APPNAME6, 6);
>      }
> =20
>      if (oem_table_id) {
> -        strncpy((char *)h->oem_table_id, oem_table_id, sizeof(h->oem_tab=
le_id));
> +        strpadcpy((char *)h->oem_table_id, sizeof(h->oem_table_id),
> +                  oem_table_id, '\0');
>      } else {
>          memcpy(h->oem_table_id, ACPI_BUILD_APPNAME4, 4);
>          memcpy(h->oem_table_id + 4, sig, 4);
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index aafdc61648..6e8f4e5713 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -31,6 +31,7 @@
>  #include "qapi/qapi-visit-misc.h"
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
> +#include "qemu/cutils.h"
> =20
>  struct acpi_table_header {
>      uint16_t _length;         /* our length, not actual part of the hdr =
*/
> @@ -181,7 +182,7 @@ static void acpi_table_install(const char unsigned *b=
lob, size_t bloblen,
>      ext_hdr->_length =3D cpu_to_le16(acpi_payload_size);
> =20
>      if (hdrs->has_sig) {
> -        strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
> +        strpadcpy(ext_hdr->sig, sizeof ext_hdr->sig, hdrs->sig, '\0');
>          ++changed_fields;
>      }
> =20
> @@ -200,12 +201,12 @@ static void acpi_table_install(const char unsigned =
*blob, size_t bloblen,
>      ext_hdr->checksum =3D 0;
> =20
>      if (hdrs->has_oem_id) {
> -        strncpy(ext_hdr->oem_id, hdrs->oem_id, sizeof ext_hdr->oem_id);
> +        strpadcpy(ext_hdr->oem_id, sizeof ext_hdr->oem_id, hdrs->oem_id,=
 '\0');
>          ++changed_fields;
>      }
>      if (hdrs->has_oem_table_id) {
> -        strncpy(ext_hdr->oem_table_id, hdrs->oem_table_id,
> -                sizeof ext_hdr->oem_table_id);
> +        strpadcpy(ext_hdr->oem_table_id, sizeof ext_hdr->oem_table_id,
> +                  hdrs->oem_table_id, '\0');
>          ++changed_fields;
>      }
>      if (hdrs->has_oem_rev) {
> @@ -213,8 +214,8 @@ static void acpi_table_install(const char unsigned *b=
lob, size_t bloblen,
>          ++changed_fields;
>      }
>      if (hdrs->has_asl_compiler_id) {
> -        strncpy(ext_hdr->asl_compiler_id, hdrs->asl_compiler_id,
> -                sizeof ext_hdr->asl_compiler_id);
> +        strpadcpy(ext_hdr->asl_compiler_id, sizeof ext_hdr->asl_compiler=
_id,
> +                  hdrs->asl_compiler_id, '\0');
>          ++changed_fields;
>      }
>      if (hdrs->has_asl_compiler_rev) {
