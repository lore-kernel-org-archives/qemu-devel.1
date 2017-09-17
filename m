Received: from eggs.gnu.org ([2001:4830:134:3::10]:45708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAz-00065S-U2
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAv-0006BY-ME
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:13 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 17 Sep 2017 18:15:45 +0100
Message-Id: <1505668548-16616-6-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 5/8] ppc/mac: More rework of the DBDMA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This completely reworks the handling of the control register
according to my understanding of the HW and the spec.

It should (hopefully ... still testing) fix a number of issues
most notably cases of MacOS hanging.

Also update dbdma_unassigned_rw() and dbdma_unassigned_flush() to
have the expected behaviour now that flush is handled slightly
differently.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/mac_dbdma.c |  191 +++++++++++++++++++++++++++++++++------------
 1 file changed, 139 insertions(+), 52 deletions(-)

diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 15452b9..3fe5073 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -96,9 +96,8 @@ static void dbdma_cmdptr_load(DBDMA_channel *ch)
 
 static void dbdma_cmdptr_save(DBDMA_channel *ch)
 {
-    DBDMA_DPRINTFCH(ch, "dbdma_cmdptr_save 0x%08x\n",
-                    ch->regs[DBDMA_CMDPTR_LO]);
-    DBDMA_DPRINTFCH(ch, "xfer_status 0x%08x res_count 0x%04x\n",
+    DBDMA_DPRINTFCH(ch, "-> update 0x%08x stat=0x%08x, res=0x%04x\n",
+                    ch->regs[DBDMA_CMDPTR_LO],
                     le16_to_cpu(ch->current.xfer_status),
                     le16_to_cpu(ch->current.res_count));
     dma_memory_write(&address_space_memory, ch->regs[DBDMA_CMDPTR_LO],
@@ -166,15 +165,14 @@ static int conditional_wait(DBDMA_channel *ch)
     uint16_t sel_mask, sel_value;
     uint32_t status;
     int cond;
-
-    DBDMA_DPRINTFCH(ch, "conditional_wait\n");
+    int res = 0;
 
     wait = le16_to_cpu(current->command) & WAIT_MASK;
-
     switch(wait) {
     case WAIT_NEVER:  /* don't wait */
         return 0;
     case WAIT_ALWAYS: /* always wait */
+        DBDMA_DPRINTFCH(ch, "  [WAIT_ALWAYS]\n");
         return 1;
     }
 
@@ -187,15 +185,19 @@ static int conditional_wait(DBDMA_channel *ch)
 
     switch(wait) {
     case WAIT_IFSET:  /* wait if condition bit is 1 */
-        if (cond)
-            return 1;
-        return 0;
+        if (cond) {
+            res = 1;
+        }
+        DBDMA_DPRINTFCH(ch, "  [WAIT_IFSET=%d]\n", res);
+        break;
     case WAIT_IFCLR:  /* wait if condition bit is 0 */
-        if (!cond)
-            return 1;
-        return 0;
+        if (!cond) {
+            res = 1;
+        }
+        DBDMA_DPRINTFCH(ch, "  [WAIT_IFCLR=%d]\n", res);
+        break;
     }
-    return 0;
+    return res;
 }
 
 static void next(DBDMA_channel *ch)
@@ -226,8 +228,6 @@ static void conditional_branch(DBDMA_channel *ch)
     uint32_t status;
     int cond;
 
-    DBDMA_DPRINTFCH(ch, "conditional_branch\n");
-
     /* check if we must branch */
 
     br = le16_to_cpu(current->command) & BR_MASK;
@@ -237,6 +237,7 @@ static void conditional_branch(DBDMA_channel *ch)
         next(ch);
         return;
     case BR_ALWAYS: /* always branch */
+        DBDMA_DPRINTFCH(ch, "  [BR_ALWAYS]\n");
         branch(ch);
         return;
     }
@@ -250,16 +251,22 @@ static void conditional_branch(DBDMA_channel *ch)
 
     switch(br) {
     case BR_IFSET:  /* branch if condition bit is 1 */
-        if (cond)
+        if (cond) {
+            DBDMA_DPRINTFCH(ch, "  [BR_IFSET = 1]\n");
             branch(ch);
-        else
+        } else {
+            DBDMA_DPRINTFCH(ch, "  [BR_IFSET = 0]\n");
             next(ch);
+        }
         return;
     case BR_IFCLR:  /* branch if condition bit is 0 */
-        if (!cond)
+        if (!cond) {
+            DBDMA_DPRINTFCH(ch, "  [BR_IFCLR = 1]\n");
             branch(ch);
-        else
+        } else {
+            DBDMA_DPRINTFCH(ch, "  [BR_IFCLR = 0]\n");
             next(ch);
+        }
         return;
     }
 }
