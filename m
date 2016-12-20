Received: from eggs.gnu.org ([2001:4830:134:3::10]:41153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJNKc-0001a7-Or
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJNKY-0007IE-Pk
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:32:02 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 21 Dec 2016 00:31:37 +0800
Message-Id: <20161220163139.12016-3-famz@redhat.com>
In-Reply-To: <20161220163139.12016-1-famz@redhat.com>
References: <20161220163139.12016-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] util: Add a notifier list for qemu_vfree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Karl Rister <krister@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, borntraeger@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>

To allow other code to intercept buffer freeing and do customized
unmapping operations.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qemu/notify.h | 1 +
 util/oslib-posix.c    | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/qemu/notify.h b/include/qemu/notify.h
index a3d73e4..24c4f5f 100644
--- a/include/qemu/notify.h
+++ b/include/qemu/notify.h
@@ -69,4 +69,5 @@ void notifier_with_return_remove(NotifierWithReturn *notifier);
 int notifier_with_return_list_notify(NotifierWithReturnList *list,
                                      void *data);
 
+void qemu_vfree_add_notifier(Notifier *n);
 #endif
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f631464..b0dd207 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -125,9 +125,18 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment)
     return ptr;
 }
 
+static NotifierList qemu_vfree_notifiers =
+    NOTIFIER_LIST_INITIALIZER(qemu_vfree_notifiers);
+
+void qemu_vfree_add_notifier(Notifier *n)
+{
+    notifier_list_add(&qemu_vfree_notifiers, n);
+}
+
 void qemu_vfree(void *ptr)
 {
     trace_qemu_vfree(ptr);
+    notifier_list_notify(&qemu_vfree_notifiers, ptr);
     free(ptr);
 }
 
-- 
2.9.3
