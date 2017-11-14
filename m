Received: from eggs.gnu.org ([2001:4830:134:3::10]:41974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEfWs-0000Lt-IB
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEfWq-0003C0-Jf
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:01:46 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 19:01:24 +0100
Message-Id: <20171114180128.17076-3-mreitz@redhat.com>
In-Reply-To: <20171114180128.17076-1-mreitz@redhat.com>
References: <20171114180128.17076-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11? v7 2/6] qapi/qlist: Add
 qlist_append_null() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Besides the macro itself, this patch also adds a corresponding
Coccinelle rule.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/qapi/qmp/qlist.h         | 3 +++
 scripts/coccinelle/qobject.cocci | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index c4b5fdad9b..59d209bbae 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -15,6 +15,7 @@
 
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qnull.h"
 #include "qemu/queue.h"
 
 typedef struct QListEntry {
@@ -37,6 +38,8 @@ typedef struct QList {
         qlist_append(qlist, qbool_from_bool(value))
 #define qlist_append_str(qlist, value) \
         qlist_append(qlist, qstring_from_str(value))
+#define qlist_append_null(qlist) \
+        qlist_append(qlist, qnull())
 
 #define QLIST_FOREACH_ENTRY(qlist, var)             \
         for ((var) = ((qlist)->head.tqh_first);     \
diff --git a/scripts/coccinelle/qobject.cocci b/scripts/coccinelle/qobject.cocci
index 1120eb1a42..47bcafe9a9 100644
--- a/scripts/coccinelle/qobject.cocci
+++ b/scripts/coccinelle/qobject.cocci
@@ -41,4 +41,7 @@ expression Obj, E;
 |
 - qlist_append(Obj, qstring_from_str(E));
 + qlist_append_str(Obj, E);
+|
+- qlist_append(Obj, qnull());
++ qlist_append_null(Obj);
 )
-- 
2.13.6
