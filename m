Received: from eggs.gnu.org ([2001:4830:134:3::10]:35823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm8v-0005G8-3D
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm8p-0006Gm-K4
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxm8p-0006GJ-DC
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:07 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:25 +0800
Message-Id: <20170929033844.26935-4-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 03/22] qobject: introduce qobject_get_try_str()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

A quick way to fetch string from qobject when it's a QString.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/qmp/qstring.h |  1 +
 qobject/qstring.c          | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 34278bd639..12ae4e1c29 100644
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
index 9df04e3c7b..bbe689a9e3 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -139,6 +139,17 @@ const char *qstring_get_try_str(const QString *qstring)
 }
 
 /**
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
+/**
  * qstring_destroy_obj(): Free all memory allocated by a QString
  * object
  */
-- 
2.13.5
