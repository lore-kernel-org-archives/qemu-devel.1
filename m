Received: from eggs.gnu.org ([2001:4830:134:3::10]:36812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d3MS3-0006Ja-Gx
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d3MS2-0005VH-Ld
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:53:47 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgnyang@gmail.com>) id 1d3MS2-0005VB-Gt
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:53:46 -0400
Received: by mail-pg0-x244.google.com with SMTP id 72so2625218pge.2
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 05:53:46 -0700 (PDT)
From: Zihan Yang <tgnyang@gmail.com>
Date: Wed, 26 Apr 2017 20:53:07 +0800
Message-Id: <1493211188-24086-4-git-send-email-tgnyang@gmail.com>
In-Reply-To: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
References: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
Subject: [Qemu-devel] [PATCH 4/5] hw/audio: replace exit with unrealize in
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

The exit callback of DeviceClass will be removed in the future, so
convert to unrealize in the init functioin

Signed-off-by: Zihan Yang <tgnyang@gmail.com>
---
 hw/audio/intel-hda.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 537face..2c497eb 100644
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
2.7.4
