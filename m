Received: from eggs.gnu.org ([2001:4830:134:3::10]:44921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFerN-0007Nv-HB
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFerI-0000UB-Ir
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:03:17 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:49522)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFerI-0000Te-0X
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:03:12 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
	by mail1.hostfission.com (Postfix) with ESMTP id A669C43ED6
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 22:03:10 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 07 May 2018 22:03:10 +1000
From: geoff@hostfission.com
Message-ID: <fcafae5827cc7fab7b98b9afaf73e08a@hostfission.com>
Subject: [Qemu-devel] [PATCH 2/2] ps2: Fix mouse stream corruption due to
 lost data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This fixes an issue by adding bounds checking to multi-byte packets
where the PS/2 mouse data stream may become corrupted due to data
being discarded when the PS/2 ringbuffer is full.

Interrupts for Multi-byte responses are postponed until the final
byte has been queued.

These changes fix a bug where windows guests drop the mouse device
entirely requring the guest to be restarted.

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
---
  hw/input/pckbd.c |   6 +--
  hw/input/ps2.c   | 160 
+++++++++++++++++++++++++++++++++++++------------------
  2 files changed, 110 insertions(+), 56 deletions(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index f17f18e51b..004ea3466d 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -216,9 +216,9 @@ static uint64_t kbd_read_status(void *opaque, hwaddr 
addr,
  static void kbd_queue(KBDState *s, int b, int aux)
  {
      if (aux)
-        ps2_queue(s->mouse, b);
+        ps2_queue_raise(s->mouse, b);
      else
-        ps2_queue(s->kbd, b);
+        ps2_queue_raise(s->kbd, b);
  }

  static void outport_write(KBDState *s, uint32_t val)
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 6edf046820..011290920f 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -192,12 +192,50 @@ void ps2_queue(PS2State *s, int b)
  {
      PS2Queue *q = &s->queue;

-    if (q->count >= PS2_QUEUE_SIZE - 1)
+    if (q->count == PS2_QUEUE_SIZE)
+    {
+        printf("Warning! PS2 Queue Overflow!\n");
          return;
+    }
+
      q->data[q->wptr] = b;
      if (++q->wptr == PS2_QUEUE_SIZE)
          q->wptr = 0;
      q->count++;
+}
+
+void ps2_raise(PS2State *s)
+{
+    s->update_irq(s->update_arg, 1);
+}
+
+void ps2_queue_raise(PS2State *s, int b)
+{
+    ps2_queue(s, b);
+    s->update_irq(s->update_arg, 1);
+}
+
+void ps2_queue_bytes(PS2State *s, const int length, ...)
+{
+    PS2Queue *q = &s->queue;
+
+    if (PS2_QUEUE_SIZE - q->count < length) {
+        printf("Unable to send %d bytes, buffer full\n", length);
+        return;
+    }
+
+    va_list args;
+    va_start(args, length);
+
+    for(int i = 0; i < length; ++i)
+    {
+        q->data[q->wptr] = va_arg(args, int);
+        if (++q->wptr == PS2_QUEUE_SIZE)
+            q->wptr = 0;
+        q->count++;
+    }
+
+    va_end(args);
      s->update_irq(s->update_arg, 1);
  }

@@ -213,13 +251,13 @@ static void ps2_put_keycode(void *opaque, int 
keycode)
          if (keycode == 0xf0) {
              s->need_high_bit = true;
          } else if (s->need_high_bit) {
-            ps2_queue(&s->common, translate_table[keycode] | 0x80);
+            ps2_queue_raise(&s->common, translate_table[keycode] | 
0x80);
              s->need_high_bit = false;
          } else {
-            ps2_queue(&s->common, translate_table[keycode]);
+            ps2_queue_raise(&s->common, translate_table[keycode]);
          }
      } else {
-        ps2_queue(&s->common, keycode);
+        ps2_queue_raise(&s->common, keycode);
      }
  }

