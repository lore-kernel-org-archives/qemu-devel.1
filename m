Received: from eggs.gnu.org ([2001:4830:134:3::10]:36966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDXi-0008TP-5E
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDXd-0008N3-Ar
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:46:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRDXd-0008Mj-4W
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:46:25 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Dec 2017 16:45:32 +0800
Message-Id: <20171219084557.9801-3-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
References: <20171219084557.9801-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v6 02/27] qobject: introduce qstring_get_try_str()
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

The only difference from qstring_get_str() is that it allows the qstring
to be NULL.  If so, NULL is returned.

CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/qmp/qstring.h |  1 +
 qobject/qstring.c          | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 65c05a9be5..a145c8ca00 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qapi/qmp/qstring.h
@@ -27,6 +27,7 @@ QString *qstring_from_str(const char *str);
 QString *qstring_from_substr(const char *str, int start, int end);
 size_t qstring_get_length(const QString *qstring);
 const char *qstring_get_str(const QString *qstring);
+const char *qstring_get_try_str(const QString *qstring);
 void qstring_append_int(QString *qstring, int64_t value);
 void qstring_append(QString *qstring, const char *str);
 void qstring_append_chr(QString *qstring, int c);
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 74182a1c02..7638ab990d 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -128,6 +128,16 @@ const char *qstring_get_str(const QString *qstring)
     return qstring->string;
 }
 
+/**
+ * qstring_get_try_str(): Return a pointer to the stored string
+ *
+ * NOTE: will return NULL if qstring is not provided.
+ */
+const char *qstring_get_try_str(const QString *qstring)
+{
+    return qstring ? qstring_get_str(qstring) : NULL;
+}
+
 /**
  * qstring_is_equal(): Test whether the two QStrings are equal
  */
-- 
2.14.3
