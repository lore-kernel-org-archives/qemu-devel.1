Received: from eggs.gnu.org ([2001:4830:134:3::10]:50998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mO-0006kV-PQ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mN-0008Eq-M6
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mN-0008Ed-Ew
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:39 -0400
Date: Tue, 20 Mar 2018 05:17:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-26-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 25/50] postcopy: Add notifier chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a notifier chain for postcopy with a 'reason' flag
and an opportunity for a notifier member to return an error.

Call it when enabling postcopy.

This will initially used to enable devices to declare they're unable
to postcopy and later to notify of devices of stages within postcopy.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 migration/postcopy-ram.h | 26 ++++++++++++++++++++++++++
 migration/postcopy-ram.c | 36 ++++++++++++++++++++++++++++++++++++
 vl.c                     |  2 ++
 3 files changed, 64 insertions(+)

diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 14f6cad..2e879bb 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -116,4 +116,30 @@ PostcopyState postcopy_state_set(PostcopyState new_state);
 
 void postcopy_fault_thread_notify(MigrationIncomingState *mis);
 
+/*
+ * To be called once at the start before any device initialisation
+ */
+void postcopy_infrastructure_init(void);
+
+/* Add a notifier to a list to be called when checking whether the devices
+ * can support postcopy.
+ * It's data is a *PostcopyNotifyData
+ * It should return 0 if OK, or a negative value on failure.
+ * On failure it must set the data->errp to an error.
+ *
+ */
+enum PostcopyNotifyReason {
+    POSTCOPY_NOTIFY_PROBE = 0,
+};
+
+struct PostcopyNotifyData {
+    enum PostcopyNotifyReason reason;
+    Error **errp;
+};
+
+void postcopy_add_notifier(NotifierWithReturn *nn);
+void postcopy_remove_notifier(NotifierWithReturn *n);
+/* Call the notifier list set by postcopy_add_start_notifier */
+int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp);
+
 #endif
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a75b5d3..1089814 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -23,6 +23,8 @@
 #include "savevm.h"
 #include "postcopy-ram.h"
 #include "ram.h"
+#include "qapi/error.h"
+#include "qemu/notify.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
 #include "qemu/error-report.h"
@@ -45,6 +47,33 @@ struct PostcopyDiscardState {
     unsigned int nsentcmds;
 };
 
+static NotifierWithReturnList postcopy_notifier_list;
+
+void postcopy_infrastructure_init(void)
+{
+    notifier_with_return_list_init(&postcopy_notifier_list);
+}
+
+void postcopy_add_notifier(NotifierWithReturn *nn)
+{
+    notifier_with_return_list_add(&postcopy_notifier_list, nn);
+}
+
+void postcopy_remove_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_remove(n);
+}
+
+int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
+{
+    struct PostcopyNotifyData pnd;
+    pnd.reason = reason;
+    pnd.errp = errp;
+
+    return notifier_with_return_list_notify(&postcopy_notifier_list,
+                                            &pnd);
+}
+
 /* Postcopy needs to detect accesses to pages that haven't yet been copied
  * across, and efficiently map new pages in, the techniques for doing this
  * are target OS specific.
@@ -215,6 +244,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
     struct uffdio_register reg_struct;
     struct uffdio_range range_struct;
     uint64_t feature_mask;
+    Error *local_err = NULL;
 
     if (qemu_target_page_size() > pagesize) {
         error_report("Target page size bigger than host page size");
@@ -228,6 +258,12 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
         goto out;
     }
 
+    /* Give devices a chance to object */
+    if (postcopy_notify(POSTCOPY_NOTIFY_PROBE, &local_err)) {
+        error_report_err(local_err);
+        goto out;
+    }
+
     /* Version and features check */
     if (!ufd_check_and_apply(ufd, mis)) {
         goto out;
diff --git a/vl.c b/vl.c
index 3ef04ce..0b15811 100644
--- a/vl.c
+++ b/vl.c
@@ -94,6 +94,7 @@ int main(int argc, char **argv)
 #include "audio/audio.h"
 #include "sysemu/cpus.h"
 #include "migration/colo.h"
+#include "migration/postcopy-ram.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
 #include "qapi/qobject-input-visitor.h"
@@ -3101,6 +3102,7 @@ int main(int argc, char **argv, char **envp)
     module_call_init(MODULE_INIT_OPTS);
 
     runstate_init();
+    postcopy_infrastructure_init();
 
     if (qcrypto_init(&err) < 0) {
         error_reportf_err(err, "cannot initialize crypto: ");
-- 
MST
