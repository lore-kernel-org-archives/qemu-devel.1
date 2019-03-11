Received: from eggs.gnu.org ([209.51.188.92]:60755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODY-00074h-Tg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODW-00033I-BK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODU-0002xk-Dg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id a188so5017888wmf.3
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:16 +0100
Message-Id: <1552323335-46779-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 12/31] lsi: implement basic SBCL functionality
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

HP-UX checks this register after sending data to the target. If there's no valid
information present, it assumes the client disconnected because the kernel sent
to much data. Implement at least some of the SBCL functionality that is possible
without having a real SCSI bus.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20190215194021.20543-1-svens@stackframe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 89def14..8ba07f8 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -160,6 +160,11 @@ static const char *names[] = {
 #define LSI_CCNTL1_DDAC      0x08
 #define LSI_CCNTL1_ZMOD      0x80
 
+#define LSI_SBCL_ATN         0x08
+#define LSI_SBCL_BSY         0x20
+#define LSI_SBCL_ACK         0x40
+#define LSI_SBCL_REQ         0x80
+
 /* Enable Response to Reselection */
 #define LSI_SCID_RRE      0x60
 
@@ -258,6 +263,7 @@ typedef struct {
     uint8_t sdid;
     uint8_t ssid;
     uint8_t sfbr;
+    uint8_t sbcl;
     uint8_t stest1;
     uint8_t stest2;
     uint8_t stest3;
@@ -356,6 +362,7 @@ static void lsi_soft_reset(LSIState *s)
     s->socl = 0;
     s->sdid = 0;
     s->ssid = 0;
+    s->sbcl = 0;
     s->stest1 = 0;
     s->stest2 = 0;
     s->stest3 = 0;
@@ -530,6 +537,8 @@ static void lsi_script_dma_interrupt(LSIState *s, int stat)
 
 static inline void lsi_set_phase(LSIState *s, int phase)
 {
+    s->sbcl &= ~PHASE_MASK;
+    s->sbcl |= phase | LSI_SBCL_REQ;
     s->sstat1 = (s->sstat1 & ~PHASE_MASK) | phase;
 }
 
@@ -567,6 +576,7 @@ static void lsi_disconnect(LSIState *s)
 {
     s->scntl1 &= ~LSI_SCNTL1_CON;
     s->sstat1 &= ~PHASE_MASK;
+    s->sbcl = 0;
 }
 
 static void lsi_bad_selection(LSIState *s, uint32_t id)
@@ -1265,7 +1275,9 @@ again:
                 s->scntl1 |= LSI_SCNTL1_CON;
                 if (insn & (1 << 3)) {
                     s->socl |= LSI_SOCL_ATN;
+                    s->sbcl |= LSI_SBCL_ATN;
                 }
+                s->sbcl |= LSI_SBCL_BSY;
                 lsi_set_phase(s, PHASE_MO);
                 break;
             case 1: /* Disconnect */
@@ -1297,8 +1309,14 @@ again:
                         insn & (1 << 10) ? " CC" : "");
                 if (insn & (1 << 3)) {
                     s->socl |= LSI_SOCL_ATN;
+                    s->sbcl |= LSI_SBCL_ATN;
                     lsi_set_phase(s, PHASE_MO);
                 }
+
+                if (insn & (1 << 6)) {
+                    s->sbcl |= LSI_SBCL_ACK;
+                }
+
                 if (insn & (1 << 9)) {
                     qemu_log_mask(LOG_UNIMP,
                         "lsi_scsi: Target mode not implemented\n");
@@ -1314,7 +1332,13 @@ again:
                         insn & (1 << 10) ? " CC" : "");
                 if (insn & (1 << 3)) {
                     s->socl &= ~LSI_SOCL_ATN;
+                    s->sbcl &= ~LSI_SBCL_ATN;
                 }
+
+                if (insn & (1 << 6)) {
+                    s->sbcl &= ~LSI_SBCL_ACK;
+                }
+
                 if (insn & (1 << 10))
                     s->carry = 0;
                 break;
@@ -1591,9 +1615,7 @@ static uint8_t lsi_reg_readb(LSIState *s, int offset)
         ret = s->ssid;
         break;
     case 0xb: /* SBCL */
-        /* ??? This is not correct. However it's (hopefully) only
-           used for diagnostics, so should be ok.  */
-        ret = 0;
+        ret = s->sbcl;
         break;
     case 0xc: /* DSTAT */
         ret = s->dstat | LSI_DSTAT_DFE;
@@ -2143,7 +2165,7 @@ static int lsi_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_lsi_scsi = {
     .name = "lsiscsi",
-    .version_id = 0,
+    .version_id = 1,
     .minimum_version_id = 0,
     .pre_save = lsi_pre_save,
     .post_load = lsi_post_load,
@@ -2202,6 +2224,7 @@ static const VMStateDescription vmstate_lsi_scsi = {
         VMSTATE_UINT8(stime0, LSIState),
         VMSTATE_UINT8(respid0, LSIState),
         VMSTATE_UINT8(respid1, LSIState),
+        VMSTATE_UINT8_V(sbcl, LSIState, 1),
         VMSTATE_UINT32(mmrs, LSIState),
         VMSTATE_UINT32(mmws, LSIState),
         VMSTATE_UINT32(sfs, LSIState),
-- 
1.8.3.1
