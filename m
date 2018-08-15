Received: from eggs.gnu.org ([2001:4830:134:3::10]:52613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpsUs-0004BF-01
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpsUq-0002rP-Vc
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:53:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fpsUq-0002q9-Lr
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:53:44 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 15 Aug 2018 17:53:26 +0800
Message-Id: <20180815095328.32414-2-peterx@redhat.com>
In-Reply-To: <20180815095328.32414-1-peterx@redhat.com>
References: <20180815095328.32414-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 1/3] qemu-error: introduce
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Blake <eblake@redhat.com>

There are many error_report()s that can be used in frequently called
functions, especially on IO paths.  That can be unideal in that
malicious guest can try to trigger the error tons of time which might
use up the log space on the host (e.g., libvirt can capture the stderr
of QEMU and put it persistently onto disk).  In VT-d emulation code, we
have trace_vtd_error() tracer.  AFAIU all those places can be replaced
by something like error_report() but trace points are mostly used to
avoid the DDOS attack that mentioned above.  However using trace points
mean that errors are not dumped if trace not enabled.

It's not a big deal in most modern server managements since we have
things like logrotate to maintain the logs and make sure the quota is
expected.  However it'll still be nice that we just provide another way
to restrict message generations.  In most cases, this kind of
error_report()s will only provide valid information on the first message
sent, and all the rest of similar messages will be mostly talking about
the same thing.  This patch introduces *_report_once() helpers to allow
a message to be dumped only once during one QEMU process's life cycle.
It will make sure: (1) it's on by deffault, so we can even get something
without turning the trace on and reproducing, and (2) it won't be
affected by DDOS attack.

To implement it, I stole the printk_once() macro from Linux.

CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/error-report.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index e1c8ae1a52..c7ec54cb97 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -44,6 +44,38 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
+/*
+ * Similar to error_report(), but it only prints the message once.  It
+ * returns true when it prints the first time, otherwise false.
+ */
+#define error_report_once(fmt, ...)             \
+    ({                                          \
+        static bool print_once_;               \
+        bool ret_print_once_ = !print_once_;  \
+                                                \
+        if (!print_once_) {                    \
+            print_once_ = true;                \
+            error_report(fmt, ##__VA_ARGS__);   \
+        }                                       \
+        unlikely(ret_print_once_);             \
+    })
+
+/*
+ * Similar to warn_report(), but it only prints the message once.  It
+ * returns true when it prints the first time, otherwise false.
+ */
+#define warn_report_once(fmt, ...)              \
+    ({                                          \
+        static bool print_once_;               \
+        bool ret_print_once_ = !print_once_;  \
+                                                \
+        if (!print_once_) {                    \
+            print_once_ = true;                \
+            warn_report(fmt, ##__VA_ARGS__);   \
+        }                                       \
+        unlikely(ret_print_once_);             \
+    })
+
 const char *error_get_progname(void);
 extern bool enable_timestamp_msg;
 
-- 
2.17.1
