Received: from eggs.gnu.org ([2001:4830:134:3::10]:39870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1e1Zqb-0000Kv-QY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1e1Zqa-0005IT-MM
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:20:01 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_KTvAN8qa7Qq=kxKSVgJQLQJ++BguQsVHB6PGiFuoFvg@mail.gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-6-andrew.smirnov@gmail.com>
	<9a757d6e-6745-9df4-7199-d55ee2510d8f@amsat.org>
	<CAFEAcA_KTvAN8qa7Qq=kxKSVgJQLQJ++BguQsVHB6PGiFuoFvg@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 9 Oct 2017 08:19:51 -0700
Message-ID: <CAHQ1cqEtbjLG0cOEFB5p34XCZ-=OuQ0OO_TJv2030q_nsUtK-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/17] imx_fec: Use ENET_FTRL to determine
 truncation length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Fri, Oct 6, 2017 at 7:00 AM, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On 30 September 2017 at 01:17, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>> Hi Andrey,
>>
>> On 09/18/2017 04:50 PM, Andrey Smirnov wrote:
>>>
>>> Frame truncation length, TRUNC_FL, is determined by the contents of
>>> ENET_FTRL register, so convert the code to use it instead of a
>>> hardcoded constant.
>>>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Cc: Jason Wang <jasowang@redhat.com>
>>> Cc: qemu-devel@nongnu.org
>>> Cc: qemu-arm@nongnu.org
>>> Cc: yurovsky@gmail.com
>>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>>> ---
>>>   hw/net/imx_fec.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
>>> index 767402909d..989c11be5f 100644
>>> --- a/hw/net/imx_fec.c
>>> +++ b/hw/net/imx_fec.c
>>> @@ -1050,8 +1050,8 @@ static ssize_t imx_enet_receive(NetClientState *n=
c,
>>> const uint8_t *buf,
>>>       size +=3D 4;
>>>         /* Huge frames are truncted.  */
>>> -    if (size > ENET_MAX_FRAME_SIZE) {
>>> -        size =3D ENET_MAX_FRAME_SIZE;
>>> +    if (size > s->regs[ENET_FTRL]) {
>>> +        size =3D s->regs[ENET_FTRL]; >           flags |=3D ENET_BD_TR=
 |
>>> ENET_BD_LG;
>>>       }
>>
>>
>> for this to be ok you need to update imx_enet_write(), such:
>>
>>      case ENET_FTRL:
>> -        s->regs[index] =3D value & 0x00003fff;
>> +        value &=3D 0x00003fff;
>> +        if (value > ENET_MAX_FRAME_SIZE) {
>> +            warn_report("%s: guest requested bigger "
>> +                        "frame size than QEMU supports "
>> +                        "(%u > %u)", value,
>> +                        ENET_MAX_FRAME_SIZE);
>> +            value =3D ENET_MAX_FRAME_SIZE;
>> +        }
>> +        s->regs[index] =3D value;
>>          break;
>
> Yes, and also an incoming-migration post_load callback that
> fails migration if the value is too large.
>
> It might be simpler to truncate to the smaller of the ENET_FTRL
> register value and ENET_MAX_FRAME_SIZE.
>
> (PS: what is the hardware behaviour if ENET_FTRL is set to
> a larger value than ENET_MAX_FRAME_SIZE ?)
>

I haven't tested it in practice, but I assume that hardware should be
capable of receiving packets of up to ENET_RCR[MAX_FL] bytes big (both
RCR[MAX_FL] and FTRL are 14-bits), since that would allow supporting
networks with jumbo frames.

What if ENET_MAX_FRAME_SIZE is increased to 16K instead? Would that
make all of that additional error checking code unnecessary?

Thanks,
Andrey Smirnov

P.S: And sure, I'll fix the typo in v2.
