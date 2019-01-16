Received: from eggs.gnu.org ([209.51.188.92]:58444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjulA-0004Sk-Vt
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul8-0003dU-NG
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:12 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul8-0003bb-Fw
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:10 -0500
Received: by mail-wm1-x343.google.com with SMTP id y139so3851887wmc.5
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:38:10 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:23 +0100
Message-Id: <161ea7f0cc7aaf032116cf9f137898deafa59ffb.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 50/50] usbaudio: change playback counters to
 64 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

With stereo playback, they need about 375 minutes of continuous audio
playback to overflow, which is usually not a problem (as stopping and
later resuming playback resets the counters).  But with 7.1 audio, they
only need about 95 minutes to overflow.

After the overflow, the buf->prod % USBAUDIO_PACKET_SIZE(channels)
assertion no longer holds true, which will result in overflowing the
buffer.  With 64 bit variables, it would take about 762000 years to
overflow.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 hw/usb/dev-audio.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index f7406da5a4..82bc6eb88f 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -577,9 +577,9 @@ static const USBDesc desc_audio_multi = {
 
 struct streambuf {
     uint8_t *data;
-    uint32_t size;
-    uint32_t prod;
-    uint32_t cons;
+    size_t size;
+    uint64_t prod;
+    uint64_t cons;
 };
 
 static void streambuf_init(struct streambuf *buf, uint32_t size,
@@ -600,7 +600,7 @@ static void streambuf_fini(struct streambuf *buf)
 
 static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
 {
-    uint32_t free = buf->size - (buf->prod - buf->cons);
+    int64_t free = buf->size - (buf->prod - buf->cons);
 
     if (free < USBAUDIO_PACKET_SIZE(channels)) {
         return 0;
@@ -609,6 +609,8 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
         return 0;
     }
 
+    /* can happen if prod overflows */
+    assert(buf->prod % USBAUDIO_PACKET_SIZE(channels) == 0);
     usb_packet_copy(p, buf->data + (buf->prod % buf->size),
                     USBAUDIO_PACKET_SIZE(channels));
     buf->prod += USBAUDIO_PACKET_SIZE(channels);
@@ -617,10 +619,10 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p, uint32_t channels)
 
 static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
 {
-    uint32_t used = buf->prod - buf->cons;
+    int64_t used = buf->prod - buf->cons;
     uint8_t *data;
 
-    if (!used) {
+    if (used <= 0) {
         *len = 0;
         return NULL;
     }
-- 
2.20.1
