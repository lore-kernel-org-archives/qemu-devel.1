Received: from eggs.gnu.org ([2001:4830:134:3::10]:58151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwc-00051N-Ae
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwZ-0004ub-QA
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:51743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cpkwZ-0004uJ-Hg
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:03 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 20 Mar 2017 08:12:41 +0800
Message-Id: <20170320001249.25521-3-haozhong.zhang@intel.com>
In-Reply-To: <20170320001249.25521-1-haozhong.zhang@intel.com>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v2 02/10] xen-hvm: initialize DM ACPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Probe the base address and the length of guest ACPI buffer reserved
for copying ACPI from QEMU.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: xen-devel@lists.xenproject.org
---
 xen-hvm.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/xen-hvm.c b/xen-hvm.c
index 5043beb98f..c42c958a0a 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -19,6 +19,7 @@
 #include "qmp-commands.h"
 
 #include "sysemu/char.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/xen-mapcache.h"
@@ -87,6 +88,18 @@ typedef struct XenPhysmap {
     QLIST_ENTRY(XenPhysmap) list;
 } XenPhysmap;
 
+#define HVM_XS_DM_ACPI_ROOT    "/hvmloader/dm-acpi"
+#define HVM_XS_DM_ACPI_ADDRESS HVM_XS_DM_ACPI_ROOT"/address"
+#define HVM_XS_DM_ACPI_LENGTH  HVM_XS_DM_ACPI_ROOT"/length"
+
+typedef struct XenAcpiBuf {
+    ram_addr_t base;
+    ram_addr_t length;
+    ram_addr_t used;
+} XenAcpiBuf;
+
+static XenAcpiBuf *dm_acpi_buf;
+
 typedef struct XenIOState {
     ioservid_t ioservid;
     shared_iopage_t *shared_page;
@@ -111,6 +124,8 @@ typedef struct XenIOState {
     hwaddr free_phys_offset;
     const XenPhysmap *log_for_dirtybit;
 
+    XenAcpiBuf dm_acpi_buf;
+
     Notifier exit;
     Notifier suspend;
     Notifier wakeup;
@@ -1205,6 +1220,52 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
     xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
 }
 
+static int dm_acpi_buf_init(XenIOState *state)
+{
+    char path[80], *value;
+    unsigned int len;
+
+    dm_acpi_buf = &state->dm_acpi_buf;
+
+    snprintf(path, sizeof(path),
+             "/local/domain/%d"HVM_XS_DM_ACPI_ADDRESS, xen_domid);
+    value = xs_read(state->xenstore, 0, path, &len);
+    if (!value) {
+        return -EINVAL;
+    }
+    if (qemu_strtoul(value, NULL, 16, &dm_acpi_buf->base)) {
+        return -EINVAL;
+    }
+
+    snprintf(path, sizeof(path),
+             "/local/domain/%d"HVM_XS_DM_ACPI_LENGTH, xen_domid);
+    value = xs_read(state->xenstore, 0, path, &len);
+    if (!value) {
+        return -EINVAL;
+    }
+    if (qemu_strtoul(value, NULL, 16, &dm_acpi_buf->length)) {
+        return -EINVAL;
+    }
+
+    dm_acpi_buf->used = 0;
+
+    return 0;
+}
+
+static int xen_dm_acpi_required(PCMachineState *pcms)
+{
+    return 0;
+}
+
+static int xen_dm_acpi_init(PCMachineState *pcms, XenIOState *state)
+{
+    if (!xen_dm_acpi_required(pcms)) {
+        return 0;
+    }
+
+    return dm_acpi_buf_init(state);
+}
+
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
     int i, rc;
@@ -1344,6 +1405,11 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     /* Disable ACPI build because Xen handles it */
     pcms->acpi_build_enabled = false;
 
+    if (xen_dm_acpi_init(pcms, state)) {
+        error_report("failed to initialize xen ACPI");
+        goto err;
+    }
+
     return;
 
 err:
-- 
2.12.0
