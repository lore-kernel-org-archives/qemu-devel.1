Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FCFC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D28A2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDm98M/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D28A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZB8-0004kU-Nl
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY46-0007dd-Uj
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY45-0004OJ-My
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:30 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:53444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY45-0004Kc-Fr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:29 -0500
Received: by mail-wm1-x32a.google.com with SMTP id m24so1555627wmc.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Z/hXY9tyxJP4bVUicIuKlm95MuHXrp390uv2lcHmGj0=;
 b=rDm98M/WphT/aoL4zE4nk0r6gR+5HRziKtZ866QuYYuA3cibw3+t6BSAqVqSmZbrhZ
 T23VN4uTEXNWl+TmRIKI8l+fuvSK4STMI+PlBGCMpXPgAst7GRC4vnoeDql8LocC5Pn+
 7VGS8sWHkqck/513Mf9tYsY9HngNbiS7mo7HQwF+OaDCJlNGheuhBmslmDPk3CZJegQy
 +L5iQMSjTrqfFRmHktS4pHZcZSHHReufxmM4HzyGoUNWBfm5gS9+x+VCWNCqBDMJ9eF5
 9FWWcqjrL+/zrO8wHLIgjsRUCYR5N/1TLvZV0cwsm1qkHGk+Jt7VMKLIESo5MI49V6f7
 kkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Z/hXY9tyxJP4bVUicIuKlm95MuHXrp390uv2lcHmGj0=;
 b=sM051OuVn8duVZtNIHEySqd0Y1/eBsLPHaBiuz4UNQgJFKAB32X750TcHl4trqOkyA
 mFwUuy61HkDrblpbw1WQoEkniguZ3mBp+CPeWbHuSrT+xsN8WwlpV7acEJxGyL2f4DvO
 0EA6zphYIhNNjzKY/pBihcV2HscqDo6jwe1OyyCmNj0OoLTasacH/iblJg75itBqWhJW
 jRzBAvnDMnisQ103rdSV6zkA+nEWVNZZYV5F2y3fxGu72Pk+1y6VO/LuflM2coPZdTPZ
 u10NVxGsRo3k2tF0jTPUXoAmjFvUXH4rkAVRCfOeH6j91sORbBUZTkjR9uzAg1vdoi80
 ActQ==
X-Gm-Message-State: APjAAAVjB6mN8M4he4FxoLa1IE16FHmgEsoQlU3Cvw8fY8c8X5zv/huk
 dgYVA+d3kAHXZ/kjjz5VcAlPZLYY
X-Google-Smtp-Source: APXvYqxlTm5T37D7m9hBcABsn5EHOcDW3+gEVEf/FS7wFKGKWh6MMV/CeRK3FlSPtvZVoqNboWbnAg==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr3040979wmi.15.1576670668222; 
 Wed, 18 Dec 2019 04:04:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 86/87] hw/display: Remove "rombar" hack from vga-pci and
 vmware_vga
Date: Wed, 18 Dec 2019 13:02:52 +0100
Message-Id: <1576670573-48048-87-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Now that the old pc-0.x machine types have been removed, we do not need
the old "rombar" hacks anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191209125248.5849-5-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga-pci.c    | 5 -----
 hw/display/vga.c        | 4 +---
 hw/display/vmware_vga.c | 5 -----
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index a27b881..cfe0957 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -264,11 +264,6 @@ static void pci_std_vga_realize(PCIDevice *dev, Error **errp)
 
         pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
     }
-
-    if (!dev->rom_bar) {
-        /* compatibility with pc-0.13 and older */
-        vga_init_vbe(s, OBJECT(dev), pci_address_space(dev));
-    }
 }
 
 static void pci_std_vga_init(Object *obj)
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 82ebe53..636586a 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2304,9 +2304,7 @@ void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
 
 void vga_init_vbe(VGACommonState *s, Object *obj, MemoryRegion *system_memory)
 {
-    /* With pc-0.12 and below we map both the PCI BAR and the fixed VBE region,
-     * so use an alias to avoid double-mapping the same region.
-     */
+    /* Use an alias to avoid double-mapping the same region */
     memory_region_init_alias(&s->vram_vbe, obj, "vram.vbe",
                              &s->vram, 0, memory_region_size(&s->vram));
     /* XXX: use optimized standard vga accesses */
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 23dc891..ead754e 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1312,11 +1312,6 @@ static void pci_vmsvga_realize(PCIDevice *dev, Error **errp)
                      &s->chip.vga.vram);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_MEM_PREFETCH,
                      &s->chip.fifo_ram);
-
-    if (!dev->rom_bar) {
-        /* compatibility with pc-0.13 and older */
-        vga_init_vbe(&s->chip.vga, OBJECT(dev), pci_address_space(dev));
-    }
 }
 
 static Property vga_vmware_properties[] = {
-- 
1.8.3.1



