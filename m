Received: from eggs.gnu.org ([2001:4830:134:3::10]:32858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIb7C-0004b4-Td
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIb77-0003JB-TK
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:12:02 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  2 Nov 2018 18:11:50 +0300
Message-Id: <20181102151152.288399-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181102151152.288399-1-vsementsov@virtuozzo.com>
References: <20181102151152.288399-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/3] error: add error_get_hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add a function to export error hint - a pair to error_get_pretty. It's
needed to handle errors by hand, where we can't just report it or
propagate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qapi/error.h | 5 +++++
 util/error.c         | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 51b63dd4b5..ff2f61b877 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -139,6 +139,11 @@ typedef enum ErrorClass {
  */
 const char *error_get_pretty(const Error *err);
 
+/*
+ * Get @err's hint if any. Otherwise return NULL.
+ */
+const char *error_get_hint(const Error *err);
+
 /*
  * Get @err's error class.
  * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is
diff --git a/util/error.c b/util/error.c
index b5ccbd8eac..e7cedd5c4a 100644
--- a/util/error.c
+++ b/util/error.c
@@ -223,6 +223,11 @@ const char *error_get_pretty(const Error *err)
     return err->msg;
 }
 
+const char *error_get_hint(const Error *err)
+{
+    return err->hint ? err->hint->str : NULL;
+}
+
 void error_report_err(Error *err)
 {
     error_report("%s", error_get_pretty(err));
-- 
2.18.0
