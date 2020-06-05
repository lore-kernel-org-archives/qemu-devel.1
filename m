Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBCDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15473206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCTl1mvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15473206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEcC-0005BC-Qs
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbA-0003Ph-RL
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEb9-0004Is-8S
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id q25so9620786wmj.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=phvNC/3twlj1z+FSK0lUDFiax2fRGfdSfNFp/IJDVTk=;
 b=mCTl1mvCxnnPcuLi0xBxmz6EH2VTEyybz5fZVgREAcDoQWmRObW5N+U6sEouCoe8LU
 v0S1AJAie0ZtTLa3ijetOQ8GF1OQVmEbsWTf2EKCIiwp+zAuSYgt4BRtHIR7Zgsfqv6q
 L1YcdeJVHGQo83svTl/ih6BFGqak3EmZSa36WNwVxcbDXs7GGNhaCJEqRmDsZ8cCYxXF
 9pSCA2QsXwSb356Tb5H93jDHFy7YTQayBKgRTnBzWI25nv9Vk7adWq38eIIf+NMnnwIA
 DBMD8LLER5Lxddka2vqDzNY5Cx90fVqePAY7CpHTxK/lLCzIPb6Ji/9N94hF+xdcaiCm
 MIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=phvNC/3twlj1z+FSK0lUDFiax2fRGfdSfNFp/IJDVTk=;
 b=Z0p7EqmF3cUAiLlXAQqEz6g6ytYDnfkPcqz3zl5dbIWjP3Y598hwGKHIlxFJ+gKPOI
 FVKkHWTjUPdWwP0ek1n8RkctKN9Vl9khDr0cDIDOEsR/ktptok7ZcGhq2WaYzngS6n4f
 6Vwn7Mh/JsJ3i9sq9op9Fnh0jXD5BMFrrGp68QodhhK/jwboah/iwsQ9e+QcG/OMvNFS
 WCPVOFxm2u9WKdJC3YbiI6e3gzGQejG+j8x8mAd2VoLElhBWybqrpqiff1DsD03gzoE+
 19zEJxxzd+IqWP1Kd3vgA2+kotlJBQLCVgbNRz7KP06Tx834Ld4uWIMD6e/QzFj2haU7
 kLtA==
X-Gm-Message-State: AOAM530Vj/fniw+heC8HlvQW9v45K6MGjbsAPIJe15drf/H9B5NToNBM
 MQw057jeSxx75OPkdmrP7LrH/A==
X-Google-Smtp-Source: ABdhPJw7H3CVv9zcPxZY1Qqx0SDFbtTnSe+Qu+M/AAbgaSAmLJY1QSVEG/30Hat1m/xmtNFL9Tkvag==
X-Received: by 2002:a05:600c:4102:: with SMTP id
 j2mr1165177wmi.48.1591372173529; 
 Fri, 05 Jun 2020 08:49:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o10sm12731793wrj.37.2020.06.05.08.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 74F761FF90;
 Fri,  5 Jun 2020 16:49:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/14] exec: flush the whole TLB if a watchpoint crosses a
 page boundary
Date: Fri,  5 Jun 2020 16:49:19 +0100
Message-Id: <20200605154929.26910-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
References: <20200605154929.26910-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no particular reason why you can't have a watchpoint in TCG
that covers a large chunk of the address space. We could be clever
about it but these cases are pretty rare and we can assume the user
will expect a little performance degradation.

NB: In my testing gdb will silently squash a watchpoint like:

  watch (char[0x7fffffffff]) *0x0

to a 4 byte watchpoint. Practically it will limit the maximum size
based on max-value-size. However given enough of a tweak the sky is
the limit.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use cleaner in_page = -(addr | TARGET_PAGE_MASK) logic per rth
---
 exec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 3d4c94a9dc3..7cd45e94fce 100644
--- a/exec.c
+++ b/exec.c
@@ -1036,6 +1036,7 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint)
 {
     CPUWatchpoint *wp;
+    vaddr in_page;
 
     /* forbid ranges which are empty or run off the end of the address space */
     if (len == 0 || (addr + len - 1) < addr) {
@@ -1056,7 +1057,12 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
         QTAILQ_INSERT_TAIL(&cpu->watchpoints, wp, entry);
     }
 
-    tlb_flush_page(cpu, addr);
+    in_page = -(addr | TARGET_PAGE_MASK);
+    if (len <= in_page) {
+        tlb_flush_page(cpu, addr);
+    } else {
+        tlb_flush(cpu);
+    }
 
     if (watchpoint)
         *watchpoint = wp;
-- 
2.20.1


