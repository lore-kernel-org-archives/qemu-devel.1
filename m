Received: from eggs.gnu.org ([2001:4830:134:3::10]:40184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e1EDw-0005Qr-Od
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 12:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e1EDt-0004lK-IB
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 12:14:40 -0400
Date: Sun, 8 Oct 2017 18:14:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <d4ffee34-8a82-95ea-bedc-ed37ae5fae67@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.1710081718490.54240@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1707270007490.20438@zero.eik.bme.hu>
	<alpine.BSF.2.21.1708192307590.44932@zero.eik.bme.hu>
	<alpine.BSF.2.21.1708202246550.65843@zero.eik.bme.hu>
	<d4ffee34-8a82-95ea-bedc-ed37ae5fae67@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [Qemu-ppc] How to debug crash in TCG code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

Hello,

I'm still trying to debug a crash that I don't understand why is
happening and how to debug it further. Any hints are apreciated. I've 
described the problem previously in
http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00249.html
but I've dug deeper now, here's what I've found.

I'm running with -accel tcg,thread=single -singlestep so it does not seem 
to be a multi threading problem. The seg fault happens when U-Boot running 
on the emulated embedded PPC SoC accesses a PCI device but after several 
successful iteration of the same access so it seems to be some internal 
inconsistency that arrises while QEMU is running, not something generally 
broken. It is also dependent on code run by the client or QEMU, so e.g. it 
disappears when I enable -d in_asm or use a different U-Boot version. I'm 
not sure what exactly causes the bug to happen or disappear but I can 
reproduce it reliably with certain images at the same place. It always 
happens during io_readx or io_writex. Here's the info I could get with a 
debugger with some additional debug and trace messages enabled:

Here's the PCI device detected by U-Boot and BARs mapped:
The device is implemended here:
http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00246.html

4744@1507472117.454656:pci_cfg_read sii3112 01:0 @0xe -> 0x0
tlb_set_page_with_attrs: vaddr=0ffb0800 paddr=0x000000000ffb0800 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ff73c00 paddr=0x000000000ff73c00 prot=7 idx=1
4744@1507472117.454676:pci_cfg_read sii3112 01:0 @0x0 -> 0x1095
4744@1507472117.454766:pci_cfg_read sii3112 01:0 @0x2 -> 0x3112
4744@1507472117.454775:pci_cfg_read sii3112 01:0 @0xa -> 0x104
tlb_set_page_with_attrs: vaddr=0ff74000 paddr=0x000000000ff74000 prot=7 idx=1
4744@1507472117.454794:pci_cfg_read sii3112 01:0 @0xa -> 0x104
4744@1507472117.454905:pci_cfg_read sii3112 01:0 @0x4 -> 0x0
4744@1507472117.454916:pci_cfg_write sii3112 01:0 @0x10 <- 0xffffffff
4744@1507472117.454927:pci_cfg_read sii3112 01:0 @0x10 -> 0xfffffff9
4744@1507472117.456524:pci_cfg_write sii3112 01:0 @0x10 <- 0x1000
tlb_set_page_with_attrs: vaddr=0ff74800 paddr=0x000000000ff74800 prot=7 idx=1
4744@1507472117.456823:pci_cfg_write sii3112 01:0 @0x14 <- 0xffffffff
4744@1507472117.456833:pci_cfg_read sii3112 01:0 @0x14 -> 0xfffffffd
4744@1507472117.456844:pci_cfg_write sii3112 01:0 @0x14 <- 0x1008
4744@1507472117.456852:pci_cfg_write sii3112 01:0 @0x18 <- 0xffffffff
4744@1507472117.456859:pci_cfg_read sii3112 01:0 @0x18 -> 0xfffffff9
4744@1507472117.456869:pci_cfg_write sii3112 01:0 @0x18 <- 0x1010
4744@1507472117.456878:pci_cfg_write sii3112 01:0 @0x1c <- 0xffffffff
4744@1507472117.456885:pci_cfg_read sii3112 01:0 @0x1c -> 0xfffffffd
4744@1507472117.456895:pci_cfg_write sii3112 01:0 @0x1c <- 0x1018
4744@1507472117.456903:pci_cfg_write sii3112 01:0 @0x20 <- 0xffffffff
4744@1507472117.456911:pci_cfg_read sii3112 01:0 @0x20 -> 0xfffffff1
4744@1507472117.456920:pci_cfg_write sii3112 01:0 @0x20 <- 0x1020
4744@1507472117.456929:pci_cfg_write sii3112 01:0 @0x24 <- 0xffffffff
4744@1507472117.456936:pci_cfg_read sii3112 01:0 @0x24 -> 0xfffffe00
4744@1507472117.457173:pci_cfg_write sii3112 01:0 @0x24 <- 0x80000000
4744@1507472117.457208:pci_cfg_write sii3112 01:0 @0x4 <- 0x7
4744@1507472117.457213:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 0,0x1000+0x8
tlb_flush_nocheck: (count: 23)
4744@1507472117.457488:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 1,0x1008+0x4
tlb_flush_nocheck: (count: 24)
4744@1507472117.457769:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 2,0x1010+0x8
tlb_flush_nocheck: (count: 25)
4744@1507472117.458048:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 3,0x1018+0x4
tlb_flush_nocheck: (count: 26)
4744@1507472117.458324:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 4,0x1020+0x10
tlb_flush_nocheck: (count: 27)
4744@1507472117.458604:pci_update_mappings_add d=0x55aca57d3ce0 00:01.0 5,0x80000000+0x200

(BAR0-4 are alias memory regions to BAR5 so all access should go to BAR5 
at the end even if U-Boot accesses it through BAR0-4)
Here U-Boot starts using the device:

tlb_set_page_with_attrs: vaddr=dec00000 paddr=0x0000000c0ec00000 prot=3 idx=1
4744@1507472121.253966:pci_cfg_read ppc4xx-host-bridge 00:0 @0xe -> 0x0
4744@1507472121.253982:pci_cfg_read ppc4xx-host-bridge 00:0 @0x0 -> 0x1014
4744@1507472121.253992:pci_cfg_read ppc4xx-host-bridge 00:0 @0x2 -> 0x27f
4744@1507472121.254005:pci_cfg_read sii3112 01:0 @0xe -> 0x0
4744@1507472121.254015:pci_cfg_read sii3112 01:0 @0x0 -> 0x1095
4744@1507472121.254024:pci_cfg_read sii3112 01:0 @0x2 -> 0x3112
tlb_set_page_with_attrs: vaddr=00000800 paddr=0x0000000000000800 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ff6f000 paddr=0x000000000ff6f000 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ff74000 paddr=0x000000000ff74000 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ff73c00 paddr=0x000000000ff73c00 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ffb0c00 paddr=0x000000000ffb0c00 prot=7 idx=1
4744@1507472121.254748:pci_cfg_write sii3112 01:0 @0x4 <- 0x7
4744@1507472121.254846:pci_cfg_read sii3112 01:0 @0x8 -> 0x1040001
4744@1507472121.255085:pci_cfg_write sii3112 01:0 @0xc <- 0x1
4744@1507472121.255228:pci_cfg_read sii3112 01:0 @0x10 -> 0x1001
4744@1507472121.255417:pci_cfg_read sii3112 01:0 @0x18 -> 0x1011
tlb_set_page_with_attrs: vaddr=0ffa3800 paddr=0x000000000ffa3800 prot=7 idx=1

And can talk to the device emulation:

tlb_set_page_with_attrs: vaddr=0ff89000 paddr=0x000000000ff89000 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1
4744@1507472121.402003:sii3112_write bmdma: write (size 1) 0x86 : 0xe0

Address 0x86 in BAR5 is accessed via vaddr d8001006 which is an alias via BAR0

tlb_set_page_with_attrs: vaddr=0ff8a400 paddr=0x000000000ff8a400 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ffa3400 paddr=0x000000000ffa3400 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ffc7800 paddr=0x000000000ffc7800 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1
4744@1507472121.513050:sii3112_set_irq channel 0 level 0
4744@1507472121.513057:sii3112_read bmdma: read (size 1) 0x87 : 0x50
tlb_set_page_with_attrs: vaddr=0ff6f000 paddr=0x000000000ff6f000 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0df6d000 paddr=0x000000000df6d000 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ffc0800 paddr=0x000000000ffc0800 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ff87800 paddr=0x000000000ff87800 prot=7 idx=1
4744@1507472121.613784:sii3112_write bmdma: write (size 1) 0xc6 : 0xe0
tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1
4744@1507472121.724016:sii3112_set_irq channel 1 level 0
4744@1507472121.724020:sii3112_read bmdma: read (size 1) 0xc7 : 0x00
tlb_set_page_with_attrs: vaddr=0ff8a400 paddr=0x000000000ff8a400 prot=7 idx=1

Accessing the device seems to work, it identifies the connected ATAPI CD 
emulation and can read from it, until it hits null pointer:

tlb_set_page_with_attrs: vaddr=0ff89800 paddr=0x000000000ff89800 prot=7 idx=1
4744@1507472121.949834:sii3112_read bmdma: read (size 1) 0x82 : 0x02
4744@1507472121.950222:sii3112_read bmdma: read (size 2) 0x80 : 0x8005
4744@1507472121.950283:sii3112_read bmdma: read (size 2) 0x80 : 0x2100
4744@1507472121.950289:sii3112_read bmdma: read (size 2) 0x80 : 0x1f
4744@1507472121.950292:sii3112_read bmdma: read (size 2) 0x80 : 0x00
4744@1507472121.950295:sii3112_read bmdma: read (size 2) 0x80 : 0x4551
4744@1507472121.950298:sii3112_read bmdma: read (size 2) 0x80 : 0x554d
4744@1507472121.950301:sii3112_read bmdma: read (size 2) 0x80 : 0x2020
4744@1507472121.950306:sii3112_read bmdma: read (size 2) 0x80 : 0x2020
4744@1507472121.950309:sii3112_read bmdma: read (size 2) 0x80 : 0x4551
4744@1507472121.950312:sii3112_read bmdma: read (size 2) 0x80 : 0x554d
4744@1507472121.950316:sii3112_read bmdma: read (size 2) 0x80 : 0x4420
4744@1507472121.950319:sii3112_read bmdma: read (size 2) 0x80 : 0x4456
4744@1507472121.950323:sii3112_read bmdma: read (size 2) 0x80 : 0x522d
4744@1507472121.950326:sii3112_read bmdma: read (size 2) 0x80 : 0x4d4f
4744@1507472121.950330:sii3112_read bmdma: read (size 2) 0x80 : 0x2020
4744@1507472121.950333:sii3112_read bmdma: read (size 2) 0x80 : 0x2020
4744@1507472121.950338:sii3112_read bmdma: read (size 2) 0x80 : 0x2e32
4744@1507472121.950342:sii3112_set_irq channel 0 level 1
4744@1507472121.950346:sii3112_set_irq channel 0 level 1
4744@1507472121.950348:sii3112_read bmdma: read (size 2) 0x80 : 0x2b35
4744@1507472121.955573:sii3112_set_irq channel 0 level 0
4744@1507472121.955590:sii3112_read bmdma: read (size 1) 0x87 : 0x50
tlb_set_page_with_attrs: vaddr=0ff89c00 paddr=0x000000000ff89c00 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ff8a000 paddr=0x000000000ff8a000 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=0ff89400 paddr=0x000000000ff89400 prot=7 idx=1
tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1
4744@1507472121.957147:sii3112_write bmdma: write (size 1) 0x86 : 0xe0
4744@1507472121.957158:sii3112_set_irq channel 0 level 0
4744@1507472121.957161:sii3112_read bmdma: read (size 1) 0x87 : 0x50
4744@1507472121.957168:sii3112_write bmdma: write (size 1) 0x81 : 0x00
4744@1507472121.957172:sii3112_write bmdma: write (size 1) 0x82 : 0x00
4744@1507472121.957177:sii3112_write bmdma: write (size 1) 0x83 : 0x00
4744@1507472121.957181:sii3112_write bmdma: write (size 1) 0x84 : 0x00
4744@1507472121.957188:sii3112_write bmdma: write (size 1) 0x85 : 0x00
4744@1507472121.957198:sii3112_write bmdma: write (size 1) 0x86 : 0xe0
4744@1507472121.957204:sii3112_write bmdma: write (size 1) 0x87 : 0xa0
4744@1507472121.957278:sii3112_set_irq channel 0 level 0
4744@1507472121.957283:sii3112_read bmdma: read (size 1) 0x87 : 0x58
4744@1507472121.957289:sii3112_write bmdma: write (size 2) 0x80 : 0x1b
4744@1507472121.957294:sii3112_write bmdma: write (size 2) 0x80 : 0x00
4744@1507472121.957298:sii3112_write bmdma: write (size 2) 0x80 : 0x03
4744@1507472121.957302:sii3112_write bmdma: write (size 2) 0x80 : 0x00
4744@1507472121.957306:sii3112_write bmdma: write (size 2) 0x80 : 0x00
4744@1507472121.957309:sii3112_write bmdma: write (size 2) 0x80 : 0x00
4744@1507472121.957315:sii3112_set_irq channel 0 level 1
4744@1507472121.962334:sii3112_set_irq channel 0 level 0
4744@1507472121.962340:sii3112_read bmdma: read (size 1) 0x87 : 0x50
4744@1507472121.962346:sii3112_read bmdma: read (size 1) 0x85 : 0x00
4744@1507472121.962351:sii3112_read bmdma: read (size 1) 0x84 : 0x00
4744@1507472121.967372:sii3112_set_irq channel 0 level 0
4744@1507472121.967378:sii3112_read bmdma: read (size 1) 0x87 : 0x50
tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3 idx=1
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffe87f7700 (LWP 4761)]
0x00005555557f4bc4 in io_writex (env=0x7fffe88002a0, iotlbentry=0x7fffe8811d60, mmu_idx=1, val=224, addr=3623882758, retaddr=140737099010411,
     size=1) at accel/tcg/cputlb.c:803
     803    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
