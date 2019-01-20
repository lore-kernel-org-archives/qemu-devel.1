Received: from eggs.gnu.org ([209.51.188.92]:56666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl676-000638-DI
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 00:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl675-0004TA-Fo
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 00:57:44 -0500
From: Li Qiang <liq3ea@163.com>
Date: Sat, 19 Jan 2019 21:55:57 -0800
Message-Id: <20190120055558.32984-3-liq3ea@163.com>
In-Reply-To: <20190120055558.32984-1-liq3ea@163.com>
References: <20190120055558.32984-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/3] nvme: ensure the num_queues is not zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com, philmd@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

When it is zero, it causes segv.
Using following command:

"-drive file=//home/test/test1.img,if=none,id=id0
-device nvme,drive=id0,serial=test,num_queues=0"
causes following Backtrack:

Thread 4 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffe9735700 (LWP 30952)]
0x0000555555a7a77c in nvme_start_ctrl (n=0x5555577473f0) at hw/block/nvme.c:825
825	    if (unlikely(n->cq[0])) {
(gdb) bt
0  0x0000555555a7a77c in nvme_start_ctrl (n=0x5555577473f0)
    at hw/block/nvme.c:825
1  0x0000555555a7af7f in nvme_write_bar (n=0x5555577473f0, offset=20,
    data=4587521, size=4) at hw/block/nvme.c:969
2  0x0000555555a7b81a in nvme_mmio_write (opaque=0x5555577473f0, addr=20,
    data=4587521, size=4) at hw/block/nvme.c:1163
3  0x0000555555869236 in memory_region_write_accessor (mr=0x555557747cd0,
    addr=20, value=0x7fffe97320f8, size=4, shift=0, mask=4294967295, attrs=...)
    at /home/test/qemu1/qemu/memory.c:502
4  0x0000555555869446 in access_with_adjusted_size (addr=20,
    value=0x7fffe97320f8, size=4, access_size_min=2, access_size_max=8,
    access_fn=0x55555586914d <memory_region_write_accessor>,
    mr=0x555557747cd0, attrs=...) at /home/test/qemu1/qemu/memory.c:568
5  0x000055555586c479 in memory_region_dispatch_write (mr=0x555557747cd0,
    addr=20, data=4587521, size=4, attrs=...)
    at /home/test/qemu1/qemu/memory.c:1499
6  0x00005555558030af in flatview_write_continue (fv=0x7fffe0061130,
    addr=4273930260, attrs=..., buf=0x7ffff7ff0028 "\001", len=4, addr1=20,
    l=4, mr=0x555557747cd0) at /home/test/qemu1/qemu/exec.c:3234
7  0x00005555558031f9 in flatview_write (fv=0x7fffe0061130, addr=4273930260,
    attrs=..., buf=0x7ffff7ff0028 "\001", len=4)
    at /home/test/qemu1/qemu/exec.c:3273
8  0x00005555558034ff in address_space_write (
---Type <return> to continue, or q <return> to quit---
    as=0x555556758480 <address_space_memory>, addr=4273930260, attrs=...,
    buf=0x7ffff7ff0028 "\001", len=4) at /home/test/qemu1/qemu/exec.c:3363
9  0x0000555555803550 in address_space_rw (
    as=0x555556758480 <address_space_memory>, addr=4273930260, attrs=...,
    buf=0x7ffff7ff0028 "\001", len=4, is_write=true)
    at /home/test/qemu1/qemu/exec.c:3374
10 0x00005555558884a1 in kvm_cpu_exec (cpu=0x555556920e40)
    at /home/test/qemu1/qemu/accel/kvm/kvm-all.c:2031
11 0x000055555584cd9d in qemu_kvm_cpu_thread_fn (arg=0x555556920e40)
    at /home/test/qemu1/qemu/cpus.c:1281
12 0x0000555555dbaf6d in qemu_thread_start (args=0x5555569438a0)
    at util/qemu-thread-posix.c:502
13 0x00007ffff5dc86db in start_thread (arg=0x7fffe9735700)
    at pthread_create.c:463
14 0x00007ffff5af188f in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/nvme.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f206391e8e..0b77b49b36 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1208,6 +1208,11 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     int64_t bs_size;
     uint8_t *pci_conf;
 
+    if (!n->num_queues) {
+        error_setg(errp, "num_queues can't be zero");
+        return;
+    }
+
     if (!n->conf.blk) {
         error_setg(errp, "drive property not set");
         return;
-- 
2.17.1
