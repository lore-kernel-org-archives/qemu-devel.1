Received: from eggs.gnu.org ([208.118.235.92]:52718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAkV-0000QO-9Y
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAkJ-0003rd-Hh
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:15 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAkI-0003mI-Vz
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:11 -0500
Received: by mail-wr1-x443.google.com with SMTP id r10so10088349wrs.10
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:53:10 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:52:26 +0100
Message-Id: <cf9372980bcb6e798c885780bdffc55f624e4e3f.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 50/52] usb-audio: do not count on avail
 bytes actually available
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

This assumption is no longer true when mixeng is turned off.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 hw/usb/dev-audio.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 589977d96c..510585ad7a 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -318,27 +318,28 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p)
 {
     uint32_t free = buf->size - (buf->prod - buf->cons);
 
-    if (!free) {
+    if (free < USBAUDIO_PACKET_SIZE) {
         return 0;
     }
-    assert(free >= USBAUDIO_PACKET_SIZE);
+
     usb_packet_copy(p, buf->data + (buf->prod % buf->size),
                     USBAUDIO_PACKET_SIZE);
     buf->prod += USBAUDIO_PACKET_SIZE;
     return USBAUDIO_PACKET_SIZE;
 }
 
-static uint8_t *streambuf_get(struct streambuf *buf)
+static uint8_t *streambuf_get(struct streambuf *buf, size_t *len)
 {
     uint32_t used = buf->prod - buf->cons;
     uint8_t *data;
 
     if (!used) {
+        *len = 0;
         return NULL;
     }
-    assert(used >= USBAUDIO_PACKET_SIZE);
     data = buf->data + (buf->cons % buf->size);
-    buf->cons += USBAUDIO_PACKET_SIZE;
+    *len = MIN(buf->prod - buf->cons,
+               buf->size - (buf->cons % buf->size));
     return data;
 }
 
@@ -370,16 +371,21 @@ static void output_callback(void *opaque, int avail)
     USBAudioState *s = opaque;
     uint8_t *data;
 
-    for (;;) {
-        if (avail < USBAUDIO_PACKET_SIZE) {
-            return;
-        }
-        data = streambuf_get(&s->out.buf);
+    while (avail) {
+        size_t written, len;
+
+        data = streambuf_get(&s->out.buf, &len);
         if (!data) {
             return;
         }
-        AUD_write(s->out.voice, data, USBAUDIO_PACKET_SIZE);
-        avail -= USBAUDIO_PACKET_SIZE;
+
+        written = AUD_write(s->out.voice, data, len);
+        avail -= written;
+        s->out.buf.cons += written;
+
+        if (written < len) {
+            return;
+        }
     }
 }
 
-- 
2.20.1
