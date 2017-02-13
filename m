Received: from eggs.gnu.org ([2001:4830:134:3::10]:43381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cdAl5-0001kA-Tm
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cdAl2-0008FE-RI
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:09:11 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:11395 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cdAl2-0008Ee-Fi
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:09:08 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 13 Feb 2017 10:09:02 +0300
Message-Id: <1486969742-16539-4-git-send-email-den@openvz.org>
In-Reply-To: <1486969742-16539-1-git-send-email-den@openvz.org>
References: <1486969742-16539-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH v3 3/3] vl: log available guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

There is a suitable log mask for the purpose.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 vl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/vl.c b/vl.c
index d5a183f..873aa4e 100644
--- a/vl.c
+++ b/vl.c
@@ -1709,6 +1709,8 @@ void qemu_system_reset(bool report)
 
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
+
     if (current_cpu) {
         current_cpu->crash_occurred = true;
     }
@@ -1723,6 +1725,13 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
 
     if (info) {
         if (info->type == GUEST_PANIC_INFORMATION_KIND_HYPER_V) {
+            qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
+                          " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
+                          info->u.hyper_v.data->arg1,
+                          info->u.hyper_v.data->arg2,
+                          info->u.hyper_v.data->arg3,
+                          info->u.hyper_v.data->arg4,
+                          info->u.hyper_v.data->arg5);
             g_free(info->u.hyper_v.data);
         }
         g_free(info);
-- 
2.7.4