@@ -428,7 +435,7 @@ wait:
 
 static void stop(DBDMA_channel *ch)
 {
-    ch->regs[DBDMA_STATUS] &= ~(ACTIVE|DEAD|FLUSH);
+    ch->regs[DBDMA_STATUS] &= ~(ACTIVE);
 
     /* the stop command does not increment command pointer */
 }
@@ -471,18 +478,22 @@ static void channel_run(DBDMA_channel *ch)
 
     switch (cmd) {
     case OUTPUT_MORE:
+        DBDMA_DPRINTFCH(ch, "* OUTPUT_MORE *\n");
         start_output(ch, key, phy_addr, req_count, 0);
         return;
 
     case OUTPUT_LAST:
+        DBDMA_DPRINTFCH(ch, "* OUTPUT_LAST *\n");
         start_output(ch, key, phy_addr, req_count, 1);
         return;
 
     case INPUT_MORE:
+        DBDMA_DPRINTFCH(ch, "* INPUT_MORE *\n");
         start_input(ch, key, phy_addr, req_count, 0);
         return;
 
     case INPUT_LAST:
+        DBDMA_DPRINTFCH(ch, "* INPUT_LAST *\n");
         start_input(ch, key, phy_addr, req_count, 1);
         return;
     }
@@ -508,10 +519,12 @@ static void channel_run(DBDMA_channel *ch)
 
     switch (cmd) {
     case LOAD_WORD:
+        DBDMA_DPRINTFCH(ch, "* LOAD_WORD *\n");
         load_word(ch, key, phy_addr, req_count);
         return;
 
     case STORE_WORD:
+        DBDMA_DPRINTFCH(ch, "* STORE_WORD *\n");
         store_word(ch, key, phy_addr, req_count);
         return;
     }
@@ -562,43 +575,117 @@ void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
     ch->io.opaque = opaque;
 }
 
