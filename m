Received: from eggs.gnu.org ([2001:4830:134:3::10]:34421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0F-0002nk-Re
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0D-00055r-86
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dOM0D-00055Y-07
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E98C0303154
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 10:39:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Jun 2017 12:39:43 +0200
Message-Id: <20170623103945.7014-6-kraxel@redhat.com>
In-Reply-To: <20170623103945.7014-1-kraxel@redhat.com>
References: <20170623103945.7014-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] ps2: add and use PS2State typedef
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

Cleanup: Create and use a typedef for PS2State and stop passing void
pointers.  No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170606112105.13331-2-kraxel@redhat.com
---
 include/hw/input/ps2.h  |  4 ++--
 include/qemu/typedefs.h |  1 +
 hw/input/ps2.c          | 12 +++++-------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/hw/input/ps2.h b/include/hw/input/ps2.h
index 7f0a80af9d..94709b8502 100644
--- a/include/hw/input/ps2.h
+++ b/include/hw/input/ps2.h
@@ -36,8 +36,8 @@ void *ps2_kbd_init(void (*update_irq)(void *, int), void *update_arg);
 void *ps2_mouse_init(void (*update_irq)(void *, int), void *update_arg);
 void ps2_write_mouse(void *, int val);
 void ps2_write_keyboard(void *, int val);
-uint32_t ps2_read_data(void *);
-void ps2_queue(void *, int b);
+uint32_t ps2_read_data(PS2State *s);
+void ps2_queue(PS2State *s, int b);
 void ps2_keyboard_set_translation(void *opaque, int mode);
 void ps2_mouse_fake_event(void *opaque);
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index f745d5faf7..2706aabedf 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -76,6 +76,7 @@ typedef struct PixelFormat PixelFormat;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
+typedef struct PS2State PS2State;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
 typedef struct QEMUFile QEMUFile;
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 1d3a440bbd..37f8cb842e 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -85,12 +85,12 @@ typedef struct {
     int rptr, wptr, count;
 } PS2Queue;
 
-typedef struct {
+struct PS2State {
     PS2Queue queue;
     int32_t write_cmd;
     void (*update_irq)(void *, int);
     void *update_arg;
-} PS2State;
+};
 
 typedef struct {
     PS2State common;
@@ -551,9 +551,8 @@ static uint8_t translate_table[256] = {
     0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
 };
 
-void ps2_queue(void *opaque, int b)
+void ps2_queue(PS2State *s, int b)
 {
-    PS2State *s = (PS2State *)opaque;
     PS2Queue *q = &s->queue;
 
     if (q->count >= PS2_QUEUE_SIZE - 1)
@@ -692,13 +691,12 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
     }
 }
 
-uint32_t ps2_read_data(void *opaque)
+uint32_t ps2_read_data(PS2State *s)
 {
-    PS2State *s = (PS2State *)opaque;
     PS2Queue *q;
     int val, index;
 
-    trace_ps2_read_data(opaque);
+    trace_ps2_read_data(s);
     q = &s->queue;
     if (q->count == 0) {
         /* NOTE: if no data left, we return the last keyboard one
-- 
2.9.3
