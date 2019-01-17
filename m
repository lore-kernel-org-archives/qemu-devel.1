Received: from eggs.gnu.org ([209.51.188.92]:57863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67I-0006V8-S1
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67H-0005p7-HG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk67H-0005oO-81
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:47 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:51 +0400
Message-Id: <20190117114359.5164-20-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 19/27] slirp: replace qemu qtailq with slirp
 own copy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/qtailq.h | 193 +++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/slirp.h  |   3 +-
 2 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 slirp/qtailq.h

diff --git a/slirp/qtailq.h b/slirp/qtailq.h
new file mode 100644
index 00000000000..a89b0c439a9
--- /dev/null
+++ b/slirp/qtailq.h
@@ -0,0 +1,193 @@
+/*      $NetBSD: queue.h,v 1.52 2009/04/20 09:56:08 mschuett Exp $ */
+
+/*
+ * slirp version: Copy from QEMU, removed all but tail queues.
+ */
+
+/*
+ * Copyright (c) 1991, 1993
+ *      The Regents of the University of California.  All rights reserve=
d.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in th=
e
+ *    documentation and/or other materials provided with the distributio=
n.
+ * 3. Neither the name of the University nor the names of its contributo=
rs
+ *    may be used to endorse or promote products derived from this softw=
are
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' A=
ND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIA=
BLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUE=
NTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOO=
DS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, S=
TRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
+ * SUCH DAMAGE.
+ *
+ *      @(#)queue.h     8.5 (Berkeley) 8/20/94
+ */
+
+#ifndef QTAILQ_H
+#define QTAILQ_H
+
+/*
+ * A tail queue is headed by a pair of pointers, one to the head of the
+ * list and the other to the tail of the list. The elements are doubly
+ * linked so that an arbitrary element can be removed without a need to
+ * traverse the list. New elements can be added to the list before or
+ * after an existing element, at the head of the list, or at the end of
+ * the list. A tail queue may be traversed in either direction.
+ */
+typedef struct QTailQLink {
+    void *tql_next;
+    struct QTailQLink *tql_prev;
+} QTailQLink;
+
+/*
+ * Tail queue definitions.  The union acts as a poor man template, as if
+ * it were QTailQLink<type>.
+ */
+#define QTAILQ_HEAD(name, type)                                         =
\
+    union name {                                                        =
\
+        struct type *tqh_first;       /* first element */               =
\
+        QTailQLink tqh_circ;          /* link for circular backwards lis=
t */ \
+    }
+
+#define QTAILQ_HEAD_INITIALIZER(head)           \
+    { .tqh_circ =3D { NULL, &(head).tqh_circ } }
+
+#define QTAILQ_ENTRY(type)                                              =
\
+    union {                                                             =
\
+        struct type *tqe_next;        /* next element */                =
\
+        QTailQLink tqe_circ;          /* link for circular backwards lis=
t */ \
+    }
+
+#define QTAILQ_INIT(head) do {                                          =
\
+        (head)->tqh_first =3D NULL;                                     =
  \
+        (head)->tqh_circ.tql_prev =3D &(head)->tqh_circ;                =
  \
+} while (/*CONSTCOND*/0)
+
+#define QTAILQ_INSERT_HEAD(head, elm, field) do {                       =
\
+        if (((elm)->field.tqe_next =3D (head)->tqh_first) !=3D NULL)    =
    \
+            (head)->tqh_first->field.tqe_circ.tql_prev =3D              =
  \
+                &(elm)->field.tqe_circ;                                 =
\
+        else                                                            =
\
+            (head)->tqh_circ.tql_prev =3D &(elm)->field.tqe_circ;       =
  \
+        (head)->tqh_first =3D (elm);                                    =
  \
+        (elm)->field.tqe_circ.tql_prev =3D &(head)->tqh_circ;           =
  \
+} while (/*CONSTCOND*/0)
+
+#define QTAILQ_INSERT_TAIL(head, elm, field) do {                       =
\
+        (elm)->field.tqe_next =3D NULL;                                 =
  \
+        (elm)->field.tqe_circ.tql_prev =3D (head)->tqh_circ.tql_prev;   =
  \
+        (head)->tqh_circ.tql_prev->tql_next =3D (elm);                  =
  \
+        (head)->tqh_circ.tql_prev =3D &(elm)->field.tqe_circ;           =
  \
+} while (/*CONSTCOND*/0)
+
+#define QTAILQ_INSERT_AFTER(head, listelm, elm, field) do {             =
\
+        if (((elm)->field.tqe_next =3D (listelm)->field.tqe_next) !=3D N=
ULL)\
+            (elm)->field.tqe_next->field.tqe_circ.tql_prev =3D          =
  \
+                &(elm)->field.tqe_circ;                                 =
\
+        else                                                            =
\
+            (head)->tqh_circ.tql_prev =3D &(elm)->field.tqe_circ;       =
  \
+        (listelm)->field.tqe_next =3D (elm);                            =
  \
+        (elm)->field.tqe_circ.tql_prev =3D &(listelm)->field.tqe_circ;  =
  \
+} while (/*CONSTCOND*/0)
+
+#define QTAILQ_INSERT_BEFORE(listelm, elm, field) do {                  =
     \
+        (elm)->field.tqe_circ.tql_prev =3D (listelm)->field.tqe_circ.tql=
_prev; \
+        (elm)->field.tqe_next =3D (listelm);                            =
       \
+        (listelm)->field.tqe_circ.tql_prev->tql_next =3D (elm);         =
       \
