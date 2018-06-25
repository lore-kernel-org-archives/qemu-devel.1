Received: from eggs.gnu.org ([2001:4830:134:3::10]:34119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1fXVve-0002c6-Sj
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huaicheng@cs.uchicago.edu>) id 1fXVvb-0005xv-LX
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:09:30 -0400
Received: from mx.cs.uchicago.edu ([128.135.164.214]:45304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <huaicheng@cs.uchicago.edu>)
	id 1fXVvb-0005xZ-DE
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:09:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx.cs.uchicago.edu (Postfix) with ESMTP id 69B57950DD
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 13:09:26 -0500 (CDT)
Received: from mx.cs.uchicago.edu ([127.0.0.1])
	by localhost (mx.cs.uchicago.edu [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YuDAv3JauhKr for <qemu-devel@nongnu.org>;
	Mon, 25 Jun 2018 13:09:25 -0500 (CDT)
Received: from mail-lf0-f41.google.com (mail-lf0-f41.google.com
	[209.85.215.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.cs.uchicago.edu (Postfix) with ESMTPSA id CFBD8950DB
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 13:09:24 -0500 (CDT)
Received: by mail-lf0-f41.google.com with SMTP id m13-v6so4667025lfb.12
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:09:24 -0700 (PDT)
MIME-Version: 1.0
From: Huaicheng Li <huaicheng@cs.uchicago.edu>
Date: Mon, 25 Jun 2018 11:08:46 -0700
Message-ID: <CANr0WEc6Mdncw0cfAsJ9H4026gwxPsuW1nRFqeCT-v5nw9=uzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] map host MMIO address to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

I'm trying to map a host MMIO region (host PCIe device BAR) into guest
physical address space. The goal is to enable direct control over that host
MMIO region from guest OS by accessing a certain GPA.

I know the address of the host MMIO region (one page). First I map the page
into QEMU process address space and get a QEMU buffer. Then I use
"memory_region_init_ram_ptr();
memory_region_add_subregion_overlap(system_memory, 512MB, my_mr, 1)" to map
the QEMU buffer as part of guest physical address space (starting from
512MB to 512MB+4K).

When I read/write to QEMU buffer, I can observe that correct MMIO region
access is triggered. However, when I try to access the mapped MMIO region
from guest OS (using a guest kernel module to access gpa:512MB directly),
the following host kernel panic will be triggered.

I don't understand why this happens. When I use the same method and map a
host memory page (instead of a host MMIO page) into guest, it works fine. I
appreciate if anyone can help analyze this? Thanks in advance.

Best,
Huaicheng

[  323.844213] BUG: unable to handle kernel paging request at
ffffea0003faf460
[  323.845671] IP: gup_pgd_range+0x2f5/0x860
[  323.846615] PGD 23f7ed067 P4D 23f7ed067 PUD 23f7ec067 PMD 0
[  323.847848] Oops: 0000 [#1] SMP
[  323.848692] Modules linked in: wpt(O) kvm_intel kvm irqbypass
[  323.850085] CPU: 2 PID: 4994 Comm: qemu-system-x86 Tainted: G
 O     4.15.0-rc4+ #10
[  323.853002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
[  323.855029] RIP: 0010:gup_pgd_range+0x2f5/0x860
[  323.855792] RSP: 0018:ffffc90004fdbae0 EFLAGS: 00010002
[  323.856648] RAX: 0000000003faf440 RBX: 0000555b8c6db000 RCX:
00003ffffffff000
[  323.857618] RDX: ffffea0003faf440 RSI: ffff88022d4c36d0 RDI:
80000000febd1067
[  323.858598] RBP: ffffc90004fdbb7c R08: 0400000000000000 R09:
ffffea0000000000
[  323.859428] R10: 00003ffffffff000 R11: 80000000febd1067 R12:
000000022d4c3067
[  323.860216] R13: ffffc90004fdbba8 R14: 0000555b8c6da000 R15:
0000000000000007
[  323.860979] FS:  00007f4a3a527700(0000) GS:ffff88023fc80000(0000)
knlGS:0000000000000000
[  323.861899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  323.862534] CR2: ffffea0003faf460 CR3: 0000000232723001 CR4:
00000000000626e0
[  323.863312] Call Trace:
[  323.863667]  __get_user_pages_fast+0x6b/0x90
[  323.864234]  __gfn_to_pfn_memslot+0xf5/0x3b0 [kvm]
[  323.864858]  ? kvm_irq_delivery_to_apic+0x51/0x2a0 [kvm]
[  323.865502]  try_async_pf+0x53/0x1f0 [kvm]
[  323.866039]  tdp_page_fault+0x112/0x280 [kvm]
[  323.866609]  kvm_mmu_page_fault+0x53/0x130 [kvm]
[  323.867201]  vmx_handle_exit+0x9b/0x1510 [kvm_intel]
[  323.867823]  ? atomic_switch_perf_msrs+0x5f/0x80 [kvm_intel]
[  323.868504]  ? vmx_vcpu_run+0x30a/0x4b0 [kvm_intel]
[  323.869101]  kvm_arch_vcpu_ioctl_run+0xa79/0x1570 [kvm]
[  323.869748]  ? kvm_vcpu_ioctl+0x2eb/0x570 [kvm]
[  323.870332]  kvm_vcpu_ioctl+0x2eb/0x570 [kvm]
[  323.870897]  ? kvm_vm_ioctl+0x142/0x7e0 [kvm]
[  323.871457]  do_vfs_ioctl+0x8f/0x5b0
[  323.871955]  ? native_write_msr+0x6/0x20
[  323.872476]  ? security_file_ioctl+0x3e/0x60
[  323.873024]  SyS_ioctl+0x74/0x80
[  323.873468]  entry_SYSCALL_64_fastpath+0x1a/0x7d
[  323.874043] RIP: 0033:0x7f4a3c897f47
[  323.874506] RSP: 002b:00007f4a3a526a78 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  323.875439] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f4a3c897f47
[  323.876234] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
000000000000000f
[  323.877093] RBP: 0000555b8c5ef450 R08: 0000555b89bc1a70 R09:
00000000ffffffff
[  323.877931] R10: 00000000fee00000 R11: 0000000000000246 R12:
0000000000000000
[  323.878760] R13: 00007f4a3e2db000 R14: 0000000000000006 R15:
0000555b8c5ef450
[  323.879555] Code: 00 00 d3 e2 85 c2 75 ae 4c 85 c7 0f 85 d0 00 00 00 f7
c7 00 02 00 00 75 9d 48 89 f8 66 66 66 90 4c 21 d0 48 c1 e8 06 4a 8d 14 08
<48> 8b 42 20 4c 8d 58 ff a8 01 4c 0f 44
da 41 8b 43 1c 85 c0 0f
[  323.881713] RIP: gup_pgd_range+0x2f5/0x860 RSP: ffffc90004fdbae0
[  323.882509] CR2: ffffea0003faf460
[  323.883069] ---[ end trace 2427ffda7b3b2a32 ]---
