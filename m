Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B765C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFB52085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTocxs39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFB52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2P5-0001Ks-AG
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2HT-0000Aw-2s
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:22:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2HQ-0003ln-PA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:22:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id v12so3979385wmh.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SMVif/eExjf/jyAhzIbCEhUo+yNRaSCxJPYg7Mv/KEQ=;
 b=bTocxs39IM9Y18bZrfeHKR61dkYrY173s8+/Fz08JfdW3ml/G1odg227f9BdHr/XoN
 vRvxiERHbEKIHwoHwfx5c2zuCuAsnXFSAW6khef+6uru5L4gZujdDm1/wel6cN7JxOf7
 yinWkPZprbmvsZRTJvJP/Y+HUb8mVYHahTd19FCSgB8GvEEDg8XxEmLY75HsY60yEGRo
 wq5p6g005Q0YXNTpjRos0QrVRemgkw3jgZHqfG8wU8dAmoTftHQ6r9YSafk/H8xVOhl4
 bdIeTgcO5Hoqi0vepVhG0GB6uumkhA1iLJG+eJC0mpjfJqWO+K1sCNeuabuqhzBRKwF1
 lM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SMVif/eExjf/jyAhzIbCEhUo+yNRaSCxJPYg7Mv/KEQ=;
 b=EoZpm3uC37DLhOTrPN/kobJzWfMicIzC+DpruFdPFSdip+dRPHN6hnfIkgUUbO1w6P
 8/DdOZ13fv09/KMW5hCWYgxL9cfH3gqqC45OlE3bmXv2JPkF7+FfCrbW6HobVvOCKCST
 hGhcQ7lHU9CYS6rzQo2eTwzvJ6kb84wFzLwSMVRPzBpLKuVZsVk2uS3EVxBpkvxOhYrZ
 DoexCH6ZYg+fsP6qyfyl1hnNubgGDqyBzCH+ZtO/MyS7R4udWWPJyu3Qen1leANyEkrB
 1NLpELHJcRnXo7g/WJPOdJZmSHrJT9UB3mA466mAQNfW31qDtYmIC1n0+4LNi1en9lu6
 SAug==
X-Gm-Message-State: AOAM5315MKovdJeFMHCT2CsEKEvQuuWgLXXkjDdaCqFwlsi/qfdmp7fm
 7ISj6vV6Ui6WYc96lEI94ipmpIcTBgw=
X-Google-Smtp-Source: ABdhPJx7x9GPGnneH3KMgnKIXVNpcUxP+GeDh9WRHIztzy0J3qnvMB+ASKIdVkCLuhtGK3BMy953Lw==
X-Received: by 2002:a7b:c0c4:: with SMTP id s4mr1063503wmh.181.1601572924191; 
 Thu, 01 Oct 2020 10:22:04 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h8sm9719625wrw.68.2020.10.01.10.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:22:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/16] dma: Document
 address_space_map/address_space_unmap() prototypes
Date: Thu,  1 Oct 2020 19:21:46 +0200
Message-Id: <20201001172159.1619456-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001172159.1619456-1-f4bug@amsat.org>
References: <20201001172159.1619456-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Add documentation based on address_space_map / address_space_unmap.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 80c5bc3e02..c6e12b4c24 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -1,7 +1,7 @@
 /*
  * DMA helper functions
  *
- * Copyright (c) 2009 Red Hat
+ * Copyright (c) 2009, 2020 Red Hat
  *
  * This work is licensed under the terms of the GNU General Public License
  * (GNU GPL), version 2 or later.
@@ -125,6 +125,19 @@ static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
 
 int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len);
 
+/**
+ * address_space_map: Map a physical memory region into a host virtual address.
+ *
+ * May map a subset of the requested range, given by and returned in @plen.
+ * May return %NULL and set *@plen to zero(0), if resources needed to perform
+ * the mapping are exhausted.
+ * Use only for reads OR writes - not for read-modify-write operations.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @len: pointer to length of buffer; updated on return
+ * @dir: indicates the transfer direction
+ */
 static inline void *dma_memory_map(AddressSpace *as,
                                    dma_addr_t addr, dma_addr_t *len,
                                    DMADirection dir)
@@ -138,6 +151,20 @@ static inline void *dma_memory_map(AddressSpace *as,
     return p;
 }
 
+/**
+ * address_space_unmap: Unmaps a memory region previously mapped
+ *                      by dma_memory_map()
+ *
+ * Will also mark the memory as dirty if @dir == %DMA_DIRECTION_FROM_DEVICE.
+ * @access_len gives the amount of memory that was actually read or written
+ * by the caller.
+ *
+ * @as: #AddressSpace used
+ * @buffer: host pointer as returned by address_space_map()
+ * @len: buffer length as returned by address_space_map()
+ * @dir: indicates the transfer direction
+ * @access_len: amount of data actually transferred
+ */
 static inline void dma_memory_unmap(AddressSpace *as,
                                     void *buffer, dma_addr_t len,
                                     DMADirection dir, dma_addr_t access_len)
-- 
2.26.2


