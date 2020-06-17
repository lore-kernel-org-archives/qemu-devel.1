Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC0DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736572073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtrdoKiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736572073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZPS-0005RM-Du
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNT-0002iH-JJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34817
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNP-0001d3-8b
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVFz5Q176/3p6VzQR0SwPBqhCFRMIJcNYF6vMJCwZ0Y=;
 b=FtrdoKiPgW1XZoAs0DfSNMqYDqwREZDzJWPKy8CNuhEINV15B0XzIoJUzDNeybjO9lyCmI
 zTdqpb+m4DjnSuPPK9wK1cP0lLwlrTHRr65stZ2qo2qK/J4wBV8g3Ou5+4/zUbFMi8d6H9
 xvzxCNQmQDBLqN+faYp2wsCqqKdydls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401--zJqdMBdN0m4tnEQWGgFlg-1; Wed, 17 Jun 2020 10:49:15 -0400
X-MC-Unique: -zJqdMBdN0m4tnEQWGgFlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE7D418A266A;
 Wed, 17 Jun 2020 14:49:14 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E77EA7CAA0;
 Wed, 17 Jun 2020 14:49:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/43] hw/ide: Make IDEDMAOps handlers take a const IDEDMA
 pointer
Date: Wed, 17 Jun 2020 16:48:27 +0200
Message-Id: <20200617144909.192176-2-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Handlers don't need to modify the IDEDMA structure.
Make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200512194917.15807-1-philmd@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/ide/internal.h | 12 ++++++------
 hw/ide/ahci.c             | 18 +++++++++---------
 hw/ide/core.c             |  6 +++---
 hw/ide/macio.c            |  6 +++---
 hw/ide/pci.c              | 12 ++++++------
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 55da35d768..1a7869e85d 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -322,12 +322,12 @@ typedef enum { IDE_HD, IDE_CD, IDE_CFATA } IDEDriveKind;
 
 typedef void EndTransferFunc(IDEState *);
 
-typedef void DMAStartFunc(IDEDMA *, IDEState *, BlockCompletionFunc *);
-typedef void DMAVoidFunc(IDEDMA *);
-typedef int DMAIntFunc(IDEDMA *, bool);
-typedef int32_t DMAInt32Func(IDEDMA *, int32_t len);
-typedef void DMAu32Func(IDEDMA *, uint32_t);
-typedef void DMAStopFunc(IDEDMA *, bool);
+typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
+typedef void DMAVoidFunc(const IDEDMA *);
+typedef int DMAIntFunc(const IDEDMA *, bool);
+typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
+typedef void DMAu32Func(const IDEDMA *, uint32_t);
+typedef void DMAStopFunc(const IDEDMA *, bool);
 
 struct unreported_events {
     bool eject_request;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index fc82cbd5f1..009120f88b 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -44,7 +44,7 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot);
 static void ahci_reset_port(AHCIState *s, int port);
 static bool ahci_write_fis_d2h(AHCIDevice *ad);
 static void ahci_init_d2h(AHCIDevice *ad);
-static int ahci_dma_prepare_buf(IDEDMA *dma, int32_t limit);
+static int ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit);
 static bool ahci_map_clb_address(AHCIDevice *ad);
 static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
@@ -1338,7 +1338,7 @@ out:
 }
 
 /* Transfer PIO data between RAM and device */
-static void ahci_pio_transfer(IDEDMA *dma)
+static void ahci_pio_transfer(const IDEDMA *dma)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
     IDEState *s = &ad->port.ifs[0];
@@ -1397,7 +1397,7 @@ out:
     }
 }
 
-static void ahci_start_dma(IDEDMA *dma, IDEState *s,
+static void ahci_start_dma(const IDEDMA *dma, IDEState *s,
                            BlockCompletionFunc *dma_cb)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
@@ -1406,7 +1406,7 @@ static void ahci_start_dma(IDEDMA *dma, IDEState *s,
     dma_cb(s, 0);
 }
 
-static void ahci_restart_dma(IDEDMA *dma)
+static void ahci_restart_dma(const IDEDMA *dma)
 {
     /* Nothing to do, ahci_start_dma already resets s->io_buffer_offset.  */
 }
@@ -1415,7 +1415,7 @@ static void ahci_restart_dma(IDEDMA *dma)
  * IDE/PIO restarts are handled by the core layer, but NCQ commands
  * need an extra kick from the AHCI HBA.
  */
-static void ahci_restart(IDEDMA *dma)
+static void ahci_restart(const IDEDMA *dma)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
     int i;
@@ -1432,7 +1432,7 @@ static void ahci_restart(IDEDMA *dma)
  * Called in DMA and PIO R/W chains to read the PRDT.
  * Not shared with NCQ pathways.
  */
-static int32_t ahci_dma_prepare_buf(IDEDMA *dma, int32_t limit)
+static int32_t ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
     IDEState *s = &ad->port.ifs[0];
@@ -1453,7 +1453,7 @@ static int32_t ahci_dma_prepare_buf(IDEDMA *dma, int32_t limit)
  * Called via dma_buf_commit, for both DMA and PIO paths.
  * sglist destruction is handled within dma_buf_commit.
  */
-static void ahci_commit_buf(IDEDMA *dma, uint32_t tx_bytes)
+static void ahci_commit_buf(const IDEDMA *dma, uint32_t tx_bytes)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
 
@@ -1461,7 +1461,7 @@ static void ahci_commit_buf(IDEDMA *dma, uint32_t tx_bytes)
     ad->cur_cmd->status = cpu_to_le32(tx_bytes);
 }
 
