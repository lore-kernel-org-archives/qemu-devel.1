Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14A4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30302075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mrrf7BSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30302075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTvl-00038Q-IY
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmY-0000WW-Jn
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmW-0000c5-P7
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJH7iZei/FUThhkCklYQGVmfL7OJejtyEbzG9hdsPU0=;
 b=Mrrf7BSXZkBbLe7k1H0GTp4R6CgRF3oWQs/SsFy56CZGC6hCDgVOHCzQ94uFS/xQF9BAUV
 fTvNrgfoegr4zn1UTc3jvahcjX4iwnwoXG7Ows+HaYlCxEUepwD3vMrLXjN/K8jweW8gBt
 zIPrLVxelKT1EPfInjYYAuq1Fm0SRMQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-o2RDD5N5N_C6v6AD_mkiBw-1; Fri, 30 Oct 2020 08:45:21 -0400
X-MC-Unique: o2RDD5N5N_C6v6AD_mkiBw-1
Received: by mail-wm1-f69.google.com with SMTP id s25so1198128wmj.7
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rJH7iZei/FUThhkCklYQGVmfL7OJejtyEbzG9hdsPU0=;
 b=nblKMgosnTdrtup0cjTs7J3KvkTFnJXUwqxNQp/cdCKBQfrJ47D0x8DoAxK9riQP5s
 inIrQsuHZ65D7QrbnkTlvBVM4lQdQM0GDmb92RkGpIQFmGjE15yHV1bxnSx7YBFv8fyv
 NT8+UNe6sDZtXciNFPkH68ogp6o0DOML/CODR9YcUWGjgpvGCWRP+yaw1S9NIlosl26u
 3zYLVbPnJrGI4PIdzRX0mjXGwfjlKC1az6+6W4FeA59i58foaIK8KWiPHaHU5QVnLATa
 K35VfhwL81mTk1cBUEAtbFuzGNDYKe9BGy2zctLU0E2HMU3dK0qW1DLlEvuWPju8KUAn
 e4sA==
X-Gm-Message-State: AOAM532+uGKleCw+JcIdLOWOzS5sJuf0rLGhbR0Zl0la43SFeDZzeq7G
 rrV12PiLhDsZIk2x2q569GIOzhWLOlGUeENPk8WEkSY0rKRpMfX55Pklny8BCeR5mIU5WO3H483
 MzdZ1thHFFkEnjRg=
X-Received: by 2002:a1c:9d94:: with SMTP id g142mr2605991wme.66.1604061920273; 
 Fri, 30 Oct 2020 05:45:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRy3wCmSKSHwXqbVM1wWlfuIRoL50WNd4zO8/8TfnQNjcEypmUtoOCZHsGUFI7lovJttc8bw==
X-Received: by 2002:a1c:9d94:: with SMTP id g142mr2605972wme.66.1604061920127; 
 Fri, 30 Oct 2020 05:45:20 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id z5sm10530539wrw.87.2020.10.30.05.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:19 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/15] hw/pci: Extract pci_bus_change_irq_level() from
 pci_change_irq_level()
Message-ID: <20201030124454.854286-7-mst@redhat.com>
References: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030124454.854286-1-mst@redhat.com>
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


