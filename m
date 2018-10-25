Received: from eggs.gnu.org ([2001:4830:134:3::10]:44409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gFmMP-0001U5-5Q
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gFm7q-0002tj-Bk
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:21:03 -0400
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-3-mark.cave-ayland@ilande.co.uk>
	<ab0a9972-57a5-1d97-22f4-13c5c58248bc@posteo.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e86ff3a4-824c-fcff-f743-583ee909b169@ilande.co.uk>
Date: Thu, 25 Oct 2018 21:20:35 +0100
MIME-Version: 1.0
In-Reply-To: <ab0a9972-57a5-1d97-22f4-13c5c58248bc@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 02/11] hw/m68k: implement ADB bus
 support for via
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <th.huth@posteo.de>, qemu-devel@nongnu.org, laurent@vivier.eu
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, yongbok.kim@mips.com, aurelien@aurel32.net

On 23/10/2018 07:49, Thomas Huth wrote:

> On 2018-10-18 19:28, Mark Cave-Ayland wrote:
>> From: Laurent Vivier <laurent@vivier.eu>
>>
>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  hw/input/adb.c            |   2 +
>>  hw/misc/mac_via.c         | 166 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/misc/mac_via.h |   7 ++
>>  3 files changed, 175 insertions(+)
>>
>> diff --git a/hw/input/adb.c b/hw/input/adb.c
>> index bbb40aeef1..d69ca74364 100644
>> --- a/hw/input/adb.c
>> +++ b/hw/input/adb.c
>> @@ -25,6 +25,8 @@
>>  #include "hw/input/adb.h"
>>  #include "adb-internal.h"
>>  
>> +#define ADB_POLL_FREQ 50
> 
> A single define without a user in a .c file? Looks suspicious...
> 
> As far as I can see, this has been replace by VIA_ADB_POLL_FREQ which
> has been introduced in the previous patch already, so you can remove
> this define here.

Ooops yes, this should have been removed from my previous refactoring - I've now
fixed this.

>>  /* error codes */
>>  #define ADB_RET_NOTPRESENT (-2)
>>  
>> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
>> index 084974a24d..1ec563a707 100644
>> --- a/hw/misc/mac_via.c
>> +++ b/hw/misc/mac_via.c
> [...]
>> +static int adb_via_send(MacVIAState *s, int state, uint8_t data)
>> +{
>> +    switch (state) {
>> +    case ADB_STATE_NEW:
>> +        s->adb_data_out_index = 0;
>> +        break;
>> +    case ADB_STATE_EVEN:
>> +        if ((s->adb_data_out_index & 1) == 0) {
>> +            return 0;
>> +        }
>> +        break;
>> +    case ADB_STATE_ODD:
>> +        if (s->adb_data_out_index & 1) {
>> +            return 0;
>> +        }
>> +        break;
>> +    case ADB_STATE_IDLE:
>> +        return 0;
>> +    }
> 
> Could you please add a
> 
>  assert(s->adb_data_out_index < sizeof(s->adb_data_out) -1);
> 
> here, just in case?

Done.

>> +    s->adb_data_out[s->adb_data_out_index++] = data;
>> +    qemu_irq_raise(s->adb_data_ready);
>> +    return 1;
>> +}
>> +
>> +static int adb_via_receive(MacVIAState *s, int state, uint8_t *data)
>> +{
>> +    switch (state) {
>> +    case ADB_STATE_NEW:
>> +        return 0;
>> +    case ADB_STATE_EVEN:
>> +        if (s->adb_data_in_size <= 0) {
>> +            qemu_irq_raise(s->adb_data_ready);
>> +            return 0;
>> +        }
>> +        if (s->adb_data_in_index >= s->adb_data_in_size) {
>> +            *data = 0;
>> +            qemu_irq_raise(s->adb_data_ready);
>> +            return 1;
>> +        }
>> +        if ((s->adb_data_in_index & 1) == 0) {
>> +            return 0;
>> +        }
>> +        break;
>> +    case ADB_STATE_ODD:
>> +        if (s->adb_data_in_size <= 0) {
>> +            qemu_irq_raise(s->adb_data_ready);
>> +            return 0;
>> +        }
>> +        if (s->adb_data_in_index >= s->adb_data_in_size) {
>> +            *data = 0;
>> +            qemu_irq_raise(s->adb_data_ready);
>> +            return 1;
>> +        }
>> +        if (s->adb_data_in_index & 1) {
>> +            return 0;
>> +        }
>> +        break;
>> +    case ADB_STATE_IDLE:
>> +        if (s->adb_data_out_index == 0) {
>> +            return 0;
>> +        }
>> +        s->adb_data_in_size = adb_request(&s->adb_bus, s->adb_data_in,
>> +                                          s->adb_data_out,
>> +                                          s->adb_data_out_index);
>> +        s->adb_data_out_index = 0;
>> +        s->adb_data_in_index = 0;
>> +        if (s->adb_data_in_size < 0) {
>> +            *data = 0xff;
>> +            qemu_irq_raise(s->adb_data_ready);
>> +            return -1;
>> +        }
>> +        if (s->adb_data_in_size == 0) {
>> +            return 0;
>> +        }
>> +        break;
>> +    }
> 
> Please also add an assert before the next line here - just in case...

And also done here.

>> +    *data = s->adb_data_in[s->adb_data_in_index++];
>> +    qemu_irq_raise(s->adb_data_ready);
>> +    if (*data == 0xff || *data == 0) {
>> +        return 0;
>> +    }
>> +    return 1;
>> +}


ATB,

Mark.
