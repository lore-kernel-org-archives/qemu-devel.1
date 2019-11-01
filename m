Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B390CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F7321734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="HLkyojo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F7321734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQaGY-0006dP-Pt
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 12:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iQaDA-0005cI-Jb
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iQaD9-00038X-0k
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:55:44 -0400
Received: from shroom.duncanthrax.net ([2a01:4f8:121:41fa::169]:38399
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iQaD5-0002p8-4D; Fri, 01 Nov 2019 12:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z11+JlJLiMPMZITDK4+JSy7JMRvg3HXx+xrM/qAInK4=; b=HLkyojo04pEKiA7mWfdeUjnshh
 QRX3uunI5vLu1xAT03mdGBl0JrUvhYAA8yVspZncaouFXydDf2imD6jTAtGOMxH9EWbWxU5lEGmXY
 TW+8Ydz9sWFR7AzN83k1BRy8SrNHXla6L3Nz0gJVzbnT2RfMhGujCBzA89BdKmNoCVTk=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=x280.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1iQaCu-0000ZA-7w; Fri, 01 Nov 2019 17:55:28 +0100
From: Sven Schnelle <svens@stackframe.org>
To: John Snow <jsnow@redhat.com>
Subject: [PATCH v3] fdc/i8257: implement verify transfer mode
Date: Fri,  1 Nov 2019 17:55:13 +0100
Message-Id: <20191101165513.14229-1-svens@stackframe.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:121:41fa::169
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sven Schnelle <svens@stackframe.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While working on the Tulip driver i tried to write some Teledisk images to
a floppy image which didn't work. Turned out that Teledisk checks the written
data by issuing a READ command to the FDC but running the DMA controller
in VERIFY mode. As we ignored the DMA request in that case, the DMA transfer
never finished, and Teledisk reported an error.

The i8257 spec says about verify transfers:

3) DMA verify, which does not actually involve the transfer of data. When an
8257 channel is in the DMA verify mode, it will respond the same as described
for transfer operations, except that no memory or I/O read/write control signals
will be generated.

Hervé proposed to remove all the dma_mode_ok stuff from fdc to have a more
clear boundary between DMA and FDC, so this patch also does that.

