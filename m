Received: from eggs.gnu.org ([2001:4830:134:3::10]:42769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBRI-00057Q-1P
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBRG-0002nY-L6
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:16:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Jun 2018 22:14:32 -0300
Message-Id: <20180611011501.10235-12-f4bug@amsat.org>
In-Reply-To: <20180611011501.10235-1-f4bug@amsat.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 11/40] hw/xen: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>

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
index 9fbc0cdb87..5e7f17ffa4 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <sys/ioctl.h>
 #include <sys/uio.h>
 
@@ -812,9 +813,9 @@ static int blk_connect(struct XenDevice *xendev)
     }
 
     xen_pv_printf(xendev, 1, "type \"%s\", fileproto \"%s\", filename \"%s\","
-                  " size %" PRId64 " (%" PRId64 " MB)\n",
+                  " size %" PRId64 " (%llu MB)\n",
                   blkdev->type, blkdev->fileproto, blkdev->filename,
-                  blkdev->file_size, blkdev->file_size >> 20);
+                  blkdev->file_size, blkdev->file_size / MiB);
 
     /* Fill in number of sector size and number of sectors */
     xenstore_write_be_int(xendev, "sector-size", blkdev->file_blk);
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 628b813a11..4e4f069a24 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 
 #include <sys/resource.h>
@@ -46,7 +47,7 @@
  * From empirical tests I observed that qemu use 75MB more than the
  * max_mcache_size.
  */
-#define NON_MCACHE_MEMORY_SIZE (80 * 1024 * 1024)
+#define NON_MCACHE_MEMORY_SIZE (80 * MiB)
 
 typedef struct MapCacheEntry {
     hwaddr paddr_index;
diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
index 027f76fad1..188acaca16 100644
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
+    xenstore_write_int(dom, "memory/target", ram_size / KiB);
+    xenstore_write_int(vm, "memory",         ram_size / MiB);
+    xenstore_write_int(vm, "maxmem",         ram_size / MiB);
 
     /* cpus */
     for (i = 0; i < smp_cpus; i++) {
@@ -113,7 +114,7 @@ int xenstore_domain_init2(int xenstore_port, int xenstore_mfn,
 
     /* console */
     xenstore_write_str(dom, "console/type",     "ioemu");
-    xenstore_write_int(dom, "console/limit",    128 * 1024);
+    xenstore_write_int(dom, "console/limit",    128 * KiB);
     xenstore_write_int(dom, "console/ring-ref", console_mfn);
     xenstore_write_int(dom, "console/port",     console_port);
     xen_config_dev_console(0);
@@ -260,7 +261,7 @@ int xen_domain_build_pv(const char *kernel, const char *ramdisk,
     }
 #endif
 
-    rc = xc_domain_setmaxmem(xen_xc, xen_domid, ram_size >> 10);
+    rc = xc_domain_setmaxmem(xen_xc, xen_domid, ram_size / KiB);
     if (rc < 0) {
         fprintf(stderr, "xen: xc_domain_setmaxmem() failed\n");
         goto err;
@@ -269,7 +270,7 @@ int xen_domain_build_pv(const char *kernel, const char *ramdisk,
     xenstore_port = xc_evtchn_alloc_unbound(xen_xc, xen_domid, 0);
     console_port = xc_evtchn_alloc_unbound(xen_xc, xen_domid, 0);
 
-    rc = xc_linux_build(xen_xc, xen_domid, ram_size >> 20,
+    rc = xc_linux_build(xen_xc, xen_domid, ram_size / MiB,
                         kernel, ramdisk, cmdline,
                         0, flags,
                         xenstore_port, &xenstore_mfn,
-- 
2.17.1
