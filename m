Received: from eggs.gnu.org ([2001:4830:134:3::10]:39059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cPGtb-0002Ab-Q6
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cPGtT-0008Qm-5e
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:52:27 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cPGtS-0008QD-T9
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:52:23 -0500
Received: by mail-pg0-x244.google.com with SMTP id i5so41992572pgh.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 14:52:21 -0800 (PST)
Received: from octofox.metropolis (corp.Cadence.COM. [158.140.1.28])
	by smtp.gmail.com with ESMTPSA id
	o1sm157193822pgf.35.2017.01.05.14.52.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 05 Jan 2017 14:52:19 -0800 (PST)
Date: Thu, 5 Jan 2017 14:52:10 -0800
From: Max Filippov <jcmvbkbc@gmail.com>
Message-ID: <20170105225210.GA5235@octofox.metropolis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] qemu-softmmu aborted with "Bad ram pointer"
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

debugging XIP kernel running directly from CFI FLASH I've got to a point
where QEMU aborts with the message "Bad ram pointer 0xbb4".

It turns out that that happens when QEMU tries to translate code from FLASH
immediately after the kernel has written to the FLASH address range:
writing to FLASH address range turns off romd_mode of its memory region:

#0  memory_region_rom_device_set_romd (mr=0x555556160900, romd_mode=false) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/memory.c:1758
#1  0x00005555556af3c2 in pflash_write (pfl=0x555556160560, offset=104608956, value=0, width=4, be=0) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/hw/block/pflash_cfi01.c:475
#2  0x00005555556afb40 in pflash_mem_write_with_attrs (opaque=0x555556160560, addr=104608956, value=0, len=4, attrs=...) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/hw/block/pflash_cfi01.c:690
#3  0x0000555555613fab in memory_region_write_with_attrs_accessor (mr=0x555556160900, addr=104608956, value=0x7fffd74da378, size=4, shift=0, mask=4294967295, attrs=...) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/memory.c:552
#4  0x00005555556140ce in access_with_adjusted_size (addr=104608956, value=0x7fffd74da378, size=4, access_size_min=1, access_size_max=4, access=0x555555613ebd <memory_region_write_with_attrs_accessor>, mr=0x555556160900,
    attrs=...) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/memory.c:592
#5  0x0000555555616839 in memory_region_dispatch_write (mr=0x555556160900, addr=104608956, data=0, size=4, attrs=...) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/memory.c:1329
#6  0x000055555561c3d5 in io_writex (env=0x55555607b7f0, iotlbentry=0x555556085898, val=0, addr=3862705340, retaddr=140737081961295, size=4) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cputlb.c:535
#7  0x000055555561dfd2 in io_writel (env=0x55555607b7f0, mmu_idx=0, index=195, val=0, addr=3862705340, retaddr=140737081961295) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/softmmu_template.h:265
#8  0x000055555561e165 in helper_le_stl_mmu (env=0x55555607b7f0, addr=3862705340, val=0, oi=32, retaddr=140737081961295) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/softmmu_template.h:300
#9  0x00007fffe7c6eb4f in code_gen_buffer ()
#10 0x00005555555ce2f1 in cpu_tb_exec (cpu=0x555556073570, itb=0x7fffda16e9a0) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpu-exec.c:164
#11 0x00005555555ceeb0 in cpu_loop_exec_tb (cpu=0x555556073570, tb=0x7fffda16e9a0, last_tb=0x7fffd74daa38, tb_exit=0x7fffd74daa34, sc=0x7fffd74daa50) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpu-exec.c:544
#12 0x00005555555cf188 in cpu_exec (cpu=0x555556073570) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpu-exec.c:638
#13 0x00005555555fde13 in tcg_cpu_exec (cpu=0x555556073570) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpus.c:1117
#14 0x00005555555fe06d in qemu_tcg_cpu_thread_fn (arg=0x555556073570) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpus.c:1197

then TLB gets flushed:

#1  0x000055555561b1e6 in tlb_flush (cpu=0x555556073570, flush_global=1) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cputlb.c:81
#2  0x00005555555c63be in tcg_commit (listener=0x555556095cb8) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/exec.c:2396
#3  0x000055555561588d in memory_region_transaction_commit () at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/memory.c:929
#4  0x0000555555617830 in memory_region_rom_device_set_romd (mr=0x555556160900, romd_mode=false) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/memory.c:1759

and then QEMU attempts code translation:

