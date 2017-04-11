Received: from eggs.gnu.org ([2001:4830:134:3::10]:44380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cxppK-0001XS-AS
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cxppG-0003Fl-Bx
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:02:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cxppG-0003Em-4d
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:02:54 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 11 Apr 2017 09:02:43 +0200
Message-Id: <20170411070243.635-3-kraxel@redhat.com>
In-Reply-To: <20170411070243.635-1-kraxel@redhat.com>
References: <20170411070243.635-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] qxl: add migration blocker to avoid
 pre-save assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 1635339@bugs.launchpad.net

Cc: 1635339@bugs.launchpad.net
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20170410113131.2585-1-kraxel@redhat.com
---
 hw/display/qxl.h |  1 +
 hw/display/qxl.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index d2d49dd..77e5a36 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -40,6 +40,7 @@ typedef struct PCIQXLDevice {
     uint32_t           cmdlog;
=20
     uint32_t           guest_bug;
+    Error              *migration_blocker;
=20
     enum qxl_mode      mode;
     uint32_t           cmdflags;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index c31b293..9feae78 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -26,6 +26,7 @@
 #include "qemu/queue.h"
 #include "qemu/atomic.h"
 #include "sysemu/sysemu.h"
+#include "migration/migration.h"
 #include "trace.h"
=20
 #include "qxl.h"
@@ -639,6 +640,30 @@ static int interface_get_command(QXLInstance *sin, s=
truct QXLCommandExt *ext)
         qxl->guest_primary.commands++;
         qxl_track_command(qxl, ext);
         qxl_log_command(qxl, "cmd", ext);
+        {
+            /*
+             * Windows 8 drivers place qxl commands in the vram
+             * (instead of the ram) bar.  We can't live migrate such a
+             * guest, so add a migration blocker in case we detect
+             * this, to avoid triggering the assert in pre_save().
+             *
+             * https://cgit.freedesktop.org/spice/win32/qxl-wddm-dod/com=
mit/?id=3Df6e099db39e7d0787f294d5fd0dce328b5210faa
+             */
+            void *msg =3D qxl_phys2virt(qxl, ext->cmd.data, ext->group_i=
d);
+            if (msg !=3D NULL && (
+                    msg < (void *)qxl->vga.vram_ptr ||
+                    msg > ((void *)qxl->vga.vram_ptr + qxl->vga.vram_siz=
e))) {
+                if (!qxl->migration_blocker) {
+                    Error *local_err =3D NULL;
+                    error_setg(&qxl->migration_blocker,
+                               "qxl: guest bug: command not in ram bar")=
;
+                    migrate_add_blocker(qxl->migration_blocker, &local_e=
rr);
+                    if (local_err) {
+                        error_report_err(local_err);
+                    }
+                }
+            }
+        }
         trace_qxl_ring_command_get(qxl->id, qxl_mode_to_string(qxl->mode=
));
         return true;
     default:
@@ -1236,6 +1261,12 @@ static void qxl_hard_reset(PCIQXLDevice *d, int lo=
advm)
     qemu_spice_create_host_memslot(&d->ssd);
     qxl_soft_reset(d);
=20
+    if (d->migration_blocker) {
+        migrate_del_blocker(d->migration_blocker);
+        error_free(d->migration_blocker);
+        d->migration_blocker =3D NULL;
+    }
+
     if (startstop) {
         qemu_spice_display_start();
     }
--=20
2.9.3
