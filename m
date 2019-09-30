Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825DBC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504D2215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504D2215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExfa-0008Gm-7J
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iExRt-0006Uh-Hk
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iExRr-0007Bp-73
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:18:52 -0400
Received: from relay68.bu.edu ([128.197.228.73]:43700)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iExRr-00078d-34
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:18:51 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: 144.121.20.163.lightower.net [144.121.20.163] (may be forged)
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id x8UFHx77021358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
 Mon, 30 Sep 2019 11:17:59 -0400
Subject: Re: [PATCH v3 17/22] fuzz: add support for fork-based fuzzing.
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-18-alxndr@bu.edu>
From: Alexander Oleinik <alxndr@bu.edu>
Message-ID: <b8d441a3-dc3b-8c91-7516-3c8162cc5a4d@bu.edu>
Date: Mon, 30 Sep 2019 11:17:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190918231846.22538-18-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x [fuzzy]
X-Received-From: 128.197.228.73
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 7:19 PM, Oleinik, Alexander wrote:
> fork() is a simple way to ensure that state does not leak in between
> fuzzing runs. Unfortunately, the fuzzer mutation engine relies on
> bitmaps which contain coverage information for each fuzzing run, and
> these bitmaps should be copied from the child to the parent(where the
> mutation occurs). These bitmaps are created through compile-time
> instrumentation and there seems to be no simple way to re-map them as
> shared memory. As a workaround, we use a linker script modification to
> place all of the bitmaps together and add some markers around them which
> we can observe from our code. Then, we map shared memory and copy the
> bimaps to the SHM (in the child) and out of the SHM(in the parent) after
> each fuzzing run. Ram blocks are marked as DONTFORK in exec.c, which
> breaks this approach. For now, avoid this with an #ifdef.
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>   exec.c                      |  2 ++
>   tests/fuzz/Makefile.include |  3 +++
>   tests/fuzz/fork_fuzz.c      | 27 ++++++++++++++++++++++
>   tests/fuzz/fork_fuzz.h      | 12 ++++++++++
>   tests/fuzz/fork_fuzz.ld     | 46 +++++++++++++++++++++++++++++++++++++
>   5 files changed, 90 insertions(+)
>   create mode 100644 tests/fuzz/fork_fuzz.c
>   create mode 100644 tests/fuzz/fork_fuzz.h
>   create mode 100644 tests/fuzz/fork_fuzz.ld
> 
> diff --git a/exec.c b/exec.c
> index 235d6bc883..d3838f4ea4 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2295,7 +2295,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>           qemu_ram_setup_dump(new_block->host, new_block->max_length);
>           qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
>           /* MADV_DONTFORK is also needed by KVM in absence of synchronous MMU */
> +#ifndef CONFIG_FUZZ /* This conflicts with fork-based fuzzing */
>           qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DONTFORK);
> +#endif
>           ram_block_notify_add(new_block->host, new_block->max_length);
>       }
>   }
> diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
> index b415b056b0..687dacce04 100644
> --- a/tests/fuzz/Makefile.include
> +++ b/tests/fuzz/Makefile.include
> @@ -2,3 +2,6 @@ QEMU_PROG_FUZZ=qemu-fuzz-$(TARGET_NAME)$(EXESUF)
>   fuzz-obj-y = $(libqos-obj-y)
>   fuzz-obj-y += tests/libqtest.o
>   fuzz-obj-y += tests/fuzz/fuzz.o
> +fuzz-obj-y += tests/fuzz/fork_fuzz.o
> +
> +FUZZ_LDFLAGS += -Xlinker -T$(SRC_PATH)/tests/fuzz/fork_fuzz.ld
> diff --git a/tests/fuzz/fork_fuzz.c b/tests/fuzz/fork_fuzz.c
> new file mode 100644
> index 0000000000..26d0b4b42e
> --- /dev/null
> +++ b/tests/fuzz/fork_fuzz.c
> @@ -0,0 +1,27 @@
> +#include "qemu/osdep.h"
> +#include "fork_fuzz.h"
> +
> +uintptr_t feature_shm;
> +
> +void counter_shm_init(void)
> +{
> +    feature_shm = (uintptr_t)mmap(NULL,
> +            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
> +            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +    return;
> +}
> +
> +void counter_shm_store(void)
> +{
> +    memcpy((void *)feature_shm,
> +            &__FUZZ_COUNTERS_START,
> +            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
> +}
> +
> +void counter_shm_load(void)
> +{
> +    memcpy(&__FUZZ_COUNTERS_START,
> +            (void *)feature_shm,
> +            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
> +}
> +
> diff --git a/tests/fuzz/fork_fuzz.h b/tests/fuzz/fork_fuzz.h
> new file mode 100644
> index 0000000000..b5f8b35015
> --- /dev/null
> +++ b/tests/fuzz/fork_fuzz.h
> @@ -0,0 +1,12 @@
> +#ifndef FORK_FUZZ_H
> +#define FORK_FUZZ_H
> +
> +extern uint8_t __FUZZ_COUNTERS_START;
> +extern uint8_t __FUZZ_COUNTERS_END;
> +
> +void counter_shm_init(void);
> +void counter_shm_store(void);
> +void counter_shm_load(void);
> +
> +#endif
> +
> diff --git a/tests/fuzz/fork_fuzz.ld b/tests/fuzz/fork_fuzz.ld
> new file mode 100644
> index 0000000000..ba0ba79570
> --- /dev/null
> +++ b/tests/fuzz/fork_fuzz.ld
> @@ -0,0 +1,46 @@
> +/* We adjust linker script modification to place all of the stuff that needs to
> + * persist across fuzzing runs into a contiguous seciton of memory. Then, it is
> + * easy to copy it to and from shared memory.
> + *
> + * Total Size : A5A00
> + * Sancov counters: B26F
> + * Coverage counters: 56D60
> + * TracePC Object: 43C00
> +*/
> +
> +SECTIONS
> +{
> +  .data.fuzz_start : ALIGN(4K)
> +  {
> +        __FUZZ_COUNTERS_START = .;
> +  }
> +  .data.fuzz_ordered :
> +  {
> +      /* Internal Libfuzzer TracePC object which contains the ValueProfileMap.
> +       * Not optimal that we have to copy the rest of the TracePC object.
> +       * */
> +      __start___sancov_cntrs = .;
> +      *(__sancov_cntrs*)
> +      __stop___sancov_cntrs = .;
> +  }
> +  .data.fuzz_unordered :
> +  {
> +      /* Coverage counters. They're not necessary for fuzzing, but are useful
> +       * for analyzing the fuzzing performance
> +       * */
> +      __start___llvm_prf_cnts = .;
> +      *(*llvm_prf_cnts);
> +      __stop___llvm_prf_cnts = .;
> +
> +      /* Lowest stack counter */
> +      *(__sancov_lowest_stack);
> +      /* Internal Libfuzzer TracePC object which contains the ValueProfileMap.
> +       * Not optimal that we have to copy the rest of the TracePC object.
> +       * */
> +      *FuzzerTracePC*(.bss._ZN6fuzzer*)
> +      __FUZZ_COUNTERS_END = .;
> +  }
> +}
> +/* Dont overwrite the SECTIONS in the default linker script. Instead insert the
> + * above into the default script */
> +INSERT AFTER .data;
> 
The obvious issue with this are that we lose the threads created prior 
to fork(). Over the past days I've been coverage of existing virtio-net 
tests with and without fork(). With fork(), virtio_net_tx_bh doesn't get 
scheduled, and never runs. Could this be due to the missing RCU thread?
This is probably an even bigger problem for iothread devices, such as 
virtio-blk...

Does anyone have suggestions for how to approach the thread problem, or 
at least the RCU part of it?
I know Paolo made some fork-related changes in 
21b7cf9e07e5991c57b461181cfb5bbb6fe7a9d6 rcu: handle forks safely
and
2a96a552f9502ac34c29da2f3a39788db5ee5692 ,
but from what I can tell, this is mostly for qemu-user.

-Alex

