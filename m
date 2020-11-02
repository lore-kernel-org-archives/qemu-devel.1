Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFAEC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3672084C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="YTfz8sSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3672084C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbA8-0002MS-Kg
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kZb8k-0001AA-NX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:49:00 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:55265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kZb8d-0007AW-GM
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1604328531;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O4lN/nFPj6Dg10BjrFvx6wJqgawoIv0G+MT9lnkXiOs=;
 b=YTfz8sSCToW+7TFvOs0/3C+i+o75czUo0mrBUOQilF6dCAndebolWgVu
 H0XIvWvGlOs+zOaTEYFv/D5Kh8afVuz+z2yLyjJl6DwBNLhRSWblkGGgN
 fu8oj0AafZDa5XtOwnxKzalz9nLQuIFnvGHBCYGvqcFnG2TFp37LN6dhz M=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: vdNO5e+VUc5koX0bchd+sTWRuGYSQINfwtJEM9uq9qmSuUK96i/aPZW6Dt2D5YYO3KuFFzjWq1
 qT0KDXIr8gRmuiUFDfr9ay51ia/MItpkhFzgyilsxN8kzkjlLItUUDotVDtNWTh2ihTCBw7T6e
 IV0CL65k6bqM8ztZ7PNprLBirCWlkn2omOEIWEN5mB6mp3A51n3YGIuBVtoC7ukvEDDcX8YmPn
 7iJuxPiVWiMehZT7AH1+//4i2rFg8ArSoGzzsXu35WR74goh/OIRBGMQyDB04UON71IahamkDQ
 qzQ=
X-SBRS: None
X-MesageID: 30625389
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,445,1596513600"; d="scan'208";a="30625389"
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 1/1] xen: rework pci_piix3_xen_ide_unplug
Date: Mon, 2 Nov 2020 14:44:54 +0000
Message-ID: <20201102144454.995592-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201102144454.995592-1-anthony.perard@citrix.com>
References: <20201102144454.995592-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.142;
 envelope-from=anthony.perard@citrix.com; helo=esa1.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 09:48:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

This is to allow IDE disks to be unplugged when adding to QEMU via:
    -drive file=/root/disk_file,if=none,id=ide-disk0,format=raw
    -device ide-hd,drive=ide-disk0,bus=ide.0,unit=0

as the current code only works for disk added with:
    -drive file=/root/disk_file,if=ide,index=0,media=disk,format=raw

Since the code already have the IDE controller as `dev`, we don't need
to use the legacy DriveInfo to find all the drive we want to unplug.
We can simply use `blk` from the controller, as it kind of was already
assume to be the same, by setting it to NULL.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Acked-by: John Snow <jsnow@redhat.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20201027154058.495112-1-anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/ide/piix.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index b402a936362b..b9860e35a5c4 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -164,30 +164,29 @@ static void pci_piix_ide_realize(PCIDevice *dev, Error **errp)
 int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux)
 {
     PCIIDEState *pci_ide;
-    DriveInfo *di;
     int i;
     IDEDevice *idedev;
+    IDEBus *idebus;
+    BlockBackend *blk;
 
     pci_ide = PCI_IDE(dev);
 
     for (i = aux ? 1 : 0; i < 4; i++) {
-        di = drive_get_by_index(IF_IDE, i);
-        if (di != NULL && !di->media_cd) {
-            BlockBackend *blk = blk_by_legacy_dinfo(di);
-            DeviceState *ds = blk_get_attached_dev(blk);
+        idebus = &pci_ide->bus[i / 2];
+        blk = idebus->ifs[i % 2].blk;
 
-            blk_drain(blk);
-            blk_flush(blk);
-
-            if (ds) {
-                blk_detach_dev(blk, ds);
-            }
-            pci_ide->bus[di->bus].ifs[di->unit].blk = NULL;
+        if (blk && idebus->ifs[i % 2].drive_kind != IDE_CD) {
             if (!(i % 2)) {
-                idedev = pci_ide->bus[di->bus].master;
+                idedev = idebus->master;
             } else {
-                idedev = pci_ide->bus[di->bus].slave;
+                idedev = idebus->slave;
             }
+
+            blk_drain(blk);
+            blk_flush(blk);
+
+            blk_detach_dev(blk, DEVICE(idedev));
+            idebus->ifs[i % 2].blk = NULL;
             idedev->conf.blk = NULL;
             monitor_remove_blk(blk);
             blk_unref(blk);
-- 
Anthony PERARD


