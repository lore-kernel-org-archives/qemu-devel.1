Received: from eggs.gnu.org ([2001:4830:134:3::10]:41769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHU-0004BK-BO
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHO-0007bF-7p
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:52 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHN-0007at-VL
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:46 -0500
Received: by mail-wm0-x244.google.com with SMTP id 141so15524194wme.3
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:45 -0800 (PST)
Received: from 640k.lan ([82.84.102.245])
	by smtp.gmail.com with ESMTPSA id f9sm6870298wmf.12.2018.02.13.04.01.43
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Feb 2018 04:01:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:15 +0100
Message-Id: <1518523252-49106-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/48] hw/net/can: interrupt cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Define two functions to update the interrupt state, and call them
on loadvm.  This removes the need to migrate the state as part of
vmstate_kvaser_pci.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/can/can_kvaser_pci.c |  4 +--
 hw/net/can/can_sja1000.c    | 82 ++++++++++++++++++++++++---------------------
 2 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 2d77ef2..5f82f43 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -264,10 +264,10 @@ static const VMStateDescription vmstate_kvaser_pci = {
     .minimum_version_id_old = 1,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, KvaserPCIState),
+        /* Load this before sja_state.  */
+        VMSTATE_UINT32(s5920_intcsr, KvaserPCIState),
         VMSTATE_STRUCT(sja_state, KvaserPCIState, 0, vmstate_can_sja,
                        CanSJA1000State),
-        VMSTATE_UINT32(s5920_intcsr, KvaserPCIState),
-        VMSTATE_UINT32(s5920_irqstate, KvaserPCIState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 503fbcf..6293233 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -378,6 +378,24 @@ static int frame2buff_bas(const qemu_can_frame *frame, uint8_t *buff)
     return frame->can_dlc + 2;
 }
 
