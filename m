Received: from eggs.gnu.org ([2001:4830:134:3::10]:52099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN71-0004Ad-Lp
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN70-0008Oi-TH
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:47 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN70-0008ON-Mh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:46 -0500
Received: by mail-wr0-x241.google.com with SMTP id q39so2265874wrb.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:46 +0100
Message-Id: <1487255507-106654-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/23] vl: log available guest crash information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

There is a suitable log mask for the purpose.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-Id: <1487053524-18674-4-git-send-email-den@openvz.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/vl.c b/vl.c
index 5993270..27d9829 100644
--- a/vl.c
+++ b/vl.c
@@ -1681,6 +1681,8 @@ void qemu_system_reset(bool report)
 
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
+
     if (current_cpu) {
         current_cpu->crash_occurred = true;
     }
@@ -1694,6 +1696,15 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
     }
 
     if (info) {
+        if (info->type == GUEST_PANIC_INFORMATION_KIND_HYPER_V) {
+            qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
+                          " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
+                          info->u.hyper_v.data->arg1,
+                          info->u.hyper_v.data->arg2,
+                          info->u.hyper_v.data->arg3,
+                          info->u.hyper_v.data->arg4,
+                          info->u.hyper_v.data->arg5);
+        }
         qapi_free_GuestPanicInformation(info);
     }
 }
-- 
1.8.3.1
