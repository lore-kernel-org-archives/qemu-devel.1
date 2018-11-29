Received: from eggs.gnu.org ([2001:4830:134:3::10]:55370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSQLG-0002bU-Cp
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSQH8-0000YN-6Z
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:38:57 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1gSQH4-0000T0-FK
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:38:52 -0500
Received: by mail-pf1-x441.google.com with SMTP id h3so1374333pfg.1
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 09:38:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 29 Nov 2018 09:38:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181129173845.GA2929@roeck-us.net>
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
	<3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
	<734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: esp: Improve consistency of
 RSTAT, RSEQ, and RINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Mark,

On Thu, Nov 29, 2018 at 11:56:39AM +0000, Mark Cave-Ayland wrote:
> On 29/11/2018 09:58, Paolo Bonzini wrote:
> 
> > On 28/11/18 22:56, Guenter Roeck wrote:
> >> The guest OS reads RSTAT, RSEQ, and RINTR, and expects those registers
> >> to reflect a consistent state. However, it is possible that the registers
> >> can change after RSTAT was read, but before RINTR is read.
> >>
> >> Guest OS		qemu
> >> --------		----
> >> Read RSTAT
> >> 			esp_command_complete()
> >> 			 RSTAT = STAT_ST
> >> 			 esp_dma_done()
> >> 			  RSTAT |= STAT_TC
> >> 			  RSEQ = 0
> >> 			  RINTR = INTR_BS
> >>
> >> Read RSEQ
> >> Read RINTR		RINTR = 0
> >> 			RSTAT &= ~STAT_TC
> >> 			RSEQ = SEQ_CD
> >>
> >> The guest OS would then try to handle INTR_BS combined with an old
> >> value of RSTAT. This sometimes resulted in lost events, spurious
> >> interrupts, guest OS confusion, and stalled SCSI operations.
> > 
> > The question is, why was the guest running the interrupt routine before
> > STAT_INT was set in RSTAT?  The code in esp_raise_irq seems good:
> > 
> >     if (!(s->rregs[ESP_RSTAT] & STAT_INT)) {
> >         s->rregs[ESP_RSTAT] |= STAT_INT;
> >         qemu_irq_raise(s->irq);
> >         trace_esp_raise_irq();
> >     }
> > 
> > Paolo
> 
> This patch is very interesting, as I have a long-running regression trying to boot
> NextSTEP 3.3 on qemu-system-sparc which I eventually bisected down to the commit that
> turned on iothread by default in QEMU.
> 
> The symptom is that ESP SCSI requests hang/timeout before the kernel is able to get
> to the userspace installer: however if you launch QEMU with "taskset –cpu-list 1
> qemu-system-sparc ..." then it works and you can complete the installation.
> 
> So certainly this suggests that there is a race condition still present in ESP
> somewhere. I've given this patch a spin, and in a few quick tests here I was able to
> consistently get further in kernel boot, but it still doesn't completely solve issue
> for me :/
> 

Can you try the attached patch ? It is a bit cleaner than the first version,
and works for me as well.

Note that this isn't perfect. Specifically, I see differences in handling
STAT_TC. The controller specification is a bit ambiguous in that regard,
but comparing the qemu code with real controller behavior shows that the
real controller does not reset STAT_TC when reading the interrupt status
register. That doesn't seem to matter for Linux, but it may influence
other guests.

Guenter

--9amGYk9869ThD9tj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-scsi-esp-Defer-command-completion-until-previous-int.patch"

>From 751edd383f3c70d8a9195345b45aa3eb1ada7553 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 29 Nov 2018 09:17:42 -0800
Subject: [PATCH] scsi: esp: Defer command completion until previous interrupts
 have been handled

The guest OS reads RSTAT, RSEQ, and RINTR, and expects those registers
to reflect a consistent state. However, it is possible that the registers
can change after RSTAT was read, but before RINTR is read, when
esp_command_complete() is called.

Guest OS		qemu
--------		----
[handle interrupt]
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

Defer handling command completion until previous interrupts have been
handled to fix the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This looks much cleaner than the previous patch and at the same time
identifies the problem. Enabling the new trace shows that the condition
is seen on a regular basis (on average 2-3 times per boot test with
qemu-system-hppa if the test does nothing but shut down immediately).

 hw/scsi/esp.c         | 29 ++++++++++++++++++++++++-----
 hw/scsi/trace-events  |  1 +
 include/hw/scsi/esp.h |  2 ++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 630d923..e3d6cc5 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -286,11 +286,8 @@ static void esp_do_dma(ESPState *s)
     esp_dma_done(s);
 }
 
