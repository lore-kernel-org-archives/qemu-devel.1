Received: from eggs.gnu.org ([2001:4830:134:3::10]:56194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeNjA-0002xl-Hm
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeNj5-0005on-LK
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:16:44 -0500
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:42494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeNj5-0005o7-EI
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:16:39 -0500
Received: by mail-pg0-x230.google.com with SMTP id q67so3021915pga.9
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 08:16:39 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-7-git-send-email-mjc@sifive.com>
	<f15753f1-7446-26f1-9937-f3b67d15c0a6@linaro.org>
	<CAHNT7Nu-6WvTZyit-xU_bNS6bLKRay3_9e9YtYFmG5tmqr0RXA@mail.gmail.com>
	<318eed49-c986-897a-0e4d-59e0946d11ad@linaro.org>
	<CAHNT7NtOTXSK9Httz=1+mZ5JRx2UP3q0tHH5hDpF22aJkHR54w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4ad71a0-ee46-56fa-9caf-e15030413bfe@linaro.org>
Date: Wed, 24 Jan 2018 08:16:34 -0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7NtOTXSK9Httz=1+mZ5JRx2UP3q0tHH5hDpF22aJkHR54w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>, Stefan O'Rear <sorear2@gmail.com>

On 01/23/2018 05:31 PM, Michael Clark wrote:
> For the meantime we've greatly simplified cpu_mmu_index to just return the
> processor mode as well as adding the processor mode to cpu_get_tb_cpu_state
> flags. cpu_mmu_index previously returned a permutation of env->priv (containing
> processer mode), mstatus.MPP (previous mode) and mstatus.MPRV. When MPRV is
> set, M mode loads and stores operate as per the mode in mstatus.MPP and the
> previous cpu_mmu_index function returned the mode the processor should do loads
> and stores as, not the current mode. This is problematic as mstatus.MPRV can be
> altered from user code via register values so there was a potential to re-enter
> a pre-existing trace with a different mmu_index. I believe we have eliminated
> that issue.
> 
> These two changes should fix the issue and we've performed testing with these
> patches:
> 
> -
> https://github.com/michaeljclark/riscv-qemu/commit/82012aef90e5c4500f926523b3b2ff621b0cd512
> - https://github.com/michaeljclark/riscv-qemu/commit/abdb897a4a607d00cfce577ac37ca6119004658f


I had been concerned, because solely within the context of these patches I
didn't see the additional flushing being added.  However, on checking out the
branch I see that they are all there on changing mstatus.

No need for it immediately, but as an incremental improvement you can use
targeted flushing.  E.g. when only MPRV changes, only PRV_M's mmu_idx is
invalidated; PRV_S and PRV_U are unaffected.  For this, use tlb_flush_by_mmuidx.

> During the process, we also found some bugs in the accessed/dirty bit handling
> in get_physical_address. i.e. when the accessed/dirty bits don't change, we now
> elide the store. This allows various use cases such as PTE entries in ROM. We
> coalesced some of the flag setting in get_physical_address based on Stefan's
> patch (PAGE_READ+PAGE_EXEC) which likely reduces the number of TLB misses, but
> we don't set PAGE_WRITE unless the access_type is MMU_DATA_STORE. The previous
> code would only set the TLB prot flag for the specific access type. We set
> PAGE_READ+PAGE_EXEC based on the PTE flags for load and fetch but we don't set
> PAGE_WRITE on loads or fetches because we want a TLB miss for subsequent stores
> so we don't miss updating the dirty bit if the first access on a RW page is a
> load or fetch. I saw code in i386 that does essentially the same thing.

You should still set PAGE_WRITE for MMU_DATA_LOAD if the dirty bit is already
set.  Consider:

Addresses A and B alias in the TLB.  Since our tlb implementation is of
necessity trivial, an access to B will remove A from the table.  Assuming both
pages are initially dirty, the access sequence

	load A
	load B
	store B

will fault 3 times with your code, but only twice if you consider the dirty bit
right away.

> We still need to make PTE updates atomic but given we only have multiplexed
> SMP, it should not be too much of an issue right now.

I'm sure that enabling multi-threading will be high on the list of post-merge
improvements.  There's certainly a lot of bang to be had there.


r~
