Received: from eggs.gnu.org ([2001:4830:134:3::10]:39370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPEV2-0005SN-Be
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cPEUz-0006ki-6q
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:19:00 -0500
Received: from relay4-d.mail.gandi.net ([2001:4b98:c:538::196]:51039)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cPEUy-0006kc-TT
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:18:57 -0500
References: <20170103211705.27876-1-jcd@tribudubois.net>
	<CAFEAcA91iJ_8MeKmMp7_fDfdc+aKLHHs4--CyYh=0FQP+SmxLw@mail.gmail.com>
	<ea377760-4e9e-a5c7-2d2d-ccf8112b23c7@gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <6206996c-51ad-d561-f98a-f39702c3c826@tribudubois.net>
Date: Thu, 5 Jan 2017 21:18:21 +0100
MIME-Version: 1.0
In-Reply-To: <ea377760-4e9e-a5c7-2d2d-ccf8112b23c7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] [m25p80] Abort in case we overrun the
 internal data buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Le 05/01/2017 à 21:04, mar.krzeminski a écrit :
> Hi Peter,
>
> W dniu 05.01.2017 o 19:38, Peter Maydell pisze:
>> On 3 January 2017 at 21:17, Jean-Christophe Dubois 
>> <jcd@tribudubois.net> wrote:
>>> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
>>> ---
>>>   hw/block/m25p80.c | 19 +++++++++++++++++--
>>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>>> index d29ff4c..6c374cf 100644
>>> --- a/hw/block/m25p80.c
>>> +++ b/hw/block/m25p80.c
>>> @@ -28,6 +28,7 @@
>>>   #include "hw/ssi/ssi.h"
>>>   #include "qemu/bitops.h"
>>>   #include "qemu/log.h"
>>> +#include "qemu/error-report.h"
>>>   #include "qapi/error.h"
>>>
>>>   #ifndef M25P80_ERR_DEBUG
>>> @@ -376,6 +377,8 @@ typedef enum {
>>>       MAN_GENERIC,
>>>   } Manufacturer;
>>>
>>> +#define _INTERNAL_DATA_SIZE 16
>>> +
>> Don't use leading underscores, please.
>>
>>>   typedef struct Flash {
>>>       SSISlave parent_obj;
>>>
>>> @@ -386,7 +389,7 @@ typedef struct Flash {
>>>       int page_size;
>>>
>>>       uint8_t state;
>>> -    uint8_t data[16];
>>> +    uint8_t data[_INTERNAL_DATA_SIZE];
>>>       uint32_t len;
>>>       uint32_t pos;
>>>       uint8_t needed_bytes;
>>> @@ -1114,6 +1117,12 @@ static uint32_t m25p80_transfer8(SSISlave 
>>> *ss, uint32_t tx)
>>>
>>>       case STATE_COLLECTING_DATA:
>>>       case STATE_COLLECTING_VAR_LEN_DATA:
>>> +
>>> +        if (s->len >= _INTERNAL_DATA_SIZE) {
>>> +            error_report("Bug - Write overrun internal data buffer");
>>> +            abort();
>>> +        }
>>> +
>>>           s->data[s->len] = (uint8_t)tx;
>>>           s->len++;
>>>
>>> @@ -1123,6 +1132,12 @@ static uint32_t m25p80_transfer8(SSISlave 
>>> *ss, uint32_t tx)
>>>           break;
>>>
>>>       case STATE_READING_DATA:
>>> +
>>> +        if (s->pos >= _INTERNAL_DATA_SIZE) {
>>> +            error_report("Bug - Read overrun internal data buffer");
>>> +            abort();
>>> +        }
>>> +
>> If these are "can't happen unless some other part of QEMU
>> is buggy" cases, then we can just assert():
>>
>>      assert(s->pos < ARRAY_SIZE(s->data));
>>
>> A comment about what kind of other part of QEMU might be buggy
>> if the assertion fires would also be helpful for future readers.
>>
>> (If they're "could happen if the guest does something wrong"
>> cases, we shouldn't just abort(), but if I'm reading the previous
>> mail thread correctly, that's not the situation here.)
> Indeed this case is about error in Qemu itself, but the same situation 
> could
> be generated from the guest (guest deasert CS only once).
> IMHO we should reset m26p80 state in such case:
> s->len = 0;
> s->pos = 0;
> s->state = STATE_IDLE;
> This will be a bit closer to real HW behaviour too.

So what would be the preferred behavior?

  * Asserting (and ending Qemu)
  * Resetting (and hiding the misbehavior).

JC


>
> Thanks,
> Marcin
>
>>
>>>           r = s->data[s->pos];
>>>           s->pos++;
>>>           if (s->pos == s->len) {
>>> @@ -1195,7 +1210,7 @@ static const VMStateDescription vmstate_m25p80 
>>> = {
>>>       .pre_save = m25p80_pre_save,
>>>       .fields = (VMStateField[]) {
>>>           VMSTATE_UINT8(state, Flash),
>>> -        VMSTATE_UINT8_ARRAY(data, Flash, 16),
>>> +        VMSTATE_UINT8_ARRAY(data, Flash, _INTERNAL_DATA_SIZE),
>>>           VMSTATE_UINT32(len, Flash),
>>>           VMSTATE_UINT32(pos, Flash),
>>>           VMSTATE_UINT8(needed_bytes, Flash),
>>> -- 
>>> 2.9.3
>> thanks
>> -- PMM
>>
>
>
