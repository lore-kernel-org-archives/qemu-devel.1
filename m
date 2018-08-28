Received: from eggs.gnu.org ([2001:4830:134:3::10]:43831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fudC6-0005LC-PE
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fudC5-0006DH-Ea
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:34:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 28 Aug 2018 14:33:45 +0200
Message-Id: <20180828123346.17548-3-cohuck@redhat.com>
In-Reply-To: <20180828123346.17548-1-cohuck@redhat.com>
References: <20180828123346.17548-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qemu-error: make use of {error,
 warn}_report_once_cond
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>

{error,warn}_report_once() are a special case of the new functions
and can simply switch to them.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/qemu/error-report.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index d2a6515e68..4e4c0e757c 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -58,10 +58,7 @@ void warn_report_once_cond(bool *printed, const char *fmt, ...)
         static bool print_once_;                \
         bool ret_print_once_ = !print_once_;    \
                                                 \
-        if (!print_once_) {                     \
-            print_once_ = true;                 \
-            error_report(fmt, ##__VA_ARGS__);   \
-        }                                       \
+        error_report_once_cond(&print_once_, fmt, ##__VA_ARGS__); \
         unlikely(ret_print_once_);              \
     })
 
@@ -74,10 +71,7 @@ void warn_report_once_cond(bool *printed, const char *fmt, ...)
         static bool print_once_;                \
         bool ret_print_once_ = !print_once_;    \
                                                 \
-        if (!print_once_) {                     \
-            print_once_ = true;                 \
-            warn_report(fmt, ##__VA_ARGS__);    \
-        }                                       \
+        warn_report_once_cond(&print_once_, fmt, ##__VA_ARGS__); \
         unlikely(ret_print_once_);              \
     })
 
-- 
2.14.4
