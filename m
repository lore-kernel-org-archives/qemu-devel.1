Received: from eggs.gnu.org ([2001:4830:134:3::10]:35216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1fQv7o-0006uz-TG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1fQv7o-0005bZ-2P
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:38:48 -0400
From: Jia He <hejianet@gmail.com>
Date: Thu,  7 Jun 2018 21:38:04 +0800
Message-Id: <1528378684-14487-1-git-send-email-hejianet@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/arm/smmuv3: fix smmu emulation when guest
 smmu is in passthrough mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jia He <hejianet@gmail.com>, jia.he@hxt-semitech.com

There is an exception when I passes iommu.passthrough=1 to guest's
kernel boot parameter(host QDF2400 kernel 4.17, guest kernel 4.14).
The guest will be hang when booting up.

When guest smmu is in passthrough mode, entry.perm will not be assigned
to flag in smmuv3_translate. It seems not be correct.

After this patch, I have tested in 4 cases and all passed.
host smmu on/passthrough + guest smmu on/passthrough

Signed-off-by: jia.he@hxt-semitech.com
---
 hw/arm/smmuv3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 42dc521..5c46102 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -560,6 +560,12 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     }
 
     ret = smmuv3_decode_config(mr, &cfg, &event);
+
+    if (cfg.bypassed) {
+        ret = 0;
+        goto out;
+    }
+
     if (ret) {
         goto out;
     }
-- 
1.8.3.1
