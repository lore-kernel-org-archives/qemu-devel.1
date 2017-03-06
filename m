Received: from eggs.gnu.org ([2001:4830:134:3::10]:52884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cksUN-0000Ar-SN
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cksUK-0004Md-Hv
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:15:47 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cksUK-0004MI-Au
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:15:44 -0500
Received: by mail-wm0-x22e.google.com with SMTP id t193so64061154wmt.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 05:15:44 -0800 (PST)
References: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
Date: Mon, 06 Mar 2017 13:15:49 +0000
Message-ID: <87k282im0q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Qemu deadlocks in tb_lock when using SVM+SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, fred.konrad@greensocs.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com


Alexander Boettcher <alexander.boettcher@genode-labs.com> writes:

> Hello,
>
> beginning with commit 3bd1d74576bacb120949e13cdeded7a0c792c685
>
> "cputlb: introduce tlb_flush_* async work"
>
> using Qemu with SoftMMU+SVM virtualization deadlocks because tb_lock is
> taken second time in cputlb.c tlb_flush_nocheck() function. The first
> time tb_lock is taken, according to my debugging, in cpu-exex.c
> tb_find() line 361.
>
> I'm using Qemu with:
>
> qemu-system-x86_64 -s -no-kvm -display sdl -m 512 -cpu phenom -nographic
> -cdrom genode.iso

I found the virtualbox.iso on your branch but I can't trigger the
assert. Running:

#!/bin/sh

QEMU="$@"

${QEMU} -s -no-kvm -display sdl -m 512 -cpu phenom -nographic -cdrom virtualbox.iso

I get:

NOVA Microhypervisor v7-2436fe2 (x86_32): Feb 25 2017 17:58:48 [gcc 4.9.2]
[init -> log_terminal]
[init -> log_terminal] [ 0] CORE:0:0:0 10:2:3:0 [0] AMD Phenom(tm) 9550 Quad-Core Processor
qemu: fatal: invalid tss type
EAX=00000000 EBX=00000000 ECX=bffff000 EDX=00100000
ESI=00000000 EDI=00000000 EBP=00000000 ESP=bffff000
EIP=00100000 EFL=00000246 [---Z-P-] CPL=3 II=0 A20=1 SMM=0 HLT=0
ES =0023 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
CS =001b 00000000 ffffffff 00c0fb00 DPL=3 CS32 [-RA]
SS =0023 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
DS =0023 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
FS =0023 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
GS =0023 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
LDT=0000 00000000 00000000 00000000
TR =0030 cffffac0 00002540 00008b00 DPL=0 TSS32-busy
GDT=     cffff780 0000004f
IDT=     c001cb68 0000054f
CR0=8001003b CR2=00100000 CR3=026e9000 CR4=00000678
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
DR6=0000000000000000 DR7=0000000000000400
CCS=00000044 CCD=00000000 CCO=EFLAGS
EFER=0000000000001000
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
XMM00=00000000cffff7800000004f00000000 XMM01=00000000c001cb680000054f00000000
XMM02=0000000000000000ffffffff0cf30023 XMM03=0000000000000000ffffffff0cf30023
XMM04=0000000000000000ffffffff0c9b0008 XMM05=0000000000000000ffffffff0c930010
XMM06=00000000cffffac000002540008b0030 XMM07=00000000000000000000000010000000
Aborted (core dumped)

Which is a guest error?


>
> When building with
> ./configure --target-list=x86_64-softmmu --enable-debug --disable-pie
> --enable-debug-tcg
>
> I get also a
>
> translate-all.c:165: tb_lock: Assertion `!have_tb_lock' failed.
>
> beginning with commit 3bd1d74576bacb120949e13cdeded7a0c792c685. Before
> the commit all is fine.
>
> Since I'm not very familiar with Qemu internals, it is not clear to me
> whether this commit breaks things or whether something must be
> handled/added special somewhere else. I attached below the backtrace of
> Qemu when it hangs in tb_lock.
>
> In [0] my branch based on 3bd1d74576bacb120949e13cdeded7a0c792c685 is
> used and [1] contains the iso image, if somebody wants try to reproduce it.
>
> [0] https://github.com/alex-ab/qemu/commits/genode_svm_issue
> [1]
> https://github.com/alex-ab/qemu/commit/1130fee3b04dd2bee576241de9a5771d6855b327
>
> Thanks in advance,
>
> Alex.


--
Alex Bennée
