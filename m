Received: from eggs.gnu.org ([2001:4830:134:3::10]:59429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euJ0m-0002iQ-6D
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euJ0l-0007z3-8d
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:28:44 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:35418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euJ0l-0007yf-2V
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:28:43 -0500
Received: by mail-ot0-x22c.google.com with SMTP id r30so8837126otr.2
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 06:28:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NvDiUHs6cBTd57uO+VdaAyQnH+2s4kp4yiQ1uBS15A22g@mail.gmail.com>
References: <CAHNT7NshwZh87Uui6i+ARdOj2BuW6d7gahOiZ0X48Cf3TdOrXQ@mail.gmail.com>
	<mhng-91cb2b22-0b57-4c9b-8027-8c25eba32497@palmer-si-x1c4>
	<CAHNT7NvDiUHs6cBTd57uO+VdaAyQnH+2s4kp4yiQ1uBS15A22g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 14:28:21 +0000
Message-ID: <CAFEAcA9jWUqFenf=P3bhiJ5iGCZ2kBc7eZxv3BRzO+jd=9h7nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PULL] RISC-V QEMU Port Submission
 v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 8 March 2018 at 19:53, Michael Clark <mjc@sifive.com> wrote:
> I re-iterate Palmer's apology.
>
> I shouldn't be polling git.qemu.org/qemu.git and answering emails near to
> 3am in the morning after 4 months of working on trying to get the RISC-V
> port in shape to go upstream.
>
> It appears it is completely my mistake and I had tagged early deltas on top
> of v8.2 instead of the tip of v8.2.
>
> I've force pushed the 'riscv-qemu-upstream-v8.2' so only the mailing list
> will hold the history of my mistake.

Thank you for the apology. On my side, I regret not starting this
email thread by just asking if you'd pushed the wrong tag by mistake,
since in retrospect that was certainly the most likely situation.

I've now merged and tested the revised tag, and pushed it upstream.

NB: there was a test failure on OpenBSD host:

TEST: tests/qom-test... (pid=64016)
  /riscv32/qom/spike_v1.9.1:                                           **
ERROR:/home/qemu/tests/qom-test.c:64:test_properties: assertion
failed: (qdict_haskey(response, "return"))
FAIL

but this seems to have been intermittent -- it was only on that one
host, and I reran the test suite there and it passed fine the second
time. So it may be nothing to do with your code; we'll see if it
comes up again.

I also had a look at running the port under valgrind, which shows
what looks like a bug in riscv_isa_string():

$ valgrind ./build/all/riscv32-softmmu/qemu-system-riscv32
[...]
==24805== Invalid read of size 1
==24805==    at 0x4C30F74: strlen (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==24805==    by 0x26518E: riscv_isa_string (cpu.c:399)
==24805==    by 0x25C15D: create_fdt (spike.c:125)
==24805==    by 0x25C15D: spike_v1_10_0_board_init (spike.c:199)
==24805==    by 0x2CCE1A: machine_run_board_init (machine.c:807)
==24805==    by 0x1BFF28: main (vl.c:4597)
==24805==  Address 0x3055be55 is 0 bytes after a block of size 5 alloc'd
==24805==    at 0x4C2FB55: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==24805==    by 0x70C8770: g_malloc0 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==24805==    by 0x26512E: riscv_isa_string (cpu.c:395)
==24805==    by 0x25C15D: create_fdt (spike.c:125)
==24805==    by 0x25C15D: spike_v1_10_0_board_init (spike.c:199)
==24805==    by 0x2CCE1A: machine_run_board_init (machine.c:807)
==24805==    by 0x1BFF28: main (vl.c:4597)

I haven't looked too hard at the code, but I suspect you're
miscalculating the length of the string and/or not writing the
trailing NUL to the string. I recommend you have a look at that,
and perhaps try running some other tests under valgrind.

thanks
-- PMM
