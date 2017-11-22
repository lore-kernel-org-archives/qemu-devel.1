Received: from eggs.gnu.org ([2001:4830:134:3::10]:52005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbX3-0000yh-OD
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbX2-0005WT-Kr
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:22:05 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9EhzPxayCGDOiM_6U9YSS6HK1gCgBroR=C1LM=H=FpQw@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-5-andrew.smirnov@gmail.com>
	<CAFEAcA9EhzPxayCGDOiM_6U9YSS6HK1gCgBroR=C1LM=H=FpQw@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 22 Nov 2017 12:22:00 -0800
Message-ID: <CAHQ1cqEW202FqhrNpXOvWTT9s-H-ZGrmdAFTeynRc6VnOia6Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/30] imx_fec: Use ENET_FTRL to
 determine truncation length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Nov 21, 2017 at 9:31 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
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
>> index eb034ffd0c..dda0816fb3 100644
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
>> +        size =3D s->regs[ENET_FTRL];
>>          flags |=3D ENET_BD_TR | ENET_BD_LG;
>>      }
>>
>> diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
>> index 4bc8f03ec2..0fcc4f0c71 100644
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
>
> This means we now have functions with 16K local array
> variables on the stack, which seems like a bad idea.
>

Can't say I see a big difference between having a 2K vs 16K buffer on
the stack, but regardless, I am not quite clear if you are not too hot
about this patch and want me to drop it (I am fine with it) or do you
want me to modify it to have the emulation layer allocate said 16K
buffer on the heap instead of a stack?

Thanks,
Andrey Smirnov
