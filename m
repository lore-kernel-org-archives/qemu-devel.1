Received: from eggs.gnu.org ([2001:4830:134:3::10]:37964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fgk-0003oj-Im
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fgh-0006SH-Sg
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:39:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-7-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKNfzT3P_=CuNhCfXG-_LnJnaZGri+sWqpLk3RAgr_OJqA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3d8c50d6-64fe-6c4b-35c2-3e923c2fe698@amsat.org>
Date: Sat, 13 May 2017 19:38:55 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNfzT3P_=CuNhCfXG-_LnJnaZGri+sWqpLk3RAgr_OJqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 06/13] arm: Don't let no-MPU
 PMSA cores write to SCTLR.M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On 05/03/2017 06:30 PM, Alistair Francis wrote:
> On Tue, Apr 25, 2017 at 5:07 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> If the CPU is a PMSA config with no MPU implemented, then the
>> SCTLR.M bit should be RAZ/WI, so that the guest can never
>> turn on the non-existent MPU.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
> Thanks,
>
> Alistair
>
>> ---
>>  target/arm/helper.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 404bfdb..f0f25c8 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -3258,6 +3258,11 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>          return;
>>      }
>>
>> +    if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
>> +        /* M bit is RAZ/WI for PMSA with no MPU implemented */
>> +        value &= ~SCTLR_M;
>> +    }
>> +
>>      raw_write(env, ri, value);
>>      /* ??? Lots of these bits are not implemented.  */
>>      /* This may enable/disable the MMU, so do a TLB flush.  */
>> --
>> 2.7.4
>>
>>
>
