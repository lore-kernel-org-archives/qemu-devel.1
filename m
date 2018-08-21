Received: from eggs.gnu.org ([2001:4830:134:3::10]:33559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4b-00025A-F0
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4V-0006n7-Ns
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:04 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4U-0006aH-U4
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id 20-v6so10507759wrb.12
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:16 +0200
Message-Id: <1534870966-9287-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 44/74] tests: add test-rcu-tailq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20180819091335.22863-10-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  4 ++++
 tests/test-rcu-list.c  | 15 +++++++++++++++
 tests/test-rcu-tailq.c |  2 ++
 3 files changed, 21 insertions(+)
 create mode 100644 tests/test-rcu-tailq.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f6b6b22..961b28b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -118,6 +118,8 @@ check-unit-y += tests/test-rcu-list$(EXESUF)
 gcov-files-test-rcu-list-y = util/rcu.c
 check-unit-y += tests/test-rcu-simpleq$(EXESUF)
 gcov-files-test-rcu-simpleq-y = util/rcu.c
+check-unit-y += tests/test-rcu-tailq$(EXESUF)
+gcov-files-test-rcu-tailq-y = util/rcu.c
 check-unit-y += tests/test-qdist$(EXESUF)
 gcov-files-test-qdist-y = util/qdist.c
 check-unit-y += tests/test-qht$(EXESUF)
@@ -601,6 +603,7 @@ test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
 	tests/test-opts-visitor.o tests/test-qmp-event.o \
 	tests/rcutorture.o tests/test-rcu-list.o \
 	tests/test-rcu-simpleq.o \
+	tests/test-rcu-tailq.o \
 	tests/test-qdist.o tests/test-shift128.o \
 	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
 	tests/atomic_add-bench.o
@@ -651,6 +654,7 @@ tests/test-int128$(EXESUF): tests/test-int128.o
 tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
 tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)
 tests/test-rcu-simpleq$(EXESUF): tests/test-rcu-simpleq.o $(test-util-obj-y)
+tests/test-rcu-tailq$(EXESUF): tests/test-rcu-tailq.o $(test-util-obj-y)
 tests/test-qdist$(EXESUF): tests/test-qdist.o $(test-util-obj-y)
 tests/test-qht$(EXESUF): tests/test-qht.o $(test-util-obj-y)
 tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(test-util-obj-y)
diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index c8bdf49..8434700 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -91,6 +91,8 @@ struct list_element {
     QLIST_ENTRY(list_element) entry;
 #elif TEST_LIST_TYPE == 2
     QSIMPLEQ_ENTRY(list_element) entry;
+#elif TEST_LIST_TYPE == 3
+    QTAILQ_ENTRY(list_element) entry;
 #else
 #error Invalid TEST_LIST_TYPE
 #endif
@@ -129,6 +131,19 @@ static QSIMPLEQ_HEAD(, list_element) Q_list_head =
 #define TEST_LIST_INSERT_HEAD_RCU   QSIMPLEQ_INSERT_HEAD_RCU
 #define TEST_LIST_FOREACH_RCU       QSIMPLEQ_FOREACH_RCU
 #define TEST_LIST_FOREACH_SAFE_RCU  QSIMPLEQ_FOREACH_SAFE_RCU
+
+#elif TEST_LIST_TYPE == 3
+static QTAILQ_HEAD(, list_element) Q_list_head;
+
+#define TEST_NAME "qtailq"
+#define TEST_LIST_REMOVE_RCU(el, f) QTAILQ_REMOVE_RCU(&Q_list_head, el, f)
+
+#define TEST_LIST_INSERT_AFTER_RCU(list_el, el, f)               \
+           QTAILQ_INSERT_AFTER_RCU(&Q_list_head, list_el, el, f)
+
+#define TEST_LIST_INSERT_HEAD_RCU   QTAILQ_INSERT_HEAD_RCU
+#define TEST_LIST_FOREACH_RCU       QTAILQ_FOREACH_RCU
+#define TEST_LIST_FOREACH_SAFE_RCU  QTAILQ_FOREACH_SAFE_RCU
 #else
 #error Invalid TEST_LIST_TYPE
 #endif
diff --git a/tests/test-rcu-tailq.c b/tests/test-rcu-tailq.c
new file mode 100644
index 0000000..8d487e0
--- /dev/null
+++ b/tests/test-rcu-tailq.c
@@ -0,0 +1,2 @@
+#define TEST_LIST_TYPE 3
+#include "test-rcu-list.c"
-- 
1.8.3.1