@@ -490,72 +528,80 @@ void ps2_write_keyboard(void *opaque, int val)
      case -1:
          switch(val) {
          case 0x00:
-            ps2_queue(&s->common, KBD_REPLY_ACK);
+            ps2_queue_raise(&s->common, KBD_REPLY_ACK);
              break;
          case 0x05:
-            ps2_queue(&s->common, KBD_REPLY_RESEND);
+            ps2_queue_raise(&s->common, KBD_REPLY_RESEND);
              break;
          case KBD_CMD_GET_ID:
-            ps2_queue(&s->common, KBD_REPLY_ACK);
              /* We emulate a MF2 AT keyboard here */
-            ps2_queue(&s->common, KBD_REPLY_ID);
              if (s->translate)
-                ps2_queue(&s->common, 0x41);
+                ps2_queue_bytes(&s->common, 3,
+                    KBD_REPLY_ACK,
+                    KBD_REPLY_ID,
+                    0x41);
              else
-                ps2_queue(&s->common, 0x83);
+                ps2_queue_bytes(&s->common, 3,
+                    KBD_REPLY_ACK,
+                    KBD_REPLY_ID,
+                    0x83);
              break;
          case KBD_CMD_ECHO:
-            ps2_queue(&s->common, KBD_CMD_ECHO);
+            ps2_queue_raise(&s->common, KBD_CMD_ECHO);
              break;
          case KBD_CMD_ENABLE:
              s->scan_enabled = 1;
-            ps2_queue(&s->common, KBD_REPLY_ACK);
+            ps2_queue_raise(&s->common, KBD_REPLY_ACK);
              break;
          case KBD_CMD_SCANCODE:
          case KBD_CMD_SET_LEDS:
          case KBD_CMD_SET_RATE:
              s->common.write_cmd = val;
-            ps2_queue(&s->common, KBD_REPLY_ACK);
+            ps2_queue_raise(&s->common, KBD_REPLY_ACK);
              break;
          case KBD_CMD_RESET_DISABLE:
              ps2_reset_keyboard(s);
              s->scan_enabled = 0;
-            ps2_queue(&s->common, KBD_REPLY_ACK);
+            ps2_queue_raise(&s->common, KBD_REPLY_ACK);
              break;
          case KBD_CMD_RESET_ENABLE:
              ps2_reset_keyboard(s);
              s->scan_enabled = 1;
-            ps2_queue(&s->common, KBD_REPLY_ACK);
+            ps2_queue_raise(&s->common, KBD_REPLY_ACK);
              break;
          case KBD_CMD_RESET:
              ps2_reset_keyboard(s);
-            ps2_queue(&s->common, KBD_REPLY_ACK);
-            ps2_queue(&s->common, KBD_REPLY_POR);
+            ps2_queue_bytes(&s->common, 2,
+                KBD_REPLY_ACK,
+                KBD_REPLY_POR);
              break;
          default:
-            ps2_queue(&s->common, KBD_REPLY_RESEND);
+            ps2_queue_raise(&s->common, KBD_REPLY_RESEND);
              break;
          }
          break;
      case KBD_CMD_SCANCODE:
          if (val == 0) {
-            ps2_queue(&s->common, KBD_REPLY_ACK);
-            ps2_put_keycode(s, s->scancode_set);
+            if (s->common.queue.count <= PS2_QUEUE_SIZE - 2)
+            {
+                ps2_queue_raise(&s->common, KBD_REPLY_ACK);
+                ps2_put_keycode(s, s->scancode_set);
+            }
          } else if (val >= 1 && val <= 3) {
              s->scancode_set = val;
-            ps2_queue(&s->common, KBD_REPLY_ACK);
+            ps2_queue_raise(&s->common, KBD_REPLY_ACK);
          } else {
-            ps2_queue(&s->common, KBD_REPLY_RESEND);
+            ps2_queue_raise(&s->common, KBD_REPLY_RESEND);
          }
          s->common.write_cmd = -1;
          break;
      case KBD_CMD_SET_LEDS:
          ps2_set_ledstate(s, val);
-        ps2_queue(&s->common, KBD_REPLY_ACK);
+        ps2_queue_raise(&s->common, KBD_REPLY_ACK);
          s->common.write_cmd = -1;
          break;
      case KBD_CMD_SET_RATE:
-        ps2_queue(&s->common, KBD_REPLY_ACK);
+        ps2_queue_raise(&s->common, KBD_REPLY_ACK);
          s->common.write_cmd = -1;
          break;
      }
@@ -572,11 +618,15 @@ void ps2_keyboard_set_translation(void *opaque, 
int mode)
      s->translate = mode;
  }

-static void ps2_mouse_send_packet(PS2MouseState *s)
+static int ps2_mouse_send_packet(PS2MouseState *s)
  {
      unsigned int b;
      int dx1, dy1, dz1;

+    const int needed = 3 + (s->mouse_type - 2);
+    if (PS2_QUEUE_SIZE - s->common.queue.count < needed)
+        return 0;
+
      dx1 = s->mouse_dx;
      dy1 = s->mouse_dy;
      dz1 = s->mouse_dz;
@@ -614,11 +664,15 @@ static void ps2_mouse_send_packet(PS2MouseState 
*s)
          break;
      }

+    ps2_raise(&s->common);
+
      trace_ps2_mouse_send_packet(s, dx1, dy1, dz1, b);
      /* update deltas */
      s->mouse_dx -= dx1;
      s->mouse_dy -= dy1;
      s->mouse_dz -= dz1;