(gdb) bt
#0  0x00005555557f4bc4 in io_writex (env=0x7fffe88002a0, iotlbentry=0x7fffe8811d60, mmu_idx=1, val=224, addr=3623882758, retaddr=140737099010411,
     size=1) at accel/tcg/cputlb.c:803
#1  0x00005555557f5673 in io_writeb (env=0x7fffe88002a0, mmu_idx=1, index=4, val=224 '\340', addr=3623882758, retaddr=140737099010411)
     at accel/tcg/softmmu_template.h:265
#2  0x00005555557f57ff in helper_ret_stb_mmu (env=0x7fffe88002a0, addr=3623882758, val=224 '\340', oi=1, retaddr=140737099010411)
     at accel/tcg/softmmu_template.h:300
#3  0x00007fffe8cb116b in code_gen_buffer ()
#4  0x00005555557fdaf1 in cpu_tb_exec (cpu=0x7fffe87f8010, itb=0x7fffe8cb0780 <code_gen_buffer+3753814>)
     at accel/tcg/cpu-exec.c:166
#5  0x00005555557fe936 in cpu_loop_exec_tb (cpu=0x7fffe87f8010, tb=0x7fffe8cb0780 <code_gen_buffer+3753814>, last_tb=0x7fffe87f6af8,
     tb_exit=0x7fffe87f6af4) at accel/tcg/cpu-exec.c:613
