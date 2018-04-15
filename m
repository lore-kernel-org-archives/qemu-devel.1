Received: from eggs.gnu.org ([2001:4830:134:3::10]:50825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rJL-0004j4-O6
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rJK-0000VF-LU
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:42:37 -0300
Message-Id: <20180415234307.28132-12-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/41] hw/xen: Use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alan Robinson <Alan.Robinson@ts.fujitsu.com>
---
 hw/block/xen_disk.c        |  5 +++--
 hw/i386/xen/xen-mapcache.c |  3 ++-
 hw/xenpv/xen_domainbuild.c | 13 +++++++------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index f74fcd42d1..c342106fd5 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <sys/ioctl.h>
 #include <sys/uio.h>
 
@@ -1153,9 +1154,9 @@ static int blk_connect(struct XenDevice *xendev)
     }
 
     xen_pv_printf(xendev, 1, "type \"%s\", fileproto \"%s\", filename \"%s\","
-                  " size %" PRId64 " (%" PRId64 " MB)\n",
+                  " size %" PRId64 " (%llu MB)\n",
                   blkdev->type, blkdev->fileproto, blkdev->filename,
-                  blkdev->file_size, blkdev->file_size >> 20);
+                  blkdev->file_size, blkdev->file_size / M_BYTE);
 
     /* Fill in number of sector size and number of sectors */
     xenstore_write_be_int(&blkdev->xendev, "sector-size", blkdev->file_blk);
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index efa35dc6e0..068347495c 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 
 #include <sys/resource.h>
@@ -47,7 +48,7 @@
  * From empirical tests I observed that qemu use 75MB more than the
  * max_mcache_size.
  */
-#define NON_MCACHE_MEMORY_SIZE (80 * 1024 * 1024)
+#define NON_MCACHE_MEMORY_SIZE (80 * M_BYTE)
 
 typedef struct MapCacheEntry {
     hwaddr paddr_index;
diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
index 027f76fad1..4c77bb70a7 100644
--- a/hw/xenpv/xen_domainbuild.c
+++ b/hw/xenpv/xen_domainbuild.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/xen/xen_backend.h"
 #include "xen_domainbuild.h"
 #include "qemu/timer.h"
@@ -75,9 +76,9 @@ int xenstore_domain_init1(const char *kernel, const char *ramdisk,
     xenstore_write_str(dom, "vm",     vm);
 
     /* memory */
-    xenstore_write_int(dom, "memory/target", ram_size >> 10);  // kB
-    xenstore_write_int(vm, "memory",         ram_size >> 20);  // MB
-    xenstore_write_int(vm, "maxmem",         ram_size >> 20);  // MB
+    xenstore_write_int(dom, "memory/target", ram_size / K_BYTE);
+    xenstore_write_int(vm, "memory",         ram_size / M_BYTE);
+    xenstore_write_int(vm, "maxmem",         ram_size / M_BYTE);
 
     /* cpus */
     for (i = 0; i < smp_cpus; i++) {
@@ -113,7 +114,7 @@ int xenstore_domain_init2(int xenstore_port, int xenstore_mfn,
 
     /* console */
     xenstore_write_str(dom, "console/type",     "ioemu");
-    xenstore_write_int(dom, "console/limit",    128 * 1024);
+    xenstore_write_int(dom, "console/limit",    128 * K_BYTE);
     xenstore_write_int(dom, "console/ring-ref", console_mfn);
     xenstore_write_int(dom, "console/port",     console_port);
     xen_config_dev_console(0);
@@ -260,7 +261,7 @@ int xen_domain_build_pv(const char *kernel, const char *ramdisk,
     }
 #endif
 
-    rc = xc_domain_setmaxmem(xen_xc, xen_domid, ram_size >> 10);
+    rc = xc_domain_setmaxmem(xen_xc, xen_domid, ram_size / K_BYTE);
     if (rc < 0) {
         fprintf(stderr, "xen: xc_domain_setmaxmem() failed\n");
         goto err;
@@ -269,7 +270,7 @@ int xen_domain_build_pv(const char *kernel, const char *ramdisk,
     xenstore_port = xc_evtchn_alloc_unbound(xen_xc, xen_domid, 0);
     console_port = xc_evtchn_alloc_unbound(xen_xc, xen_domid, 0);
 
-    rc = xc_linux_build(xen_xc, xen_domid, ram_size >> 20,
+    rc = xc_linux_build(xen_xc, xen_domid, ram_size / M_BYTE,
                         kernel, ramdisk, cmdline,
                         0, flags,
                         xenstore_port, &xenstore_mfn,
-- 
2.17.0
