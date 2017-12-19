Received: from eggs.gnu.org ([2001:4830:134:3::10]:37013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDXo-00005v-32
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDXn-0008SW-Do
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:46:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRDXn-0008Rt-6l
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:46:35 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Dec 2017 16:45:33 +0800
Message-Id: <20171219084557.9801-4-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
References: <20171219084557.9801-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v6 03/27] qobject: introduce qobject_get_try_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

A quick way to fetch string from qobject when it's a QString.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/qmp/qstring.h |  1 +
 qobject/qstring.c          | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index a145c8ca00..6517d8e377 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qapi/qmp/qstring.h
@@ -28,6 +28,7 @@ QString *qstring_from_substr(const char *str, int start, int end);
 size_t qstring_get_length(const QString *qstring);
 const char *qstring_get_str(const QString *qstring);
 const char *qstring_get_try_str(const QString *qstring);
+const char *qobject_get_try_str(const QObject *qstring);
 void qstring_append_int(QString *qstring, int64_t value);
 void qstring_append(QString *qstring, const char *str);
 void qstring_append_chr(QString *qstring, int c);
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 7638ab990d..fc6834baa6 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -138,6 +138,17 @@ const char *qstring_get_try_str(const QString *qstring)
     return qstring ? qstring_get_str(qstring) : NULL;
 }
 
+/**
+ * qobject_get_try_str(): Return a pointer of the backstore string
+ *
+ * NOTE: the string will only be returned if the object is valid, and
+ * its type is QString, otherwise NULL is returned.
+ */
+const char *qobject_get_try_str(const QObject *qstring)
+{
+    return qstring_get_try_str(qobject_to_qstring(qstring));
+}
+
 /**
  * qstring_is_equal(): Test whether the two QStrings are equal
  */
-- 
2.14.3
