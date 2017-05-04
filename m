Received: from eggs.gnu.org ([2001:4830:134:3::10]:34635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1u-0001UE-0T
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1p-0004Y7-HQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1p-0004XV-BA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:21 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:42 +0200
Message-Id: <20170504071811.3547-2-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 01/30] hw/audio: replace exit with unrealize in
 hda_codec_device_class_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <tgnyang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Zihan Yang <tgnyang@gmail.com>

The exit callback of DeviceClass will be removed in the future, so
convert to unrealize in the init functioin

Signed-off-by: Zihan Yang <tgnyang@gmail.com>
Message-id: 1493211188-24086-4-git-send-email-tgnyang@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/intel-hda.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 537face94d..2c497eb174 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -70,7 +70,7 @@ static void hda_codec_dev_realize(DeviceState *qdev, Error **errp)
     }
 }
 
-static int hda_codec_dev_exit(DeviceState *qdev)
+static void hda_codec_dev_unrealize(DeviceState *qdev, Error **errp)
 {
     HDACodecDevice *dev = HDA_CODEC_DEVICE(qdev);
     HDACodecDeviceClass *cdc = HDA_CODEC_DEVICE_GET_CLASS(dev);
@@ -78,7 +78,6 @@ static int hda_codec_dev_exit(DeviceState *qdev)
     if (cdc->exit) {
         cdc->exit(dev);
     }
-    return 0;
 }
 
 HDACodecDevice *hda_codec_find(HDACodecBus *bus, uint32_t cad)
@@ -1318,7 +1317,7 @@ static void hda_codec_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->realize = hda_codec_dev_realize;
-    k->exit = hda_codec_dev_exit;
+    k->unrealize = hda_codec_dev_unrealize;
     set_bit(DEVICE_CATEGORY_SOUND, k->categories);
     k->bus_type = TYPE_HDA_BUS;
     k->props = hda_props;
-- 
2.9.3