+
+    return 1;
  }

  static void ps2_mouse_event(DeviceState *dev, QemuConsole *src,
@@ -680,10 +734,7 @@ static void ps2_mouse_sync(DeviceState *dev)
          qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
      }
      if (!(s->mouse_status & MOUSE_STATUS_REMOTE)) {
-        while (s->common.queue.count < PS2_QUEUE_SIZE - 4) {
-            /* if not remote, send event. Multiple events are sent if
-               too big deltas */
-            ps2_mouse_send_packet(s);
+        while(ps2_mouse_send_packet(s)) {
              if (s->mouse_dx == 0 && s->mouse_dy == 0 && s->mouse_dz == 
0)
                  break;
          }
@@ -713,66 +764,68 @@ void ps2_write_mouse(void *opaque, int val)
          if (s->mouse_wrap) {
              if (val == AUX_RESET_WRAP) {
                  s->mouse_wrap = 0;
-                ps2_queue(&s->common, AUX_ACK);
+                ps2_queue_raise(&s->common, AUX_ACK);
                  return;
              } else if (val != AUX_RESET) {
-                ps2_queue(&s->common, val);
+                ps2_queue_raise(&s->common, val);
                  return;
              }
          }
          switch(val) {
          case AUX_SET_SCALE11:
              s->mouse_status &= ~MOUSE_STATUS_SCALE21;
-            ps2_queue(&s->common, AUX_ACK);
+            ps2_queue_raise(&s->common, AUX_ACK);
              break;
          case AUX_SET_SCALE21:
              s->mouse_status |= MOUSE_STATUS_SCALE21;
-            ps2_queue(&s->common, AUX_ACK);
+            ps2_queue_raise(&s->common, AUX_ACK);
              break;
          case AUX_SET_STREAM:
              s->mouse_status &= ~MOUSE_STATUS_REMOTE;
-            ps2_queue(&s->common, AUX_ACK);
+            ps2_queue_raise(&s->common, AUX_ACK);
              break;
          case AUX_SET_WRAP:
              s->mouse_wrap = 1;
-            ps2_queue(&s->common, AUX_ACK);
+            ps2_queue_raise(&s->common, AUX_ACK);
              break;
          case AUX_SET_REMOTE:
              s->mouse_status |= MOUSE_STATUS_REMOTE;
-            ps2_queue(&s->common, AUX_ACK);
+            ps2_queue_raise(&s->common, AUX_ACK);
              break;
          case AUX_GET_TYPE:
-            ps2_queue(&s->common, AUX_ACK);
-            ps2_queue(&s->common, s->mouse_type);
+            ps2_queue_bytes(&s->common, 2,
+                AUX_ACK,
+                s->mouse_type);
              break;
          case AUX_SET_RES:
          case AUX_SET_SAMPLE:
              s->common.write_cmd = val;
-            ps2_queue(&s->common, AUX_ACK);
+            ps2_queue_raise(&s->common, AUX_ACK);
              break;
          case AUX_GET_SCALE:
-            ps2_queue(&s->common, AUX_ACK);
-            ps2_queue(&s->common, s->mouse_status);
-            ps2_queue(&s->common, s->mouse_resolution);
-            ps2_queue(&s->common, s->mouse_sample_rate);
+            ps2_queue_bytes(&s->common, 4,
+                AUX_ACK,
+                s->mouse_status,
+                s->mouse_resolution,
+                s->mouse_sample_rate);
              break;
          case AUX_POLL:
-            ps2_queue(&s->common, AUX_ACK);
+            ps2_queue_raise(&s->common, AUX_ACK);
              ps2_mouse_send_packet(s);
              break;
          case AUX_ENABLE_DEV:
              s->mouse_status |= MOUSE_STATUS_ENABLED;
-            ps2_queue(&s->common, AUX_ACK);
+            ps2_queue_raise(&s->common, AUX_ACK);
              break;
          case AUX_DISABLE_DEV:
              s->mouse_status &= ~MOUSE_STATUS_ENABLED;
-            ps2_queue(&s->common, AUX_ACK);
+            ps2_queue_raise(&s->common, AUX_ACK);
              break;
          case AUX_SET_DEFAULT:
              s->mouse_sample_rate = 100;
              s->mouse_resolution = 2;
              s->mouse_status = 0;
-            ps2_queue(&s->common, AUX_ACK);
+            ps2_queue_raise(&s->common, AUX_ACK);
              break;
          case AUX_RESET:
              s->mouse_sample_rate = 100;
@@ -780,9 +833,10 @@ void ps2_write_mouse(void *opaque, int val)
              s->mouse_status = 0;
              s->mouse_type = 0;
              ps2_reset_queue(&s->common);
-            ps2_queue(&s->common, AUX_ACK);
-            ps2_queue(&s->common, 0xaa);
-            ps2_queue(&s->common, s->mouse_type);
+            ps2_queue_bytes(&s->common, 3,
+                AUX_ACK,
+                0xaa,
+                s->mouse_type);
              break;
          default:
              break;
@@ -816,12 +870,12 @@ void ps2_write_mouse(void *opaque, int val)
              s->mouse_detect_state = 0;
              break;
          }
-        ps2_queue(&s->common, AUX_ACK);
+        ps2_queue_raise(&s->common, AUX_ACK);
          s->common.write_cmd = -1;
          break;
      case AUX_SET_RES:
          s->mouse_resolution = val;
-        ps2_queue(&s->common, AUX_ACK);
+        ps2_queue_raise(&s->common, AUX_ACK);
          s->common.write_cmd = -1;
          break;
      }
-- 
2.14.2
