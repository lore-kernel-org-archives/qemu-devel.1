Received: from eggs.gnu.org ([2001:4830:134:3::10]:36479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euJN8-0007OA-2x
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euJN6-0000iu-62
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:51:50 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euJN5-0000ib-QN
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:51:48 -0500
Received: by mail-ot0-x244.google.com with SMTP id 95so8884298ote.5
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 06:51:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9jWUqFenf=P3bhiJ5iGCZ2kBc7eZxv3BRzO+jd=9h7nQ@mail.gmail.com>
References: <CAHNT7NshwZh87Uui6i+ARdOj2BuW6d7gahOiZ0X48Cf3TdOrXQ@mail.gmail.com>
	<mhng-91cb2b22-0b57-4c9b-8027-8c25eba32497@palmer-si-x1c4>
	<CAHNT7NvDiUHs6cBTd57uO+VdaAyQnH+2s4kp4yiQ1uBS15A22g@mail.gmail.com>
	<CAFEAcA9jWUqFenf=P3bhiJ5iGCZ2kBc7eZxv3BRzO+jd=9h7nQ@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 10 Mar 2018 03:51:46 +1300
Message-ID: <CAHNT7NuBjcngEesbS4XSwn=gw7S8VYVE_e6FjxKuAHfjoWowjQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Sat, Mar 10, 2018 at 3:28 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 8 March 2018 at 19:53, Michael Clark <mjc@sifive.com> wrote:
> > I re-iterate Palmer's apology.
> >
> > I shouldn't be polling git.qemu.org/qemu.git and answering emails near
> to
> > 3am in the morning after 4 months of working on trying to get the RISC-V
> > port in shape to go upstream.
> >
> > It appears it is completely my mistake and I had tagged early deltas on
> top
> > of v8.2 instead of the tip of v8.2.
> >
> > I've force pushed the 'riscv-qemu-upstream-v8.2' so only the mailing list
> > will hold the history of my mistake.
>
> Thank you for the apology. On my side, I regret not starting this
> email thread by just asking if you'd pushed the wrong tag by mistake,
> since in retrospect that was certainly the most likely situation.
>

No worries. It was very late at night. I was tired and a little anxious.
Thanks very much for bearing with me after my comments.


> I've now merged and tested the revised tag, and pushed it upstream.
>

That's great news.


> NB: there was a test failure on OpenBSD host:
>
> TEST: tests/qom-test... (pid=64016)
>   /riscv32/qom/spike_v1.9.1:                                           **
> ERROR:/home/qemu/tests/qom-test.c:64:test_properties: assertion
> failed: (qdict_haskey(response, "return"))
> FAIL
>
> but this seems to have been intermittent -- it was only on that one
> host, and I reran the test suite there and it passed fine the second
> time. So it may be nothing to do with your code; we'll see if it
> comes up again.
>
> I also had a look at running the port under valgrind, which shows
> what looks like a bug in riscv_isa_string():
>
> $ valgrind ./build/all/riscv32-softmmu/qemu-system-riscv32
> [...]
> ==24805== Invalid read of size 1
> ==24805==    at 0x4C30F74: strlen (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==24805==    by 0x26518E: riscv_isa_string (cpu.c:399)
> ==24805==    by 0x25C15D: create_fdt (spike.c:125)
> ==24805==    by 0x25C15D: spike_v1_10_0_board_init (spike.c:199)
> ==24805==    by 0x2CCE1A: machine_run_board_init (machine.c:807)
> ==24805==    by 0x1BFF28: main (vl.c:4597)
> ==24805==  Address 0x3055be55 is 0 bytes after a block of size 5 alloc'd
> ==24805==    at 0x4C2FB55: calloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==24805==    by 0x70C8770: g_malloc0 (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
> ==24805==    by 0x26512E: riscv_isa_string (cpu.c:395)
> ==24805==    by 0x25C15D: create_fdt (spike.c:125)
> ==24805==    by 0x25C15D: spike_v1_10_0_board_init (spike.c:199)
> ==24805==    by 0x2CCE1A: machine_run_board_init (machine.c:807)
> ==24805==    by 0x1BFF28: main (vl.c:4597)
>
> I haven't looked too hard at the code, but I suspect you're
> miscalculating the length of the string and/or not writing the
> trailing NUL to the string. I recommend you have a look at that,
> and perhaps try running some other tests under valgrind.
>

Thanks very much!

I'll valgrind locally when I get time. It's very late at night here. 3.45am.

We may very well have a memory issue but it's likely restricted to the
RISC-V port and shouldn't cause any issues for other ports.

BTW - I've integrated the following 3 branches into the riscv tree:

- https://github.com/riscv/riscv-qemu/tree/softfloat-snan-abort-fix
- https://github.com/riscv/riscv-qemu/tree/riscv-qemu-upstream-v8.2
- https://github.com/michaeljclark/riscv-qemu/tree/qemu-devel

into our `riscv-all` integration branch, and we're now passing all FPU
tests, interestingly, including the NaN-boxing of single precision values
into doubles. We'll need to check that the riscv-tests testsuite is
exhastive enough... Suprised! I think Richard might have thought about
our NaN-boxing
issue or some other sort of magic is going on :-)

- https://github.com/riscv/riscv-qemu/tree/riscv-all

Michael.
--

$ sh qemu-images/run-riscv-tests.sh
rv64ua-v-amoadd_d
rv64ua-v-amoadd_w
rv64ua-v-amoand_d
rv64ua-v-amoand_w
rv64ua-v-amomax_d
rv64ua-v-amomax_w
rv64ua-v-amomaxu_d
rv64ua-v-amomaxu_w
rv64ua-v-amomin_d
rv64ua-v-amomin_w
rv64ua-v-amominu_d
rv64ua-v-amominu_w
rv64ua-v-amoor_d
rv64ua-v-amoor_w
rv64ua-v-amoswap_d
rv64ua-v-amoswap_w
rv64ua-v-amoxor_d
rv64ua-v-amoxor_w
rv64ua-v-lrsc
rv64uc-v-rvc
rv64ud-v-fadd
rv64ud-v-fclass
rv64ud-v-fcmp
rv64ud-v-fcvt
rv64ud-v-fcvt_w
rv64ud-v-fdiv
rv64ud-v-fmadd
rv64ud-v-fmin
rv64ud-v-ldst
rv64ud-v-move
rv64ud-v-recoding
rv64ud-v-structural
rv64uf-v-fadd
rv64uf-v-fclass
rv64uf-v-fcmp
rv64uf-v-fcvt
rv64uf-v-fcvt_w
rv64uf-v-fdiv
rv64uf-v-fmadd
rv64uf-v-fmin
rv64uf-v-ldst
rv64uf-v-move
rv64uf-v-recoding
rv64ui-v-add
rv64ui-v-addi
rv64ui-v-addiw
rv64ui-v-addw
rv64ui-v-and
rv64ui-v-andi
rv64ui-v-auipc
rv64ui-v-beq
rv64ui-v-bge
rv64ui-v-bgeu
rv64ui-v-blt
rv64ui-v-bltu
rv64ui-v-bne
rv64ui-v-fence_i
rv64ui-v-jal
rv64ui-v-jalr
rv64ui-v-lb
rv64ui-v-lbu
rv64ui-v-ld
rv64ui-v-lh
rv64ui-v-lhu
rv64ui-v-lui
rv64ui-v-lw
rv64ui-v-lwu
rv64ui-v-or
rv64ui-v-ori
rv64ui-v-sb
rv64ui-v-sd
rv64ui-v-sh
rv64ui-v-simple
rv64ui-v-sll
rv64ui-v-slli
rv64ui-v-slliw
rv64ui-v-sllw
rv64ui-v-slt
rv64ui-v-slti
rv64ui-v-sltiu
rv64ui-v-sltu
rv64ui-v-sra
rv64ui-v-srai
rv64ui-v-sraiw
rv64ui-v-sraw
rv64ui-v-srl
rv64ui-v-srli
rv64ui-v-srliw
rv64ui-v-srlw
rv64ui-v-sub
rv64ui-v-subw
rv64ui-v-sw
rv64ui-v-xor
rv64ui-v-xori
rv64um-v-div
rv64um-v-divu
rv64um-v-divuw
rv64um-v-divw
rv64um-v-mul
rv64um-v-mulh
rv64um-v-mulhsu
rv64um-v-mulhu
rv64um-v-mulw
rv64um-v-rem
rv64um-v-remu
rv64um-v-remuw
rv64um-v-remw
