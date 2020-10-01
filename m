Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4541C47423
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A20620739
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYGWZab3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A20620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2iS-0006MR-D3
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Lt-0005It-R2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Lr-0004Sx-8c
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/PF6nhOiKuc0/NQNRc+aC6XALs0M14l/UELS8Wkj5yQ=;
 b=eYGWZab3OmQJ5PqryfE+dvXLI1O7V487/Qj1ilgImQ9L38n9aJQA9S021ugz+UoevHbCIU
 jA/QKe6wcRpdlwmUL1YBJ22ZmVfflxYncK+4ZpjG6O+e4Ep81Rrp6QkUnTxebF+k5+90ey
 GZXQVbEJ2V/C2bgqp+n1BSZB8jAzwF0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-8JwQblu7PbOBp5kt77_QYw-1; Thu, 01 Oct 2020 13:26:31 -0400
X-MC-Unique: 8JwQblu7PbOBp5kt77_QYw-1
Received: by mail-wr1-f72.google.com with SMTP id v5so2352146wrr.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/PF6nhOiKuc0/NQNRc+aC6XALs0M14l/UELS8Wkj5yQ=;
 b=Oy+WBgtRJdCnm1M/5dovEgkRVAABl+lqbCSKXr9t0mS7LdVF4Tf05OYEm/qLFV7cbM
 hUDZz0MjGYao4esT2VuhwBUu3rGa5YESyQs8cPGM/ugPTWjlqRtx9zJTk2FlMExw2Jxc
 7e89F6zSp+jAwrRv0P2AQ/M3vyLSkQf5H6i5DwyFKsoNT/tFJmTsOQBqgU/BSgrkc2qS
 qVhUXuAG2WZ4Z9Zq8s8pk11GyqLa4lpu5cZ/6oje+V39zd4UJHEwvdCfpTridwvLUTZw
 xOdIaBcoXYVtsIWJFPXEHLRzJXaZdhBqt2+mpun3/paIkHNcDaG4hu6QkZuDRgpf6d3n
 3FjQ==
X-Gm-Message-State: AOAM533JzvbPK5W8JsnIV8SJ4PY76l+aISTyelQN00WQLnnbT+RlBPnr
 EKGBwQOpwa2w4kzpSVPAJpAH1zM30CfRJ1pVPI/qSlGBwKWuB5QyZQqrjAdC0nXS0/4cQhsqclq
 ePjVbs+2WMT6oMXg=
X-Received: by 2002:a5d:634d:: with SMTP id b13mr10553191wrw.324.1601573189953; 
 Thu, 01 Oct 2020 10:26:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIoEmG/G5FJTaG28c1zrQb/RRt+r8pbfSAI5BCK7unghT/ZRlB5FuKOir/mKgqiaqaLh2vTw==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr10553182wrw.324.1601573189791; 
 Thu, 01 Oct 2020 10:26:29 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id c14sm9985434wrm.64.2020.10.01.10.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:26:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 14/16] pci: Let pci_dma_rw() propagate MemTxResult
Date: Thu,  1 Oct 2020 19:25:17 +0200
Message-Id: <20201001172519.1620782-15-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001172519.1620782-1-philmd@redhat.com>
References: <20201001172519.1620782-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dma_memory_rw() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index dc1799b519..f77f4e49e4 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -780,8 +780,22 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
     return &dev->bus_master_as;
 }
 
-static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
-                             void *buf, dma_addr_t len, DMADirection dir)
+/**
+ * pci_dma_rw: Read from or write to an address space from PCI device.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @dev: #PCIDevice doing the memory access
+ * @addr: address within the #PCIDevice address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to read or write
+ * @dir: indicates the transfer direction
+ */
+static inline MemTxResult pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
+                                     void *buf, dma_addr_t len,
+                                     DMADirection dir)
 {
     return dma_memory_rw(pci_get_address_space(dev), addr, buf, len,
                          dir, MEMTXATTRS_UNSPECIFIED);
-- 
2.26.2


