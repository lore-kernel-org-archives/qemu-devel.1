Received: from eggs.gnu.org ([2001:4830:134:3::10]:54293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eQN1F-0006Iy-0U
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 19:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eQN1C-0003ga-1V
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 19:41:26 -0500
MIME-Version: 1.0
In-Reply-To: <9b5f2a4a-2cdf-d3c1-c7b6-0c1ab7e7dabc@amsat.org>
References: <20171214145255.31545-1-andrew.smirnov@gmail.com>
	<20171214145255.31545-6-andrew.smirnov@gmail.com>
	<9b5f2a4a-2cdf-d3c1-c7b6-0c1ab7e7dabc@amsat.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Sat, 16 Dec 2017 16:41:21 -0800
Message-ID: <CAHQ1cqEbp-AaYOPii1F52ozvsO75rUOmwJGcUOurAofX0oQKEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/15] imx_fec: Use ENET_FTRL to
 determine truncation length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "open list:ARM" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Fri, Dec 15, 2017 at 2:15 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi Andrey,
>
> On 12/14/2017 11:52 AM, Andrey Smirnov wrote:
>> Frame truncation length, TRUNC_FL, is determined by the contents of
>> ENET_FTRL register, so convert the code to use it instead of a
>> hardcoded constant.
>>
>> To avoid the case where TRUNC_FL is greater that ENET_MAX_FRAME_SIZE,
>> increase the value of the latter to its theoretical maximum of 16K.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  hw/net/imx_fec.c         | 4 ++--
>>  include/hw/net/imx_fec.h | 3 ++-
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
>> index 56cb72273c..50da91bf9e 100644
>> --- a/hw/net/imx_fec.c
>> +++ b/hw/net/imx_fec.c
>> @@ -1052,8 +1052,8 @@ static ssize_t imx_enet_receive(NetClientState *nc=
, const uint8_t *buf,
>>      crc_ptr =3D (uint8_t *) &crc;
>>
>>      /* Huge frames are truncted.  */
>> -    if (size > ENET_MAX_FRAME_SIZE) {
>> -        size =3D ENET_MAX_FRAME_SIZE;
>> +    if (size > s->regs[ENET_FTRL]) {
>
> Shouldn't this be:
>
>        if (size > s->regs[ENET_FTRL] + 1) {
>
>> +        size =3D s->regs[ENET_FTRL];
>
> and:
>
>            size =3D s->regs[ENET_FTRL] + 1;
>

I haven't tried to reproduce this in real HW and verify the behavior,
so I can't say for a fact, but the datasheet seems to be pretty clear
about "ENETx_FTRL":

"Frame Truncation Length
Indicates the value a receive frame is truncated, if it is greater
than this value. Must be greater than or
equal to RCR[MAX_FL].
NOTE: Truncation happens at TRUNC_FL. However, when truncation occurs,
the application (FIFO) may
receive less data, guaranteeing that it never receives more than the set li=
mit."

so, having nothing better to go on than above description, I think the
original code is OK.


>>          flags |=3D ENET_BD_TR | ENET_BD_LG;
>>      }
>>
>> diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
>> index 67993870a2..a390d704a6 100644
>> --- a/include/hw/net/imx_fec.h
>> +++ b/include/hw/net/imx_fec.h
>> @@ -86,7 +86,6 @@
>>  #define ENET_TCCR3             393
>>  #define ENET_MAX               400
>>
>> -#define ENET_MAX_FRAME_SIZE    2032
>>
>>  /* EIR and EIMR */
>>  #define ENET_INT_HB            (1 << 31)
>> @@ -155,6 +154,8 @@
>>  #define ENET_RCR_NLC           (1 << 30)
>>  #define ENET_RCR_GRS           (1 << 31)
>>
>> +#define ENET_MAX_FRAME_SIZE    (1 << ENET_RCR_MAX_FL_LENGTH)
>> +
>>  /* TCR */
>>  #define ENET_TCR_GTS           (1 << 0)
>>  #define ENET_TCR_FDEN          (1 << 2)
>>
