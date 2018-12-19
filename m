Received: from eggs.gnu.org ([2001:4830:134:3::10]:58938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZbCV-0001V9-N3
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZbCS-0007l8-Vp
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:43:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZbCS-0007jR-NS
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:43:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so19382394wra.6
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 04:43:43 -0800 (PST)
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-4-philmd@redhat.com>
	<20181219101034.2dgs2faryopmflnz@kamzik.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49ed6ada-c821-6afd-11a9-9520901a151c@redhat.com>
Date: Wed, 19 Dec 2018 13:43:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181219101034.2dgs2faryopmflnz@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, 1803872@bugs.launchpad.net, Igor Mammedov <imammedo@redhat.com>

Hi Drew,

On 12/19/18 11:10 AM, Andrew Jones wrote:
> On Tue, Dec 18, 2018 at 06:51:20PM +0100, Philippe Mathieu-Daudé wrote:
>> GCC 8 added a -Wstringop-truncation warning:
>>
>>   The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
>>   bug 81117 is specifically intended to highlight likely unintended
>>   uses of the strncpy function that truncate the terminating NUL
>>   character from the source string.
>>
>> This new warning leads to compilation failures:
>>
>>     CC      hw/acpi/core.o
>>   In function 'acpi_table_install', inlined from 'acpi_table_add' at qemu/hw/acpi/core.c:296:5:
>>   qemu/hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 equals destination size [-Werror=stringop-truncation]
>>            strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
>>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   make: *** [qemu/rules.mak:69: hw/acpi/core.o] Error 1
>>
>> Use the QEMU_NONSTRING attribute, since ACPI tables don't require the
>> strings to be NUL-terminated.
> 
> Aren't we always starting with zero-initialized structures in ACPI code?
> If so, then we should be able to change the strncpy's to memcpy's.

The first call zero-initializes, but then we call realloc():

    /* We won't fail from here on. Initialize / extend the globals. */
    if (acpi_tables == NULL) {
        acpi_tables_len = sizeof(uint16_t);
        acpi_tables = g_malloc0(acpi_tables_len);
    }

    acpi_tables = g_realloc(acpi_tables, acpi_tables_len +
                                         ACPI_TABLE_PFX_SIZE +
                                         sizeof dfl_hdr + body_size);

    ext_hdr = (struct acpi_table_header *)(acpi_tables +
                                           acpi_tables_len);

So memcpy() isn't enough.

I can resend the previous patch which uses strpadcpy() if you prefer,
Igor already reviewed it:

https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04406.html

>>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/acpi/core.c              | 8 ++++----
>>  include/hw/acpi/acpi-defs.h | 8 ++++----
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>> index aafdc61648..f60f750c3d 100644
>> --- a/hw/acpi/core.c
>> +++ b/hw/acpi/core.c
>> @@ -35,14 +35,14 @@
>>  struct acpi_table_header {
>>      uint16_t _length;         /* our length, not actual part of the hdr */
>>                                /* allows easier parsing for fw_cfg clients */
>> -    char sig[4];              /* ACPI signature (4 ASCII characters) */
>> +    char sig[4] QEMU_NONSTRING; /* ACPI signature (4 ASCII characters) */
>>      uint32_t length;          /* Length of table, in bytes, including header */
>>      uint8_t revision;         /* ACPI Specification minor version # */
>>      uint8_t checksum;         /* To make sum of entire table == 0 */
>> -    char oem_id[6];           /* OEM identification */
>> -    char oem_table_id[8];     /* OEM table identification */
>> +    char oem_id[6] QEMU_NONSTRING; /* OEM identification */
>> +    char oem_table_id[8] QEMU_NONSTRING; /* OEM table identification */
>>      uint32_t oem_revision;    /* OEM revision number */
>> -    char asl_compiler_id[4];  /* ASL compiler vendor ID */
>> +    char asl_compiler_id[4] QEMU_NONSTRING; /* ASL compiler vendor ID */
>>      uint32_t asl_compiler_revision; /* ASL compiler revision number */
>>  } QEMU_PACKED;
>>  
>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
>> index af8e023968..3bf0bec8ba 100644
>> --- a/include/hw/acpi/acpi-defs.h
>> +++ b/include/hw/acpi/acpi-defs.h
>> @@ -43,7 +43,7 @@ enum {
>>  struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer */
>>      uint64_t signature;              /* ACPI signature, contains "RSD PTR " */
>>      uint8_t  checksum;               /* To make sum of struct == 0 */
>> -    uint8_t  oem_id [6];             /* OEM identification */
>> +    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */
>>      uint8_t  revision;               /* Must be 0 for 1.0, 2 for 2.0 */
>>      uint32_t rsdt_physical_address;  /* 32-bit physical address of RSDT */
>>      uint32_t length;                 /* XSDT Length in bytes including hdr */
>> @@ -62,10 +62,10 @@ typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
>>      uint32_t length;                 /* Length of table, in bytes, including header */ \
>>      uint8_t  revision;               /* ACPI Specification minor version # */ \
>>      uint8_t  checksum;               /* To make sum of entire table == 0 */ \
>> -    uint8_t  oem_id [6];             /* OEM identification */ \
>> -    uint8_t  oem_table_id [8];       /* OEM table identification */ \
>> +    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */ \
>> +    uint8_t  oem_table_id [8] QEMU_NONSTRING; /* OEM table identification */ \
>>      uint32_t oem_revision;           /* OEM revision number */ \
>> -    uint8_t  asl_compiler_id [4];    /* ASL compiler vendor ID */ \
>> +    uint8_t  asl_compiler_id [4] QEMU_NONSTRING; /* ASL compiler vendor ID */ \
>>      uint32_t asl_compiler_revision;  /* ASL compiler revision number */
>>  
>>  
>> -- 
>> 2.17.2
>>
>>
