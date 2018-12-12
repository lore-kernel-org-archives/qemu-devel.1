Received: from eggs.gnu.org ([2001:4830:134:3::10]:52413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mc-0000uK-OL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MZ-0000Ib-OV
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:54 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MZ-0000Gj-EH
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:51 -0500
Received: by mail-wm1-x334.google.com with SMTP id q26so6345460wmf.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:51 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:50 +0100
Message-Id: <1544628195-37728-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/54] qemu/queue.h: remove Q_TAILQ_{HEAD, ENTRY}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These are not present for other kinds of queue, and unused.
Zap them before more changes are made to the QTAILQ
implementation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/queue.h       | 14 ++++++--------
 scripts/cocci-macro-file.h | 10 ----------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index ac418ef..b9571e9 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -350,22 +350,20 @@ struct {                                                                \
 /*
  * Tail queue definitions.
  */
-#define Q_TAILQ_HEAD(name, type, qual)                                  \
+#define QTAILQ_HEAD(name, type)                                         \
 struct name {                                                           \
-        qual type *tqh_first;           /* first element */             \
-        qual type *qual *tqh_last;      /* addr of last next element */ \
+        type *tqh_first;      /* first element */                       \
+        type **tqh_last;      /* addr of last next element */           \
 }
-#define QTAILQ_HEAD(name, type)  Q_TAILQ_HEAD(name, struct type,)
 
 #define QTAILQ_HEAD_INITIALIZER(head)                                   \
         { NULL, &(head).tqh_first }
 
-#define Q_TAILQ_ENTRY(type, qual)                                       \
+#define QTAILQ_ENTRY(type)                                              \
 struct {                                                                \
-        qual type *tqe_next;            /* next element */              \
-        qual type *qual *tqe_prev;      /* address of previous next element */\
+        type *tqe_next;       /* next element */                   \
+        type **tqe_prev;      /* address of previous next element */    \
 }
-#define QTAILQ_ENTRY(type)       Q_TAILQ_ENTRY(struct type,)
 
 /*
  * Tail queue functions.
diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
index 9f2e72e..5c49369 100644
--- a/scripts/cocci-macro-file.h
+++ b/scripts/cocci-macro-file.h
@@ -93,11 +93,6 @@ struct {                                                                \
 /*
  * Tail queue definitions.
  */
-#define Q_TAILQ_HEAD(name, type, qual)                                  \
-struct name {                                                           \
-        qual type *tqh_first;           /* first element */             \
-        qual type *qual *tqh_last;      /* addr of last next element */ \
-}
 #define QTAILQ_HEAD(name, type)                                         \
 struct name {                                                           \
         type *tqh_first;      /* first element */                       \
@@ -107,11 +102,6 @@ struct name {                                                           \
 #define QTAILQ_HEAD_INITIALIZER(head)                                   \
         { NULL, &(head).tqh_first }
 
-#define Q_TAILQ_ENTRY(type, qual)                                       \
-struct {                                                                \
-        qual type *tqe_next;            /* next element */              \
-        qual type *qual *tqe_prev;      /* address of previous next element */\
-}
 #define QTAILQ_ENTRY(type)                                              \
 struct {                                                                \
         type *tqe_next;       /* next element */                        \
-- 
1.8.3.1
