Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4621EC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AAD20725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNmDLRfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AAD20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYToc-0002Md-Mo
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTma-0000Z3-9X
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmY-0000eD-I5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/zT27wrNEHsIn9RPNBpuM2tzqmJYYoAGZySli/obU8=;
 b=SNmDLRfhcI/9mIAN/dW3pv2og1GGCnIwknyrHmUAbvLGn8Gs94uNcAD/GZXjbRFjF+QuZF
 BQ0d9G0WLcJITe2UUd5Q3DwhXFRaVVgR0QEH5gLeLB67f5AJes2QZfAHkaR/1+eEOAKlKJ
 N7CieII13qTliz9rm0ddUNguhrgjOl4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-p8oNuSqwP32YI3V6yiAn6Q-1; Fri, 30 Oct 2020 08:45:24 -0400
X-MC-Unique: p8oNuSqwP32YI3V6yiAn6Q-1
Received: by mail-wr1-f72.google.com with SMTP id t11so2619051wrv.10
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=B/zT27wrNEHsIn9RPNBpuM2tzqmJYYoAGZySli/obU8=;
 b=aOB1JVwswe2tt+HC493ChB8sgfhhz4fy45nVYP1hyzPSUyhHyBeVQiIptvGtWZ9tOf
 HEVPwLa+prpiI0qOQmgNNp3YmpcnjriuHXZKGN4LkljQZ7yVYjXuhSkc1YL/7xU4E/Vl
 UHq2AHfiPdzxOZqeM2uOK0thLxTGFRA4l1SdiRuX3vXv/VtD6SmB1Wxwh1h6n95Z+PZU
 1fW71JCczCQX1HpPk0QxTNX2c++enp55NJwnEk01ERoE0wLEzQ+7gn6YVpd08iUtzdzK
 +OLSOLpg8i1+/dRHXDbcO8DJT3YhlTdXLs7PIPx8IaIZnlQAX2IW8jaTfQldHXWBk+ST
 cp6A==
X-Gm-Message-State: AOAM530x6WwqFEqFQiKS5e3ANo/VZGEFcMSNqupE+4lCwT37GQjxkVnD
 tXnzFLHtE/XuSXKeNbk7i2cVeBewrLmz03/vBq1TeWKysF+/8ROBbLMsoOYeSDlVpmbi7aUDNEB
 qGKY17w9cQ4QYkC0=
X-Received: by 2002:a5d:4b12:: with SMTP id v18mr2882661wrq.259.1604061922520; 
 Fri, 30 Oct 2020 05:45:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWpB2dIplVbLMFmPo22CKqNaAudJKkIqAfJ4iUVHWvHAYKi5BTxYxtrGhHTv1hI0sEMBf1IA==
X-Received: by 2002:a5d:4b12:: with SMTP id v18mr2882644wrq.259.1604061922375; 
 Fri, 30 Oct 2020 05:45:22 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id g8sm4597291wma.36.2020.10.30.05.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:21 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/15] pci: Assert irqnum is between 0 and bus->nirqs in
 pci_bus_change_irq_level
Message-ID: <20201030124454.854286-8-mst@redhat.com>
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