#6  0x00005555557fec29 in cpu_exec (cpu=0x7fffe87f8010) at accel/tcg/cpu-exec.c:711
#7  0x00005555557c7a05 in tcg_cpu_exec (cpu=0x7fffe87f8010) at qemu/cpus.c:1270
#8  0x00005555557c7c3c in qemu_tcg_rr_cpu_thread_fn (arg=0x7fffe87f8010) at qemu/cpus.c:1365
#9  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
#10 0x00007ffff42d062d in clone () from /lib64/libc.so.6
(gdb) p mr
$1 = (MemoryRegion *) 0x0
(gdb) p/x addr
$2 = 0xd8001006
(gdb) p *iotlbentry
$3 = {addr = 18446744070085669013, attrs = {unspecified = 1, secure = 0, user = 0, requester_id = 0}}
(gdb) p/x iotlbentry->addr
$4 = 0xffffffff27fff095
(gdb) up
#1  0x00005555557f5673 in io_writeb (env=0x7fffe88002a0, mmu_idx=1, index=4, val=224 '\340', addr=3623882758, retaddr=140737099010411)
     at accel/tcg/softmmu_template.h:265
265    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, DATA_SIZE);
(gdb) up
#2  0x00005555557f57ff in helper_ret_stb_mmu (env=0x7fffe88002a0, addr=3623882758, val=224 '\340', oi=1, retaddr=140737099010411)
     at accel/tcg/softmmu_template.h:300
