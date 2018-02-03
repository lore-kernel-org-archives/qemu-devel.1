Received: from eggs.gnu.org ([2001:4830:134:3::10]:57387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei5XF-0005eA-Hk
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei5XC-0004ja-DI
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:39:45 -0500
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:39916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei5XC-0004jN-6F
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:39:42 -0500
Received: by mail-pf0-x22a.google.com with SMTP id e11so19201318pff.6
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 13:39:42 -0800 (PST)
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-5-git-send-email-peter.maydell@linaro.org>
	<675ab9e3-80ec-97fc-5c01-ce28b2d2d4d1@linaro.org>
	<CAFEAcA9xBQO-o8wV0bR1qK1PG23xbAAWtd-JdXqS0ao9N+f3mw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1f56786e-e492-b260-344c-7050d6b4c07f@linaro.org>
Date: Sat, 3 Feb 2018 13:39:37 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xBQO-o8wV0bR1qK1PG23xbAAWtd-JdXqS0ao9N+f3mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] target/arm: Make v7M exception entry
 stack push check MPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 02/03/2018 01:30 PM, Peter Maydell wrote:
> On 3 February 2018 at 21:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 01/30/2018 07:02 AM, Peter Maydell wrote:
>>> +    if (get_phys_addr(env, addr, MMU_DATA_STORE, mmu_idx, &physaddr,
>>> +                      &attrs, &prot, &page_size, &fi, NULL)) {
>>
>> Given that you know you're going to call this at least 8 times in a row,
>> probably with all operations on the same page, it is worth querying the qemu
>> tlb first, and when that fails but the lookup succeeds, installing the result
>> into the tlb?
> 
> get_phys_addr and address_space_stl_le don't touch the TLB though?

No, get_phys_addr is the primitive that tlb_fill uses.

> We could in theory do a get_phys_addr() once per-page rather than
> doing it all 8 times though, yes.

After I sent that first message I thought perhaps interacting with the proper
TLB is too/overly complicated.  We'd get nearly the same results just having a
local 1-entry cache.  Something like

    pagecache = -1;
    stacked_ok =
        v7m_stack_write(cpu, frameptr, env->regs[0],
                        &pagecache, mmu_idx, false) &&
        v7m_stack_write(cpu, frameptr + 4, env->regs[1],
                        &pagecache, mmu_idx, false) &&
        ...


r~
