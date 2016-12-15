Received: from eggs.gnu.org ([2001:4830:134:3::10]:51030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cHWgg-00063t-2W
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cHWgZ-0005sU-Q6
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:07:10 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <skiver.cloud.yzy@gmail.com>)
	id 1cHWgZ-0005lB-Jl
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:07:03 -0500
Received: by mail-pg0-f67.google.com with SMTP id e9so6326472pgc.1
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 06:06:41 -0800 (PST)
From: skiver.cloud.yzy@gmail.com
Date: Thu, 15 Dec 2016 22:04:53 +0800
Message-Id: <1481810693-13733-1-git-send-email-skiver.cloud.yzy@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/block/pflash_cfi*.c: fix confusing assert
 fail message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ziyue Yang <yzylivezh@hotmail.com>, Ziyue Yang <skiver.cloud.yzy@gmail.com>

From: Ziyue Yang <yzylivezh@hotmail.com>

The patch is to fix the confusing assert fail message caused by
un-initialized device structure (from bite sized tasks).

The bug can be reproduced by

./qemu-system-x86_64 -nographic -device cfi.pflash01

The CFI hardware is dynamically loaded by QOM realizing mechanism,
however the realizing function in pflash_cfi01_realize function
requires the device being initialized manually before calling, like

./qemu-system-x86_64 -nographic
-device cfi.pflash01,num-blocks=1024,sector-length=4096,name=testcard

Once the initializing parameters are left off in the command, it will
leave the device structure not initialized, which makes
pflash_cfi01_realize try to realize a zero-volume card, causing

/mnt/EXT_volume/projects/qemu/qemu-dev/exec.c:1378:
find_ram_offset: Assertion `size != 0\' failed.

Through my test, at least the flash device's block-number, sector-length
and its name is needed for pflash_cfi01_realize to behave correctly. So
I think the new asserts are needed to hint the QEMU user to specify
the device's parameters correctly.

Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>
---
 hw/block/pflash_cfi01.c | 13 +++++++++++++
 hw/block/pflash_cfi02.c | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 62d7a56..5f0ee9d 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -707,6 +707,19 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     int num_devices;
     Error *local_err = NULL;
 
+    if (pfl->sector_len == 0) {
+        error_setg(errp, "attribute \"sector-length\" not specified or zero.");
+        return;
+    }
+    if (pfl->nb_blocs == 0) {
+        error_setg(errp, "attribute \"num-blocks\" not specified or zero.");
+        return;
+    }
+    if (pfl->name == NULL) {
+        error_setg(errp, "attribute \"name\" not specified.");
+        return;
+    }
+
     total_len = pfl->sector_len * pfl->nb_blocs;
 
     /* These are only used to expose the parameters of each device
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 4f6105c..ef71322 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -600,6 +600,19 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     int ret;
     Error *local_err = NULL;
 
+    if (pfl->sector_len == 0) {
+        error_setg(errp, "attribute \"sector-length\" not specified or zero.");
+        return;
+    }
+    if (pfl->nb_blocs == 0) {
+        error_setg(errp, "attribute \"num-blocks\" not specified or zero.");
+        return;
+    }
+    if (pfl->name == NULL) {
+        error_setg(errp, "attribute \"name\" not specified.");
+        return;
+    }
+
     chip_len = pfl->sector_len * pfl->nb_blocs;
     /* XXX: to be fixed */
 #if 0
-- 
2.1.4
