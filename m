Received: from eggs.gnu.org ([2001:4830:134:3::10]:47695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNej-0007TH-4c
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNeg-0006eh-02
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:06:41 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  8 Jun 2018 22:05:47 +0200
Message-Id: <20180608200558.386-3-laurent@vivier.eu>
In-Reply-To: <20180608200558.386-1-laurent@vivier.eu>
References: <20180608200558.386-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC 02/13] ADB: VIA probes ADB bus when it is idle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/input/adb-kbd.c     |  4 ++++
 hw/input/adb-mouse.c   |  4 ++++
 hw/input/adb.c         | 33 +++++++++++++++++++++++++--------
 hw/misc/mac_via.c      | 27 ++++++++++++++++++++++++++-
 include/hw/input/adb.h |  1 +
 5 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 50b62712c8..7de92935b8 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -195,6 +195,10 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
     int keycode;
     int olen;
 
+    if (obuf == NULL) {
+        return s->count;
+    }
+
     olen = 0;
     if (s->count == 0) {
         return 0;
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 3ba6027d33..a3f0b74dd1 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -73,6 +73,10 @@ static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
         return 0;
     }
 
+    if (obuf == NULL) {
+        return 2;
+    }
+
     dx = s->dx;
     if (dx < -63) {
         dx = -63;
diff --git a/hw/input/adb.c b/hw/input/adb.c
index 2e5460730c..756122ac09 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -94,28 +94,47 @@ int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
     return olen;
 }
 
+int adb_via_poll(ADBBusState *adb, int state, uint8_t *data)
+{
+    if (state != STATE_IDLE) {
+        return 0;
+    }
+    if (adb->data_in_size < adb->data_in_index) {
+        return 0;
+    }
+    if (adb->data_out_index != 0) {
+        return 0;
+    }
+    adb->data_in_index = 0;
+    adb->data_out_index = 0;
+    adb->data_in_size = adb_poll(adb, adb->data_in, 0xffff);
+    if (adb->data_in_size) {
+        *data = adb->data_in[adb->data_in_index++];
+        qemu_irq_raise(adb->data_ready);
+    }
+    return adb->data_in_size;
+}
+
 int adb_send(ADBBusState *adb, int state, uint8_t data)
 {
     switch (state) {
     case STATE_NEW:
-        adb->data_out[0] = data;
-        adb->data_out_index = 1;
+        adb->data_out_index = 0;
         break;
     case STATE_EVEN:
         if ((adb->data_out_index & 1) == 0) {
             return 0;
         }
-        adb->data_out[adb->data_out_index++] = data;
         break;
     case STATE_ODD:
         if (adb->data_out_index & 1) {
             return 0;
         }
-        adb->data_out[adb->data_out_index++] = data;
         break;
     case STATE_IDLE:
         return 0;
     }
+    adb->data_out[adb->data_out_index++] = data;
     qemu_irq_raise(adb->data_ready);
     return 1;
 }
@@ -138,7 +157,6 @@ int adb_receive(ADBBusState *adb, int state, uint8_t *data)
         if ((adb->data_in_index & 1) == 0) {
             return 0;
         }
-        *data = adb->data_in[adb->data_in_index++];
         break;
     case STATE_ODD:
         if (adb->data_in_size <= 0) {
@@ -153,7 +171,6 @@ int adb_receive(ADBBusState *adb, int state, uint8_t *data)
         if (adb->data_in_index & 1) {
             return 0;
         }
-        *data = adb->data_in[adb->data_in_index++];
         break;
     case STATE_IDLE:
         if (adb->data_out_index == 0) {
@@ -162,6 +179,7 @@ int adb_receive(ADBBusState *adb, int state, uint8_t *data)
         adb->data_in_size = adb_request(adb, adb->data_in,
                                         adb->data_out, adb->data_out_index);
         adb->data_out_index = 0;
+        adb->data_in_index = 0;
         if (adb->data_in_size < 0) {
             *data = 0xff;
             qemu_irq_raise(adb->data_ready);
@@ -170,10 +188,9 @@ int adb_receive(ADBBusState *adb, int state, uint8_t *data)
         if (adb->data_in_size == 0) {
             return 0;
         }
-        *data = adb->data_in[0];
-        adb->data_in_index = 1;
         break;
     }
+    *data = adb->data_in[adb->data_in_index++];
     qemu_irq_raise(adb->data_ready);
     if (*data == 0xff || *data == 0) {
         return 0;
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index a6a11c5b3d..055091535f 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -247,6 +247,8 @@
 #define VIA1B_vADB_StateMask    (VIA1B_vADBS1 | VIA1B_vADBS2)
 #define VIA1B_vADB_StateShift   4
 
+#define VIA_ADB_POLL_FREQ 50 /* XXX: not real */
+
 typedef struct VIATimer {
     int index;
     uint16_t counter; /* Timer counter */
@@ -305,6 +307,7 @@ typedef struct MacVIAState {
     /* ADB */
 
     ADBBusState adb_bus;
+    QEMUTimer *adb_poll_timer;
 
     /* external timers */
 
@@ -596,7 +599,7 @@ static void via1_adb_update(MacVIAState *m)
     } else {
         /* input mode */
         ret = adb_receive(&m->adb_bus, state, &s->sr);
-        if (ret > 0) {
+        if (ret > 0 && s->sr != 0xff) {
             s->b &= ~VIA1B_vADBInt;
         } else {
             s->b |= VIA1B_vADBInt;
@@ -604,6 +607,23 @@ static void via1_adb_update(MacVIAState *m)
     }
 }
 
+static void via_adb_poll(void *opaque)
+{
+    MacVIAState *m = opaque;
+    VIAState *s = &m->via[0];
+    int state;
+
+    if (s->b & VIA1B_vADBInt) {
+        state = (s->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+        if (adb_via_poll(&m->adb_bus, state, &s->sr)) {
+            s->b &= ~VIA1B_vADBInt;
+        }
+    }
+    timer_mod(m->adb_poll_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
+}
+
 static void via_write(void *opaque, hwaddr addr,
                        uint64_t val, unsigned int size)
 {
@@ -858,6 +878,10 @@ static void mac_via_reset(DeviceState *dev)
     m->cmd = 0;
     m->wprotect = 0;
     m->alt = 0;
+
+    timer_mod(m->adb_poll_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
 }
 
 static void mac_via_realizefn(DeviceState *dev, Error **errp)
@@ -872,6 +896,7 @@ static void mac_via_realizefn(DeviceState *dev, Error **errp)
 
     qemu_get_timedate(&tm, 0);
     m->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
+    m->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via_adb_poll, m);
 
     /* ouput IRQs */
 
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index ce393004eb..9ef7fa2f0e 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -90,6 +90,7 @@ int adb_poll(ADBBusState *s, uint8_t *buf_out, uint16_t poll_mask);
 #define TYPE_ADB_KEYBOARD "adb-keyboard"
 #define TYPE_ADB_MOUSE "adb-mouse"
 
+int adb_via_poll(ADBBusState *s, int state, uint8_t *data);
 int adb_send(ADBBusState *adb, int state, uint8_t data);
 int adb_receive(ADBBusState *adb, int state, uint8_t *data);
 #endif /* ADB_H */
-- 
2.14.4
