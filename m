Received: from eggs.gnu.org ([2001:4830:134:3::10]:44223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAEVe-0002O2-Cz
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAEVb-0007HM-9N
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:49:54 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAEVb-0007H1-4A
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:49:51 -0400
Received: by mail-qt0-x244.google.com with SMTP id r58so14995109qtb.2
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 04:49:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170505125718.18337-1-julien@gns3.net>
	<4f8b9366-6eab-3d36-6e2b-f3ad19aa71b7@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <236b8452-4975-69b7-7d80-180b2b527f50@amsat.org>
Date: Mon, 15 May 2017 08:49:47 -0300
MIME-Version: 1.0
In-Reply-To: <4f8b9366-6eab-3d36-6e2b-f3ad19aa71b7@amsat.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Disable the not fully implemented warning
 for e1000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julien Duponchelle <julien@gns3.net>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com

Hi Julien,

> On 05/05/2017 09:57 AM, Julien Duponchelle wrote:
>> Otherwise for image like CISCO IOSv you got a lot
>> of warning on the console preventing you to use
>> the VM because it's slow down the machine.
>>
>> This fix:
>> https://bugs.launchpad.net/qemu/+bug/1673722
>>
>> Signed-off-by: Julien Duponchelle <julien@gns3.net>
>> ---
>>  hw/net/e1000.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
>> index f2e5072d27..095fd0133f 100644
>> --- a/hw/net/e1000.c
>> +++ b/hw/net/e1000.c
>> @@ -35,6 +35,7 @@
>>  #include "sysemu/dma.h"
>>  #include "qemu/iov.h"
>>  #include "qemu/range.h"
>> +#include "qemu/log.h"
>>
>>  #include "e1000x_common.h"
>>
>> @@ -1264,8 +1265,9 @@ e1000_mmio_write(void *opaque, hwaddr addr,
>> uint64_t val,
>>          if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
>>              || (s->compat_flags & (mac_reg_access[index] >> 2))) {
>>              if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
>> -                DBGOUT(GENERAL, "Writing to register at offset:
>> 0x%08x. "
>> -                       "It is not fully implemented.\n", index<<2);
>> +                qemu_log_mask(LOG_UNIMP, "e1000: "
>> +                        "Writing to register at offset: 0x%08x. "
>> +                        "It is not fully implemented.\n", index << 2);
>
> trailing newline is no more necessary.

I mistaken with error_report(), qemu_log_mask() do use trailing newline, 
sorry!

>
> what about:
>                 qemu_log_mask(LOG_UNIMP, "%s: write to unimplemented "
>                               "register addr=0x%05x val=0x%08" PRIx64,
>                                __func__, index << 2, val);
>
>>              }
>>              macreg_writeops[index](s, index, val);
>>          } else {    /* "flag needed" bit is set, but the flag is not
>> active */
>> @@ -1291,8 +1293,9 @@ e1000_mmio_read(void *opaque, hwaddr addr,
>> unsigned size)
>>          if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
>>              || (s->compat_flags & (mac_reg_access[index] >> 2))) {
>>              if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
>> -                DBGOUT(GENERAL, "Reading register at offset: 0x%08x. "
>> -                       "It is not fully implemented.\n", index<<2);
>> +                qemu_log_mask(LOG_UNIMP, "e1000: "
>> +                        "Reading register at offset: 0x%08x. "
>> +                        "It is not fully implemented.\n", index << 2);
>
>                 qemu_log_mask(LOG_UNIMP, "%s: read  to unimplemented "
>                               "register addr=0x%05x" PRIx64, __func__,
>                               index << 2);
>
>>              }
>>              return macreg_readops[index](s, index);
>>          } else {    /* "flag needed" bit is set, but the flag is not
>> active */
>>
>
> Regard,
>
> Phil.
