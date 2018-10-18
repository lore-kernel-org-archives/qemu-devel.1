Received: from eggs.gnu.org ([2001:4830:134:3::10]:37684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gDD2u-0002vL-TV
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gDD2q-00028O-Fk
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:29:19 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 18 Oct 2018 19:28:47 +0100
Message-Id: <20181018182856.28001-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v4 02/11] hw/m68k: implement ADB bus support
 for via
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, yongbok.kim@mips.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

From: Laurent Vivier <laurent@vivier.eu>

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/input/adb.c            |   2 +
 hw/misc/mac_via.c         | 166 ++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/misc/mac_via.h |   7 ++
 3 files changed, 175 insertions(+)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index bbb40aeef1..d69ca74364 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -25,6 +25,8 @@
 #include "hw/input/adb.h"
 #include "adb-internal.h"
 
+#define ADB_POLL_FREQ 50
+
 /* error codes */
 #define ADB_RET_NOTPRESENT (-2)
 
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 084974a24d..1ec563a707 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -237,6 +237,11 @@
  * Table 19-10 ADB transaction states
  */
 
+#define ADB_STATE_NEW       0
+#define ADB_STATE_EVEN      1
+#define ADB_STATE_ODD       2
+#define ADB_STATE_IDLE      3
+
 #define VIA1B_vADB_StateMask    (VIA1B_vADBS1 | VIA1B_vADBS2)
 #define VIA1B_vADB_StateShift   4
 
@@ -424,6 +429,158 @@ static void via1_rtc_update(MacVIAState *m)
     }
 }
 
