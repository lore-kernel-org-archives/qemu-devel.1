Received: from eggs.gnu.org ([2001:4830:134:3::10]:42039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZDGC-0002JJ-CR
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZDG9-0003o8-20
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:10:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZDG8-0003lt-Qd
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:09:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so6889272wmd.1
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 03:09:55 -0800 (PST)
References: <20181218110333.22558-1-philmd@redhat.com>
	<20181218110333.22558-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cfe5e8d8-9528-2623-53cf-922632ef2d87@redhat.com>
Date: Tue, 18 Dec 2018 12:09:51 +0100
MIME-Version: 1.0
In-Reply-To: <20181218110333.22558-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: qemu-devel@nongnu.org
Cc: Ben Pye <ben@curlybracket.co.uk>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, 1803872@bugs.launchpad.net, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 12/18/18 12:03 PM, Philippe Mathieu-Daudé wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> GCC 8 added a -Wstringop-truncation warning:
> 
>   The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
>   bug 81117 is specifically intended to highlight likely unintended
>   uses of the strncpy function that truncate the terminating NUL
>   character from the source string.
> 
> This new warning leads to compilation failures:
> 
>     CC      hw/acpi/core.o
>   In function 'acpi_table_install', inlined from 'acpi_table_add' at qemu/hw/acpi/core.c:296:5:
>   qemu/hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 equals destination size [-Werror=stringop-truncation]
>            strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   make: *** [qemu/rules.mak:69: hw/acpi/core.o] Error 1
> 
> The ACPI tables don't require the strings to be NUL-terminated,
> therefore strncpy is the right function to use here.
> 
> We could add a #pragma GCC diagnostic ignored "-Wstringop-truncation"
> around, disable the warning globally using -Wno-stringop-truncation,
> but since QEMU provides the strpadcpy() which does the same purpose,
> simply use it to avoid the annoying warning.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> [PMD: reword commit subject and description]

I forgot to also add "Use '\0' instead of 0".

> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---

v1: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03941.html

>  hw/acpi/aml-build.c |  6 ++++--
>  hw/acpi/core.c      | 13 +++++++------
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
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
>  
>  static GArray *build_alloc_array(void)
> @@ -1532,13 +1533,14 @@ build_header(BIOSLinker *linker, GArray *table_data,
>      h->revision = rev;
>  
>      if (oem_id) {
> -        strncpy((char *)h->oem_id, oem_id, sizeof h->oem_id);
> +        strpadcpy((char *)h->oem_id, sizeof h->oem_id, oem_id, '\0');
>      } else {
>          memcpy(h->oem_id, ACPI_BUILD_APPNAME6, 6);
>      }
>  
>      if (oem_table_id) {
> -        strncpy((char *)h->oem_table_id, oem_table_id, sizeof(h->oem_table_id));
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
>  
>  struct acpi_table_header {
>      uint16_t _length;         /* our length, not actual part of the hdr */
> @@ -181,7 +182,7 @@ static void acpi_table_install(const char unsigned *blob, size_t bloblen,
>      ext_hdr->_length = cpu_to_le16(acpi_payload_size);
>  
>      if (hdrs->has_sig) {
> -        strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
> +        strpadcpy(ext_hdr->sig, sizeof ext_hdr->sig, hdrs->sig, '\0');
>          ++changed_fields;
>      }
>  
> @@ -200,12 +201,12 @@ static void acpi_table_install(const char unsigned *blob, size_t bloblen,
>      ext_hdr->checksum = 0;
>  
>      if (hdrs->has_oem_id) {
> -        strncpy(ext_hdr->oem_id, hdrs->oem_id, sizeof ext_hdr->oem_id);
> +        strpadcpy(ext_hdr->oem_id, sizeof ext_hdr->oem_id, hdrs->oem_id, '\0');
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
> @@ -213,8 +214,8 @@ static void acpi_table_install(const char unsigned *blob, size_t bloblen,
>          ++changed_fields;
>      }
>      if (hdrs->has_asl_compiler_id) {
> -        strncpy(ext_hdr->asl_compiler_id, hdrs->asl_compiler_id,
> -                sizeof ext_hdr->asl_compiler_id);
> +        strpadcpy(ext_hdr->asl_compiler_id, sizeof ext_hdr->asl_compiler_id,
> +                  hdrs->asl_compiler_id, '\0');
>          ++changed_fields;
>      }
>      if (hdrs->has_asl_compiler_rev) {
> 
