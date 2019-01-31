Received: from eggs.gnu.org ([209.51.188.92]:37781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0in-0000Cj-I7
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0ik-00009Z-TU
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:00:48 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 31 Jan 2019 01:59:41 +0100
Message-Id: <20190131005945.20149-10-mreitz@redhat.com>
In-Reply-To: <20190131005945.20149-1-mreitz@redhat.com>
References: <20190131005945.20149-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/13] nvme: ensure the num_queues is not zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

From: Li Qiang <liq3ea@163.com>

When it is zero, it causes segv.
Using following command:

"-drive file=3D//home/test/test1.img,if=3Dnone,id=3Did0
-device nvme,drive=3Did0,serial=3Dtest,num_queues=3D0"
causes following Backtrack:

Thread 4 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffe9735700 (LWP 30952)]
0x0000555555a7a77c in nvme_start_ctrl (n=3D0x5555577473f0) at hw/block/nv=
me.c:825
825	    if (unlikely(n->cq[0])) {
(gdb) bt
0  0x0000555555a7a77c in nvme_start_ctrl (n=3D0x5555577473f0)
    at hw/block/nvme.c:825
1  0x0000555555a7af7f in nvme_write_bar (n=3D0x5555577473f0, offset=3D20,
    data=3D4587521, size=3D4) at hw/block/nvme.c:969
2  0x0000555555a7b81a in nvme_mmio_write (opaque=3D0x5555577473f0, addr=3D=
20,
    data=3D4587521, size=3D4) at hw/block/nvme.c:1163
3  0x0000555555869236 in memory_region_write_accessor (mr=3D0x555557747cd=
0,
    addr=3D20, value=3D0x7fffe97320f8, size=3D4, shift=3D0, mask=3D429496=
7295, attrs=3D...)
    at /home/test/qemu1/qemu/memory.c:502
4  0x0000555555869446 in access_with_adjusted_size (addr=3D20,
    value=3D0x7fffe97320f8, size=3D4, access_size_min=3D2, access_size_ma=
x=3D8,
    access_fn=3D0x55555586914d <memory_region_write_accessor>,
    mr=3D0x555557747cd0, attrs=3D...) at /home/test/qemu1/qemu/memory.c:5=
68
5  0x000055555586c479 in memory_region_dispatch_write (mr=3D0x555557747cd=
0,
    addr=3D20, data=3D4587521, size=3D4, attrs=3D...)
    at /home/test/qemu1/qemu/memory.c:1499
6  0x00005555558030af in flatview_write_continue (fv=3D0x7fffe0061130,
    addr=3D4273930260, attrs=3D..., buf=3D0x7ffff7ff0028 "\001", len=3D4,=
 addr1=3D20,
    l=3D4, mr=3D0x555557747cd0) at /home/test/qemu1/qemu/exec.c:3234
7  0x00005555558031f9 in flatview_write (fv=3D0x7fffe0061130, addr=3D4273=
930260,
    attrs=3D..., buf=3D0x7ffff7ff0028 "\001", len=3D4)
    at /home/test/qemu1/qemu/exec.c:3273
8  0x00005555558034ff in address_space_write (
---Type <return> to continue, or q <return> to quit---
    as=3D0x555556758480 <address_space_memory>, addr=3D4273930260, attrs=3D=
...,
    buf=3D0x7ffff7ff0028 "\001", len=3D4) at /home/test/qemu1/qemu/exec.c=
:3363
9  0x0000555555803550 in address_space_rw (
    as=3D0x555556758480 <address_space_memory>, addr=3D4273930260, attrs=3D=
...,
    buf=3D0x7ffff7ff0028 "\001", len=3D4, is_write=3Dtrue)
    at /home/test/qemu1/qemu/exec.c:3374
10 0x00005555558884a1 in kvm_cpu_exec (cpu=3D0x555556920e40)
    at /home/test/qemu1/qemu/accel/kvm/kvm-all.c:2031
11 0x000055555584cd9d in qemu_kvm_cpu_thread_fn (arg=3D0x555556920e40)
    at /home/test/qemu1/qemu/cpus.c:1281
12 0x0000555555dbaf6d in qemu_thread_start (args=3D0x5555569438a0)
    at util/qemu-thread-posix.c:502
13 0x00007ffff5dc86db in start_thread (arg=3D0x7fffe9735700)
    at pthread_create.c:463
14 0x00007ffff5af188f in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190120055558.32984-3-liq3ea@163.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 hw/block/nvme.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f206391e8e..0b77b49b36 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1208,6 +1208,11 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
     int64_t bs_size;
     uint8_t *pci_conf;
=20
+    if (!n->num_queues) {
+        error_setg(errp, "num_queues can't be zero");
+        return;
+    }
+
     if (!n->conf.blk) {
         error_setg(errp, "drive property not set");
         return;
--=20
2.20.1
