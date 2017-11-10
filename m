Received: from eggs.gnu.org ([2001:4830:134:3::10]:47455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHYS-0004ii-D4
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHYR-0005YN-JV
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:13:40 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 23:13:27 +0100
Message-Id: <20171110221329.24176-2-mreitz@redhat.com>
In-Reply-To: <20171110221329.24176-1-mreitz@redhat.com>
References: <20171110221329.24176-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 1/3] qapi: Add qdict_is_null()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qapi/qmp/qdict.h |  1 +
 qobject/qdict.c          | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index fc218e7be6..c65ebfc748 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -76,6 +76,7 @@ int64_t qdict_get_try_int(const QDict *qdict, const char *key,
                           int64_t def_value);
 bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value);
 const char *qdict_get_try_str(const QDict *qdict, const char *key);
+bool qdict_is_qnull(const QDict *qdict, const char *key);
 
 void qdict_copy_default(QDict *dst, QDict *src, const char *key);
 void qdict_set_default_str(QDict *dst, const char *key, const char *val);
diff --git a/qobject/qdict.c b/qobject/qdict.c
index e8f15f1132..a032ea629a 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -294,6 +294,16 @@ const char *qdict_get_try_str(const QDict *qdict, const char *key)
 }
 
 /**
+ * qdict_is_qnull(): Return true if the value for 'key' is QNull
+ */
+bool qdict_is_qnull(const QDict *qdict, const char *key)
+{
+    QObject *value = qdict_get(qdict, key);
+
+    return value && value->type == QTYPE_QNULL;
+}
+
+/**
  * qdict_iter(): Iterate over all the dictionary's stored values.
  *
  * This function allows the user to provide an iterator, which will be
-- 
2.13.6