#0  tlb_set_page_with_attrs (cpu=0x555556073570, vaddr=3862794240, paddr=4131229696, attrs=..., prot=1028, mmu_idx=0, size=268435456) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cputlb.c:393
#1  0x000055555561bf9b in tlb_set_page (cpu=0x555556073570, vaddr=3862794240, paddr=4131229696, prot=1028, mmu_idx=0, size=268435456) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cputlb.c:428
#2  0x0000555555650a45 in tlb_fill (cs=0x555556073570, vaddr=3862797236, access_type=MMU_INST_FETCH, mmu_idx=0, retaddr=0) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/target/xtensa/op_helper.c:67
#3  0x0000555555622efe in helper_ret_ldb_cmmu (env=0x55555607b7f0, addr=3862797236, oi=0, retaddr=0) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/softmmu_template.h:127
#4  0x000055555561ade4 in cpu_ldub_code_ra (env=0x55555607b7f0, ptr=3862797236, retaddr=0) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/include/exec/cpu_ldst_template.h:102
#5  0x000055555561ae58 in cpu_ldub_code (env=0x55555607b7f0, ptr=3862797236) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/include/exec/cpu_ldst_template.h:114
#6  0x000055555561c0a5 in get_page_addr_code (env1=0x55555607b7f0, addr=3862797236) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cputlb.c:482
#7  0x00005555555ce761 in tb_htable_lookup (cpu=0x555556073570, pc=3862797236, cs_base=0, flags=98320) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpu-exec.c:306
#8  0x00005555555ce8cf in tb_find (cpu=0x555556073570, last_tb=0x0, tb_exit=0) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpu-exec.c:329
#9  0x00005555555cf165 in cpu_exec (cpu=0x555556073570) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpu-exec.c:637
#10 0x00005555555fde13 in tcg_cpu_exec (cpu=0x555556073570) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpus.c:1117

but the condition (!memory_region_is_ram(section->mr) && !memory_region_is_romd(section->mr))
is true in the tlb_set_page_with_attrs, so TLB entry gets bogus
addend (0 - vaddr, actually), which results in the following abort:

#0  0x00007ffff34c7067 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
#1  0x00007ffff34c8448 in __GI_abort () at abort.c:89
#2  0x000055555561b8cb in qemu_ram_addr_from_host_nofail (ptr=0xbb4) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cputlb.c:253
#3  0x000055555561c1de in get_page_addr_code (env1=0x55555607c7f0, addr=3862797236) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cputlb.c:498
#4  0x00005555555ce761 in tb_htable_lookup (cpu=0x555556074570, pc=3862797236, cs_base=0, flags=98320) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpu-exec.c:306
#5  0x00005555555ce8cf in tb_find (cpu=0x555556074570, last_tb=0x0, tb_exit=0) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpu-exec.c:329
#6  0x00005555555cf165 in cpu_exec (cpu=0x555556074570) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpu-exec.c:637
#7  0x00005555555fde13 in tcg_cpu_exec (cpu=0x555556074570) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpus.c:1117
#8  0x00005555555fe06d in qemu_tcg_cpu_thread_fn (arg=0x555556074570) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpus.c:1197
#9  0x00007ffff38450a4 in start_thread (arg=0x7fffd74db700) at pthread_create.c:309
#10 0x00007ffff357a62d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111

With CFI flash debug output enabled it looks like that:

PFLASH: pflash_write: writing offset 00000000063c34c0 value e60b1198 width 4 wcycle 0x0
PFLASH: pflash_write: CFI query
PFLASH: pflash_write: writing offset 00000000063c34c4 value 00000000 width 4 wcycle 0x1
PFLASH: pflash_write: leaving query mode
PFLASH: pflash_write: writing offset 00000000063c34c8 value 00000000 width 4 wcycle 0x1
PFLASH: pflash_write: leaving query mode
PFLASH: pflash_write: writing offset 00000000063c34dc value 00000000 width 4 wcycle 0x1
PFLASH: pflash_write: leaving query mode
PFLASH: pflash_write: writing offset 00000000063c34e0 value 00000000 width 4 wcycle 0x1
PFLASH: pflash_write: leaving query mode
PFLASH: pflash_write: writing offset 00000000063c34ec value 00000000 width 4 wcycle 0x1
PFLASH: pflash_write: leaving query mode
PFLASH: pflash_write: writing offset 00000000063c34f4 value 00000000 width 4 wcycle 0x1
PFLASH: pflash_write: leaving query mode
PFLASH: pflash_write: writing offset 00000000063c34fc value 00000000 width 4 wcycle 0x1
PFLASH: pflash_write: leaving query mode
Bad ram pointer 0xbb4


AFAIU the FLASH is readable at that point, but instruction
fetching doesn't work, and it's not FLASH model issue, it's
an issue somewhere in the memory region code.

Command line that I used:
qemu-system-xtensa -cpu dc233c -M kc705 -monitor null -nographic -serial mon:stdio -m 1G -pflash xip-kc705-dc233c-flash

FLASH image:
http://jcmvbkbc.spb.ru/~jcmvbkbc/tmp/201701051441/xip-kc705-dc233c-flash.gz

-- 
Thanks.
-- Max
