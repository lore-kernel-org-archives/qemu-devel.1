Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACE3C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1772145D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLqInrcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1772145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxH8-0001dq-QI
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxCi-0005FS-DU
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxCg-0008Vv-MV
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602506726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEfJTmQm7IfbaNLnhhKiUk3mZKxHaYrO9aWEgNYf1LY=;
 b=eLqInrccy2QDgw0SL2TZj+s7G9Rlr3MC6t82q2/zg+uDMBjDRMIOdloT2P2M3tYOwaTaIs
 x7TZB3ucdYNDt4oH9UedIIURKzm8Kd8B1mDDL7Ano1ATct056PwbLiRGhj35UFMshjp+zV
 v6iKG6mpmOKFlMzNgU1QBmaFGcAAmBo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-M_x1QKMtMCKR4JLJ9auc4w-1; Mon, 12 Oct 2020 08:45:22 -0400
X-MC-Unique: M_x1QKMtMCKR4JLJ9auc4w-1
Received: by mail-wr1-f70.google.com with SMTP id y6so4514200wra.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uEfJTmQm7IfbaNLnhhKiUk3mZKxHaYrO9aWEgNYf1LY=;
 b=WjkhQCy76EDm4ixb8bA564ieixojECFYTOpNXqN/HbhpwV1R+6rcF2vPcizeZb2vxo
 hfDE7CP+btzDQMWkIgLp/mT9vg10CEmpyzudbtZ8hRtbpRwIkwjkPuhQMTAY3ngh7Cky
 qNZM02vZr3P6z+qWwkLAttSeGnvWQTOT9FNIF5vywCjOw9MMwDJZacGD7X1tgt9HjTn8
 LOFEjEbVXsVe+B4wzW9SAanhco/e7xTQ9aRnW+ViDNEQUo9Pkhr8JULmUrmEvcXBAMLc
 TpwElLpLxtp2yyjnOyYyOV3ecKxqtlnoSX8G0u9KfDyV6D5yCtEbMFKZcxQ0IZRJ2/L+
 xtmA==
X-Gm-Message-State: AOAM532pLg+j5Tp3blwFBWgnsCxVpMX4irmpRj+HuuMDCBydqhsUNjcz
 8EnrWJ0vBuwC7gGVrM2PICLZgH1eA75rDrX/8d4PYPHOBcTC1BZ5IAcRQmpXsvtC9J+R5Sm9HYr
 iF85Mh3Q4LHRXjZw=
X-Received: by 2002:adf:8b85:: with SMTP id o5mr16319184wra.104.1602506720842; 
 Mon, 12 Oct 2020 05:45:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUet7a3+icknkdXIUBYsqHO/fz4MbL6X5ByiZqEc6CjjMuhyc0L0IjJS+YtIXZM/ET90duwQ==
X-Received: by 2002:adf:8b85:: with SMTP id o5mr16319151wra.104.1602506720677; 
 Mon, 12 Oct 2020 05:45:20 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b5sm2564766wrs.97.2020.10.12.05.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:45:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/pci-host: Use the PCI_BUILD_BDF() macro from
 'hw/pci/pci.h'
Date: Mon, 12 Oct 2020 14:45:03 +0200
Message-Id: <20201012124506.3406909-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012124506.3406909-1-philmd@redhat.com>
References: <20201012124506.3406909-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We already have a generic PCI_BUILD_BDF() macro in "hw/pci/pci.h"
to pack these values, use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c   | 3 +--
 hw/pci-host/pnv_phb4.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index abb3ee86769..b05295639a6 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -196,8 +196,7 @@ FIELD(BONGENCFG, PCIQUEUE,      12, 1)
 #define PCI_IDSEL_VIA686B          (1 << PCI_IDSEL_VIA686B_BIT)
 
 #define PCI_ADDR(busno , devno , funno , regno)  \
-    ((((busno) << 8) & 0xff00) + (((devno) << 3) & 0xf8) + \
-    (((funno) & 0x7) << 8) + (regno))
+    ((PCI_BUILD_BDF(busno, PCI_DEVFN(devno , funno)) << 8) + (regno))
 
 typedef struct BonitoState BonitoState;
 
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 03daf40a237..6328e985f81 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -889,7 +889,7 @@ static bool pnv_phb4_resolve_pe(PnvPhb4DMASpace *ds)
     /* Read RTE */
     bus_num = pci_bus_num(ds->bus);
     addr = rtt & PHB_RTT_BASE_ADDRESS_MASK;
-    addr += 2 * ((bus_num << 8) | ds->devfn);
+    addr += 2 * PCI_BUILD_BDF(bus_num, ds->devfn);
     if (dma_memory_read(&address_space_memory, addr, &rte, sizeof(rte))) {
         phb_error(ds->phb, "Failed to read RTT entry at 0x%"PRIx64, addr);
         /* Set error bits ? fence ? ... */
-- 
2.26.2


