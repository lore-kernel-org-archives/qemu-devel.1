Received: from eggs.gnu.org ([2001:4830:134:3::10]:43630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29O-0001F4-Lh
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29M-0004xC-4q
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ29K-0004V5-9q
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5764C065F74
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:18:07 +0000 (UTC)
Received: from donizetti.redhat.com (unknown [10.36.112.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC64D5D9C5
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:18:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:53 +0100
Message-Id: <20181217231700.24482-29-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/35] qemu/queue.h: remove Q_TAILQ_{HEAD, ENTRY}
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
index ac418efc43..b9571e93d8 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -350,22 +350,20 @@ struct {                                           =
                     \
 /*
  * Tail queue definitions.
  */
-#define Q_TAILQ_HEAD(name, type, qual)                                  =
\
+#define QTAILQ_HEAD(name, type)                                         =
\
 struct name {                                                           =
\
-        qual type *tqh_first;           /* first element */             =
\
-        qual type *qual *tqh_last;      /* addr of last next element */ =
\
+        type *tqh_first;      /* first element */                       =
\
+        type **tqh_last;      /* addr of last next element */           =
\
 }
-#define QTAILQ_HEAD(name, type)  Q_TAILQ_HEAD(name, struct type,)
=20
 #define QTAILQ_HEAD_INITIALIZER(head)                                   =
\
         { NULL, &(head).tqh_first }
=20
-#define Q_TAILQ_ENTRY(type, qual)                                       =
\
+#define QTAILQ_ENTRY(type)                                              =
\
 struct {                                                                =
\
-        qual type *tqe_next;            /* next element */              =
\
-        qual type *qual *tqe_prev;      /* address of previous next elem=
ent */\
+        type *tqe_next;       /* next element */                   \
+        type **tqe_prev;      /* address of previous next element */    =
\
 }
-#define QTAILQ_ENTRY(type)       Q_TAILQ_ENTRY(struct type,)
=20
 /*
  * Tail queue functions.
diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
index 7e200a1023..e274ca3682 100644
--- a/scripts/cocci-macro-file.h
+++ b/scripts/cocci-macro-file.h
@@ -92,11 +92,6 @@ struct {                                              =
                  \
 /*
  * Tail queue definitions.
  */
-#define Q_TAILQ_HEAD(name, type, qual)                                  =
\
-struct name {                                                           =
\
-        qual type *tqh_first;           /* first element */             =
\
-        qual type *qual *tqh_last;      /* addr of last next element */ =
\
-}
 #define QTAILQ_HEAD(name, type)                                         =
\
 struct name {                                                           =
\
         type *tqh_first;      /* first element */                       =
\
@@ -106,11 +101,6 @@ struct name {                                       =
                    \
 #define QTAILQ_HEAD_INITIALIZER(head)                                   =
\
         { NULL, &(head).tqh_first }
=20
-#define Q_TAILQ_ENTRY(type, qual)                                       =
\
-struct {                                                                =
\
-        qual type *tqe_next;            /* next element */              =
\
-        qual type *qual *tqe_prev;      /* address of previous next elem=
ent */\
-}
 #define QTAILQ_ENTRY(type)                                              =
\
 struct {                                                                =
\
         type *tqe_next;       /* next element */                        =
\
--=20
2.20.1
