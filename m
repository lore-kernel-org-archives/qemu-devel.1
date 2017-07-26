Received: from eggs.gnu.org ([2001:4830:134:3::10]:37729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1daUsS-0007Q2-Ay
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1daUsN-0005oz-ED
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:34:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:11079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1daUsN-0005km-2a
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:33:55 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
	by localhost (Postfix) with SMTP id 756487456EE
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 00:33:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 41C737456EB
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 00:33:46 +0200 (CEST)
Date: Thu, 27 Jul 2017 00:33:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1707270007490.20438@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] How to debug crash in TCG code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I'm getting a segfault in generated code that I don't know how to debug 
further. The back trace shows:

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffe87f7700 (LWP 24372)]
0x00005555557ee0a1 in io_readx (env=0x7fffe88002a0, iotlbentry=0x7fffe8811d60, addr=3623882752, retaddr=140737096497196, size=2)
     at accel/tcg/cputlb.c:766
766         if (mr->global_locking) {
(gdb) bt
#0  0x00005555557ee0a1 in io_readx (env=0x7fffe88002a0, iotlbentry=0x7fffe8811d60, addr=3623882752, retaddr=140737096497196, size=2)
     at accel/tcg/cputlb.c:766
#1  0x00005555557eede9 in io_readw (env=0x7fffe88002a0, mmu_idx=1, index=4, addr=3623882752, retaddr=140737096497196)
     at softmmu_template.h:104
#2  0x00005555557ef1f0 in helper_be_lduw_mmu (env=0x7fffe88002a0, addr=3623882752, oi=145, retaddr=140737096497196)
     at softmmu_template.h:208
#3  0x00007fffe8a4b8d3 in code_gen_buffer ()
#4  0x00005555557f69b8 in cpu_tb_exec (cpu=0x7fffe87f8010, itb=0x7fffe8a4b660 <code_gen_buffer+1242678>)
     at accel/tcg/cpu-exec.c:166
#5  0x00005555557f769f in cpu_loop_exec_tb (cpu=0x7fffe87f8010, tb=0x7fffe8a4b660 <code_gen_buffer+1242678>,
     last_tb=0x7fffe87f6af8, tb_exit=0x7fffe87f6af4) at accel/tcg/cpu-exec.c:578
#6  0x00005555557f7992 in cpu_exec (cpu=0x7fffe87f8010) at accel/tcg/cpu-exec.c:676
#7  0x00005555557c2955 in tcg_cpu_exec (cpu=0x7fffe87f8010) at cpus.c:1270
#8  0x00005555557c2b8c in qemu_tcg_rr_cpu_thread_fn (arg=0x7fffe87f8010) at cpus.c:1365
#9  0x00007ffff5d515bd in start_thread () from /lib64/libpthread.so.0
#10 0x00007ffff42d062d in clone () from /lib64/libc.so.6
(gdb) p mr
$1 = (MemoryRegion *) 0x0

This is happening while reading from an emulated ATAPI DVD and happens 
after several successful reads from the same device with similar calls 
succeeding without a problem until hitting the above error. The point 
where this happens seems to depend on the ammount of guest code executed. 
The more code is there, the sooner this happens. (This is running in 
TCG ppc-softmmu on x86_64 host in case that's relevant but I can't make 
an easy test case to reproduce it.)

First I thought it may be related to MTTCG or removing the iothread lock 
but I could also get the same with 791158d9, where the back trace is:

#0  0x00005555557e1de5 in memory_region_access_valid (mr=0x0, addr=0, size=2, is_write=false) at memory.c:1204
#1  0x00005555557e200a in memory_region_dispatch_read (mr=0x0, addr=0, pval=0x7fffe4854488, size=2, attrs=...)
     at memory.c:1268
#2  0x00005555557e7f9c in io_readx (env=0x7ffff7e232a0, iotlbentry=0x7ffff7e34d58, addr=3623882752,
      retaddr=140737066697996, size=2) at cputlb.c:506
#3  0x00005555557e8a9e in io_readw (env=0x7ffff7e232a0, mmu_idx=1, index=4, addr=3623882752, retaddr=140737066697996)
     at softmmu_template.h:104
#4  0x00005555557e8eb0 in helper_be_lduw_mmu (env=0x7ffff7e232a0, addr=3623882752, oi=145, retaddr=140737066697996)
     at softmmu_template.h:208
#5  0x00007fffe6de05b3 in code_gen_buffer ()
#6  0x0000555555783fca in cpu_tb_exec (cpu=0x7ffff7e1b010, itb=0x7fffe49a2080) at cpu-exec.c:164
#7  0x0000555555784b97 in cpu_loop_exec_tb (cpu=0x7ffff7e1b010, tb=0x7fffe49a2080, last_tb=0x7fffe4854af8,
      tb_exit=0x7fffe4854af4, sc=0x7fffe4854b10) at cpu-exec.c:550
#8  0x0000555555784ea0 in cpu_exec (cpu=0x7ffff7e1b010) at cpu-exec.c:655
#9  0x00005555557c8da3 in tcg_cpu_exec (cpu=0x7ffff7e1b010) at cpus.c:1253
#10 0x00005555557c900d in qemu_tcg_cpu_thread_fn (arg=0x7ffff7e1b010) at cpus.c:1345
#11 0x00007ffff45b65bd in start_thread () from /lib64/libpthread.so.0
#12 0x00007ffff42f262d in clone () from /lib64/libc.so.6

So it seems to be caused not by thread locking issues by recent changes 
but maybe by somehow referencing an invalid iotlb entry in a TB. My theory 
(without knowing anything about how this part of QEMU works) is that as 
code is executed instruction and data exceptions are triggered which make 
changes in TLB entries but this does not correctly invalidate a TB that 
already references this entry and this causes the crash when this happens 
(but it works until the TLB is not changed which explains why less code 
works and more code which makes these exceptions more frequent triggers it 
sooner). But I have no idea if this theory is correct or how to verify it 
and where to look for the problem and fix.

Does anyone have any idea that could help or point me to the right 
direction please?

Thank you,
BALATON Zoltan
