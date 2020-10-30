Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A7BC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB82D2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkU7fxjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB82D2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVGV-0003w7-Ho
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8e-0003i9-Fr
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8Z-0007Fx-2M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/zT27wrNEHsIn9RPNBpuM2tzqmJYYoAGZySli/obU8=;
 b=WkU7fxjW3w8waHRYU9T4WRwy+GDJxfZ1CizWcI9GR/JLNntWKXZ/qy4tQGf0dpW8aOMHg5
 eyAB9SvKQzgixeL7pxmSTrV3CGa6bODcRNBdWaTc1JUt6BlBhPj1LLMflgGkMcKYxEpt3l
 kvxsWQoLayknZCMV8psnMToV3aI590E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-3es-3gwWM8WqwBsIRMZ-Zg-1; Fri, 30 Oct 2020 10:12:08 -0400
X-MC-Unique: 3es-3gwWM8WqwBsIRMZ-Zg-1
Received: by mail-wr1-f72.google.com with SMTP id w3so616969wrt.11
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=B/zT27wrNEHsIn9RPNBpuM2tzqmJYYoAGZySli/obU8=;
 b=dChyVuJPVA5qpka8/lh9wWDITGxescW6j+5+KiJnkGDZUKKjI3YmB4HWm2GH424tdc
 AL9AsIai8CgbFPHA4d+dPi06aSrr0ZSlrtLnr0ZWW0hXlj52/9im0oWgWsNimYgDs4NS
 PLzJv74sQObD5kqdLLMOxC5j6nZmymduyn2MbT7TYo/zgGGHiaW735XURaMG1KgNj6FE
 2UKoIql2N35WMtPVqQwCVGkyX67YPVF5+LgBWgF56BpscJh0/6heMBAcgK4qMsWg0FBv
 dkmad+1jMhSSkxVuxuDoY/HB9E6F75btqu3comHSwISffQaPtX8+ZLc0+MXJcb+oDFCV
 baCA==
X-Gm-Message-State: AOAM531GwDwBqCZNlc5imJVuV+2KyzQaPwq8CNsCQbFvIHuJaUdCbMkP
 5TqqFcvfPp1eJinFE2pciPMcLo0OCFCrRVsb1Vexe6axltWmKOvuU0l0K5UlmHxnz3FqwWrrcJ/
 ey3unPI6YMFmkgEA=
X-Received: by 2002:a5d:688c:: with SMTP id h12mr3577080wru.92.1604067126720; 
 Fri, 30 Oct 2020 07:12:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz88sXk08d3H74+ai8QgMNtx7G+dDD6r5jEDCWNgQ+yd73QVVkxAb6mKY5UPzwkhqDBXLLmfg==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr3577066wru.92.1604067126579; 
 Fri, 30 Oct 2020 07:12:06 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id m14sm10754435wro.43.2020.10.30.07.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:12:05 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:12:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/15] pci: Assert irqnum is between 0 and bus->nirqs in
 pci_bus_change_irq_level
Message-ID: <20201030141136.1013521-8-mst@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These assertions similar to those in the adjacent pci_bus_get_irq_level()
function ensure that irqnum lies within the valid PCI bus IRQ range.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20201011082022.3016-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201024203900.3619498-3-f4bug@amsat.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 081ddcadd1..dc4019865b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -250,6 +250,8 @@ static inline void pci_set_irq_state(PCIDevice *d, int irq_num, int level)
 
 static void pci_bus_change_irq_level(PCIBus *bus, int irq_num, int change)
 {
+    assert(irq_num >= 0);
+    assert(irq_num < bus->nirq);
     bus->irq_count[irq_num] += change;
     bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
 }
-- 
MST