+static int adb_via_poll(MacVIAState *s, int state, uint8_t *data)
+{
+    if (state != ADB_STATE_IDLE) {
+        return 0;
+    }
+    if (s->adb_data_in_size < s->adb_data_in_index) {
+        return 0;
+    }
+    if (s->adb_data_out_index != 0) {
+        return 0;
+    }
+    s->adb_data_in_index = 0;
+    s->adb_data_out_index = 0;
+    s->adb_data_in_size = adb_poll(&s->adb_bus, s->adb_data_in, 0xffff);
+    if (s->adb_data_in_size) {
+        *data = s->adb_data_in[s->adb_data_in_index++];
+        qemu_irq_raise(s->adb_data_ready);
+    }
+    return s->adb_data_in_size;
+}
+
+static int adb_via_send(MacVIAState *s, int state, uint8_t data)
+{
+    switch (state) {
+    case ADB_STATE_NEW:
+        s->adb_data_out_index = 0;
+        break;
+    case ADB_STATE_EVEN:
+        if ((s->adb_data_out_index & 1) == 0) {
+            return 0;
+        }
+        break;
+    case ADB_STATE_ODD:
+        if (s->adb_data_out_index & 1) {
+            return 0;
+        }
+        break;
+    case ADB_STATE_IDLE:
+        return 0;
+    }
+    s->adb_data_out[s->adb_data_out_index++] = data;
+    qemu_irq_raise(s->adb_data_ready);
+    return 1;
+}
+
+static int adb_via_receive(MacVIAState *s, int state, uint8_t *data)
+{
+    switch (state) {
+    case ADB_STATE_NEW:
+        return 0;
+    case ADB_STATE_EVEN:
+        if (s->adb_data_in_size <= 0) {
+            qemu_irq_raise(s->adb_data_ready);
+            return 0;
+        }
+        if (s->adb_data_in_index >= s->adb_data_in_size) {
+            *data = 0;
+            qemu_irq_raise(s->adb_data_ready);
+            return 1;
+        }
+        if ((s->adb_data_in_index & 1) == 0) {
+            return 0;
+        }
+        break;
+    case ADB_STATE_ODD:
+        if (s->adb_data_in_size <= 0) {
+            qemu_irq_raise(s->adb_data_ready);
+            return 0;
+        }
+        if (s->adb_data_in_index >= s->adb_data_in_size) {
+            *data = 0;
+            qemu_irq_raise(s->adb_data_ready);
+            return 1;
+        }
+        if (s->adb_data_in_index & 1) {
+            return 0;
+        }
+        break;
+    case ADB_STATE_IDLE:
+        if (s->adb_data_out_index == 0) {
+            return 0;
+        }
+        s->adb_data_in_size = adb_request(&s->adb_bus, s->adb_data_in,
+                                          s->adb_data_out,
+                                          s->adb_data_out_index);
+        s->adb_data_out_index = 0;
+        s->adb_data_in_index = 0;
+        if (s->adb_data_in_size < 0) {
+            *data = 0xff;
+            qemu_irq_raise(s->adb_data_ready);
+            return -1;
+        }
+        if (s->adb_data_in_size == 0) {
+            return 0;
+        }
+        break;
+    }
+    *data = s->adb_data_in[s->adb_data_in_index++];
+    qemu_irq_raise(s->adb_data_ready);
+    if (*data == 0xff || *data == 0) {
+        return 0;
+    }
+    return 1;
+}
+
+static void via1_adb_update(MacVIAState *m)
+{
+    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&m->mos6522_via1);
+    MOS6522State *s = MOS6522(v1s);
+    int state;
+    int ret;
+
+    state = (s->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+
+    if (s->acr & VIA1ACR_vShiftOut) {
+        /* output mode */
+        ret = adb_via_send(m, state, s->sr);
+        if (ret > 0) {
+            s->b &= ~VIA1B_vADBInt;
+        } else {
+            s->b |= VIA1B_vADBInt;
+        }
+    } else {
+        /* input mode */
+        ret = adb_via_receive(m, state, &s->sr);
+        if (ret > 0 && s->sr != 0xff) {
+            s->b &= ~VIA1B_vADBInt;
+        } else {
+            s->b |= VIA1B_vADBInt;
+        }
+    }
+}
+
+static void via_adb_poll(void *opaque)
+{
+    MacVIAState *m = opaque;
+    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&m->mos6522_via1);
+    MOS6522State *s = MOS6522(v1s);
+    int state;
+
+    if (s->b & VIA1B_vADBInt) {
+        state = (s->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+        if (adb_via_poll(m, state, &s->sr)) {
+            s->b &= ~VIA1B_vADBInt;
+        }
+    }
+
+    timer_mod(m->adb_poll_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
+}
+
 static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
 {
     MOS6522Q800VIA1State *s = opaque;
@@ -486,6 +643,10 @@ static void mac_via_reset(DeviceState *dev)
 {
     MacVIAState *m = MAC_VIA(dev);
 
+    timer_mod(m->adb_poll_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
+
     timer_mod(m->VBL_timer, (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 16630)
               / 16630 * 16630);
 
@@ -524,6 +685,10 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
 
     qemu_get_timedate(&tm, 0);
     m->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
+
+    m->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via_adb_poll, m);
+    m->adb_data_ready = qdev_get_gpio_in_named(dev, "via1-irq",
+                                               VIA1_IRQ_ADB_READY_BIT);
 }
 
 static void mac_via_init(Object *obj)
@@ -572,6 +737,7 @@ static void mos6522_q800_via1_portB_write(MOS6522State *s)
     MacVIAState *m = container_of(v1s, MacVIAState, mos6522_via1);
 
     via1_rtc_update(m);
+    via1_adb_update(m);
 
     v1s->last_b = s->b;
 }
diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index a3a972ccc5..ac56df8c35 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -96,6 +96,13 @@ typedef struct MacVIAState {
 
     /* ADB */
     ADBBusState adb_bus;
+    QEMUTimer *adb_poll_timer;
+    qemu_irq adb_data_ready;
+    int adb_data_in_size;
+    int adb_data_in_index;
+    int adb_data_out_index;
+    uint8_t adb_data_in[128];
+    uint8_t adb_data_out[16];
 
     /* external timers */
     QEMUTimer *one_second_timer;
-- 
2.11.0
