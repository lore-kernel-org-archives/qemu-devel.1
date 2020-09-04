Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E83C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E63206E7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbdEGMa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E63206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDwO-0005bI-GI
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDtw-0001P4-M8
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDts-0007Ue-Vm
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599234314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7iJC1mwPlkCljaia40Coq6k2ckspF1fbeJzPRIKgYw=;
 b=KbdEGMa6K9pboGJkVb5UYtqCryiqXn4xf4rTZgASYUSp45+d8AszJm+gviJrAGUbuuhE/K
 OOtGiJg13tSOmwBEz+ujOPoLDmukVbe5wuCUZcuuoHRlA6VeLOhRiPMhw+LDxlt9+W2uz9
 usDuHc+evBOrBQw4My0CoB1RQpKDf+k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-RKSpKidKN66BcQ5EakZwXA-1; Fri, 04 Sep 2020 11:45:12 -0400
X-MC-Unique: RKSpKidKN66BcQ5EakZwXA-1
Received: by mail-wr1-f69.google.com with SMTP id x15so1618037wrm.7
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i7iJC1mwPlkCljaia40Coq6k2ckspF1fbeJzPRIKgYw=;
 b=GMB2iFcyWBsqnWV/mGxZdfwviFxp62gvmj7t3j3pYaFVvis6t7irZbUMt0rwcKC+xQ
 kTmIU0vOQWvPn9f+hJS8tcTjxUsueKhxNSVmL2gbgqU1zf7pFN8trZSL+l+rbE0/x1t7
 /T+2Nt4tFAwb60MRaNz9n4F7WIIHGHy8Q7fK5Ab8Z9aP9jSBnVxm/FIe5FPTcvl2P7+V
 2x38Ej7RdmUEu5cCHyAVMqWKR8qF4grKu0ViRPNjj8BOX7z9uGiTgYYju5X7jCPyKLgd
 1+T4yrei+KJZuSSrPHEpgEaYulntTfe9WVV9DaEhiSgyx/P4sa1Kw4NYZJAIRihEYJIW
 Y8Dw==
X-Gm-Message-State: AOAM533o+AnF+4bMS4MXbjyT90BNG3a9dylX9LSXKLPwmCUnZw2T+soB
 +3FAaPTU+yDyANAnjJz5uWwkdoVh0eHPRXHrzgYJBUVIBwBT16wOpy4kPq8t+AveM0Xh7V+EL+T
 lOJBqRHVHsArUsrs=
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr8238161wma.18.1599234311163; 
 Fri, 04 Sep 2020 08:45:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT7Q4ncElC0kjC3GurLgpimQG2OqwITFLYV5TGQlNp3mFO4DrTejodazSeRw+YYLQQ5xC/Cg==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr8238120wma.18.1599234310985; 
 Fri, 04 Sep 2020 08:45:10 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 92sm13343137wra.19.2020.09.04.08.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:45:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 05/13] dma: Let dma_memory_rw() propagate MemTxResult
Date: Fri,  4 Sep 2020 17:44:31 +0200
Message-Id: <20200904154439.643272-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904154439.643272-1-philmd@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:46:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

address_space_rw() returns a MemTxResult type.
Do not discard it, return it to the caller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index ad8a3f82f47..661d7d0ca88 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -80,12 +80,13 @@ static inline bool dma_memory_valid(AddressSpace *as,
                                       MEMTXATTRS_UNSPECIFIED);
 }
 
-static inline int dma_memory_rw_relaxed(AddressSpace *as, dma_addr_t addr,
-                                        void *buf, dma_addr_t len,
-                                        DMADirection dir)
+static inline MemTxResult dma_memory_rw_relaxed(AddressSpace *as,
+                                                dma_addr_t addr,
+                                                void *buf, dma_addr_t len,
+                                                DMADirection dir)
 {
-    return (bool)address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
-                                  buf, len, dir == DMA_DIRECTION_FROM_DEVICE);
+    return address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
+                            buf, len, dir == DMA_DIRECTION_FROM_DEVICE);
 }
 
 static inline int dma_memory_read_relaxed(AddressSpace *as, dma_addr_t addr,
@@ -101,9 +102,22 @@ static inline int dma_memory_write_relaxed(AddressSpace *as, dma_addr_t addr,
                                  DMA_DIRECTION_FROM_DEVICE);
 }
 
-static inline int dma_memory_rw(AddressSpace *as, dma_addr_t addr,
-                                void *buf, dma_addr_t len,
-                                DMADirection dir)
+/**
+ * dma_memory_rw: Read from or write to an address space from DMA controller.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to read or write
+ * @dir: indicates the transfer direction
+ */
+static inline MemTxResult dma_memory_rw(AddressSpace *as, dma_addr_t addr,
+                                        void *buf, dma_addr_t len,
+                                        DMADirection dir)
 {
     dma_barrier(as, dir);
 
-- 
2.26.2


