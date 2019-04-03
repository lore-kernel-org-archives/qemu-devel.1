Received: from eggs.gnu.org ([209.51.188.92]:57335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBaMU-0005xW-KU
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBaMT-0001ZQ-LD
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:31:06 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBaMS-0001X5-TX
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:31:05 -0400
Received: by mail-io1-xd43.google.com with SMTP id v4so13234744ioj.5
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 00:31:04 -0700 (PDT)
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-5-richard.henderson@linaro.org>
	<CAFEAcA_c+RSOmxHcoNueRtAoQAZZCfeSt-4F2GFe=BhSg_1jXg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <863b0e29-2eef-319a-10a0-1648259d8d4d@linaro.org>
Date: Wed, 3 Apr 2019 14:30:58 +0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_c+RSOmxHcoNueRtAoQAZZCfeSt-4F2GFe=BhSg_1jXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 04/26] target/arm: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 4/3/19 12:14 PM, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 10:44, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> 
>> +bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>> +                      MMUAccessType access_type, int mmu_idx,
>> +                      bool probe, uintptr_t retaddr)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(cs);
>> +
>> +#ifdef CONFIG_USER_ONLY
>> +    cpu->env.exception.vaddress = address;
>> +    if (access_type == MMU_INST_FETCH) {
>> +        cs->exception_index = EXCP_PREFETCH_ABORT;
>> +    } else {
>> +        cs->exception_index = EXCP_DATA_ABORT;
>> +    }
>> +    cpu_loop_exit_restore(cs, retaddr);
>> +#else
>> +    hwaddr phys_addr;
>> +    target_ulong page_size;
>> +    int prot, ret;
>> +    MemTxAttrs attrs = {};
>> +    ARMMMUFaultInfo fi = {};
>> +
>> +    /*
>> +     * Walk the page table and (if the mapping exists) add the page
>> +     * to the TLB. Return false on success, or true on failure. Populate
>> +     * fsr with ARM DFSR/IFSR fault register format value on failure.
>> +     */
> 
> This comment about what we return doesn't seem to match what
> the code is doing.

Bah.  The perils of copying comments while changing the function signature.


r~
