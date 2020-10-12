Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBC0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF8321BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7/Hgayk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF8321BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxM1-0000gi-Ux
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxCx-0005n2-1D
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxCu-0000Ac-PQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602506740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wGxJZcsEOLAGSmgs7p8pt5WGBHmly5siKydoVe/oZE=;
 b=Y7/HgaykXGJaGQG1ddlXdHHOTOYd1wURQ8nb8ZWa64+1Rx459M+bMwX7wddfBvNj9qjxS0
 Nd4g8YhzGiqJl1gR4ZxzdoQRDBc+hcXr+4kjoBSHj/HFJLgm/53tHu/4vO1Jkl+62wXf48
 ZdMH6nEJ9Jveq//6sLWsQNxuZS8qO+Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-fwcS_nsyNWOHGOu-Miv66w-1; Mon, 12 Oct 2020 08:45:38 -0400
X-MC-Unique: fwcS_nsyNWOHGOu-Miv66w-1
Received: by mail-wr1-f70.google.com with SMTP id 47so9255106wrc.19
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9wGxJZcsEOLAGSmgs7p8pt5WGBHmly5siKydoVe/oZE=;
 b=LV+yyIHfBFTaXJ9BgJagMr7z2D9XbwAjxpZIDoHoEHND6YZ5qCqhDlK5wyijCMw39I
 J5Ht49wDIqVfbHO/QJCWHED/4d086BnPYjgW2ciVMuZYoWKHeDQ7mGA1/tdCfk77DMa8
 boQ5G8P8zp9y249cjWsN+sis0quUNiy2P055tDw0UGzvmi0LCpQLQLjljH0qf+014RuV
 QXly+/77Lee1MtNea94jFKLHtBVdMQkZmP7RTDodBSvScPaIn0lnXyI3A4RoHRW7rcgu
 MJeNvctn44N+Qvk5vuzdzJJy4a4l5SupKkH1M/wBlJJGWbOh+ZfkR+c+AL1uq8PVBRBR
 nPRA==
X-Gm-Message-State: AOAM530/G/egoKso5hpfnh725CqXtb8+NiJwjtjiBfFZt0xvB6k4Tpja
 6mwVQTQnVRsnqUd1ptPckaQQNMUWm2kUuovWlYBfE5AAxORj6RYzgA1+QWaubhT6+I4tCfX3WBf
 7dC4WvdChtWNgxIk=
X-Received: by 2002:adf:dccc:: with SMTP id x12mr30544388wrm.241.1602506737184; 
 Mon, 12 Oct 2020 05:45:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGju9pLDMIkjylp5prt4ukBOzX2jmiDpK+NGjR15EPrzwXN0JDbAFCeWH5hcu15IBYdHhmBg==
X-Received: by 2002:adf:dccc:: with SMTP id x12mr30544349wrm.241.1602506736967; 
 Mon, 12 Oct 2020 05:45:36 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id s185sm22765462wmf.3.2020.10.12.05.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:45:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw: Use the PCI_DEVFN() macro from 'hw/pci/pci.h'
Date: Mon, 12 Oct 2020 14:45:06 +0200
Message-Id: <20201012124506.3406909-6-philmd@redhat.com>
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

We already have a generic PCI_DEVFN() macro in "hw/pci/pci.h"
to pack the PCI slot/function identifiers, use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/virt.c          | 3 ++-
 hw/pci-host/uninorth.c | 6 ++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e465a988d68..f601ef0798c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1144,7 +1144,8 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
                      full_irq_map, sizeof(full_irq_map));
 
     qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupt-map-mask",
-                           0x1800, 0, 0, /* devfn (PCI_SLOT(3)) */
+                           cpu_to_be16(PCI_DEVFN(3, 0)), /* Slot 3 */
+                           0, 0,
                            0x7           /* PCI irq */);
 }
 
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index c21de0ab805..f73d452bdce 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -70,10 +70,8 @@ static uint32_t unin_get_config_reg(uint32_t reg, uint32_t addr)
         /* ... and then convert them to x86 format */
         /* config pointer */
         retval = (reg & (0xff - 7)) | (addr & 7);
-        /* slot */
-        retval |= slot << 11;
-        /* fn */
-        retval |= func << 8;
+        /* slot, fn */
+        retval |= PCI_DEVFN(slot, func) << 8;
     }
 
     trace_unin_get_config_reg(reg, addr, retval);
-- 
2.26.2


