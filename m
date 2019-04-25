Received: from eggs.gnu.org ([209.51.188.92]:60918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1hJY6N-0004js-Q2
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 02:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1hJXyy-0004aj-L6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 02:35:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hJXyy-0004YT-Ez
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 02:35:44 -0400
From: P J P <ppandit@redhat.com>
Date: Thu, 25 Apr 2019 12:05:34 +0530
Message-Id: <20190425063534.32747-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qxl: check release info object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Bugs SysSec <bugs-syssec@rub.de>

From: Prasad J Pandit <pjp@fedoraproject.org>

When releasing spice resources in release_resource() routine,
if release info object 'ext.info' is null, it leads to null
pointer dereference. Add check to avoid it.

Reported-by: Bugs SysSec <bugs-syssec@rub.de>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/display/qxl.c | 3 +++
 1 file changed, 3 insertions(+)

=3D=3D=3D
(process:30785): Spice-WARNING **: 11:43:59.284: memslot.c:68:memslot_val=
idate_virt: virtual address out of range
    virt=3D0x555556d247e0+0xbf slot_id=3D0 group_id=3D0
    slot=3D0x0-0x0 delta=3D0x0

Thread 5 "SPICE Worker" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffdb7ff700 (LWP 30792)]
interface_release_resource (sin=3D0x555556d12738, ext=3D...) at hw/displa=
y/qxl.c:785
785	        QXLCommandExt *cmdext =3D (void *)(intptr_t)(ext.info->id);
(gdb) bt
#0  0x0000555555adca68 in interface_release_resource (sin=3D0x555556d1273=
8, ext=3D...) at hw/display/qxl.c:785
#1  0x00007ffff74991d5 in red_drawable_unref (red_drawable=3D0x7fffd402a5=
20) at red-worker.c:100
#2  0x00007ffff749941c in red_drawable_unref (red_drawable=3D<optimized o=
ut>) at red-worker.c:229
#3  0x00007ffff749941c in red_process_display (worker=3Dworker@entry=3D0x=
555556e2f050, ring_is_empty=3Dring_is_empty@entry=3D0x7fffdb7fe854) at re=
d-worker.c:229
#4  0x00007ffff74995f2 in worker_source_dispatch (source=3D<optimized out=
>, callback=3D<optimized out>, user_data=3D<optimized out>) at red-worker=
.c:1265
#5  0x00007ffff7ec906d in g_main_dispatch (context=3D0x555556e38fc0) at g=
main.c:3182
#6  0x00007ffff7ec906d in g_main_context_dispatch (context=3Dcontext@entr=
y=3D0x555556e38fc0) at gmain.c:3847
#7  0x00007ffff7ec9438 in g_main_context_iterate (context=3D0x555556e38fc=
0, block=3Dblock@entry=3D1, dispatch=3Ddispatch@entry=3D1, self=3D<optimi=
zed out>) at gmain.c:3920
#8  0x00007ffff7ec9762 in g_main_loop_run (loop=3D0x7fffd4002100) at gmai=
n.c:4116
#9  0x00007ffff7498dde in red_worker_main (arg=3D0x555556e2f050) at red-w=
orker.c:1369
#10 0x00007ffff70e458e in start_thread () at /lib64/libpthread.so.0
#11 0x00007ffff7013683 in clone () at /lib64/libc.so.6
(gdb)
=3D=3D=3D

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index c8ce5781e0..632923add2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -777,6 +777,9 @@ static void interface_release_resource(QXLInstance *s=
in,
     QXLReleaseRing *ring;
     uint64_t *item, id;
=20
+    if (!ext.info) {
+        return;
+    }
     if (ext.group_id =3D=3D MEMSLOT_GROUP_HOST) {
         /* host group -> vga mode update request */
         QXLCommandExt *cmdext =3D (void *)(intptr_t)(ext.info->id);
--=20
2.20.1
