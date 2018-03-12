Received: from eggs.gnu.org ([2001:4830:134:3::10]:45204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJT-0000g9-D6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJS-0005wr-6a
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJS-0005wF-0j
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 718338D6D7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:04 -0500
Message-Id: <20180312183628.394722-14-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 13/36] qobject: introduce qstring_get_try_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Peter Xu <peterx@redhat.com>

The only difference from qstring_get_str() is that it allows the qstring
to be NULL.  If so, NULL is returned.

CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-3-peterx@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qstring.h |  1 +
 qobject/qstring.c          | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index b72843fc1b0..38c680b7185 100644
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
index 8bae529ef79..5777f0af231 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -116,6 +116,16 @@ const char *qstring_get_str(const QString *qstring)
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
