Received: from eggs.gnu.org ([209.51.188.92]:60927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODg-0007FW-IA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODf-0003Vy-69
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODe-0003Rf-TP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id f14so5953724wrg.1
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:56:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:29 +0100
Message-Id: <1552323335-46779-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 25/31] lsi: use SCSI phase names instead of
 numbers in trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

This makes trace logs much easier to read, especially for
people who are not fluent in SCSI.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190305195519.24303-5-svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 31 +++++++++++++++++++++++--------
 hw/scsi/trace-events |  6 +++---
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d67584e..66f217f 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -306,6 +306,22 @@ typedef struct {
 #define LSI53C895A(obj) \
     OBJECT_CHECK(LSIState, (obj), TYPE_LSI53C895A)
 
+static const char *scsi_phases[] = {
+    "DOUT",
+    "DIN",
+    "CMD",
+    "STATUS",
+    "RSVOUT",
+    "RSVIN",
+    "MSGOUT",
+    "MSGIN"
+};
+
+static const char *scsi_phase_name(int phase)
+{
+    return scsi_phases[phase & PHASE_MASK];
+}
+
 static inline int lsi_irq_on_rsl(LSIState *s)
 {
     return (s->sien0 & LSI_SIST0_RSL) && (s->scid & LSI_SCID_RRE);
@@ -1201,8 +1217,9 @@ again:
             s->ia = s->dsp - 12;
         }
         if ((s->sstat1 & PHASE_MASK) != ((insn >> 24) & 7)) {
-            trace_lsi_execute_script_blockmove_badphase(s->sstat1 & PHASE_MASK,
-                                                        (insn >> 24) & 7);
+            trace_lsi_execute_script_blockmove_badphase(
+                    scsi_phase_name(s->sstat1),
+                    scsi_phase_name(insn >> 24));
             lsi_script_scsi_interrupt(s, LSI_SIST0_MA, 0);
             break;
         }
@@ -1234,8 +1251,8 @@ again:
             lsi_do_msgin(s);
             break;
         default:
-            qemu_log_mask(LOG_UNIMP, "lsi_scsi: Unimplemented phase %d\n",
-                          s->sstat1 & PHASE_MASK);
+            qemu_log_mask(LOG_UNIMP, "lsi_scsi: Unimplemented phase %s\n",
+                          scsi_phase_name(s->sstat1));
         }
         s->dfifo = s->dbc & 0xff;
         s->ctest5 = (s->ctest5 & 0xfc) | ((s->dbc >> 8) & 3);
@@ -1463,10 +1480,8 @@ again:
                 cond = s->carry != 0;
             }
             if (cond == jmp && (insn & (1 << 17))) {
-                trace_lsi_execute_script_tc_compp(
-                        (s->sstat1 & PHASE_MASK),
-                        jmp ? '=' : '!',
-                        ((insn >> 24) & 7));
+                trace_lsi_execute_script_tc_compp(scsi_phase_name(s->sstat1),
+                        jmp ? '=' : '!', scsi_phase_name(insn >> 24));
                 cond = (s->sstat1 & PHASE_MASK) == ((insn >> 24) & 7);
             }
             if (cond == jmp && (insn & (1 << 18))) {
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 29aaa75..09f3fc3 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -268,7 +268,7 @@ lsi_memcpy(uint32_t dest, uint32_t src, int count) "memcpy dest 0x%"PRIx32" src
 lsi_wait_reselect(void) "Wait Reselect"
 lsi_execute_script(uint32_t dsp, uint32_t insn, uint32_t addr) "SCRIPTS dsp=0x%"PRIx32" opcode 0x%"PRIx32" arg 0x%"PRIx32
 lsi_execute_script_blockmove_delayed(void) "Delayed select timeout"
-lsi_execute_script_blockmove_badphase(uint8_t phase, uint8_t expected) "Wrong phase got %d expected %d"
+lsi_execute_script_blockmove_badphase(const char *phase, const char *expected) "Wrong phase got %s expected %s"
 lsi_execute_script_io_alreadyreselected(void) "Already reselected, jumping to alternative address"
 lsi_execute_script_io_selected(uint8_t id, const char *atn) "Selected target %d%s"
 lsi_execute_script_io_disconnect(void) "Wait Disconnect"
@@ -278,8 +278,8 @@ lsi_execute_script_io_opcode(const char *opcode, int reg, const char *opname, ui
 lsi_execute_script_tc_nop(void) "NOP"
 lsi_execute_script_tc_delayedselect_timeout(void) "Delayed select timeout"
 lsi_execute_script_tc_compc(int result) "Compare carry %d"
-lsi_execute_script_tc_compp(uint8_t phase, int op, uint8_t insn_phase) "Compare phase %d %c= %d"
-lsi_execute_script_tc_compd(uint32_t sfbr, uint8_t mask, int op, int result) "Compare data 0x%"PRIx32" & 0x%x %c= 0x%x"
+lsi_execute_script_tc_compp(const char *phase, char op, const char *insn_phase) "Compare phase %s %c= %s"
+lsi_execute_script_tc_compd(uint32_t sfbr, uint8_t mask, char op, int result) "Compare data 0x%"PRIx32" & 0x%x %c= 0x%x"
 lsi_execute_script_tc_jump(uint32_t addr) "Jump to 0x%"PRIx32
 lsi_execute_script_tc_call(uint32_t addr) "Call 0x%"PRIx32
 lsi_execute_script_tc_return(uint32_t addr) "Return to 0x%"PRIx32
-- 
1.8.3.1
