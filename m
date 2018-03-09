Received: from eggs.gnu.org ([2001:4830:134:3::10]:41389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euLDB-0001TO-Sn
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euLDB-0003pG-2q
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:49:41 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euLDA-0003p4-Ry
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:49:41 -0500
Received: by mail-oi0-x243.google.com with SMTP id g5so7428821oiy.8
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 08:49:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9jWUqFenf=P3bhiJ5iGCZ2kBc7eZxv3BRzO+jd=9h7nQ@mail.gmail.com>
References: <CAHNT7NshwZh87Uui6i+ARdOj2BuW6d7gahOiZ0X48Cf3TdOrXQ@mail.gmail.com>
	<mhng-91cb2b22-0b57-4c9b-8027-8c25eba32497@palmer-si-x1c4>
	<CAHNT7NvDiUHs6cBTd57uO+VdaAyQnH+2s4kp4yiQ1uBS15A22g@mail.gmail.com>
	<CAFEAcA9jWUqFenf=P3bhiJ5iGCZ2kBc7eZxv3BRzO+jd=9h7nQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 16:49:19 +0000
Message-ID: <CAFEAcA9SQ5JF4Am0F=QJ11kF+iQ4z_-ogr8t1Xj3vbcfOAJhAg@mail.gmail.com>
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

On 9 March 2018 at 14:28, Peter Maydell <peter.maydell@linaro.org> wrote:
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

On a later test run I got this different one; openbsd again:

TEST: tests/test-hmp... (pid=45236)
  /riscv32/hmp/spike_v1.9.1:                                           **
ERROR:/home/qemu/qom/object.c:488:object_new_with_type: assertion
failed: (type != NULL)
Broken pipe
FAIL

My current best theory is that OpenBSD libc's memory allocator
happens to be more sensitive to a memory corruption bug in the risc
code, resulting in intermittent failures if the allocations happen
to come out the wrong way. You do have at least one invalid-write
off the end of a block according to valgrind:

==17441== Invalid write of size 1
==17441==    at 0x26517F: riscv_isa_string (cpu.c:399)
==17441==    by 0x25C14D: create_fdt (spike.c:125)
==17441==    by 0x25C14D: spike_v1_10_0_board_init (spike.c:199)
==17441==    by 0x2CCE0A: machine_run_board_init (machine.c:807)
==17441==    by 0x1BFF28: main (vl.c:4597)
==17441==  Address 0x3055c425 is 0 bytes after a block of size 5 alloc'd
==17441==    at 0x4C2FB55: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==17441==    by 0x70C8770: g_malloc0 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==17441==    by 0x26511E: riscv_isa_string (cpu.c:395)
==17441==    by 0x25C14D: create_fdt (spike.c:125)
==17441==    by 0x25C14D: spike_v1_10_0_board_init (spike.c:199)
==17441==    by 0x2CCE0A: machine_run_board_init (machine.c:807)
==17441==    by 0x1BFF28: main (vl.c:4597)

If you can prioritise a patch that fixes the bug in riscv_isa_string()
I'll apply that and hopefully these intermittent failures will go away.

thanks
-- PMM
