Received: from eggs.gnu.org ([2001:4830:134:3::10]:35141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZNH-00017U-NN
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZNE-0003qr-Hu
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:11 -0500
Received: from mail-sn1nam01on0065.outbound.protection.outlook.com
	([104.47.32.65]:58550
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZNE-0003qZ-94
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:08 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:58:53 -0800
Message-ID: <06b7c057b537c1de173ad4ecc9221dcd4fa1c1da.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 41/45] hw/xen*: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

xen_pt_log() was left with an fprintf(stderr,

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
V3:
 - Don't change xen_pt_log()
V2:
 - Split hw patch into individual directories

 hw/xen/xen-common.c        | 11 ++++++-----
 hw/xenpv/xen_domainbuild.c | 24 ++++++++++++------------
 hw/xenpv/xen_machine_pv.c  |  9 +++++----
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 632a938dcc..42ada2ac05 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/xen/xen_backend.h"
 #include "qmp-commands.h"
 #include "chardev/char.h"
@@ -47,19 +48,19 @@ static int store_dev_info(int domid, Chardev *cs, const char *string)
     /* We now have everything we need to set the xenstore entry. */
     xs = xs_open(0);
     if (xs == NULL) {
-        fprintf(stderr, "Could not contact XenStore\n");
+        error_report("Could not contact XenStore");
         goto out;
     }
 
     path = xs_get_domain_path(xs, domid);
     if (path == NULL) {
-        fprintf(stderr, "xs_get_domain_path() error\n");
+        error_report("xs_get_domain_path() error");
         goto out;
     }
     newpath = realloc(path, (strlen(path) + strlen(string) +
                 strlen("/tty") + 1));
     if (newpath == NULL) {
-        fprintf(stderr, "realloc error\n");
+        error_report("realloc error");
         goto out;
     }
     path = newpath;
@@ -96,13 +97,13 @@ static void xenstore_record_dm_state(struct xs_handle *xs, const char *state)
     char path[50];
 
     if (xs == NULL) {
-        fprintf(stderr, "xenstore connection not initialized\n");
+        error_report("xenstore connection not initialized");
         exit(1);
     }
 
     snprintf(path, sizeof (path), "device-model/%u/state", xen_domid);
     if (!xs_write(xs, XBT_NULL, path, state, strlen(state))) {
-        fprintf(stderr, "error recording dm state\n");
+        error_report("error recording dm state");
         exit(1);
     }
 }
diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
index 027f76fad1..f5514ffec2 100644
--- a/hw/xenpv/xen_domainbuild.c
+++ b/hw/xenpv/xen_domainbuild.c
@@ -25,22 +25,22 @@ static int xenstore_domain_mkdir(char *path)
     int i;
 
     if (!xs_mkdir(xenstore, 0, path)) {
-        fprintf(stderr, "%s: xs_mkdir %s: failed\n", __func__, path);
-	return -1;
+        error_report("%s: xs_mkdir %s: failed", __func__, path);
+        return -1;
     }
     if (!xs_set_permissions(xenstore, 0, path, perms_ro, 2)) {
-        fprintf(stderr, "%s: xs_set_permissions failed\n", __func__);
-	return -1;
+        error_report("%s: xs_set_permissions failed", __func__);
+        return -1;
     }
 
     for (i = 0; writable[i]; i++) {
         snprintf(subpath, sizeof(subpath), "%s/%s", path, writable[i]);
         if (!xs_mkdir(xenstore, 0, subpath)) {
-            fprintf(stderr, "%s: xs_mkdir %s: failed\n", __func__, subpath);
+            error_report("%s: xs_mkdir %s: failed", __func__, subpath);
             return -1;
         }
         if (!xs_set_permissions(xenstore, 0, subpath, perms_rw, 2)) {
-            fprintf(stderr, "%s: xs_set_permissions failed\n", __func__);
+            error_report("%s: xs_set_permissions failed", __func__);
             return -1;
         }
     }
@@ -235,7 +235,7 @@ int xen_domain_build_pv(const char *kernel, const char *ramdisk,
     memcpy(uuid, &qemu_uuid, sizeof(uuid));
     rc = xen_domain_create(xen_xc, ssidref, uuid, flags, &xen_domid);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_create() failed\n");
+        error_report("xen: xc_domain_create() failed");
         goto err;
     }
     qemu_log("xen: created domain %d\n", xen_domid);
@@ -248,21 +248,21 @@ int xen_domain_build_pv(const char *kernel, const char *ramdisk,
 
     rc = xc_domain_max_vcpus(xen_xc, xen_domid, smp_cpus);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_max_vcpus() failed\n");
+        error_report("xen: xc_domain_max_vcpus() failed");
         goto err;
     }
 
 #if 0
     rc = xc_domain_setcpuweight(xen_xc, xen_domid, 256);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_setcpuweight() failed\n");
+        error_report("xen: xc_domain_setcpuweight() failed");
         goto err;
     }
 #endif
 
     rc = xc_domain_setmaxmem(xen_xc, xen_domid, ram_size >> 10);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_setmaxmem() failed\n");
+        error_report("xen: xc_domain_setmaxmem() failed");
         goto err;
     }
 
@@ -275,7 +275,7 @@ int xen_domain_build_pv(const char *kernel, const char *ramdisk,
                         xenstore_port, &xenstore_mfn,
                         console_port, &console_mfn);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_linux_build() failed\n");
+        error_report("xen: xc_linux_build() failed");
         goto err;
     }
 
@@ -285,7 +285,7 @@ int xen_domain_build_pv(const char *kernel, const char *ramdisk,
     qemu_log("xen: unpausing domain %d\n", xen_domid);
     rc = xc_domain_unpause(xen_xc, xen_domid);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_unpause() failed\n");
+        error_report("xen: xc_domain_unpause() failed");
         goto err;
     }
 
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 69a52a9f93..44d67b87c4 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/xen/xen_backend.h"
@@ -36,7 +37,7 @@ static void xen_init_pv(MachineState *machine)
 
     /* Initialize backend core & drivers */
     if (xen_be_init() != 0) {
-        fprintf(stderr, "%s: xen backend core setup failed\n", __func__);
+        error_report("%s: xen backend core setup failed", __func__);
         exit(1);
     }
 
@@ -51,18 +52,18 @@ static void xen_init_pv(MachineState *machine)
         const char *initrd_filename = machine->initrd_filename;
         if (xen_domain_build_pv(kernel_filename, initrd_filename,
                                 kernel_cmdline) < 0) {
-            fprintf(stderr, "xen pv domain creation failed\n");
+            error_report("xen pv domain creation failed");
             exit(1);
         }
         break;
     }
 #endif
     case XEN_EMULATE:
-        fprintf(stderr, "xen emulation not implemented (yet)\n");
+        error_report("xen emulation not implemented (yet)");
         exit(1);
         break;
     default:
-        fprintf(stderr, "unhandled xen_mode %d\n", xen_mode);
+        error_report("unhandled xen_mode %d", xen_mode);
         exit(1);
         break;
     }
-- 
2.14.1
