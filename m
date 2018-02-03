Received: from eggs.gnu.org ([2001:4830:134:3::10]:58350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtOm-00011S-QG
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtOl-0008B0-QW
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:42:12 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202183731.29990-1-armbru@redhat.com>
	<20180202183731.29990-3-armbru@redhat.com>
	<11be568a-8c6d-3d45-8c32-dc41ea70c352@redhat.com>
Date: Sat, 03 Feb 2018 09:42:04 +0100
In-Reply-To: <11be568a-8c6d-3d45-8c32-dc41ea70c352@redhat.com> (Eric Blake's
	message of "Fri, 2 Feb 2018 13:35:52 -0600")
Message-ID: <87h8qy5usj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 02/15] hw/arm: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alistair.francis@xilinx.com

Eric Blake <eblake@redhat.com> writes:

> On 02/02/2018 12:37 PM, Markus Armbruster wrote:
>> From: Alistair Francis <alistair.francis@xilinx.com>
>> 
>> Replace a large number of the fprintf(stderr, "*\n" calls with
>> error_report(). The functions were renamed with these commands and then
>> compiler issues where manually fixed.
>> 
>
>> 
>> Some lines where then manually tweaked to pass checkpatch.
>> 
>> The 'qemu: ' prefix was manually removed from the hw/arm/boot.c file.
>> 
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Cc: qemu-arm@nongnu.org
>> 
>> Conversions that aren't followed by exit() dropped, because they might
>> be inappropriate.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/hw/arm/gumstix.c
>> @@ -35,6 +35,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>  #include "hw/hw.h"
>>  #include "hw/arm/pxa.h"
>>  #include "net/net.h"
>> @@ -62,8 +63,8 @@ static void connex_init(MachineState *machine)
>>  
>>      dinfo = drive_get(IF_PFLASH, 0, 0);
>>      if (!dinfo && !qtest_enabled()) {
>> -        fprintf(stderr, "A flash image must be given with the "
>> -                "'pflash' parameter\n");
>> +        error_report("A flash image must be given with the "
>> +                     "'pflash' parameter");
>>          exit(1);
>>      }
>>  
>> @@ -76,7 +77,7 @@ static void connex_init(MachineState *machine)
>>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>>                                 sector_len, connex_rom / sector_len,
>>                                 2, 0, 0, 0, 0, be)) {
>> -        fprintf(stderr, "qemu: Error registering flash memory.\n");
>> +        error_report("Error registering flash memory.");
>
> Do we care about consistency on trailing dots in these conversions?

Good opportunity to get rid of trailing punctuation in converted error
messages.

> At any rate, all of these are sane rewrites of existing patterns;
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
