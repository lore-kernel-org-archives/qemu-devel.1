Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EA7C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49200206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky44pJQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49200206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR0mp-0005DH-8m
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 17:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthoine.bourgeois@gmail.com>) id 1jR0lv-0004nS-DV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <anthoine.bourgeois@gmail.com>) id 1jR0ls-0006st-9z
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:49:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthoine.bourgeois@gmail.com>)
 id 1jR0lr-0006ml-Pk
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:49:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id g13so12994wrb.8
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hxPz1+FV0NyZSt3UlOe4Pt8nN7VD9hUNy9KsDhU6z3U=;
 b=Ky44pJQwK1Uj5tBPWiJ7RpnKTPL7s80fa+99mURtxsWwTjd9efaNbhBJnOzC3xP31C
 DUkTSFVU8fZ8v+GQ45mL3rzNF3PcmDroyDuGSS97OeC2M1zo1pjCwMJRpSnSYa2IEACa
 HfonsjoWxH8z4mbpBvyzKGDnI2RPCde8s6djyoimmvvvJ09wOFqT/uSVAWasBck/DfJr
 jBZaj6G3ZNNIx9joO7ThUXKTaojix7bV5BiJdDlAt+SYwDI968Ovs+hUGDEEZCv3H688
 MklyQSl+QvR6lJtA8/GXqUylHOVUlNUt4I8xMIAI5oc+OkGYwWwpHSalHg+oQbI740a7
 uvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hxPz1+FV0NyZSt3UlOe4Pt8nN7VD9hUNy9KsDhU6z3U=;
 b=f+PeBIiLlKzgExIYfvXOSlORFRvOZ2xxmX54wS6IV2VIXekPR+f7iOEcCWZmhaxmGI
 cN8OpfwXtnkE4Yx+QK/7x2KT2U/HKjEyz3WCEca7cbtrMvyowNU4nb0YmFUrsbPj/TWt
 VlC0eQwMyceS/s2Lj+6GLLLwa+VOTclWOCfSMXKYLc5vN4FEobAY4TOmFStU/b364bMe
 CgAvuCfXCj1gMK+z1kVY8KEQdlCQ9S35hGL5EKDmnVHNPAKhainuoRx47XqCyLbwiYiu
 i0XxBKZiQo9tB4pXBvpOKzh+Ltv2spRugu6vXb4KzAeI0rnLKeUIJVELRJMdDfk4+YMa
 AkTg==
X-Gm-Message-State: AGi0PuZFKNPgLwLo+EGWTNmex8VGc/QK/fOt9hZKPMt4bjc7Yvu2MRAx
 mPYlCgfsTMAxuBYRIiYqbcw=
X-Google-Smtp-Source: APiQypINmV7DUR/U9mubNJVbkNPvVVUxYRiCh/PXLqi7w8mRs8T1QgmxNVR3CeoWhP4rJGOyl7CpXg==
X-Received: by 2002:a5d:4b90:: with SMTP id b16mr27723224wrt.16.1587505773171; 
 Tue, 21 Apr 2020 14:49:33 -0700 (PDT)
Received: from hobbes.blade-group.net
 ([2a01:e35:2fb2:a0d0:6d28:3d72:693e:c474])
 by smtp.gmail.com with ESMTPSA id z1sm5051596wmf.15.2020.04.21.14.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 14:49:32 -0700 (PDT)
From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] virtio-vga: fix virtio-vga bar ordering
Date: Tue, 21 Apr 2020 23:48:53 +0200
Message-Id: <20200421214853.14412-1-anthoine.bourgeois@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=anthoine.bourgeois@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With virtio-vga, pci bar are reordered. Bar #2 is used for compatibility
with stdvga. By default, bar #2 is used by virtio modern io bar.
This bar is the last one introduce in the virtio pci bar layout and it's
crushed by the virtio-vga reordering. So virtio-vga and
modern-pio-notify are incompatible because virtio-vga failed to
initialize with this option.

This fix exchange the modern io bar with the modern memory bar,
replacing the msix bar that is never impacted anyway.

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
---
 hw/display/virtio-vga.c | 2 +-
 hw/virtio/virtio-pci.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 2b4c2aa126..f5f8737c60 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -113,7 +113,7 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
      * the stdvga mmio registers at the start of bar #2.
      */
     vpci_dev->modern_mem_bar_idx = 2;
-    vpci_dev->msix_bar_idx = 4;
+    vpci_dev->modern_io_bar_idx = 4;
 
     if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
         /*
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4cb784389c..9c5efaa06e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1705,6 +1705,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
      *
      *   region 0   --  virtio legacy io bar
      *   region 1   --  msi-x bar
+     *   region 2   --  virtio modern io bar
      *   region 4+5 --  virtio modern memory (64bit) bar
      *
      */
-- 
2.20.1


