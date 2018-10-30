Received: from eggs.gnu.org ([208.118.235.92]:57346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHMQi-0005lz-UV
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHMQi-0005V8-3q
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:19:04 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Oct 2018 22:18:38 -0700
Message-Id: <1540876720-9574-3-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 2/4] nvme: ensure the num_queues is not zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

When it is zero, it causes segv. Backtrack:
Thread 5 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffc6c17700 (LWP 51808)]
0x0000555555acbd90 in nvme_start_ctrl (n=0x6240000c8100) at hw/block/nvme.c:820
warning: Source file is more recent than executable.
820	    if (unlikely(n->cq[0])) {
(gdb) bt
0  0x0000555555acbd90 in nvme_start_ctrl (n=0x6240000c8100) at hw/block/nvme.c:820
1  0x0000555555accdbc in nvme_write_bar (n=0x6240000c8100, offset=20, data=4587521, size=4) at hw/block/nvme.c:964
2  0x0000555555acdd2b in nvme_mmio_write (opaque=0x6240000c8100, addr=20, data=4587521, size=4) at hw/block/nvme.c:1158
3  0x00005555558973ed in memory_region_write_accessor (mr=0x6240000c89e0, addr=20, value=0x7fffc6c14428, size=4, shift=0, mask=4294967295, attrs=...) at /home/liqiang02/qemu-upstream/qemu/memory.c:500
4  0x0000555555897600 in access_with_adjusted_size (addr=20, value=0x7fffc6c14428, size=4, access_size_min=2, access_size_max=8, access_fn=0x555555897304 <memory_region_write_accessor>, mr=0x6240000c89e0, attrs=...) at /home/liqiang02/qemu-upstream/qemu/memory.c:566
5  0x000055555589a200 in memory_region_dispatch_write (mr=0x6240000c89e0, addr=20, data=4587521, size=4, attrs=...) at /home/liqiang02/qemu-upstream/qemu/memory.c:1442
6  0x0000555555835151 in flatview_write_continue (fv=0x6060000e6fc0, addr=4273930260, attrs=..., buf=0x7fffc8a18028 "\001", len=4, addr1=20, l=4, mr=0x6240000c89e0) at /home/liqiang02/qemu-upstream/qemu/exec.c:3233
7  0x000055555583529b in flatview_write (fv=0x6060000e6fc0, addr=4273930260, attrs=..., buf=0x7fffc8a18028 "\001", len=4) at /home/liqiang02/qemu-upstream/qemu/exec.c:3272
8  0x00005555558355a1 in address_space_write (as=0x55555683ade0 <address_space_memory>, addr=4273930260, attrs=..., buf=0x7fffc8a18028 "\001", len=4) at /home/liqiang02/qemu-upstream/qemu/exec.c:3362
9  0x00005555558355f2 in address_space_rw (as=0x55555683ade0 <address_space_memory>, addr=4273930260, attrs=..., buf=0x7fffc8a18028 "\001", len=4, is_write=true) at /home/liqiang02/qemu-upstream/qemu/exec.c:3373
10 0x00005555558b66ac in kvm_cpu_exec (cpu=0x631000014800) at /home/liqiang02/qemu-upstream/qemu/accel/kvm/kvm-all.c:2031
11 0x000055555587c3ac in qemu_kvm_cpu_thread_fn (arg=0x631000014800) at /home/liqiang02/qemu-upstream/qemu/cpus.c:1277
12 0x0000555555e54ae6 in qemu_thread_start (args=0x60300002c170) at util/qemu-thread-posix.c:504
13 0x00007fffdadbd494 in start_thread () from /lib/x86_64-linux-gnu/libpthread.so.0
14 0x00007fffdaaffacf in clone () from /lib/x86_64-linux-gnu/libc.so.6
(gdb) q

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/block/nvme.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 676cc48..72c9644 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1221,6 +1221,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         error_setg(errp, "serial property not set");
         return;
     }
+
+    if (!n->num_queues) {
+        error_setg(errp, "num_queues can't be zero");
+    }
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
                                        false, errp)) {
-- 
1.8.3.1
