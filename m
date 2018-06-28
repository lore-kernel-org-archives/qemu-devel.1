Received: from eggs.gnu.org ([2001:4830:134:3::10]:36425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYd38-0002Di-V2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYd37-0000bt-Lx
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:51 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:50989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYd37-0000ZU-BA
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:49 -0400
Received: by mail-wm0-x22b.google.com with SMTP id e16-v6so10965504wmd.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:57:49 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	d102-v6sm12516646wma.10.2018.06.28.12.57.46
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 12:57:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 21:57:37 +0200
Message-Id: <1530215858-1525-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
References: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] pr-manager: add query-pr-managers QMP
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

This command lets you query the connection status of each pr-manager-helper
object.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/scsi/pr-manager.h |  2 ++
 qapi/block.json           | 28 ++++++++++++++++++++++++++++
 scsi/pr-manager-helper.c  | 13 +++++++++++++
 scsi/pr-manager-stub.c    |  6 ++++++
 scsi/pr-manager.c         | 45 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+)

diff --git a/include/scsi/pr-manager.h b/include/scsi/pr-manager.h
index 71971ae..50a77b0 100644
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
index ca807f1..8765c29 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -78,6 +78,34 @@
   'data': { 'device': 'str', 'name': 'str' } }
 
 ##
+# @PRManagerInfo:
+#
+# Information about a persistent reservation manager
+#
+# @id: the identifier of the persistent reservation manager
+#
+# @connected: true if the persistent reservation manager is connected to
+#             the underlying storage or helper
+#
+# Since: 3.0
+##
+{ 'struct': 'PRManagerInfo',
+  'data': {'id': 'str', 'connected': 'bool'} }
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
+{ 'command': 'query-pr-managers', 'returns': ['PRManagerInfo'],
+  'allow-preconfig': true }
+
+
+##
 # @blockdev-snapshot-internal-sync:
 #
 # Synchronously take an internal snapshot of a block device, when the
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 0c0fe38..b11481b 100644
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
diff --git a/scsi/pr-manager-stub.c b/scsi/pr-manager-stub.c
index 632f17c..738b6d7 100644
--- a/scsi/pr-manager-stub.c
+++ b/scsi/pr-manager-stub.c
@@ -22,3 +22,9 @@ PRManager *pr_manager_lookup(const char *id, Error **errp)
     error_setg(errp, "No persistent reservation manager with id '%s'", id);
         return NULL;
 }
+
+
+PRManagerInfoList *qmp_query_pr_managers(Error **errp)
+{
+    return NULL;
+}
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index 87c45db..2a8f300 100644
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
+    info->connected = pr_manager_is_connected(pr_mgr);
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
1.8.3.1
