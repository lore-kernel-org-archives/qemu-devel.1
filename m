Received: from eggs.gnu.org ([2001:4830:134:3::10]:46655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TB2-0001tQ-IZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TAt-000733-40
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:00:32 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:49589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0TAs-00072Q-T8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:00:23 -0400
Received: by mail-wm0-x232.google.com with SMTP id b189so7766970wmd.4
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:00:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9a757d6e-6745-9df4-7199-d55ee2510d8f@amsat.org>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-6-andrew.smirnov@gmail.com>
	<9a757d6e-6745-9df4-7199-d55ee2510d8f@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 15:00:00 +0100
Message-ID: <CAFEAcA_KTvAN8qa7Qq=kxKSVgJQLQJ++BguQsVHB6PGiFuoFvg@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 30 September 2017 at 01:17, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> Hi Andrey,
>
> On 09/18/2017 04:50 PM, Andrey Smirnov wrote:
>>
>> Frame truncation length, TRUNC_FL, is determined by the contents of
>> ENET_FTRL register, so convert the code to use it instead of a
>> hardcoded constant.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>   hw/net/imx_fec.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
>> index 767402909d..989c11be5f 100644
>> --- a/hw/net/imx_fec.c
>> +++ b/hw/net/imx_fec.c
>> @@ -1050,8 +1050,8 @@ static ssize_t imx_enet_receive(NetClientState *nc=
,
>> const uint8_t *buf,
>>       size +=3D 4;
>>         /* Huge frames are truncted.  */
>> -    if (size > ENET_MAX_FRAME_SIZE) {
>> -        size =3D ENET_MAX_FRAME_SIZE;
>> +    if (size > s->regs[ENET_FTRL]) {
>> +        size =3D s->regs[ENET_FTRL]; >           flags |=3D ENET_BD_TR =
|
>> ENET_BD_LG;
>>       }
>
>
> for this to be ok you need to update imx_enet_write(), such:
>
>      case ENET_FTRL:
> -        s->regs[index] =3D value & 0x00003fff;
> +        value &=3D 0x00003fff;
> +        if (value > ENET_MAX_FRAME_SIZE) {
> +            warn_report("%s: guest requested bigger "
> +                        "frame size than QEMU supports "
> +                        "(%u > %u)", value,
> +                        ENET_MAX_FRAME_SIZE);
> +            value =3D ENET_MAX_FRAME_SIZE;
> +        }
> +        s->regs[index] =3D value;
>          break;

Yes, and also an incoming-migration post_load callback that
fails migration if the value is too large.

It might be simpler to truncate to the smaller of the ENET_FTRL
register value and ENET_MAX_FRAME_SIZE.

(PS: what is the hardware behaviour if ENET_FTRL is set to
a larger value than ENET_MAX_FRAME_SIZE ?)

thanks
-- PMM
