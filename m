Received: from eggs.gnu.org ([2001:4830:134:3::10]:48022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dihdD-0005vZ-2n
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dihd9-0006Pp-VA
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:48:11 -0400
Date: Fri, 18 Aug 2017 15:48:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1708181526340.19483@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] BookE MMU question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>

Hello,

While trying to get my recently posted Sam460ex emulation working (more 
details on that here: 
http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00112.html)
I'm stuck at a point with BookE MMU behaviour that seems to differ from 
real hardware but I don't know much about it so I hope someone with more 
knowledge can spot the problem or give some hints where to look for it.

When trying to boot AROS it currently fails when mmu_init() is run from 
https://github.com/ezrec/AROS-mirror/blob/ABI_V1/AROS/arch/ppc-sam440/kernel/mmu.c
(around line 273 I think).

With a lot of debug enabled I see this:

[KRN] MMU Init
[KRN] lowest = 007f74e8, base = 00800000, highest = 00c081f0
[KRN] Kernel size: 4128KB code, 34KB data
[KRN] Executing at ff841658, stack at ff7fd260, bss at ff7fd848, data at ff7fffb8
[KRN] TLB0f: -I---rwxrwx 00000000 - 0fffffff : 00000000: 0:00000290 1:00000000 2:0000043f
[KRN] TLB02: -I-G-rw-rw- 80000000 - 8fffffff : 80000000: 0:80000290 1:8000000c 2:0000051b
[KRN] TLB03: -I-G-rw-rw- 90000000 - 9fffffff : 90000000: 0:90000290 1:9000000c 2:0000051b
[KRN] TLB04: -I-G-rw-rw- a0000000 - afffffff : a0000000: 0:a0000290 1:a000000d 2:0000051b
[KRN] TLB05: -I-G-rw-rw- b0000000 - bfffffff : b0000000: 0:b0000290 1:b000000d 2:0000051b
[KRN] TLB06: -I-G-rw-rw- c0000000 - cfffffff : c0000000: 0:c0000290 1:c000000d 2:0000051b
[KRN] TLB01: -I-G-rw-rw- d0000000 - dfffffff : 00000000: 0:d0000290 1:0000000c 2:0000051b
[KRN] TLB07: -I-G-rw-rw- e0000000 - e0ffffff : 00000000: 0:e0000270 1:0000000d 2:0000051b
[KRN] TLB08: -I-G-rw-rw- e1000000 - e1ffffff : 20000000: 0:e1000270 1:2000000d 2:0000051b
[KRN] TLB0e: -I-G-rwxrwx e2000000 - e20fffff : bff00000: 0:e2000250 1:bff00004 2:0000053f
[KRN] TLB09: -I-G-rw-rw- e3000000 - e30003ff : 10000000: 0:e3000200 1:1000000d 2:0000051b
[KRN] TLB0a: -I-G-rw-rw- e3001000 - e30013ff : 30000000: 0:e3001200 1:3000000d 2:0000051b
[KRN] TLB0b: -I-G-rw-rw- e4000000 - e4003fff : 08010000: 0:e4000220 1:0801000c 2:0000051b
[KRN] TLB0c: -I---rwxrwx e5000000 - e50fffff : 00000000: 0:e5000250 1:00000004 2:0000043f
[KRN] TLB0d: -I-G-rwxrwx ef000000 - efffffff : ef000000: 0:ef000270 1:ef000004 2:0000053f
[KRN] TLB00: -I---rwxrwx ff000000 - ffffffff : 00000000: 0:ff000270 1:00000000 2:0000043f
[KRN] map_region(007f7000, ff7f7000, 00009000, 081b):
[KRN] TLB00: 007f7000 - 007f7fff : ff7f7000 - ff7f7fff:

helper_440_tlbwe word 0 entry 0 value ff7f7210
tlb_flush_nocheck: (count: 36)
helper_440_tlbwe word 1 entry 0 value 007f7000
tlb_flush_nocheck: (count: 37)
helper_440_tlbwe word 2 entry 0 value 0000081b
ppcemb_tlb_check: TLB 0 address ff7fd648 PID 0 <=> ff7f7000 fffff000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 1 address ff7fd648 PID 0 <=> d0000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 2 address ff7fd648 PID 0 <=> 80000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 3 address ff7fd648 PID 0 <=> 90000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 4 address ff7fd648 PID 0 <=> a0000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 5 address ff7fd648 PID 0 <=> b0000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 6 address ff7fd648 PID 0 <=> c0000000 f0000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 7 address ff7fd648 PID 0 <=> e0000000 ff000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 8 address ff7fd648 PID 0 <=> e1000000 ff000000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 9 address ff7fd648 PID 0 <=> e3000000 fffffc00 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 10 address ff7fd648 PID 0 <=> e3001000 fffffc00 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 11 address ff7fd648 PID 0 <=> e4000000 ffffc000 0 3b
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 12 address ff7fd648 PID 0 <=> e5000000 fff00000 0 7f
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 13 address ff7fd648 PID 0 <=> ef000000 ff000000 0 7f
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 14 address ff7fd648 PID 0 <=> e2000000 fff00000 0 7f
mmubooke_check_tlb: TLB entry not found
ppcemb_tlb_check: TLB 15 address ff7fd648 PID 0 <=> 00000000 f0000000 0 7f
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_check_tlb: TLB entry not found
mmubooke_get_physical_address: access refused ff7fd648 => ffffffffffffffff 0 -1

Apparently this works on real hardware (although I could not check because 
I don't have access to it and found no logs proving it) but fails in 
emulation so it may be a bug or some difference in emulation. Does anyone 
have any idea? Could this be related to caching/shadow TLBs on real 
hardware that are not emulated? How could this be fixed in QEMU?

Regards,
BALATON Zoltan