-void esp_command_complete(SCSIRequest *req, uint32_t status,
-                                 size_t resid)
+static void _esp_command_complete(ESPState *s, uint32_t status)
 {
-    ESPState *s = req->hba_private;
-
     trace_esp_command_complete();
     if (s->ti_size != 0) {
         trace_esp_command_complete_unexpected();
@@ -311,6 +308,23 @@ void esp_command_complete(SCSIRequest *req, uint32_t status,
     }
 }
 
+void esp_command_complete(SCSIRequest *req, uint32_t status,
+                          size_t resid)
+{
+    ESPState *s = req->hba_private;
+
+    if (s->rregs[ESP_RSTAT] & STAT_INT) {
+        /* Defer handling command complete until the previous
+         * interrupt has been handled.
+         */
+        trace_esp_command_complete_deferred();
+        s->deferred_status = status;
+        s->deferred_complete = true;
+        return;
+    }
+    _esp_command_complete(s, status);
+}
+
 void esp_transfer_data(SCSIRequest *req, uint32_t len)
 {
     ESPState *s = req->hba_private;
@@ -422,7 +436,10 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         s->rregs[ESP_RSEQ] = SEQ_CD;
         esp_lower_irq(s);
-
+        if (s->deferred_complete) {
+            _esp_command_complete(s, s->deferred_status);
+            s->deferred_complete = false;
+        }
         return old_val;
     case ESP_TCHI:
         /* Return the unique id if the value has never been written */
@@ -582,6 +599,8 @@ const VMStateDescription vmstate_esp = {
         VMSTATE_UINT32(ti_wptr, ESPState),
         VMSTATE_BUFFER(ti_buf, ESPState),
         VMSTATE_UINT32(status, ESPState),
+        VMSTATE_UINT32(deferred_status, ESPState),
+        VMSTATE_BOOL(deferred_complete, ESPState),
         VMSTATE_UINT32(dma, ESPState),
         VMSTATE_PARTIAL_BUFFER(cmdbuf, ESPState, 16),
         VMSTATE_BUFFER_START_MIDDLE_V(cmdbuf, ESPState, 16, 4),
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 0fb6a99..2fe8a7c 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -167,6 +167,7 @@ esp_handle_satn_stop(uint32_t cmdlen) "cmdlen %d"
 esp_write_response(uint32_t status) "Transfer status (status=%d)"
 esp_do_dma(uint32_t cmdlen, uint32_t len) "command len %d + %d"
 esp_command_complete(void) "SCSI Command complete"
+esp_command_complete_deferred(void) "SCSI Command complete deferred"
 esp_command_complete_unexpected(void) "SCSI command completed unexpectedly"
 esp_command_complete_fail(void) "Command failed"
 esp_transfer_data(uint32_t dma_left, int32_t ti_size) "transfer %d/%d"
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 682a0d2..adab63d 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -23,6 +23,8 @@ struct ESPState {
     int32_t ti_size;
     uint32_t ti_rptr, ti_wptr;
     uint32_t status;
+    uint32_t deferred_status;
+    bool deferred_complete;
     uint32_t dma;
     uint8_t ti_buf[TI_BUFSZ];
     SCSIBus bus;
-- 
2.7.4


--9amGYk9869ThD9tj--
