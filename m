Received: from eggs.gnu.org ([2001:4830:134:3::10]:55692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euIgn-0002wt-GG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euIgi-0008Ba-Hh
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:08:05 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euIgi-0008BI-Aa
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:08:00 -0500
Received: by mail-wr0-x22d.google.com with SMTP id v18so9143033wrv.0
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 06:08:00 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215220540.6556-1-f4bug@amsat.org>
	<20180215220540.6556-7-f4bug@amsat.org>
	<CAFEAcA9rkRtO7e9M8RTbmZDYf05EVdjyuDb9ftF63hUhk+QvKQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f9831a65-6144-c229-98d2-250cfb576226@amsat.org>
Date: Fri, 9 Mar 2018 15:07:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9rkRtO7e9M8RTbmZDYf05EVdjyuDb9ftF63hUhk+QvKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 06/11] sdcard: do not trace CMD55 when
 expecting ACMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

Hi Peter,

On 02/22/2018 01:01 PM, Peter Maydell wrote:
> On 15 February 2018 at 22:05, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>  hw/sd/sd.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 564f7a9bfd..af4df2b104 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -818,13 +818,15 @@ static void sd_lock_command(SDState *sd)
>>          sd->card_status &= ~CARD_IS_LOCKED;
>>  }
>>
>> -static sd_rsp_type_t sd_normal_command(SDState *sd,
>> -                                       SDRequest req)
>> +static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>>  {
>>      uint32_t rca = 0x0000;
>>      uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
>>
>> -    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->state));
>> +    if (req.cmd != 55 || sd->expecting_acmd) {
>> +        trace_sdcard_normal_command(req.cmd, req.arg,
>> +                                    sd_state_name(sd->state));
>> +    }
> 
> The commit message says "don't trace CMD55 when expecting ACMD",
> but the code says "don't trace CMD55 when *not* expecting ACMD" --
> which is correct?

If req.cmd == 55 we will expect an ACMD (setting sd->expecting_acmd =
true). Logging CMD55 is not interesting, since we prefer to log the ACMD
directly.

Now if we have another CMD55 after a CMD55, this is not an ACMD and we
want to log it.

I'll use the following message: "Do not trace CMD55, except when we
already expect an ACMD" and add the previous lines as comment.

Is that Ok to you? I don't have clearer if condition, the code looks
correct to me.

Thanks,

Phil.
