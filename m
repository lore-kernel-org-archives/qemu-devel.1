Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06171C47425
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E63A20759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgI3hdhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E63A20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2j1-0007aY-P0
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2LT-0004Zf-5l
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2LP-0004OV-La
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DE77vjLAXxwClEJ7RgdDUv8monpyieaGAVYLnjVrC+s=;
 b=HgI3hdhcro8NhEl3oePn3WfOTX3MzjM5zRm8LuvG2L4yyC32QcdmiGmeMtQwiCiDxyYHOU
 a4hDUen+quzH5rEeY5afLaNEJyrW0X7Sz08HIsVT7a0SMzAQTeU+eu3xsWlKqJpg6duE5u
 UHlDL0Nc0z7TxFdPki/JvhOvC7p51lo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-NhoCJ8QSPpmZR0tVHfyZ9A-1; Thu, 01 Oct 2020 13:26:12 -0400
X-MC-Unique: NhoCJ8QSPpmZR0tVHfyZ9A-1
Received: by mail-wr1-f69.google.com with SMTP id v5so2298874wrs.17
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DE77vjLAXxwClEJ7RgdDUv8monpyieaGAVYLnjVrC+s=;
 b=hnfkBXIniQxYBzne6kNE6oxxMnXiiN6K3DlvCPbFOEJTIN3XfWdJfqwbG25kUCxCj6
 AwrJ/mPLxka4InQmRHgiJkFRBFWSQJO4q4/tBl+2zXAy7e7mD+QYr+K2BMIZ76fyWpVD
 GCiPgkJimaiYwvZG8wViK9eJ4nEzzWOFxNd3wDWbnA3EHo9xKVpKIlUlFi03dO4hP+hW
 Yh4G9V7xjbKLeFzFLvIQttHmUZsNXu08twPJeZp63Ucspc+GWNV77w68SZIDyHj73tAG
 0nD+Y7ahVfEG6/IBbkJscn3r1Yi3TK74xiq2P33kJBf25NRipnwF9lVpYH7OJie39nS6
 UmZw==
X-Gm-Message-State: AOAM533S1UCF7tq7feMjjbFrvegx2UIR3MgXzcOXzP9+J86qB/19e6Jv
 maIRQJ9wfA4radpGNEjE7QU5mTKDQYviZlt7siykffX+5+tzdwb9EBOaOgWAQm3lQOFDFBqjfV0
 JNe0Ns9L4/0V/1+Y=
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr10102297wrn.212.1601573170716; 
 Thu, 01 Oct 2020 10:26:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhYa2pIYBNENWsjY/M8YHJaHnQ5Yxot6kNXp1e6URKTGVbkXFfjBglMcEzmpsPTpDw3oVhsg==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr10102286wrn.212.1601573170577; 
 Thu, 01 Oct 2020 10:26:10 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h4sm11741661wrm.54.2020.10.01.10.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:26:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 10/16] dma: Let dma_memory_rw_relaxed() take
 MemTxAttrs argument
Date: Thu,  1 Oct 2020 19:25:13 +0200
Message-Id: <20201001172519.1620782-11-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
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

We will add the MemTxAttrs argument to dma_memory_rw() in
the next commit. Since dma_memory_rw_relaxed() is only used
by dma_memory_rw(), modify it first in a separate commit to
keep the next commit easier to review.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 608393d1b6..936b2c902b 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -83,9 +83,10 @@ static inline bool dma_memory_valid(AddressSpace *as,
 static inline MemTxResult dma_memory_rw_relaxed(AddressSpace *as,
                                                 dma_addr_t addr,
                                                 void *buf, dma_addr_t len,
-                                                DMADirection dir)
+                                                DMADirection dir,
+                                                MemTxAttrs attrs)
 {
-    return address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
+    return address_space_rw(as, addr, attrs,
                             buf, len, dir == DMA_DIRECTION_FROM_DEVICE);
 }
 
@@ -93,7 +94,9 @@ static inline MemTxResult dma_memory_read_relaxed(AddressSpace *as,
                                                   dma_addr_t addr,
                                                   void *buf, dma_addr_t len)
 {
-    return dma_memory_rw_relaxed(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
+    return dma_memory_rw_relaxed(as, addr, buf, len,
+                                 DMA_DIRECTION_TO_DEVICE,
+                                 MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline MemTxResult dma_memory_write_relaxed(AddressSpace *as,
@@ -102,7 +105,8 @@ static inline MemTxResult dma_memory_write_relaxed(AddressSpace *as,
                                                    dma_addr_t len)
 {
     return dma_memory_rw_relaxed(as, addr, (void *)buf, len,
-                                 DMA_DIRECTION_FROM_DEVICE);
+                                 DMA_DIRECTION_FROM_DEVICE,
+                                 MEMTXATTRS_UNSPECIFIED);
 }
 
 /**
@@ -124,7 +128,8 @@ static inline MemTxResult dma_memory_rw(AddressSpace *as, dma_addr_t addr,
 {
     dma_barrier(as, dir);
 
-    return dma_memory_rw_relaxed(as, addr, buf, len, dir);
+    return dma_memory_rw_relaxed(as, addr, buf, len, dir,
+                                 MEMTXATTRS_UNSPECIFIED);
 }
 
 /**
-- 
2.26.2


