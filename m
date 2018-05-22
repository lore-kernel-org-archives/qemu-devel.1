Received: from eggs.gnu.org ([2001:4830:134:3::10]:44226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKyPh-0004T0-ME
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKyPg-0002zV-WC
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:56:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fKyPg-0002z9-RP
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:56:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50B4E401EF0F
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 03:56:40 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 22 May 2018 11:56:28 +0800
Message-Id: <20180522035629.30428-2-peterx@redhat.com>
In-Reply-To: <20180522035629.30428-1-peterx@redhat.com>
References: <20180522035629.30428-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] qemu-error: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

I stole the printk_once() macro.

I always wanted to be able to print some error directly if there is a
buffer to dump, however we can't use error_report() where the code path
can be triggered by DDOS attack.  To avoid that, we can introduce a
print-once-like function for it.  Meanwhile, we also introduce the
corresponding helper for warn_report().

CC: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/error-report.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index e1c8ae1a52..3e6e84801f 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -44,6 +44,32 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
+/* Similar to error_report(), but it only prints the message once. */
+#define error_report_once(fmt, ...)             \
+    ({                                          \
+        static bool __print_once;               \
+        bool __ret_print_once = !__print_once;  \
+                                                \
+        if (!__print_once) {                    \
+            __print_once = true;                \
+            error_report(fmt, ##__VA_ARGS__);   \
+        }                                       \
+        unlikely(__ret_print_once);             \
+    })
+
+/* Similar to warn_report(), but it only prints the message once. */
+#define warn_report_once(fmt, ...)              \
+    ({                                          \
+        static bool __print_once;               \
+        bool __ret_print_once = !__print_once;  \
+                                                \
+        if (!__print_once) {                    \
+            __print_once = true;                \
+            warn_report(fmt, ##__VA_ARGS__);   \
+        }                                       \
+        unlikely(__ret_print_once);             \
+    })
+
 const char *error_get_progname(void);
 extern bool enable_timestamp_msg;
 
-- 
2.17.0
