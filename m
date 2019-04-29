Received: from eggs.gnu.org ([209.51.188.92]:32882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL8Gd-0007k0-Qy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL8Ga-0002ca-FE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:32:30 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hL8Ga-0002US-7A
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:32:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id d9so5237666pls.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:32:28 -0700 (PDT)
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-33-richard.henderson@linaro.org>
	<CAFEAcA-uRsaN7zPSWO5Ga8UnYHEbF5MdEKmnbt07N9nDoOXZ8A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <23ce5069-3f36-5f18-c815-275bf9dfc83f@linaro.org>
Date: Mon, 29 Apr 2019 08:32:20 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-uRsaN7zPSWO5Ga8UnYHEbF5MdEKmnbt07N9nDoOXZ8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 32/36] cpu: Move icount_decr to
 CPUNegativeOffsetState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4/29/19 7:48 AM, Peter Maydell wrote:
>> -static void align_clocks(SyncClocks *sc, const CPUState *cpu)
>> +static void align_clocks(SyncClocks *sc, CPUState *cpu)
>>  {
>>      int64_t cpu_icount;
>>
>> @@ -62,7 +62,7 @@ static void align_clocks(SyncClocks *sc, const CPUState *cpu)
>>          return;
>>      }
>>
>> -    cpu_icount = cpu->icount_extra + cpu->icount_decr.u16.low;
>> +    cpu_icount = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
>>      sc->diff_clk += cpu_icount_to_ns(sc->last_cpu_icount - cpu_icount);
>>      sc->last_cpu_icount = cpu_icount;
> 
> Why does this require that we remove the 'const' from the cpu
> argument to the function ?

Because

  CPUNegativeOffsetState *cpu_neg(CPUState *);

and this isn't c++ so we can't overload with another

  const CPUNegativeOffsetState *cpu_neg(const CPUState *);

and it doesn't seem worthwhile to preserve constness here.

>> @@ -265,7 +265,7 @@ static void cpu_common_reset(CPUState *cpu)
>>      cpu->mem_io_pc = 0;
>>      cpu->mem_io_vaddr = 0;
>>      cpu->icount_extra = 0;
>> -    atomic_set(&cpu->icount_decr.u32, 0);
>> +    atomic_set(&cpu->icount_decr_ptr->u32, 0);
>>      cpu->can_do_io = 1;
>>      cpu->exception_index = -1;
>>      cpu->crash_occurred = false;
> 
> What determines when we need to access the icount fields
> via icount_decr_ptr versus when we can just directly
> access icount_decr ?

NEED_CPU_H.  To access the field directly you need ArchCPU defined.


r~
