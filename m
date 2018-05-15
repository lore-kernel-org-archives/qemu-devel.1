Received: from eggs.gnu.org ([2001:4830:134:3::10]:33127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fId0X-0005s8-Mx
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fId0U-0007Qr-9t
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:41:01 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:23739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fId0T-0007Pf-VF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:40:58 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 15 May 2018 17:40:51 +0100
Message-ID: <20180515164053.14604-2-paul.durrant@citrix.com>
In-Reply-To: <20180515164053.14604-1-paul.durrant@citrix.com>
References: <20180515164053.14604-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/3] xen-hvm: create separate function for
 ioreq server initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

The code is sufficiently substantial that it improves code readability
to put it in a new function called by xen_hvm_init() rather than having
it inline.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/i386/xen/xen-hvm.c | 76 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index caa563be3d..6ffa3c22cc 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -95,7 +95,8 @@ typedef struct XenIOState {
     CPUState **cpu_by_vcpu_id;
     /* the evtchn port for polling the notification, */
     evtchn_port_t *ioreq_local_port;
-    /* evtchn local port for buffered io */
+    /* evtchn remote and local ports for buffered io */
+    evtchn_port_t bufioreq_remote_port;
     evtchn_port_t bufioreq_local_port;
     /* the evtchn fd for polling */
     xenevtchn_handle *xce_handle;
@@ -1236,12 +1237,52 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
     xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
 }
 
-void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
+static int xen_map_ioreq_server(XenIOState *state)
 {
-    int i, rc;
     xen_pfn_t ioreq_pfn;
     xen_pfn_t bufioreq_pfn;
     evtchn_port_t bufioreq_evtchn;
+    int rc;
+
+    rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
+                                   &ioreq_pfn, &bufioreq_pfn,
+                                   &bufioreq_evtchn);
+    if (rc < 0) {
+        error_report("failed to get ioreq server info: error %d handle=%p",
+                     errno, xen_xc);
+        return rc;
+    }
+
+    DPRINTF("shared page at pfn %lx\n", ioreq_pfn);
+    DPRINTF("buffered io page at pfn %lx\n", bufioreq_pfn);
+    DPRINTF("buffered io evtchn is %x\n", bufioreq_evtchn);
+
+    state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
+                                              PROT_READ | PROT_WRITE,
+                                              1, &ioreq_pfn, NULL);
+    if (state->shared_page == NULL) {
+        error_report("map shared IO page returned error %d handle=%p",
+                     errno, xen_xc);
+        return -1;
+    }
+
+    state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
+                                                   PROT_READ | PROT_WRITE,
+                                                   1, &bufioreq_pfn, NULL);
+    if (state->buffered_io_page == NULL) {
+        error_report("map buffered IO page returned error %d", errno);
+        return -1;
+    }
+
+    state->bufioreq_remote_port = bufioreq_evtchn;
+
+    return 0;
+}
+
+void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
+{
+    int i, rc;
+    xen_pfn_t ioreq_pfn;
     XenIOState *state;
 
     state = g_malloc0(sizeof (XenIOState));
@@ -1269,25 +1310,8 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     state->wakeup.notify = xen_wakeup_notifier;
     qemu_register_wakeup_notifier(&state->wakeup);
 
-    rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
-                                   &ioreq_pfn, &bufioreq_pfn,
-                                   &bufioreq_evtchn);
+    rc = xen_map_ioreq_server(state);
     if (rc < 0) {
-        error_report("failed to get ioreq server info: error %d handle=%p",
-                     errno, xen_xc);
-        goto err;
-    }
-
-    DPRINTF("shared page at pfn %lx\n", ioreq_pfn);
-    DPRINTF("buffered io page at pfn %lx\n", bufioreq_pfn);
-    DPRINTF("buffered io evtchn is %x\n", bufioreq_evtchn);
-
-    state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
-                                              PROT_READ|PROT_WRITE,
-                                              1, &ioreq_pfn, NULL);
-    if (state->shared_page == NULL) {
-        error_report("map shared IO page returned error %d handle=%p",
-                     errno, xen_xc);
         goto err;
     }
 
@@ -1308,14 +1332,6 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
         goto err;
     }
 
-    state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
-                                                   PROT_READ|PROT_WRITE,
-                                                   1, &bufioreq_pfn, NULL);
-    if (state->buffered_io_page == NULL) {
-        error_report("map buffered IO page returned error %d", errno);
-        goto err;
-    }
-
     /* Note: cpus is empty at this point in init */
     state->cpu_by_vcpu_id = g_malloc0(max_cpus * sizeof(CPUState *));
 
@@ -1340,7 +1356,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     }
 
     rc = xenevtchn_bind_interdomain(state->xce_handle, xen_domid,
-                                    bufioreq_evtchn);
+                                    state->bufioreq_remote_port);
     if (rc == -1) {
         error_report("buffered evtchn bind error %d", errno);
         goto err;
-- 
2.11.0
