Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0676CC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9AD2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4uqe4aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9AD2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVAb-0005RS-2u
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8a-0003gz-IN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8W-0007Fi-7w
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJH7iZei/FUThhkCklYQGVmfL7OJejtyEbzG9hdsPU0=;
 b=G4uqe4aOv01YJdqYif+e2Mw+I8jmiVATAbAgbCrNbEbs9Di/716NxZlKEWJcd2IxhBiDAt
 OIin2s3x4TuYm4BXRy0OLAnTskVnBZw4ciYMV/Sh4I4I3lCQ6XfN6Bmgdy/ubMyM92r3RP
 CGNJKFl4Wisbh74N00vkzawat4hcLxM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-Z1H_bqEsM1WXEuvfMStGfg-1; Fri, 30 Oct 2020 10:12:06 -0400
X-MC-Unique: Z1H_bqEsM1WXEuvfMStGfg-1
Received: by mail-wr1-f72.google.com with SMTP id m20so2704306wrb.21
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rJH7iZei/FUThhkCklYQGVmfL7OJejtyEbzG9hdsPU0=;
 b=WUZxnd/010cBFtslt3KXDOod8Nw09Fe91QcAIVaPIAgMyypHTZPAo8uv+Idh83blJL
 wJ0Ob8mHXvt6sKJ/Pe1AWic2CbqPSi5P33HZdZ++li72KXqLUyh2yjXrJnHKa9+LPFQf
 sy+w8FVRAnz/D/iyLuvf7s8CuK5CuYMjrAtOFZWGQrEHVGMvFIUqkfaO703P+zAYHjiE
 Krg2PT0bD8dmKcmiKGDpOxCyy/iOT8Ohuc+DMGvePRFKCkve0pv9s2eon44ThRrnMwN6
 RzdLdGbyQD3+xDxRz2oyDAFY6kyb8Z+94qoyHrvGVkZkPid0Dns9phDeYJdnP+ifcxF/
 lOEw==
X-Gm-Message-State: AOAM5317u+4kJTW1LGBOMPF7jQWPf9o0QcoYTD1Speo5tVhkFXSnnjef
 UjY1TzKVxKkUGheSLqlykUY/xWXOE1aLk3OXMdy55ume9ecf7JP9HdA/Ojg1n9Sl4SLLVfTweL7
 4+CWt0Fh5KHnKb6A=
X-Received: by 2002:a5d:4747:: with SMTP id o7mr3543326wrs.423.1604067124405; 
 Fri, 30 Oct 2020 07:12:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7w+2Y04FRPM846EQJivrPXE9bZkKljysc9zSbbPwK9GD/heTRctZf2hWk9oDVJCO/KBzivw==
X-Received: by 2002:a5d:4747:: with SMTP id o7mr3543310wrs.423.1604067124223; 
 Fri, 30 Oct 2020 07:12:04 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y200sm266949wmc.23.2020.10.30.07.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:12:03 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:12:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/15] hw/pci: Extract pci_bus_change_irq_level() from
 pci_change_irq_level()
Message-ID: <20201030141136.1013521-7-mst@redhat.com>
References: <20201030141136.1013521-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030141136.1013521-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Extract pci_bus_change_irq_level() from pci_change_irq_level() to
make it clearer it operates on the bus.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201024203900.3619498-2-f4bug@amsat.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 100c9381c2..081ddcadd1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -248,6 +248,12 @@ static inline void pci_set_irq_state(PCIDevice *d, int irq_num, int level)
         d->irq_state |= level << irq_num;
 }
 
+static void pci_bus_change_irq_level(PCIBus *bus, int irq_num, int change)
+{
+    bus->irq_count[irq_num] += change;
+    bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
+}
+
 static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
 {
     PCIBus *bus;
@@ -258,8 +264,7 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
             break;
         pci_dev = bus->parent_dev;
     }
-    bus->irq_count[irq_num] += change;
-    bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
+    pci_bus_change_irq_level(bus, irq_num, change);
 }
 
 int pci_bus_get_irq_level(PCIBus *bus, int irq_num)
-- 
MST


