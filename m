Received: from eggs.gnu.org ([2001:4830:134:3::10]:43138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCrag-0004Mr-Up
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCrac-0002CB-S0
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:34:46 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCrac-0002Bh-Cn
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:34:42 -0400
Received: by mail-pg1-x543.google.com with SMTP id 23-v6so12997161pgc.8
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 12:34:42 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-13-aclindsa@gmail.com>
	<0fdcad4a-c8b5-3309-d2ce-f9be901ec52a@linaro.org>
	<20181017192013.GA25905@quinoa.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <31f327f4-42ee-55fc-596d-97d935803867@linaro.org>
Date: Wed, 17 Oct 2018 12:34:37 -0700
MIME-Version: 1.0
In-Reply-To: <20181017192013.GA25905@quinoa.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 12/14] target/arm: PMU: Set PMCR.N to 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <Aaron@os.amperecomputing.com>
Cc: Aaron Lindsay <aclindsa@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Digant Desai <digantd@codeaurora.org>

On 10/17/18 12:20 PM, Aaron Lindsay wrote:
> On Oct 16 17:09, Richard Henderson wrote:
>> On 10/10/18 1:37 PM, Aaron Lindsay wrote:
>>> This both advertises that we support four counters and enables them
>>> because the pmu_num_counters() reads this value from PMCR.
>>>
>>> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
>>> ---
>>>  target/arm/helper.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> It looks like this should have been folded into patch 10,
>> or patch 10 split to include the code changes that go with
>> these comment changes.
> 
> By setting PMCR.N to 4, this commit is what causes all the previous
> implementation of non-PMCCNTR counters to become usable by the guest -
> both because the OS can now detect their presence in PMCR, and because
> the system registers used to setup/access the counters are gated on
> pmu_num_counters(), which uses PMCR.N to determine if a counter is
> implemented.

But e.g.

> @@ -5412,8 +5412,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      }
>      if (arm_feature(env, ARM_FEATURE_V7)) {
>          /* v7 performance monitor control register: same implementor
> -         * field as main ID register, and we implement only the cycle
> -         * count register.
> +         * field as main ID register, and we implement four counters in
> +         * addition to the cycle count register.
>           */
>          unsigned int i, pmcrn = 4;
>          ARMCPRegInfo pmcr = {

clearly belongs with the previous patch, since pmcrn is already 4.

> @@ -1706,7 +1706,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .access = PL1_W, .type = ARM_CP_NOP },
>      /* Performance monitors are implementation defined in v7,
>       * but with an ARM recommended set of registers, which we
> -     * follow (although we don't actually implement any counters)
> +     * follow.
>       *
>       * Performance registers fall into three categories:
>       *  (a) always UNDEF in PL0, RW in PL1 (PMINTENSET, PMINTENCLR)

And this is out of date as well, and probably belonged elsewhere.
Which leaves only

> @@ -5430,7 +5430,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              .access = PL0_RW, .accessfn = pmreg_access,
>              .type = ARM_CP_IO,
>              .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
> -            .resetvalue = cpu->midr & 0xff000000,
> +            .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT),
>              .writefn = pmcr_write, .raw_writefn = raw_write,
>          };

which suggests that this one line belonged to the patch that set pmcrn in the
first place.


r~
