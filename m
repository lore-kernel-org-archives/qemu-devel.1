Received: from eggs.gnu.org ([2001:4830:134:3::10]:43627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gS7on-0002rD-Qs
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gS7oj-0006YU-2M
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:56:24 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1gS7oh-0006Vl-4L
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:56:19 -0500
Received: by mail-pf1-x443.google.com with SMTP id c73so10811355pfe.13
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 13:56:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 28 Nov 2018 13:56:11 -0800
Message-Id: <1543442171-24863-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH 2/2] scsi: esp: Improve consistency of RSTAT,
 RSEQ, and RINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>

The guest OS reads RSTAT, RSEQ, and RINTR, and expects those registers
to reflect a consistent state. However, it is possible that the registers
can change after RSTAT was read, but before RINTR is read.

Guest OS		qemu
--------		----
Read RSTAT
			esp_command_complete()
			 RSTAT = STAT_ST
			 esp_dma_done()
			  RSTAT |= STAT_TC
			  RSEQ = 0
			  RINTR = INTR_BS

Read RSEQ
Read RINTR		RINTR = 0
			RSTAT &= ~STAT_TC
			RSEQ = SEQ_CD

The guest OS would then try to handle INTR_BS combined with an old
value of RSTAT. This sometimes resulted in lost events, spurious
interrupts, guest OS confusion, and stalled SCSI operations.
A typical guest error log (observed with various versions of Linux)
looks as follows.

scsi host1: Spurious irq, sreg=13.
...
scsi host1: Aborting command [84531f10:2a]
scsi host1: Current command [f882eea8:35]
scsi host1: Queued command [84531f10:2a]
scsi host1:  Active command [f882eea8:35]
scsi host1: Dumping command log
scsi host1: ent[15] CMD val[44] sreg[90] seqreg[00] sreg2[00] ireg[20] ss[00] event[0c]
scsi host1: ent[16] CMD val[01] sreg[90] seqreg[00] sreg2[00] ireg[20] ss[02] event[0c]
scsi host1: ent[17] CMD val[43] sreg[90] seqreg[00] sreg2[00] ireg[20] ss[02] event[0c]
scsi host1: ent[18] EVENT val[0d] sreg[92] seqreg[04] sreg2[00] ireg[18] ss[00] event[0c]
...

Adress the situation by caching RINTR and RSEQ when RSTAT is read and
using the cached values when the respective registers are read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I am not too happy with this solution (it looks kludgy to me), but it does
work. With this series applied, I have not seen a single spurious interrupt
after hundreds of boots, and no stalls. Prior to that, spurious interrupts
were seen with pretty much every boot, and the stall occurred on a regular
basis (roughly every other boot with qemu-system-hppa, less with others).

If anyone has a better idea, please let me know, and I'll be happy to
test it.

 hw/scsi/esp.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 include/hw/scsi/esp.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 630d923..6af74bc 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -415,6 +415,16 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
         }
         break;
     case ESP_RINTR:
+        if (s->rintr_saved) {
+            old_val = s->rintr_saved;
+            s->rintr_saved = 0;
+            if (!(s->rregs[ESP_RINTR])) {
+                s->rregs[ESP_RSTAT] &= ~STAT_TC;
+                s->rregs[ESP_RSEQ] = SEQ_CD;
+                esp_lower_irq(s);
+            }
+            return old_val;
+        }
         /* Clear sequence step, interrupt register and all status bits
            except TC */
         old_val = s->rregs[ESP_RINTR];
@@ -429,6 +439,34 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
         if (!s->tchi_written) {
             return s->chip_id;
         }
+    case ESP_RSTAT:
+        /*
+         * After receiving an interrupt, the guest OS reads
+         * RSTAT, RSEQ, and RINTR. When reading RINTR,
+         * RSTAT and RSEQ are updated. It was observed that
+         * esp_command_complete() and with it esp_dma_done()
+         * was called after the guest OS reads RSTAT, but
+         * before it was able to read RINTR. In other words,
+         * the host would read RINTR associated with the
+         * old value of RSTAT, not the new value. Since RSTAT
+         * was supposed to reflect STAT_ST in this situation,
+         * the host OS got confused, and the operation stalled.
+         * Remedy the situation by caching both ESP_RINTR and
+         * ESP_RSEQ. Return those values until ESP_RINTR is read.
+         * Only do this if an interrupt is pending to limit its
+         * impact.
+         */
+        if (s->rregs[ESP_RSTAT] & STAT_INT) {
+            s->rintr_saved = s->rregs[ESP_RINTR];
+            s->rseq_saved =  s->rregs[ESP_RSEQ];
+            s->rregs[ESP_RINTR] = 0;
+        }
+        break;
+    case ESP_RSEQ:
+        if (s->rintr_saved) {
+            return s->rseq_saved;
+        }
+        break;
     default:
         break;
     }
@@ -577,6 +615,8 @@ const VMStateDescription vmstate_esp = {
     .fields = (VMStateField[]) {
         VMSTATE_BUFFER(rregs, ESPState),
         VMSTATE_BUFFER(wregs, ESPState),
+        VMSTATE_UINT8(rintr_saved, ESPState),
+        VMSTATE_UINT8(rseq_saved, ESPState),
         VMSTATE_INT32(ti_size, ESPState),
         VMSTATE_UINT32(ti_rptr, ESPState),
         VMSTATE_UINT32(ti_wptr, ESPState),
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 682a0d2..342f607 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -17,6 +17,8 @@ typedef struct ESPState ESPState;
 struct ESPState {
     uint8_t rregs[ESP_REGS];
     uint8_t wregs[ESP_REGS];
+    uint8_t rintr_saved;
+    uint8_t rseq_saved;
     qemu_irq irq;
     uint8_t chip_id;
     bool tchi_written;
-- 
2.7.4
