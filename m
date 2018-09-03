Received: from eggs.gnu.org ([2001:4830:134:3::10]:55676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fwkQ9-0006iM-Py
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 04:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fwkQ8-0003hi-Uz
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 04:41:17 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:46019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fwkQ8-0003hP-JG
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 04:41:16 -0400
Received: by mail-oi0-x233.google.com with SMTP id t68-v6so32237316oie.12
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 01:41:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJhHMCBKpf2F5NqEvZOugzd0TgK802TxCWfYL1Y2ELiGH-vmJg@mail.gmail.com>
References: <CAJhHMCDR3FVHxO7hfUNbYTM2zsx6Q1CeKfeMjkW0b-En-1Z0Xw@mail.gmail.com>
	<CAJhHMCCUzMvQbbcfa8GboH1wpCogFSr1vgf==1EjAz8L+yxo6w@mail.gmail.com>
	<CAHNT7NvuwMw71jn4aQP2DWiekMEe0veSNrnL0tao3pPR+uGROg@mail.gmail.com>
	<CAJhHMCBKpf2F5NqEvZOugzd0TgK802TxCWfYL1Y2ELiGH-vmJg@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 3 Sep 2018 20:41:15 +1200
Message-ID: <CAHNT7Nsu4nzuWGFZL5a9Rb2PiQ15e+F7M4Gk+OsiZdt=DG-5cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu-riscv64 seg fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Mon, Sep 3, 2018 at 8:16 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:

> On Mon, Sep 3, 2018 at 1:07 AM Michael Clark <mjc@sifive.com> wrote:
> >
> > Thanks. I was just about to log an issue in the riscv-qemu issue tracker
> on GitHub.
> >
> > I reproduced it on my side. The fact that it is causes QEMU user to
> crash in translate.c is interesting.
> >
> > I ran your program with -d in_asm and it appears to crash in thread::join
>
> Interestingly, qemu-x86_64 crashes too. But running natively on x86
> works fine. There is something off somewhere...
>

Indeed. Another data-point. I tested it in both qemu-2.12 and qemu-3.0. It
still crashed in translate.c in qemu-2.12, but on another line. There was
quite a bit of restructuring of target/riscv/translate.c in qemu-3.0, which
is why I tried qemu-2.12, however, it seems that is likely not the cause.

This was the backtrace from riscv-qemu-2.12:

Thread 1 "qemu-riscv64" received signal SIGSEGV, Segmentation fault.
0x00005555555e1347 in gen_intermediate_code (cs=cs@entry=0x555557905590,
    tb=tb@entry=0x5555558e1a00 <static_code_gen_buffer+9952>)
    at /home/mjc/src/sifive/riscv-qemu/target/riscv/translate.c:1934
1934         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
(gdb) print tb
$1 = (TranslationBlock *) 0x5555558e1a00 <static_code_gen_buffer+9952>
(gdb) quit
A debugging session is active.

~/quickht$ qemu-x86_64 ./bench -t 2 -u 2
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault
>
> ~/quickht$ ./bench -t 2 -u 2
> Comparisons: 23922
> Buckets touched: 4933
> Operations: 2000
>
