Received: from eggs.gnu.org ([2001:4830:134:3::10]:43128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDJ-0003qF-SZ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDH-0000QJ-O3
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:45 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gDNDH-0000NT-En
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:43 -0400
Received: by mail-pl1-x641.google.com with SMTP id y11-v6so15349089plt.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:20:43 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Oct 2018 22:20:12 -0700
Message-Id: <1539926412-21831-8-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 7/7] vfio: platform: destory mutex in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/vfio/platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index ba19143..e9d9e80 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -668,7 +668,7 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
             error_setg(errp, "%s", gerr->message);
             g_error_free(gerr);
             g_free(path);
-            return;
+            goto out;
         }
         g_free(path);
         vdev->compat = contents;
@@ -691,6 +691,8 @@ out:
         return;
     }
 
+    qemu_mutex_destroy(&vdev->intp_mutex);
+
     if (vdev->vbasedev.name) {
         error_prepend(errp, ERR_PREFIX, vdev->vbasedev.name);
     } else {
-- 
1.8.3.1
