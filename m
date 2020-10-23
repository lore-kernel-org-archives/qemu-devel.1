Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AE4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFEB20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMjB0Fav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFEB20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVz0Q-0005s8-Ms
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyqv-00014p-WC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyqs-000099-Cu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woEn3sc6gXxf1+d8nTxR4+S5Pfst+tMKZK/gRYER+Og=;
 b=hMjB0Favt5f/wYxcPgUjc8efCWaqu7tOXpvu3YePOCrW65oRCKF5qoezRrFBxsELy6RG3H
 8mz19RIIW9jG+kQDtW8rAnYF6oX4gcpbF6DUFzyvjCYMdkjvM4kyIrI6D2WC4XH15+EaqZ
 93t35QJhwiReLYTUoWZIUBb3o63q/O4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-KqStS-i2ORiIrjpOa4UUYQ-1; Fri, 23 Oct 2020 11:19:31 -0400
X-MC-Unique: KqStS-i2ORiIrjpOa4UUYQ-1
Received: by mail-wr1-f70.google.com with SMTP id 2so700557wrd.14
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=woEn3sc6gXxf1+d8nTxR4+S5Pfst+tMKZK/gRYER+Og=;
 b=U2io50h3kCrM7oVgIbhAyHst8do+yg2XJ4wPdrn1u6C6nGR35NkXfpv0bV65wYfoc8
 3OU6HlXJrBXRMXG4XLljCtTD70FRF1/ygu+hqnp2TAaayS5NwGmMiWcGQHsIh3FaCQXh
 ozLDN/02vA5Hgul8s3zg06WAvqflrCAweLnOmJRZXtDjqtmImw18JnYQaqx6RiZYaGCM
 jumQPV5cKaRCcm+H1eOXpiKz55q4QhHsRbVMF9O2A+eo6ZbbF5F69wN2XMQsbxsAIW8T
 mgScKoRNBDSp2s9WqmNuV9lAG/RfAK+McoF5zIMEuAt5wOljZet4HanmOG1+aaCVZcEV
 pUmg==
X-Gm-Message-State: AOAM533zLgvDW9bUd7Zu33eC4PmkgvQ0T+lJC8u4QGQSflkO50CNKiOi
 D/LmdTQY9gVkIVWTZQ3XBz4u6/TOW7xSReo57v0PdNLfVRKcieZhOv6qcCfxH31EdyyFjK0MPtq
 a7FrQCee/1gUEKeY=
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr2970315wmk.91.1603466370320;
 Fri, 23 Oct 2020 08:19:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgsgQv+WrSHRvo7gMkXRybAvm8gaV/Vqvr+EjqJahvToCQ9n2nuHw6FZj8+jSZuavxNDqb9A==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr2970289wmk.91.1603466370113;
 Fri, 23 Oct 2020 08:19:30 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u5sm5123339wru.63.2020.10.23.08.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:19:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 01/10] pci: pass along the return value of
 dma_memory_rw
Date: Fri, 23 Oct 2020 17:19:14 +0200
Message-Id: <20201023151923.3243652-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023151923.3243652-1-philmd@redhat.com>
References: <20201023151923.3243652-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Li Qiang <liq3ea@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Some might actually care about the return value of dma_memory_rw. So
let us pass it along instead of ignoring it.

There are no existing users of the return value, so this patch should be
safe.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20191011070141.188713-2-its@irrelevant.dk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 0a59a06b149..f19ffe6b4fe 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -783,8 +783,7 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
 static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                              void *buf, dma_addr_t len, DMADirection dir)
 {
-    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
-    return 0;
+    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
 }
 
 static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
-- 
2.26.2


