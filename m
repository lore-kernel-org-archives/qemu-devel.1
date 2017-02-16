Received: from eggs.gnu.org ([2001:4830:134:3::10]:40931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ceVBh-0005ZI-Pa
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ceVBe-0005xm-K0
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:10:09 -0500
Received: from mail-db5eur01on0117.outbound.protection.outlook.com
	([104.47.2.117]:3680
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1ceVBe-0005uo-6H
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:10:06 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 16 Feb 2017 20:39:20 +0300
Message-ID: <1487266760-80500-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1487266760-80500-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1487266760-80500-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] qmp-events: fix GUEST_PANICKED description
 formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@openvz.org, anton.nefedov@virtuozzo.com

also remove a useless NULL check in the event reporting code

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qapi/event.json |  4 ++--
 vl.c            | 22 ++++++++++------------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/qapi/event.json b/qapi/event.json
index 970ff02..e02852c 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -488,9 +488,9 @@
 #
 # @action: action that has been taken, currently always "pause"
 #
-# @info: optional information about a panic
+# @info: #optional information about a panic (since 2.9)
 #
-# Since: 1.5 (@info since 2.9)
+# Since: 1.5
 #
 # Example:
 #
diff --git a/vl.c b/vl.c
index 903c46d..f410e03 100644
--- a/vl.c
+++ b/vl.c
@@ -1710,6 +1710,15 @@ void qemu_system_reset(bool report)
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
+    if (info && info->type == GUEST_PANIC_INFORMATION_KIND_HYPER_V) {
+        qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
+                      " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
+                      info->u.hyper_v.data->arg1,
+                      info->u.hyper_v.data->arg2,
+                      info->u.hyper_v.data->arg3,
+                      info->u.hyper_v.data->arg4,
+                      info->u.hyper_v.data->arg5);
+    }
 
     if (current_cpu) {
         current_cpu->crash_occurred = true;
@@ -1723,18 +1732,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
         qemu_system_shutdown_request();
     }
 
-    if (info) {
-        if (info->type == GUEST_PANIC_INFORMATION_KIND_HYPER_V) {
-            qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
-                          " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
-                          info->u.hyper_v.data->arg1,
-                          info->u.hyper_v.data->arg2,
-                          info->u.hyper_v.data->arg3,
-                          info->u.hyper_v.data->arg4,
-                          info->u.hyper_v.data->arg5);
-        }
-        qapi_free_GuestPanicInformation(info);
-    }
+    qapi_free_GuestPanicInformation(info);
 }
 
 void qemu_system_reset_request(void)
-- 
2.7.4
