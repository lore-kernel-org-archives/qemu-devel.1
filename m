Received: from eggs.gnu.org ([2001:4830:134:3::10]:41042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epINX-00075a-RD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epINU-0003Uh-Jh
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:47:31 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:37521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epINU-0003TX-CF
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:47:28 -0500
Received: by mail-pl0-x241.google.com with SMTP id ay8so5371090plb.4
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:47:28 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-2-richard.henderson@linaro.org>
	<877er3abex.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cba5d6f3-a3bf-d799-ee79-7425887421c0@linaro.org>
Date: Fri, 23 Feb 2018 10:47:24 -0800
MIME-Version: 1.0
In-Reply-To: <877er3abex.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 01/67] target/arm: Enable SVE
 for aarch64-linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 02/23/2018 09:00 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Enable ARM_FEATURE_SVE for the generic "any" cpu.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.c   | 7 +++++++
>>  target/arm/cpu64.c | 1 +
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 1b3ae62db6..10843994c3 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -150,6 +150,13 @@ static void arm_cpu_reset(CPUState *s)
>>          env->cp15.sctlr_el[1] |= SCTLR_UCT | SCTLR_UCI | SCTLR_DZE;
>>          /* and to the FP/Neon instructions */
>>          env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 2, 3);
>> +        /* and to the SVE instructions */
>> +        env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
>> +        env->cp15.cptr_el[3] |= CPTR_EZ;
>> +        /* with maximum vector length */
>> +        env->vfp.zcr_el[1] = ARM_MAX_VQ - 1;
>> +        env->vfp.zcr_el[2] = ARM_MAX_VQ - 1;
>> +        env->vfp.zcr_el[3] = ARM_MAX_VQ - 1;
>>  #else
> 
> I notice this is linux-user only but what happens if you specify a
> specific CPU in linux-user mode, do we still end up running SVE specific
> initialisation?
> 
> It seems to me that we should be seeing feature guarded reset stuff in here.

You're right.  On the whole (probably) wouldn't matter in the end because the
actual insn decode would still be protected by ARM_FEATURE_SVE.  But even so
we'd see VQ=16 in the TB flags and do too much work in clear_high_part.


r~
