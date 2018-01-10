Received: from eggs.gnu.org ([2001:4830:134:3::10]:47416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZDiS-0004Ei-P2
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZDiR-0007l8-QF
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:34:40 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:39087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZDiR-0007ke-Kq
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:34:39 -0500
Received: by mail-oi0-x236.google.com with SMTP id t8so267115oie.6
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 02:34:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3719059.PceeUxPRNs@wirbelwind>
References: <16658597.jA1MYeglPg@wirbelwind>
	<CAFEAcA_V9LRUCk+nq_kz8jC8yCQSgNbV0gdGFu+CFLWsbxh=xA@mail.gmail.com>
	<3719059.PceeUxPRNs@wirbelwind>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jan 2018 10:34:18 +0000
Message-ID: <CAFEAcA-8WufG_RSvra9v-Y_3qem0aDPQBg1KAMr6x6kMJgCHtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-discuss] ppc and icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: steven.seeger@flightsystems.net
Cc: qemu-discuss <qemu-discuss@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Richard Purdie <richard.purdie@linuxfoundation.org>, Richard Henderson <rth@twiddle.net>

On 10 January 2018 at 08:57, Steven Seeger
<steven.seeger@flightsystems.net> wrote:
> Sorry for another post. I did a bisect and found what is the bad commit for
> me:
>
> 044897ef4a22af89aecb8df509477beba0a2e0ce is the first bad commit
> commit 044897ef4a22af89aecb8df509477beba0a2e0ce
> Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> Date:   Mon Dec 4 22:25:43 2017 +0000
>
>     target/ppc: Fix system lockups caused by interrupt_request state
> corruption

Great -- thanks for the bisect. Let's take this to the -devel list;
I've cc'd the PPC maintainers.

Context: Steven reports that we broke -icount for PPC guests with
this commit:

$ ./build/all/ppc-softmmu/qemu-system-ppc  -icount auto
qemu: fatal: Raised interrupt while not in I/O function
NIP fff08978   LR fff08904 CTR 00000000 XER 00000000 CPU#0
MSR 00000000 HID0 00000000  HF 00000000 iidx 3 didx 3
Bad icount read

The backtrace from the assert is:

#0  tcg_handle_interrupt (cpu=0x7ffff7fc2010, mask=4) at qemu/accel/tcg/tcg-
all.c:58
#1  0x0000555555962aa4 in cpu_interrupt (cpu=0x7ffff7fc2010, mask=4) at qemu/
include/qom/cpu.h:859
#2  0x0000555555962e55 in cpu_interrupt_exittb (cs=0x7ffff7fc2010) at qemu/
target/ppc/helper_regs.h:105
#3  0x0000555555964505 in do_rfi (env=0x7ffff7fca2b0, nip=197460, msr=4096)
    at qemu/target/ppc/excp_helper.c:998
#4  0x0000555555964555 in helper_rfi (env=0x7ffff7fca2b0) at qemu/target/ppc/
excp_helper.c:1008
#5  0x00007fffe7c124b9 in code_gen_buffer ()

The problem is that icount was relying on the previous
handling of do_rfi() as "just set state as we know we're
going to be last insn in the TB".

Not sure how best to fix this (mark the insn as IO ok?)

thanks
-- PMM
