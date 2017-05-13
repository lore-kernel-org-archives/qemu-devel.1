Received: from eggs.gnu.org ([2001:4830:134:3::10]:39948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fvm-0001Vv-KN
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fvj-0004Ls-JT
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:54:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-2-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKMPX+=acJqRKkncy=s4G3C04Q8grD9PdSiPs8f1RuVRxg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <85907ff4-9947-d5b2-5ec4-7d64fbd6c3e8@amsat.org>
Date: Sat, 13 May 2017 19:54:26 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMPX+=acJqRKkncy=s4G3C04Q8grD9PdSiPs8f1RuVRxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/13] arm: Use the mmu_idx we're passed in
 arm_cpu_do_unaligned_access()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On 05/02/2017 07:05 PM, Alistair Francis wrote:
> On Tue, Apr 25, 2017 at 5:06 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> When identifying the DFSR format for an alignment fault, use
>> the mmu index that we are passed, rather than calling cpu_mmu_index()
>> to get the mmu index for the current CPU state. This doesn't actually
>> make any difference since the only cases where the current MMU index
>> differs from the index used for the load are the "unprivileged
>> load/store" instructions, and in that case the mmu index may
>> differ but the translation regime is the same (apart from the
>> "use from Hyp mode" case which is UNPREDICTABLE).
>> However it's the more logical thing to do.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Thanks,
>
> Alistair
>
>> ---
>>  target/arm/op_helper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
>> index 156b825..de24815 100644
>> --- a/target/arm/op_helper.c
>> +++ b/target/arm/op_helper.c
>> @@ -208,7 +208,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>>      /* the DFSR for an alignment fault depends on whether we're using
>>       * the LPAE long descriptor format, or the short descriptor format
>>       */
>> -    if (arm_s1_regime_using_lpae_format(env, cpu_mmu_index(env, false))) {
>> +    if (arm_s1_regime_using_lpae_format(env, mmu_idx)) {
>>          env->exception.fsr = (1 << 9) | 0x21;
>>      } else {
>>          env->exception.fsr = 0x1;
>> --
>> 2.7.4
>>
>>
>
