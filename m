Received: from eggs.gnu.org ([2001:4830:134:3::10]:33450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gWQIA-0008NX-Mb
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gWQI9-0003h1-Lr
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:28:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gWQI9-0003fM-B2
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:28:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 901DF81DED
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 18:28:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Dec 2018 19:28:13 +0100
Message-Id: <20181210182816.2014-6-pbonzini@redhat.com>
In-Reply-To: <20181210182816.2014-1-pbonzini@redhat.com>
References: <20181210182816.2014-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/8] qemu/queue.h: remove Q_TAILQ_{HEAD, ENTRY}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

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
index 9f2e72e7e1..5c49369dac 100644
--- a/scripts/cocci-macro-file.h
+++ b/scripts/cocci-macro-file.h
@@ -93,11 +93,6 @@ struct {                                              =
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
@@ -107,11 +102,6 @@ struct name {                                       =
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
2.19.2
