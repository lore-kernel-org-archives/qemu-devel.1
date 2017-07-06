Received: from eggs.gnu.org ([2001:4830:134:3::10]:33076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nf-0004nr-I1
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9ne-00061Q-Mh
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:43 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:20 +0200
Message-Id: <20170706163828.24082-4-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/11] util: use RCU accessors for notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

This provides more flexibility for its users.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/notify.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/util/notify.c b/util/notify.c
index 06de63a839..16fff8d07d 100644
--- a/util/notify.c
+++ b/util/notify.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/notify.h"
+#include "qemu/rcu_queue.h"
 
 void notifier_list_init(NotifierList *list)
 {
@@ -24,19 +25,19 @@ void notifier_list_init(NotifierList *list)
 
 void notifier_list_add(NotifierList *list, Notifier *notifier)
 {
-    QLIST_INSERT_HEAD(&list->notifiers, notifier, node);
+    QLIST_INSERT_HEAD_RCU(&list->notifiers, notifier, node);
 }
 
 void notifier_remove(Notifier *notifier)
 {
-    QLIST_REMOVE(notifier, node);
+    QLIST_REMOVE_RCU(notifier, node);
 }
 
 void notifier_list_notify(NotifierList *list, void *data)
 {
     Notifier *notifier, *next;
 
-    QLIST_FOREACH_SAFE(notifier, &list->notifiers, node, next) {
+    QLIST_FOREACH_SAFE_RCU(notifier, &list->notifiers, node, next) {
         notifier->notify(notifier, data);
     }
 }
@@ -49,12 +50,12 @@ void notifier_with_return_list_init(NotifierWithReturnList *list)
 void notifier_with_return_list_add(NotifierWithReturnList *list,
                                    NotifierWithReturn *notifier)
 {
-    QLIST_INSERT_HEAD(&list->notifiers, notifier, node);
+    QLIST_INSERT_HEAD_RCU(&list->notifiers, notifier, node);
 }
 
 void notifier_with_return_remove(NotifierWithReturn *notifier)
 {
-    QLIST_REMOVE(notifier, node);
+    QLIST_REMOVE_RCU(notifier, node);
 }
 
 int notifier_with_return_list_notify(NotifierWithReturnList *list, void *data)
@@ -62,7 +63,7 @@ int notifier_with_return_list_notify(NotifierWithReturnList *list, void *data)
     NotifierWithReturn *notifier, *next;
     int ret = 0;
 
-    QLIST_FOREACH_SAFE(notifier, &list->notifiers, node, next) {
+    QLIST_FOREACH_SAFE_RCU(notifier, &list->notifiers, node, next) {
         ret = notifier->notify(notifier, data);
         if (ret != 0) {
             break;
-- 
2.13.0
