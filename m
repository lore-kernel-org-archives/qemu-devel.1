Received: from eggs.gnu.org ([2001:4830:134:3::10]:46147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=245da84ed=Paul.Durrant@citrix.com>)
	id 1cq1Dk-0001xv-2B
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=245da84ed=Paul.Durrant@citrix.com>)
	id 1cq1Dg-0000KM-Tx
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:35:52 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:61106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=245da84ed=Paul.Durrant@citrix.com>)
	id 1cq1Dg-0000Jd-MX
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:35:48 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 20 Mar 2017 16:53:33 +0000
Message-ID: <1490028813-3911-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] xen: use libxendevice model to restrict
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>

This patch adds a command-line option (-xen-domid-restrict) which will
use the new libxendevicemodel API to restrict devicemodel operations to
the specified domid.

This patch also adds a tracepoint to allow successful enabling of the
restriction to be monitored.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

NOTE: This is already re-based on Juergen Gross's patch "xen: use 5 digit
      xen versions" and so should not be applied until after that patch
      has been applied.

v2:
 - Log errno in tracepoint
---
 hw/xen/trace-events         |  1 +
 include/hw/xen/xen.h        |  1 +
 include/hw/xen/xen_common.h | 20 ++++++++++++++++++++
 qemu-options.hx             |  6 ++++++
 vl.c                        |  8 ++++++++
 xen-hvm.c                   |  8 ++++++++
 6 files changed, 44 insertions(+)

diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index c4fb6f1..5615dce 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -11,3 +11,4 @@ xen_map_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %
 xen_unmap_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
 xen_map_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
 xen_unmap_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
+xen_domid_restrict(int err) "err: %u"
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 2b1733b..7efcdaa 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -21,6 +21,7 @@ enum xen_mode {
 
 extern uint32_t xen_domid;
 extern enum xen_mode xen_mode;
+extern bool xen_domid_restrict;
 
 extern bool xen_allowed;
 
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index df098c7..4f3bd35 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -152,6 +152,13 @@ static inline int xendevicemodel_set_mem_type(
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
 }
 
+static inline int xendevicemodel_restrict(
+    xendevicemodel_handle *dmod, domid_t domid)
+{
+    errno = ENOTTY;
+    return -1;
+}
+
 #else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
 
 #include <xendevicemodel.h>
@@ -206,6 +213,19 @@ static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
     return xendevicemodel_modified_memory(xen_dmod, domid, first_pfn, nr);
 }
 
+static inline int xen_restrict(domid_t domid)
+{
+    int rc = xendevicemodel_restrict(xen_dmod, domid);
+
+    trace_xen_domid_restrict(errno);
+
+    if (errno == ENOTTY) {
+        return 0;
+    }
+
+    return rc;
+}
+
 /* Xen 4.2 through 4.6 */
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40701
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 99af8ed..4aab077 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3354,6 +3354,10 @@ DEF("xen-attach", 0, QEMU_OPTION_xen_attach,
     "-xen-attach     attach to existing xen domain\n"
     "                xend will use this when starting QEMU\n",
     QEMU_ARCH_ALL)
+DEF("xen-domid-restrict", 0, QEMU_OPTION_xen_domid_restrict,
+    "-xen-domid-restrict     restrict set of available xen operations\n"
+    "                        to specified domain id\n",
+    QEMU_ARCH_ALL)
 STEXI
 @item -xen-domid @var{id}
 @findex -xen-domid
@@ -3366,6 +3370,8 @@ Warning: should not be used when xend is in use (XEN only).
 @findex -xen-attach
 Attach to existing xen domain.
 xend will use this when starting QEMU (XEN only).
+@findex -xen-domid-restrict
+Restrict set of available xen operations to specified domain id (XEN only).
 ETEXI
 
 DEF("no-reboot", 0, QEMU_OPTION_no_reboot, \
diff --git a/vl.c b/vl.c
index 0b4ed52..f46e070 100644
--- a/vl.c
+++ b/vl.c
@@ -205,6 +205,7 @@ static NotifierList machine_init_done_notifiers =
 bool xen_allowed;
 uint32_t xen_domid;
 enum xen_mode xen_mode = XEN_EMULATE;
+bool xen_domid_restrict;
 
 static int has_defaults = 1;
 static int default_serial = 1;
@@ -3933,6 +3934,13 @@ int main(int argc, char **argv, char **envp)
                 }
                 xen_mode = XEN_ATTACH;
                 break;
+            case QEMU_OPTION_xen_domid_restrict:
+                if (!(xen_available())) {
+                    error_report("Option not supported for this target");
+                    exit(1);
+                }
+                xen_domid_restrict = true;
+                break;
             case QEMU_OPTION_trace:
                 g_free(trace_file);
                 trace_file = trace_opt_parse(optarg);
diff --git a/xen-hvm.c b/xen-hvm.c
index 4b928cf..335e263 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -1226,6 +1226,14 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
         goto err;
     }
 
+    if (xen_domid_restrict) {
+        rc = xen_restrict(xen_domid);
+        if (rc < 0) {
+            error_report("failed to restrict: error %d", errno);
+            goto err;
+        }
+    }
+
     xen_create_ioreq_server(xen_domid, &state->ioservid);
 
     state->exit.notify = xen_exit_notifier;
-- 
2.1.4
