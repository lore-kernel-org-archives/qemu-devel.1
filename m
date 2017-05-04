Received: from eggs.gnu.org ([2001:4830:134:3::10]:34624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1t-0001U6-VB
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1p-0004Xl-68
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1o-0004XL-W2
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:21 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:43 +0200
Message-Id: <20170504071811.3547-3-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 02/30] hw/audio: convert exit callback in
 HDACodecDeviceClass to void
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

The exit callback always return 0, convert it to void

Signed-off-by: Zihan Yang <tgnyang@gmail.com>
Message-id: 1493211188-24086-5-git-send-email-tgnyang@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/intel-hda.h | 2 +-
 hw/audio/hda-codec.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/audio/intel-hda.h b/hw/audio/intel-hda.h
index d784bcf5fc..53b78da4df 100644
--- a/hw/audio/intel-hda.h
+++ b/hw/audio/intel-hda.h
@@ -38,7 +38,7 @@ typedef struct HDACodecDeviceClass
     DeviceClass parent_class;
 
     int (*init)(HDACodecDevice *dev);
-    int (*exit)(HDACodecDevice *dev);
+    void (*exit)(HDACodecDevice *dev);
     void (*command)(HDACodecDevice *dev, uint32_t nid, uint32_t data);
     void (*stream)(HDACodecDevice *dev, uint32_t stnr, bool running, bool output);
 } HDACodecDeviceClass;
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 52d4640e60..5402cd196c 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -520,7 +520,7 @@ static int hda_audio_init(HDACodecDevice *hda, const struct desc_codec *desc)
     return 0;
 }
 
-static int hda_audio_exit(HDACodecDevice *hda)
+static void hda_audio_exit(HDACodecDevice *hda)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
     HDAAudioStream *st;
@@ -539,7 +539,6 @@ static int hda_audio_exit(HDACodecDevice *hda)
         }
     }
     AUD_remove_card(&a->card);
-    return 0;
 }
 
 static int hda_audio_post_load(void *opaque, int version)
-- 
2.9.3
