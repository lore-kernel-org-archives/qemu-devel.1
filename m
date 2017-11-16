Received: from eggs.gnu.org ([2001:4830:134:3::10]:37825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJsG-0007gb-BR
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJsA-0005N7-Lw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:06:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJsA-0005LN-FU
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:06:26 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:05:44 +0800
Message-Id: <20171116130610.23582-2-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 01/27] qobject: introduce qstring_get_try_str()
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/qmp/qstring.h |  1 +
 qobject/qstring.c          | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 10076b7c8c..34278bd639 100644
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
index 5da7b5f37c..9df04e3c7b 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -129,6 +129,16 @@ const char *qstring_get_str(const QString *qstring)
 }
 
 /**
+ * qstring_get_try_str(): Return a pointer to the stored string
+ *
+ * NOTE: will return NULL if qstring is not provided.
+ */
+const char *qstring_get_try_str(const QString *qstring)
+{
+    return qstring ? qstring_get_str(qstring) : NULL;
+}
+
+/**
  * qstring_destroy_obj(): Free all memory allocated by a QString
  * object
  */
-- 
2.13.6