+        (listelm)->field.tqe_circ.tql_prev =3D &(elm)->field.tqe_circ;  =
       \
+} while (/*CONSTCOND*/0)
+
+#define QTAILQ_REMOVE(head, elm, field) do {                            =
\
+        if (((elm)->field.tqe_next) !=3D NULL)                          =
  \
+            (elm)->field.tqe_next->field.tqe_circ.tql_prev =3D          =
  \
+                (elm)->field.tqe_circ.tql_prev;                         =
\
+        else                                                            =
\
+            (head)->tqh_circ.tql_prev =3D (elm)->field.tqe_circ.tql_prev=
; \
+        (elm)->field.tqe_circ.tql_prev->tql_next =3D (elm)->field.tqe_ne=
xt; \
+        (elm)->field.tqe_circ.tql_prev =3D NULL;                        =
  \
+} while (/*CONSTCOND*/0)
+
+#define QTAILQ_FOREACH(var, head, field)                                =
\
+        for ((var) =3D ((head)->tqh_first);                             =
  \
+                (var);                                                  =
\
+                (var) =3D ((var)->field.tqe_next))
+
+#define QTAILQ_FOREACH_SAFE(var, head, field, next_var)                 =
\
+        for ((var) =3D ((head)->tqh_first);                             =
  \
+                (var) && ((next_var) =3D ((var)->field.tqe_next), 1);   =
  \
+                (var) =3D (next_var))
+
+#define QTAILQ_FOREACH_REVERSE(var, head, field)                        =
\
+        for ((var) =3D QTAILQ_LAST(head);                               =
  \
+                (var);                                                  =
\
+                (var) =3D QTAILQ_PREV(var, field))
+
+#define QTAILQ_FOREACH_REVERSE_SAFE(var, head, field, prev_var)         =
\
+        for ((var) =3D QTAILQ_LAST(head);                               =
  \
+             (var) && ((prev_var) =3D QTAILQ_PREV(var, field));         =
  \
+             (var) =3D (prev_var))
+
+/*
+ * Tail queue access methods.
+ */
+#define QTAILQ_EMPTY(head)               ((head)->tqh_first =3D=3D NULL)
+#define QTAILQ_FIRST(head)               ((head)->tqh_first)
+#define QTAILQ_NEXT(elm, field)          ((elm)->field.tqe_next)
+#define QTAILQ_IN_USE(elm, field)        ((elm)->field.tqe_circ.tql_prev=
 !=3D NULL)
+
+#define QTAILQ_LINK_PREV(link)                                          =
\
+        ((link).tql_prev->tql_prev->tql_next)
+#define QTAILQ_LAST(head)                                               =
\
+        ((typeof((head)->tqh_first)) QTAILQ_LINK_PREV((head)->tqh_circ))
+#define QTAILQ_PREV(elm, field)                                         =
\
+        ((typeof((elm)->field.tqe_next)) QTAILQ_LINK_PREV((elm)->field.t=
qe_circ))
+
+#define field_at_offset(base, offset, type)                             =
       \
+        ((type *) (((char *) (base)) + (offset)))
+
+/*
+ * Raw access of elements of a tail queue head.  Offsets are all zero
+ * because it's a union.
+ */
+#define QTAILQ_RAW_FIRST(head)                                          =
       \
+        field_at_offset(head, 0, void *)
+#define QTAILQ_RAW_TQH_CIRC(head)                                       =
       \
+        field_at_offset(head, 0, QTailQLink)
+
+/*
+ * Raw access of elements of a tail entry
+ */
+#define QTAILQ_RAW_NEXT(elm, entry)                                     =
       \
+        field_at_offset(elm, entry, void *)
+#define QTAILQ_RAW_TQE_CIRC(elm, entry)                                 =
       \
+        field_at_offset(elm, entry, QTailQLink)
+/*
+ * Tail queue traversal using pointer arithmetic.
+ */
+#define QTAILQ_RAW_FOREACH(elm, head, entry)                            =
       \
+        for ((elm) =3D *QTAILQ_RAW_FIRST(head);                         =
         \
+             (elm);                                                     =
       \
+             (elm) =3D *QTAILQ_RAW_NEXT(elm, entry))
+/*
+ * Tail queue insertion using pointer arithmetic.
+ */
+#define QTAILQ_RAW_INSERT_TAIL(head, elm, entry) do {                   =
        \
+        *QTAILQ_RAW_NEXT(elm, entry) =3D NULL;                          =
          \
+        QTAILQ_RAW_TQE_CIRC(elm, entry)->tql_prev =3D QTAILQ_RAW_TQH_CIR=
C(head)->tql_prev; \
+        QTAILQ_RAW_TQH_CIRC(head)->tql_prev->tql_next =3D (elm);        =
          \
+        QTAILQ_RAW_TQH_CIRC(head)->tql_prev =3D QTAILQ_RAW_TQE_CIRC(elm,=
 entry);  \
+} while (/*CONSTCOND*/0)
+
+#endif /* QTAILQ_H */
diff --git a/slirp/slirp.h b/slirp/slirp.h
index c9f91438016..0e4d973c2ab 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -46,8 +46,7 @@ typedef char *caddr_t;
=20
 #include "debug.h"
 #include "util.h"
-
-#include "qemu/queue.h"
+#include "qtailq.h"
=20
 #include "libslirp.h"
 #include "ip.h"
--=20
2.20.1.98.gecbdaf0899
