Received: from eggs.gnu.org ([2001:4830:134:3::10]:43418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fcI0g-0000vF-VH
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 18:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fcI0f-0000TN-QI
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 18:18:26 -0400
References: <20180627232951.14725-1-laurent@vivier.eu>
	<20180627232951.14725-10-laurent@vivier.eu>
	<CAFEAcA-T4+fc62yOL4mGd=_v_0vPLcCR94apqWf=k3DA9HkLuA@mail.gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <7225a30e-0112-8b8b-f121-d133769ad62e@reactos.org>
Date: Mon, 9 Jul 2018 00:17:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-T4+fc62yOL4mGd=_v_0vPLcCR94apqWf=k3DA9HkLuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v3 09/10] dp8393x: manage big endian bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

Le 08/07/2018 à 23:11, Peter Maydell a écrit :
> On 28 June 2018 at 00:29, Laurent Vivier <laurent@vivier.eu> wrote:
>> This is needed by Quadra 800, this card can run on little-endian
>> or big-endian bus.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> Tested-by: Hervé Poussineau <hpoussin@reactos.org>
>> ---
>>   hw/net/dp8393x.c | 88 ++++++++++++++++++++++++++++++++++++--------------------
>>   1 file changed, 57 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>> index f2d2ce344c..62adff9ba3 100644
>> --- a/hw/net/dp8393x.c
>> +++ b/hw/net/dp8393x.c
>> @@ -150,6 +150,7 @@ typedef struct dp8393xState {
>>
>>       /* Hardware */
>>       uint8_t it_shift;
>> +    bool big_endian;
>>       qemu_irq irq;
>>   #ifdef DEBUG_SONIC
>>       int irq_level;
>> @@ -220,6 +221,29 @@ static uint32_t dp8393x_wt(dp8393xState *s)
>>       return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
>>   }
>>
>> +static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
>> +                            int offset)
>> +{
>> +    uint16_t val;
>> +
>> +    if (s->big_endian) {
>> +        val = be16_to_cpu(base[offset * width + width - 1]);
>> +    } else {
>> +        val = le16_to_cpu(base[offset * width]);
>> +    }
>> +    return val;
>> +}
>> +
>> +static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
>> +                        uint16_t val)
>> +{
>> +    if (s->big_endian) {
>> +        base[offset * width + width - 1] = cpu_to_be16(val);
>> +    } else {
>> +        base[offset * width] = cpu_to_le16(val);
>> +    }
>> +}
>> +
>>   static void dp8393x_update_irq(dp8393xState *s)
>>   {
>>       int level = (s->regs[SONIC_IMR] & s->regs[SONIC_ISR]) ? 1 : 0;
>> @@ -251,12 +275,12 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>>           /* Fill current entry */
>>           address_space_rw(&s->as, dp8393x_cdp(s),
>>               MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
>> -        s->cam[index][0] = data[1 * width] & 0xff;
>> -        s->cam[index][1] = data[1 * width] >> 8;
>> -        s->cam[index][2] = data[2 * width] & 0xff;
>> -        s->cam[index][3] = data[2 * width] >> 8;
>> -        s->cam[index][4] = data[3 * width] & 0xff;
>> -        s->cam[index][5] = data[3 * width] >> 8;
>> +        s->cam[index][0] = dp8393x_get(s, width, data, 1) & 0xff;
>> +        s->cam[index][1] = dp8393x_get(s, width, data, 1) >> 8;
>> +        s->cam[index][2] = dp8393x_get(s, width, data, 2) & 0xff;
>> +        s->cam[index][3] = dp8393x_get(s, width, data, 2) >> 8;
>> +        s->cam[index][4] = dp8393x_get(s, width, data, 3) & 0xff;
>> +        s->cam[index][5] = dp8393x_get(s, width, data, 3) >> 8;
> 
> The general pattern with the code in this device seems to be
> "load sizeof(uint16_t) * width * N bytes; then look at
> data[i * width], possibly with an endianness flip", where
> width is either 1 or 2 depending on a config register.
> 
> Maybe it would be clearer if the data was loaded by doing a
> loop of N iterations of address_space_ldl_le / address_space_ldw_le /
> address_space_ldl_be / address_space_ldw_be ? Then you're doing
> something more like what the device is doing (ie a series of
> bus accesses of a particular width and endianness), and the
> handling of width and endianness is in the code doing the data
> loads rather than in the code that is manipulating the loaded
> data.
> 
> Incidentally, the only other use of this device is in
> the mips 'jazz' boards. Those seem to be compiled for both
> mips64el and mips64 -- does anybody know if it actually
> works correctly in both those configurations ?

dp8393x in mips64el works well. mips64 is not testable.

Hervé
