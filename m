Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D07C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075D220E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUuaZRsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075D220E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVz1W-0007FW-Ve
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyrN-0001gu-I0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyrL-0000B9-NY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6cKAl65zW1qyY38kdhpIGpdqbKF2puemJ9sAGdpEGk=;
 b=VUuaZRsGT9AFOZ12UfSJKcxnaPZo0LFcnmdzZRaUqqKEeYw0YDPGwxUXu48eiEkE6dklOw
 VMjBMIFkKrjLiWJ1lOQ4xBP9LBLw4qZRRXAYlp2hGr/6KuE7IiFGttUv15+obIiOpuA7ZH
 KcL+JKptRGb0fVb78jhOF44BUsTzkoY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-0F8vc1QsNd6N4lpFzkVixA-1; Fri, 23 Oct 2020 11:20:00 -0400
X-MC-Unique: 0F8vc1QsNd6N4lpFzkVixA-1
Received: by mail-wr1-f71.google.com with SMTP id t17so700067wrm.13
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E6cKAl65zW1qyY38kdhpIGpdqbKF2puemJ9sAGdpEGk=;
 b=MdlyfXFxFCotOA9fghaXQ+9jW6SaicpVntVzphcXLo5yDINb1nckm3Cyn0NDNoISLF
 k/hpH1FtCPySnknFrfJ9Ubm2PERHf1tKNZyhQh8bB2fIHA79pevd8PgJAS5+0vLftv2W
 ylJR7goSMlstW91JIUU4WYG58NVF9pDfLTL9ndym1fwIuSYAUBn49wxESnInsYz0qhRD
 lIqpO9oGSqv9JZLtswOxtaYMmVJXv+b5sxnafCKt2xdfZoqvpzhdncOXnKG27h5fO97k
 iVK6gxoQ4uFP+rylAG8Tg/mdMn9WMls/s/+Ydfq0Q2QT9+DlqUJl6hjzGYXfIKNRyw/+
 dhkQ==
X-Gm-Message-State: AOAM531LYJPoUc/LE9+4mE4JpnBP0lMBtSnmVh3PE+rqqQguwdPTSPGi
 YaSjryXx+N87oKJSMyu8zDnhwJbJmtZw+URnd+3EnpAQBXl1ezvEMO0Vxdz4fZXfo8H6uazGBqk
 7xsF/rf6bbu8cD7Q=
X-Received: by 2002:adf:9f0a:: with SMTP id l10mr3004586wrf.427.1603466398991; 
 Fri, 23 Oct 2020 08:19:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6SANdtk0trnDse1dOiwg/trn2UoCu6ZDnKMlQdgTPRyQdT038mLI5VBv/zvFMpTXeqTn23Q==
X-Received: by 2002:adf:9f0a:: with SMTP id l10mr3004564wrf.427.1603466398833; 
 Fri, 23 Oct 2020 08:19:58 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id a127sm4252674wmh.13.2020.10.23.08.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:19:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 07/10] dma: Let dma_memory_write() propagate
 MemTxResult
Date: Fri, 23 Oct 2020 17:19:20 +0200
Message-Id: <20201023151923.3243652-8-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dma_memory_rw_relaxed() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index df170047eb3..a052f7bca3f 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -96,8 +96,10 @@ static inline MemTxResult dma_memory_read_relaxed(AddressSpace *as,
     return dma_memory_rw_relaxed(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
 
-static inline int dma_memory_write_relaxed(AddressSpace *as, dma_addr_t addr,
-                                           const void *buf, dma_addr_t len)
+static inline MemTxResult dma_memory_write_relaxed(AddressSpace *as,
+                                                   dma_addr_t addr,
+                                                   const void *buf,
+                                                   dma_addr_t len)
 {
     return dma_memory_rw_relaxed(as, addr, (void *)buf, len,
                                  DMA_DIRECTION_FROM_DEVICE);
@@ -143,8 +145,20 @@ static inline MemTxResult dma_memory_read(AddressSpace *as, dma_addr_t addr,
     return dma_memory_rw(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
 
-static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
-                                   const void *buf, dma_addr_t len)
+/**
+ * address_space_write: Write to address space from DMA controller.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to write
+ */
+static inline MemTxResult dma_memory_write(AddressSpace *as, dma_addr_t addr,
+                                           const void *buf, dma_addr_t len)
 {
     return dma_memory_rw(as, addr, (void *)buf, len,
                          DMA_DIRECTION_FROM_DEVICE);
-- 
2.26.2


