Received: from eggs.gnu.org ([2001:4830:134:3::10]:38151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXRPX-0005q0-6d
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXRPW-0005ls-3J
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:20:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-20-f4bug@amsat.org>
	<20180625150719.0392da6c.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9854192e-810e-f872-2c92-70cb5a53f744@amsat.org>
Date: Mon, 25 Jun 2018 10:19:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180625150719.0392da6c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 19/46] hw/s390x: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:S390" <qemu-s390x@nongnu.org>

Hi Cornelia,

On 06/25/2018 10:07 AM, Cornelia Huck wrote:
> On Mon, 25 Jun 2018 09:42:11 -0300
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> It eases code review, unit is explicit.
>>
>> Patch generated using:
>>
>>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
>>
>> and modified manually.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 
> Hm, I had not looked at the v2+ patches, as this already carried my
> ack...

Oops...

>> ---
>>  hw/s390x/s390-skeys.c    | 3 ++-
>>  hw/s390x/s390-stattrib.c | 3 ++-
> 
> ...but these two were added later on.
> 
>>  hw/s390x/sclp.c          | 3 ++-
>>  3 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
>> index 76241c240e..15f7ab0e53 100644
>> --- a/hw/s390x/s390-skeys.c
>> +++ b/hw/s390x/s390-skeys.c
>> @@ -10,6 +10,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>  #include "hw/boards.h"
>>  #include "hw/s390x/storage-keys.h"
>>  #include "qapi/error.h"
>> @@ -19,7 +20,7 @@
>>  #include "sysemu/kvm.h"
>>  #include "migration/register.h"
>>  
>> -#define S390_SKEYS_BUFFER_SIZE 131072  /* Room for 128k storage keys */
>> +#define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage keys */
> 
> This one looks confusing to me. We're not allocating 128 chunks of 1
> KiB size, but space enough for 128k byte values. What do others think?

The idea is use the byte IEC binary prefix to make it more obvious.

If the unit is not 'byte', then this is not a correct use (confusing, as
you said).

> 
>>  #define S390_SKEYS_SAVE_FLAG_EOS 0x01
>>  #define S390_SKEYS_SAVE_FLAG_SKEYS 0x02
>>  #define S390_SKEYS_SAVE_FLAG_ERROR 0x04
>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>> index 70b95550a8..5161a1659b 100644
>> --- a/hw/s390x/s390-stattrib.c
>> +++ b/hw/s390x/s390-stattrib.c
>> @@ -10,6 +10,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>  #include "hw/boards.h"
>>  #include "cpu.h"
>>  #include "migration/qemu-file.h"
>> @@ -20,7 +21,7 @@
>>  #include "qapi/error.h"
>>  #include "qapi/qmp/qdict.h"
>>  
>> -#define CMMA_BLOCK_SIZE  (1 << 10)
>> +#define CMMA_BLOCK_SIZE  (1 * KiB)
> 
> This one looks fine.
> 
>>  
>>  #define STATTR_FLAG_EOS     0x01ULL
>>  #define STATTR_FLAG_MORE    0x02ULL
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 047d577313..bd2a024efd 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -13,6 +13,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>  #include "qapi/error.h"
>>  #include "cpu.h"
>>  #include "sysemu/sysemu.h"
>> @@ -289,7 +290,7 @@ static void sclp_realize(DeviceState *dev, Error **errp)
>>      ret = s390_set_memory_limit(machine->maxram_size, &hw_limit);
>>      if (ret == -E2BIG) {
>>          error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
>> -                   hw_limit >> 30);
>> +                   hw_limit / GiB);
>>      } else if (ret) {
>>          error_setg(&err, "setting the guest size failed");
>>      }
> 