+static void can_sja_update_pel_irq(CanSJA1000State *s)
+{
+    if (s->interrupt_en & s->interrupt_pel) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static void can_sja_update_bas_irq(CanSJA1000State *s)
+{
+    if ((s->control >> 1) & s->interrupt_bas) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
 void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
                        unsigned size)
 {
@@ -457,9 +475,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
                 /* Clear transmit status. */
                 s->status_pel &= ~(1 << 5);
                 s->interrupt_pel |= 0x02;
-                if (s->interrupt_en & 0x02) {
-                    qemu_irq_raise(s->irq);
-                }
+                can_sja_update_pel_irq(s);
             }
             if (0x04 & val) { /* Release Receive Buffer */
                 if (s->rxmsg_cnt <= 0) {
@@ -488,19 +504,13 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
                 if (s->rxmsg_cnt == 0) {
                     s->status_pel &= ~(1 << 0);
                     s->interrupt_pel &= ~(1 << 0);
-                }
-                if ((s->interrupt_en & 0x01) && (s->interrupt_pel == 0)) {
-                    /* no other interrupts. */
-                    qemu_irq_lower(s->irq);
+                    can_sja_update_pel_irq(s);
                 }
             }
             if (0x08 & val) { /* Clear data overrun */
                 s->status_pel &= ~(1 << 1);
                 s->interrupt_pel &= ~(1 << 3);
-                if ((s->interrupt_en & 0x80) && (s->interrupt_pel == 0)) {
-                    /* no other interrupts. */
-                    qemu_irq_lower(s->irq);
-                }
+                can_sja_update_pel_irq(s);
             }
             break;
         case SJA_SR: /* Status register */
@@ -568,9 +578,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
                 /* Clear transmit status. */
                 s->status_bas &= ~(1 << 5);
                 s->interrupt_bas |= 0x02;
-                if (s->control & 0x04) {
-                    qemu_irq_raise(s->irq);
-                }
+                can_sja_update_bas_irq(s);
             }
             if (0x04 & val) { /* Release Receive Buffer */
                 if (s->rxmsg_cnt <= 0) {
@@ -593,19 +601,13 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
                 if (s->rxmsg_cnt == 0) {
                     s->status_bas &= ~(1 << 0);
                     s->interrupt_bas &= ~(1 << 0);
-                }
-                if ((s->control & 0x02) && (s->interrupt_bas == 0)) {
-                    /* no other interrupts. */
-                    qemu_irq_lower(s->irq);
+                    can_sja_update_bas_irq(s);
                 }
             }
             if (0x08 & val) { /* Clear data overrun */
                 s->status_bas &= ~(1 << 1);
                 s->interrupt_bas &= ~(1 << 3);
-                if ((s->control & 0x10) && (s->interrupt_bas == 0)) {
-                    /* no other interrupts. */
-                    qemu_irq_lower(s->irq);
-                }
+                can_sja_update_bas_irq(s);
             }
             break;
         case 4:
@@ -654,9 +656,8 @@ uint64_t can_sja_mem_read(CanSJA1000State *s, hwaddr addr, unsigned size)
             s->interrupt_pel = 0;
             if (s->rxmsg_cnt) {
                 s->interrupt_pel |= (1 << 0); /* Receive interrupt. */
-                break;
             }
-            qemu_irq_lower(s->irq);
+            can_sja_update_pel_irq(s);
             break;
         case SJA_IER: /* Interrupt enable register, addr 4 */
             temp = s->interrupt_en;
@@ -704,9 +705,8 @@ uint64_t can_sja_mem_read(CanSJA1000State *s, hwaddr addr, unsigned size)
             s->interrupt_bas = 0;
             if (s->rxmsg_cnt) {
                 s->interrupt_bas |= (1 << 0); /* Receive interrupt. */
-                break;
             }
-            qemu_irq_lower(s->irq);
+            can_sja_update_bas_irq(s);
             break;
         case 4:
             temp = s->code;
@@ -789,13 +789,11 @@ ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
         if (s->rx_cnt + ret > SJA_RCV_BUF_LEN) { /* Data overrun. */
             s->status_pel |= (1 << 1); /* Overrun status */
             s->interrupt_pel |= (1 << 3);
-            if (s->interrupt_en & (1 << 3)) { /* Overrun interrupt enable */
-                qemu_irq_raise(s->irq);
-            }
             s->status_pel &= ~(1 << 4);
             if (DEBUG_FILTER) {
                 qemu_log("[cansja]: receive FIFO overrun\n");
             }
+            can_sja_update_pel_irq(s);
             return ret;
         }
         s->rx_cnt += ret;
@@ -813,9 +811,7 @@ ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
         s->interrupt_pel |= 0x01;
         s->status_pel &= ~(1 << 4);
         s->status_pel |= (1 << 0);
-        if (s->interrupt_en & 0x01) { /* Receive Interrupt enable. */
-            qemu_irq_raise(s->irq);
-        }
+        can_sja_update_pel_irq(s);
     } else { /* BasicCAN mode */
 
         /* the CAN controller is receiving a message */
@@ -834,9 +830,7 @@ ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
             s->status_bas |= (1 << 1); /* Overrun status */
             s->status_bas &= ~(1 << 4);
             s->interrupt_bas |= (1 << 3);
-            if (s->control & (1 << 4)) { /* Overrun interrupt enable */
-                qemu_irq_raise(s->irq);
-            }
+            can_sja_update_bas_irq(s);
             if (DEBUG_FILTER) {
                 qemu_log("[cansja]: receive FIFO overrun\n");
             }
@@ -856,10 +850,8 @@ ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
 
         s->status_bas |= 0x01; /* Set the Receive Buffer Status. DS-p15 */
         s->status_bas &= ~(1 << 4);
-        s->interrupt_bas |= 0x01;
-        if (s->control & 0x02) { /* Receive Interrupt enable. */
-            qemu_irq_raise(s->irq);
-        }
+        s->interrupt_bas |= (1 << 0);
+        can_sja_update_bas_irq(s);
     }
     return 1;
 }
@@ -909,12 +901,24 @@ const VMStateDescription vmstate_qemu_can_filter = {
     }
 };
 
+static int can_sja_post_load(void *opaque, int version_id)
+{
+    CanSJA1000State *s = opaque;
+    if (s->clock & 0x80) { /* PeliCAN Mode */
+        can_sja_update_pel_irq(s);
+    } else {
+        can_sja_update_bas_irq(s);
+    }
+    return 0;
+}
+
 /* VMState is needed for live migration of QEMU images */
 const VMStateDescription vmstate_can_sja = {
     .name = "can_sja",
     .version_id = 1,
     .minimum_version_id = 1,
     .minimum_version_id_old = 1,
+    .post_load = can_sja_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8(mode, CanSJA1000State),
 
-- 
1.8.3.1