-static void
-dbdma_control_write(DBDMA_channel *ch)
+static void dbdma_control_write(DBDMA_channel *ch)
 {
     uint16_t mask, value;
     uint32_t status;
+    bool do_flush = false;
 
     mask = (ch->regs[DBDMA_CONTROL] >> 16) & 0xffff;
     value = ch->regs[DBDMA_CONTROL] & 0xffff;
 
-    value &= (RUN | PAUSE | FLUSH | WAKE | DEVSTAT);
-
+    /* This is the status register which we'll update
+     * appropriately and store back
+     */
     status = ch->regs[DBDMA_STATUS];
 
-    status = (value & mask) | (status & ~mask);
+    /* RUN and PAUSE are bits under SW control only
+     * FLUSH and WAKE are set by SW and cleared by HW
+     * DEAD, ACTIVE and BT are only under HW control
+     *
+     * We handle ACTIVE separately at the end of the
+     * logic to ensure all cases are covered.
+     */
 
-    if (status & WAKE)
-        status |= ACTIVE;
-    if (status & RUN) {
-        status |= ACTIVE;
-        status &= ~DEAD;
+    /* Setting RUN will tentatively activate the channel
+     */
+    if ((mask & RUN) && (value & RUN)) {
+        status |= RUN;
+        DBDMA_DPRINTFCH(ch, " Setting RUN !\n");
+    }
+
+    /* Clearing RUN 1->0 will stop the channel */
+    if ((mask & RUN) && !(value & RUN)) {
+        /* This has the side effect of clearing the DEAD bit */
+        status &= ~(DEAD | RUN);
+        DBDMA_DPRINTFCH(ch, " Clearing RUN !\n");
+    }
+
+    /* Setting WAKE wakes up an idle channel if it's running
+     *
+     * Note: The doc doesn't say so but assume that only works
+     * on a channel whose RUN bit is set.
+     *
+     * We set WAKE in status, it's not terribly useful as it will
+     * be cleared on the next command fetch but it seems to mimmic
+     * the HW behaviour and is useful for the way we handle
+     * ACTIVE further down.
+     */
+    if ((mask & WAKE) && (value & WAKE) && (status & RUN)) {
+        status |= WAKE;
+        DBDMA_DPRINTFCH(ch, " Setting WAKE !\n");
+    }
+
+    /* PAUSE being set will deactivate (or prevent activation)
+     * of the channel. We just copy it over for now, ACTIVE will
+     * be re-evaluated later.
+     */
+    if (mask & PAUSE) {
+        status = (status & ~PAUSE) | (value & PAUSE);
+        DBDMA_DPRINTFCH(ch, " %sing PAUSE !\n",
+                        (value & PAUSE) ? "sett" : "clear");
+    }
+
+    /* FLUSH is its own thing */
+    if ((mask & FLUSH) && (value & FLUSH))  {
+        DBDMA_DPRINTFCH(ch, " Setting FLUSH !\n");
+        /* We set flush directly in the status register, we do *NOT*
+         * set it in "status" so that it gets naturally cleared when
+         * we update the status register further down. That way it
+         * will be set only during the HW flush operation so it is
+         * visible to any completions happening during that time.
+         */
+        ch->regs[DBDMA_STATUS] |= FLUSH;
+        do_flush = true;
     }
-    if (status & PAUSE)
+
+    /* If either RUN or PAUSE is clear, so should ACTIVE be,
+     * otherwise, ACTIVE will be set if we modified RUN, PAUSE or
+     * set WAKE. That means that PAUSE was just cleared, RUN was
+     * just set or WAKE was just set.
+     */
+    if ((status & PAUSE) || !(status & RUN)) {
         status &= ~ACTIVE;
-    if ((ch->regs[DBDMA_STATUS] & RUN) && !(status & RUN)) {
-        /* RUN is cleared */
-        status &= ~(ACTIVE|DEAD);
+        DBDMA_DPRINTFCH(ch, "  -> ACTIVE down !\n");
+
+        /* We stopped processing, we want the underlying HW command
+         * to complete *before* we clear the ACTIVE bit. Otherwise
+         * we can get into a situation where the command status will
+         * have RUN or ACTIVE not set which is going to confuse the
+         * MacOS driver.
+         */
+        do_flush = true;
+    } else if (mask & (RUN | PAUSE)) {
+        status |= ACTIVE;
+        DBDMA_DPRINTFCH(ch, " -> ACTIVE up !\n");
+    } else if ((mask & WAKE) && (value & WAKE)) {
+        status |= ACTIVE;
+        DBDMA_DPRINTFCH(ch, " -> ACTIVE up !\n");
     }
 
-    if ((status & FLUSH) && ch->flush) {
+    DBDMA_DPRINTFCH(ch, " new status=0x%08x\n", status);
+
+    /* If we need to flush the underlying HW, do it now, this happens
+     * both on FLUSH commands and when stopping the channel for safety.
+     */
+    if (do_flush && ch->flush) {
         ch->flush(&ch->io);
-        status &= ~FLUSH;
     }
 
-    DBDMA_DPRINTFCH(ch, "    status 0x%08x\n", status);
-
+    /* Finally update the status register image */
     ch->regs[DBDMA_STATUS] = status;
 
+    /* If active, make sure the BH gets to run */
     if (status & ACTIVE) {
         DBDMA_kick(dbdma_from_ch(ch));
     }
@@ -666,13 +753,9 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
 
     value = ch->regs[reg];
 
-    DBDMA_DPRINTFCH(ch, "readl 0x" TARGET_FMT_plx " => 0x%08x\n", addr, value);
-    DBDMA_DPRINTFCH(ch, "channel 0x%x reg 0x%x\n",
-                    (uint32_t)addr >> DBDMA_CHANNEL_SHIFT, reg);
-
     switch(reg) {
     case DBDMA_CONTROL:
-        value = 0;
+        value = ch->regs[DBDMA_STATUS];
         break;
     case DBDMA_STATUS:
     case DBDMA_CMDPTR_LO:
@@ -698,6 +781,10 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
         break;
     }
 
+    DBDMA_DPRINTFCH(ch, "readl 0x" TARGET_FMT_plx " => 0x%08x\n", addr, value);
+    DBDMA_DPRINTFCH(ch, "channel 0x%x reg 0x%x\n",
+                    (uint32_t)addr >> DBDMA_CHANNEL_SHIFT, reg);
+
     return value;
 }
 
@@ -776,28 +863,28 @@ static void dbdma_reset(void *opaque)
 static void dbdma_unassigned_rw(DBDMA_io *io)
 {
     DBDMA_channel *ch = io->channel;
-    qemu_log_mask(LOG_GUEST_ERROR, "%s: use of unassigned channel %d\n",
-                  __func__, ch->channel);
-    ch->io.processing = false;
-}
-
-static void dbdma_unassigned_flush(DBDMA_io *io)
-{
-    DBDMA_channel *ch = io->channel;
     dbdma_cmd *current = &ch->current;
     uint16_t cmd;
     qemu_log_mask(LOG_GUEST_ERROR, "%s: use of unassigned channel %d\n",
                   __func__, ch->channel);
+    ch->io.processing = false;
 
     cmd = le16_to_cpu(current->command) & COMMAND_MASK;
     if (cmd == OUTPUT_MORE || cmd == OUTPUT_LAST ||
         cmd == INPUT_MORE || cmd == INPUT_LAST) {
-        current->xfer_status = cpu_to_le16(ch->regs[DBDMA_STATUS] | FLUSH);
+        current->xfer_status = cpu_to_le16(ch->regs[DBDMA_STATUS]);
         current->res_count = cpu_to_le16(io->len);
         dbdma_cmdptr_save(ch);
     }
 }
 
+static void dbdma_unassigned_flush(DBDMA_io *io)
+{
+    DBDMA_channel *ch = io->channel;
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: use of unassigned channel %d\n",
+                  __func__, ch->channel);
+}
+
 void* DBDMA_init (MemoryRegion **dbdma_mem)
 {
     DBDMAState *s;
-- 
1.7.10.4
