Received: from eggs.gnu.org ([2001:4830:134:3::10]:47374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMZ-0007TE-5p
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMX-0000LY-TM
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:35 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 23:32:13 +0200
Message-Id: <20180502213219.7842-2-mreitz@redhat.com>
In-Reply-To: <20180502213219.7842-1-mreitz@redhat.com>
References: <20180502213219.7842-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC 1/7] qdict: Add qdict_set_default_bool()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qapi/qmp/qdict.h |  1 +
 qobject/qdict.c          | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 2cc3e906f7..a6fb89302d 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -69,6 +69,7 @@ const char *qdict_get_try_str(const QDict *qdict, const char *key);
 
 void qdict_copy_default(QDict *dst, QDict *src, const char *key);
 void qdict_set_default_str(QDict *dst, const char *key, const char *val);
+void qdict_set_default_bool(QDict *dst, const char *key, bool val);
 
 QDict *qdict_clone_shallow(const QDict *src);
 void qdict_flatten(QDict *qdict);
diff --git a/qobject/qdict.c b/qobject/qdict.c
index d1997a0d8a..5c25da36b3 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -498,6 +498,19 @@ void qdict_set_default_str(QDict *dst, const char *key, const char *val)
     qdict_put_str(dst, key, val);
 }
 
+/**
+ * qdict_set_default_bool(): If no entry mapped by 'key' exists in
+ * 'dst' yet, a new QBool initialized by 'val' is put there.
+ */
+void qdict_set_default_bool(QDict *dst, const char *key, bool val)
+{
+    if (qdict_haskey(dst, key)) {
+        return;
+    }
+
+    qdict_put_bool(dst, key, val);
+}
+
 static void qdict_flatten_qdict(QDict *qdict, QDict *target,
                                 const char *prefix);
 
-- 
2.14.3