-static int ahci_dma_rw_buf(IDEDMA *dma, bool is_write)
+static int ahci_dma_rw_buf(const IDEDMA *dma, bool is_write)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
     IDEState *s = &ad->port.ifs[0];
@@ -1486,7 +1486,7 @@ static int ahci_dma_rw_buf(IDEDMA *dma, bool is_write)
     return 1;
 }
 
-static void ahci_cmd_done(IDEDMA *dma)
+static void ahci_cmd_done(const IDEDMA *dma)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 689bb36409..d997a78e47 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2570,16 +2570,16 @@ static void ide_init1(IDEBus *bus, int unit)
                                            ide_sector_write_timer_cb, s);
 }
 
-static int ide_nop_int(IDEDMA *dma, bool is_write)
+static int ide_nop_int(const IDEDMA *dma, bool is_write)
 {
     return 0;
 }
 
-static void ide_nop(IDEDMA *dma)
+static void ide_nop(const IDEDMA *dma)
 {
 }
 
-static int32_t ide_nop_int32(IDEDMA *dma, int32_t l)
+static int32_t ide_nop_int32(const IDEDMA *dma, int32_t l)
 {
     return 0;
 }
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 30af0e93e6..62a599a075 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -376,17 +376,17 @@ static void macio_ide_reset(DeviceState *dev)
     ide_bus_reset(&d->bus);
 }
 
-static int ide_nop_int(IDEDMA *dma, bool is_write)
+static int ide_nop_int(const IDEDMA *dma, bool is_write)
 {
     return 0;
 }
 
-static int32_t ide_nop_int32(IDEDMA *dma, int32_t l)
+static int32_t ide_nop_int32(const IDEDMA *dma, int32_t l)
 {
     return 0;
 }
 
-static void ide_dbdma_start(IDEDMA *dma, IDEState *s,
+static void ide_dbdma_start(const IDEDMA *dma, IDEState *s,
                             BlockCompletionFunc *cb)
 {
     MACIOIDEState *m = container_of(dma, MACIOIDEState, dma);
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 97347f07f1..5e85c4ad17 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -103,7 +103,7 @@ const MemoryRegionOps pci_ide_data_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void bmdma_start_dma(IDEDMA *dma, IDEState *s,
+static void bmdma_start_dma(const IDEDMA *dma, IDEState *s,
                             BlockCompletionFunc *dma_cb)
 {
     BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
@@ -126,7 +126,7 @@ static void bmdma_start_dma(IDEDMA *dma, IDEState *s,
  * IDEState.io_buffer_size will contain the number of bytes described
  * by the PRDs, whether or not we added them to the sglist.
  */
-static int32_t bmdma_prepare_buf(IDEDMA *dma, int32_t limit)
+static int32_t bmdma_prepare_buf(const IDEDMA *dma, int32_t limit)
 {
     BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
     IDEState *s = bmdma_active_if(bm);
@@ -181,7 +181,7 @@ static int32_t bmdma_prepare_buf(IDEDMA *dma, int32_t limit)
 }
 
 /* return 0 if buffer completed */
-static int bmdma_rw_buf(IDEDMA *dma, bool is_write)
+static int bmdma_rw_buf(const IDEDMA *dma, bool is_write)
 {
     BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
     IDEState *s = bmdma_active_if(bm);
@@ -230,7 +230,7 @@ static int bmdma_rw_buf(IDEDMA *dma, bool is_write)
     return 1;
 }
 
-static void bmdma_set_inactive(IDEDMA *dma, bool more)
+static void bmdma_set_inactive(const IDEDMA *dma, bool more)
 {
     BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
 
@@ -242,7 +242,7 @@ static void bmdma_set_inactive(IDEDMA *dma, bool more)
     }
 }
 
-static void bmdma_restart_dma(IDEDMA *dma)
+static void bmdma_restart_dma(const IDEDMA *dma)
 {
     BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
 
@@ -257,7 +257,7 @@ static void bmdma_cancel(BMDMAState *bm)
     }
 }
 
-static void bmdma_reset(IDEDMA *dma)
+static void bmdma_reset(const IDEDMA *dma)
 {
     BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
 
-- 
2.25.4


