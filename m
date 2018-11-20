Received: from eggs.gnu.org ([2001:4830:134:3::10]:44572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPBy5-0006A5-CQ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPBxy-0006nH-UD
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:45:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPBxy-0006ZB-JB
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:45:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so3277122wmc.1
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 11:45:23 -0800 (PST)
References: <20181120152753.10463-1-marcandre.lureau@redhat.com>
	<20181120152753.10463-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21558663-34ed-810f-989c-d105f97ae6a1@redhat.com>
Date: Tue, 20 Nov 2018 20:45:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181120152753.10463-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1? 3/3] acpi: fix stringop-truncation
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On 20/11/18 16:27, Marc-André Lureau wrote:
> Replace strcpy() that don't mind about having dest not ending with NUL
> char by qemu strpadcpy().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/acpi/aml-build.c |  6 ++++--
>   hw/acpi/core.c      | 13 +++++++------
>   2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1e43cd736d..0a64a23e09 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -24,6 +24,7 @@
>   #include "hw/acpi/aml-build.h"
>   #include "qemu/bswap.h"
>   #include "qemu/bitops.h"
> +#include "qemu/cutils.h"
>   #include "sysemu/numa.h"
>   
>   static GArray *build_alloc_array(void)
> @@ -1532,13 +1533,14 @@ build_header(BIOSLinker *linker, GArray *table_data,
>       h->revision = rev;
>   
>       if (oem_id) {
> -        strncpy((char *)h->oem_id, oem_id, sizeof h->oem_id);
> +        strpadcpy((char *)h->oem_id, sizeof h->oem_id, oem_id, 0);
>       } else {
>           memcpy(h->oem_id, ACPI_BUILD_APPNAME6, 6);
>       }
>   
>       if (oem_table_id) {
> -        strncpy((char *)h->oem_table_id, oem_table_id, sizeof(h->oem_table_id));
> +        strpadcpy((char *)h->oem_table_id, sizeof(h->oem_table_id),
> +                  oem_table_id, 0);
>       } else {
>           memcpy(h->oem_table_id, ACPI_BUILD_APPNAME4, 4);
>           memcpy(h->oem_table_id + 4, sig, 4);
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index aafdc61648..c1b4dfbfd9 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -31,6 +31,7 @@
>   #include "qapi/qapi-visit-misc.h"
>   #include "qemu/error-report.h"
>   #include "qemu/option.h"
> +#include "qemu/cutils.h"
>   
>   struct acpi_table_header {
>       uint16_t _length;         /* our length, not actual part of the hdr */
> @@ -181,7 +182,7 @@ static void acpi_table_install(const char unsigned *blob, size_t bloblen,
>       ext_hdr->_length = cpu_to_le16(acpi_payload_size);
>   
>       if (hdrs->has_sig) {
> -        strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
> +        strpadcpy(ext_hdr->sig, sizeof ext_hdr->sig, hdrs->sig, 0);
>           ++changed_fields;
>       }
>   
> @@ -200,12 +201,12 @@ static void acpi_table_install(const char unsigned *blob, size_t bloblen,
>       ext_hdr->checksum = 0;
>   
>       if (hdrs->has_oem_id) {
> -        strncpy(ext_hdr->oem_id, hdrs->oem_id, sizeof ext_hdr->oem_id);
> +        strpadcpy(ext_hdr->oem_id, sizeof ext_hdr->oem_id, hdrs->oem_id, 0);
>           ++changed_fields;
>       }
>       if (hdrs->has_oem_table_id) {
> -        strncpy(ext_hdr->oem_table_id, hdrs->oem_table_id,
> -                sizeof ext_hdr->oem_table_id);
> +        strpadcpy(ext_hdr->oem_table_id, sizeof ext_hdr->oem_table_id,
> +                  hdrs->oem_table_id, 0);
>           ++changed_fields;
>       }
>       if (hdrs->has_oem_rev) {
> @@ -213,8 +214,8 @@ static void acpi_table_install(const char unsigned *blob, size_t bloblen,
>           ++changed_fields;
>       }
>       if (hdrs->has_asl_compiler_id) {
> -        strncpy(ext_hdr->asl_compiler_id, hdrs->asl_compiler_id,
> -                sizeof ext_hdr->asl_compiler_id);
> +        strpadcpy(ext_hdr->asl_compiler_id, sizeof ext_hdr->asl_compiler_id,
> +                  hdrs->asl_compiler_id, 0);
>           ++changed_fields;
>       }
>       if (hdrs->has_asl_compiler_rev) {
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Sounds like a good idea. However we don't this particular one for 3.1, 
does it silents a warning?

Regards,

Phil.
