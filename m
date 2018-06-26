Received: from eggs.gnu.org ([2001:4830:134:3::10]:34346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXq59-0008PD-1R
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXq57-0005fa-Qg
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:39 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:43517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fXq57-0005el-GE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:37 -0400
Received: by mail-wr0-x232.google.com with SMTP id c5-v6so6578567wrs.10
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:40:37 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 Jun 2018 17:40:27 +0200
Message-Id: <20180626154028.11133-5-pbonzini@redhat.com>
In-Reply-To: <20180626154028.11133-1-pbonzini@redhat.com>
References: <20180626154028.11133-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] pr-manager: add query-pr-managers QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mprivozn@redhat.com

This command lets you query the connection status of each pr-manager-helper
object.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/scsi/pr-manager.h |  2 ++
 qapi/block.json           | 27 +++++++++++++++++++++++
 scsi/pr-manager-helper.c  | 13 +++++++++++
 scsi/pr-manager.c         | 45 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/include/scsi/pr-manager.h b/include/scsi/pr-manager.h
index 5d2f13a5e4..adadca7954 100644
--- a/include/scsi/pr-manager.h
+++ b/include/scsi/pr-manager.h
@@ -33,8 +33,10 @@ typedef struct PRManagerClass {
 
     /* <public> */
     int (*run)(PRManager *pr_mgr, int fd, struct sg_io_hdr *hdr);
+    bool (*is_connected)(PRManager *pr_mgr);
 } PRManagerClass;
 
+bool pr_manager_is_connected(PRManager *pr_mgr);
 BlockAIOCB *pr_manager_execute(PRManager *pr_mgr,
                                AioContext *ctx, int fd,
                                struct sg_io_hdr *hdr,
diff --git a/qapi/block.json b/qapi/block.json
index c694524002..dc3323c954 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -77,6 +77,33 @@
 { 'struct': 'BlockdevSnapshotInternal',
   'data': { 'device': 'str', 'name': 'str' } }
 
+##
+# @PRManagerInfo:
+#
+# Information about a persistent reservation manager
+#
+# @id: the identifier of the persistent reservation manager
+#
+# @is-connected: whether the persistent reservation manager is connected to
+#                the underlying storage or helper
+#
+# Since: 3.0
+##
+{ 'struct': 'PRManagerInfo',
+  'data': {'id': 'str', 'is-connected': 'bool'} }
+
+##
+# @query-pr-managers:
+#
+# Returns a list of information about each persistent reservation manager.
+#
+# Returns: a list of @PRManagerInfo for each persistent reservation manager
+#
+# Since: 3.0
+##
+{ 'command': 'query-pr-managers', 'returns': ['PRManagerInfo'] }
+
+
 ##
 # @blockdev-snapshot-internal-sync:
 #
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 0c0fe389b7..b11481be9e 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -235,6 +235,18 @@ out:
     return ret;
 }
 
+static bool pr_manager_helper_is_connected(PRManager *p)
+{
+    PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(p);
+    bool result;
+
+    qemu_mutex_lock(&pr_mgr->lock);
+    result = (pr_mgr->ioc != NULL);
+    qemu_mutex_unlock(&pr_mgr->lock);
+
+    return result;
+}
+
 static void pr_manager_helper_complete(UserCreatable *uc, Error **errp)
 {
     PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(uc);
@@ -284,6 +296,7 @@ static void pr_manager_helper_class_init(ObjectClass *klass,
                                   &error_abort);
     uc_klass->complete = pr_manager_helper_complete;
     prmgr_klass->run = pr_manager_helper_run;
+    prmgr_klass->is_connected = pr_manager_helper_is_connected;
 }
 
 static const TypeInfo pr_manager_helper_info = {
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index 87c45db5d4..b6c3056cc3 100644
--- a/scsi/pr-manager.c
+++ b/scsi/pr-manager.c
@@ -17,6 +17,10 @@
 #include "block/thread-pool.h"
 #include "scsi/pr-manager.h"
 #include "trace.h"
+#include "qapi/qapi-types-block.h"
+#include "qapi/qapi-commands-block.h"
+
+#define PR_MANAGER_PATH     "/objects"
 
 typedef struct PRManagerData {
     PRManager *pr_mgr;
@@ -64,6 +68,14 @@ BlockAIOCB *pr_manager_execute(PRManager *pr_mgr,
                                   data, complete, opaque);
 }
 
+bool pr_manager_is_connected(PRManager *pr_mgr)
+{
+    PRManagerClass *pr_mgr_class =
+        PR_MANAGER_GET_CLASS(pr_mgr);
+
+    return !pr_mgr_class->is_connected || pr_mgr_class->is_connected(pr_mgr);
+}
+
 static const TypeInfo pr_manager_info = {
     .parent = TYPE_OBJECT,
     .name = TYPE_PR_MANAGER,
@@ -105,5 +117,38 @@ pr_manager_register_types(void)
     type_register_static(&pr_manager_info);
 }
 
+static int query_one_pr_manager(Object *object, void *opaque)
+{
+    PRManagerInfoList ***prev = opaque;
+    PRManagerInfoList *elem;
+    PRManagerInfo *info;
+    PRManager *pr_mgr;
+
+    pr_mgr = (PRManager *)object_dynamic_cast(object, TYPE_PR_MANAGER);
+    if (!pr_mgr) {
+        return 0;
+    }
+
+    elem = g_new0(PRManagerInfoList, 1);
+    info = g_new0(PRManagerInfo, 1);
+    info->id = object_get_canonical_path_component(object);
+    info->is_connected = pr_manager_is_connected(pr_mgr);
+    elem->value = info;
+    elem->next = NULL;
+
+    **prev = elem;
+    *prev = &elem->next;
+    return 0;
+}
+
+PRManagerInfoList *qmp_query_pr_managers(Error **errp)
+{
+    PRManagerInfoList *head = NULL;
+    PRManagerInfoList **prev = &head;
+    Object *container = container_get(object_get_root(), PR_MANAGER_PATH);
+
+    object_child_foreach(container, query_one_pr_manager, &prev);
+    return head;
+}
 
 type_init(pr_manager_register_types);
-- 
2.17.1