Suggested-by: Hervé Poussineau <hpoussin@reactos.org>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/block/fdc.c       | 61 +++++++++++++-------------------------------
 hw/dma/i8257.c       | 20 ++++++++++-----
 include/hw/isa/isa.h |  1 -
 3 files changed, 31 insertions(+), 51 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index ac5d31e8c1..01812c7553 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1714,53 +1714,28 @@ static void fdctrl_start_transfer(FDCtrl *fdctrl, int direction)
     }
     fdctrl->eot = fdctrl->fifo[6];
     if (fdctrl->dor & FD_DOR_DMAEN) {
-        IsaDmaTransferMode dma_mode;
+        /* DMA transfer is enabled. */
         IsaDmaClass *k = ISADMA_GET_CLASS(fdctrl->dma);
-        bool dma_mode_ok;
-        /* DMA transfer are enabled. Check if DMA channel is well programmed */
-        dma_mode = k->get_transfer_mode(fdctrl->dma, fdctrl->dma_chann);
-        FLOPPY_DPRINTF("dma_mode=%d direction=%d (%d - %d)\n",
-                       dma_mode, direction,
-                       (128 << fdctrl->fifo[5]) *
+
+        FLOPPY_DPRINTF("direction=%d (%d - %d)\n",
+                       direction, (128 << fdctrl->fifo[5]) *
                        (cur_drv->last_sect - ks + 1), fdctrl->data_len);
-        switch (direction) {
-        case FD_DIR_SCANE:
-        case FD_DIR_SCANL:
-        case FD_DIR_SCANH:
-            dma_mode_ok = (dma_mode == ISADMA_TRANSFER_VERIFY);
-            break;
-        case FD_DIR_WRITE:
-            dma_mode_ok = (dma_mode == ISADMA_TRANSFER_WRITE);
-            break;
-        case FD_DIR_READ:
-            dma_mode_ok = (dma_mode == ISADMA_TRANSFER_READ);
-            break;
-        case FD_DIR_VERIFY:
-            dma_mode_ok = true;
-            break;
-        default:
-            dma_mode_ok = false;
-            break;
-        }
-        if (dma_mode_ok) {
-            /* No access is allowed until DMA transfer has completed */
-            fdctrl->msr &= ~FD_MSR_RQM;
-            if (direction != FD_DIR_VERIFY) {
-                /* Now, we just have to wait for the DMA controller to
-                 * recall us...
-                 */
-                k->hold_DREQ(fdctrl->dma, fdctrl->dma_chann);
-                k->schedule(fdctrl->dma);
-            } else {
-                /* Start transfer */
-                fdctrl_transfer_handler(fdctrl, fdctrl->dma_chann, 0,
-                                        fdctrl->data_len);
-            }
-            return;
+
+        /* No access is allowed until DMA transfer has completed */
+        fdctrl->msr &= ~FD_MSR_RQM;
+        if (direction != FD_DIR_VERIFY) {
+            /*
+             * Now, we just have to wait for the DMA controller to
+             * recall us...
+             */
+            k->hold_DREQ(fdctrl->dma, fdctrl->dma_chann);
+            k->schedule(fdctrl->dma);
         } else {
-            FLOPPY_DPRINTF("bad dma_mode=%d direction=%d\n", dma_mode,
-                           direction);
+            /* Start transfer */
+            fdctrl_transfer_handler(fdctrl, fdctrl->dma_chann, 0,
+                    fdctrl->data_len);
         }
+        return;
     }
     FLOPPY_DPRINTF("start non-DMA transfer\n");
     fdctrl->msr |= FD_MSR_NONDMA | FD_MSR_RQM;
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 792f617eb4..85dad3d391 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -292,12 +292,6 @@ static uint64_t i8257_read_cont(void *opaque, hwaddr nport, unsigned size)
     return val;
 }
 
-static IsaDmaTransferMode i8257_dma_get_transfer_mode(IsaDma *obj, int nchan)
-{
-    I8257State *d = I8257(obj);
-    return (d->regs[nchan & 3].mode >> 2) & 3;
-}
-
 static bool i8257_dma_has_autoinitialization(IsaDma *obj, int nchan)
 {
     I8257State *d = I8257(obj);
@@ -400,6 +394,11 @@ static void i8257_dma_register_channel(IsaDma *obj, int nchan,
     r->opaque = opaque;
 }
 
+static bool i8257_is_verify_transfer(I8257Regs *r)
+{
+    return (r->mode & 0x0c) == 0;
+}
+
 static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int pos,
                                  int len)
 {
@@ -407,6 +406,10 @@ static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int pos,
     I8257Regs *r = &d->regs[nchan & 3];
     hwaddr addr = ((r->pageh & 0x7f) << 24) | (r->page << 16) | r->now[ADDR];
 
+    if (i8257_is_verify_transfer(r)) {
+        return len;
+    }
+
     if (r->mode & 0x20) {
         int i;
         uint8_t *p = buf;
@@ -431,6 +434,10 @@ static int i8257_dma_write_memory(IsaDma *obj, int nchan, void *buf, int pos,
     I8257Regs *r = &s->regs[nchan & 3];
     hwaddr addr = ((r->pageh & 0x7f) << 24) | (r->page << 16) | r->now[ADDR];
 
+    if (i8257_is_verify_transfer(r)) {
+        return len;
+    }
+
     if (r->mode & 0x20) {
         int i;
         uint8_t *p = buf;
@@ -597,7 +604,6 @@ static void i8257_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_i8257;
     dc->props = i8257_properties;
 
-    idc->get_transfer_mode = i8257_dma_get_transfer_mode;
     idc->has_autoinitialization = i8257_dma_has_autoinitialization;
     idc->read_memory = i8257_dma_read_memory;
     idc->write_memory = i8257_dma_write_memory;
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 018ada4f6f..f516e253c5 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -56,7 +56,6 @@ typedef int (*IsaDmaTransferHandler)(void *opaque, int nchan, int pos,
 typedef struct IsaDmaClass {
     InterfaceClass parent;
 
-    IsaDmaTransferMode (*get_transfer_mode)(IsaDma *obj, int nchan);
     bool (*has_autoinitialization)(IsaDma *obj, int nchan);
     int (*read_memory)(IsaDma *obj, int nchan, void *buf, int pos, int len);
     int (*write_memory)(IsaDma *obj, int nchan, void *buf, int pos, int len);
-- 
2.23.0