300        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr);
(gdb) l 260
255# endif
256#endif
257
258static inline void glue(io_write, SUFFIX)(CPUArchState *env,
259                                          size_t mmu_idx, size_t index,
260                                          DATA_TYPE val,
261                                          target_ulong addr,
262                                          uintptr_t retaddr)
263{
264    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
265    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, DATA_SIZE);
266}
267
268void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
269                       TCGMemOpIdx oi, uintptr_t retaddr)
270{
271    unsigned mmu_idx = get_mmuidx(oi);
272    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
273    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
274    unsigned a_bits = get_alignment_bits(get_memop(oi));
275    uintptr_t haddr;
276
277    if (addr & ((1 << a_bits) - 1)) {
278        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
279                             mmu_idx, retaddr);
280    }
281
282    /* If the TLB entry is for a different page, reload and try again.  */
283    if ((addr & TARGET_PAGE_MASK)
284        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
285        if (!VICTIM_TLB_HIT(addr_write, addr)) {
286            tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
287        }
288        tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
289    }
290
291    /* Handle an IO access.  */
292    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
293        if ((addr & (DATA_SIZE - 1)) != 0) {
294            goto do_unaligned_access;
295        }
296
297        /* ??? Note that the io helpers always read data in the target
298           byte ordering.  We should push the LE/BE request down into io.  */
299        val = TGT_LE(val);
300        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr);
301        return;
302    }
303
304    /* Handle slow unaligned access (it spans two pages or IO).  */
(gdb) p/x tlb_addr
$5 = 0xd8001080
(gdb) p/x env->tlb_table[mmu_idx][index]
$6 = {{{addr_read = 0xd8001080, addr_write = 0xd8001080, addr_code = 0xffffffff, addend = 0xffffffff27fff000}, dummy = {0x80, 0x10, 0x0, 0xd8,
       0x80, 0x10, 0x0, 0xd8, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x0, 0xf0, 0xff, 0x27, 0xff <repeats 12 times>}}}

So as far as I understand the mmu_idx and index variables passed down to 
io_write are from env->tlb_table but are used on the env->iotlb array to 
get iotlbentry which seems to be invalid in this case (while apparently 
normally these are in sync and this works because several successful 
accesses precede this one causing the crash). Does anyone know if this is 
correct and how are these arrays can get out of sync causing this crash or 
what should be checked to find the problem here?

Thank you,
BALATON Zoltan
