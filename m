Received: from eggs.gnu.org ([2001:4830:134:3::10]:60165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGsFC-0003nb-OY
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGsF8-0002GQ-Ly
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:00:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eGsF8-0002Ft-Cy
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:00:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 573A980B29
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 20:00:33 +0000 (UTC)
References: <1510834622-28800-1-git-send-email-thuth@redhat.com>
	<20171120175522.76bf71c3@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <30190107-f070-8846-fda5-09258d5ee246@redhat.com>
Date: Mon, 20 Nov 2017 21:00:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171120175522.76bf71c3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tests/bios-tables-test: Fix endianess
 problems when passing data to iasl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 20.11.2017 17:55, Igor Mammedov wrote:
> On Thu, 16 Nov 2017 13:17:02 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The bios-tables-test was writing out files that we pass to iasl in
>> with the wrong endianness in the header when running on a big endian
>> host. So instead of storing mixed endian information in our structures,
>> let's keep everything in little endian and byte-swap it only when we
>> need a value in the code.
>>
>> Reported-by: Daniel P. Berrange <berrange@redhat.com>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1724570
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Fixed vmgenid-test which was accidentially broken in v1
>>
>>  tests/acpi-utils.h       | 27 +++++----------------------
>>  tests/bios-tables-test.c | 42 ++++++++++++++++++++++--------------------
>>  tests/vmgenid-test.c     | 22 ++++++++++++----------
>>  3 files changed, 39 insertions(+), 52 deletions(-)
>>
>> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
>> index f8d8723..d5ca5b6 100644
>> --- a/tests/acpi-utils.h
>> +++ b/tests/acpi-utils.h
>> @@ -28,24 +28,9 @@ typedef struct {
>>      bool tmp_files_retain;   /* do not delete the temp asl/aml */
>>  } AcpiSdtTable;
>>  
>> -#define ACPI_READ_FIELD(field, addr)           \
>> -    do {                                       \
>> -        switch (sizeof(field)) {               \
>> -        case 1:                                \
>> -            field = readb(addr);               \
>> -            break;                             \
>> -        case 2:                                \
>> -            field = readw(addr);               \
>> -            break;                             \
>> -        case 4:                                \
>> -            field = readl(addr);               \
>> -            break;                             \
>> -        case 8:                                \
>> -            field = readq(addr);               \
>> -            break;                             \
>> -        default:                               \
>> -            g_assert(false);                   \
>> -        }                                      \
> probably it's been discussed but, why not do
>  leXX_to_cpu()
> here, instead of making each place that access read field
> to do leXX_to_cpu() manually.?
>
> Beside of keeping access to structure in natural host order,
> it should also be less error-prone as field users don't
> have to worry about endianness.

Actually, the readw/l/q functions already do byte-swapping, so the data
was stored in host endian order. But Michael said that he'd prefer to
store all data from the ACPI tables in little endian mode instead -
that's why I've done the patch that way.

 Thomas
