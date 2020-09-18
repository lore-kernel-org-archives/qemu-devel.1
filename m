Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D56EC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4FE21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="NUM3J8jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4FE21D42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHpE-0005LO-37
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kJHnK-0003cm-5L; Fri, 18 Sep 2020 10:55:27 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:3996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kJHnC-0005w4-Th; Fri, 18 Sep 2020 10:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1600440919;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MI2M58kBJ1OEcBYbATKIFzPQ8de4fGGgBCGB9RvSrMg=;
 b=NUM3J8jTCMvTCI68CQa+jOkYOHJMlEzynfU61iQVXd2lxuA+vClL33q5
 CqjgSD6DuQezD0jBs/BQhoqxsTlyLb9AjHibla/Ip68bF9byq3um8q+w3
 BbHuBOKjx7FwUmPdm6soI7xV1/8o4ryfe0d1IsgqTxloZ7ugjziawi+6j s=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: 9wn8DzkPAbEk+42aOJVeszh+QmSzR9AvwPVOCi6VmW7cV2vboCHk7xkXWQNhkIbHCVz185d4To
 BUlLS2ddAaQO+UXpoyJPFdWHrrzsWumGuKyUKCF6MUoh4C1nwPLmh811tBylJFN6xoiPSvkDR2
 YjqZZLU1SaJ/vYoe7NL4BR0IL6bJ/ogYg7RdH0VDhQDOa+9kg6gAFQw6ya7uDKNukk6mIlxWt0
 aZ5O9km/hof9UHErR6905Y3AE4wwbKQsvamqU0CBf5q6LFolTywo1UUDWZeg9fEE9Ldc1an9w5
 u/s=
X-SBRS: 2.7
X-MesageID: 27038931
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,274,1596513600"; d="scan'208";a="27038931"
To: <qemu-devel@nongnu.org>
CC: Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony.perard@citrix.com>, John Snow <jsnow@redhat.com>, 
 <qemu-block@nongnu.org>
Subject: [PATCH] xen: rework pci_piix3_xen_ide_unplug
Date: Fri, 18 Sep 2020 15:52:56 +0100
Message-ID: <20200918145256.1886250-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.153;
 envelope-from=anthony.perard@citrix.com; helo=esa2.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 10:55:13
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
---
 hw/ide/piix.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index b402a936362b..16fcbe58d6fe 100644
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
+        if (blk && idebus->ifs[i%2].drive_kind != IDE_CD) {
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


