Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9988C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B03720672
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKHmN9DU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B03720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR77L-00051d-Mo
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74X-0000QJ-OA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74X-0004j5-4w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR74W-0004fG-Mm
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:16 -0400
Received: by mail-pf1-x443.google.com with SMTP id x15so457990pfa.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ar4ktbgi8ho4D2K0AlAA7ABuossIOEQqKwU/YvDdwbY=;
 b=KKHmN9DUtNl/895jM8s3jff7LEzmFeqpQ8DWMpXM1qONzT3m9ARgcZsMgP+XdscICt
 HZLMNtv/ZqoDWF8cXeHk+2bSlQs/4PWjWY5m0f5+6wiIyah2Z+B4dd2NmFckQr7NJ6HO
 FJ2+o+DHRGk8N+afxBcsGByNqu6GDXbOc6issTgN7yM3kAgSlrKXj2oY6o/6HzchDLLo
 iH6AsFkzi9ygAU/ahiyH9fYPWIhJi4eQgbeJH9nfG4wPaO08AUWKlOGemDpIwU7+crxI
 eXUdP952xqi7ovID9SZ5VX81/jeMI2wy+AP48xd3inj5+XoViGfrnA0WWgdTVEceMl3X
 kM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ar4ktbgi8ho4D2K0AlAA7ABuossIOEQqKwU/YvDdwbY=;
 b=pKp4HhKOe3UZkAp1jcPrX/7FgkrhVQUzdOlqJ8FcUwITiakSyIb3CJbH7EB1kC9WGo
 Go2nMCRhHSgro+KOMQzGcnAi3fHf1o2WT20QrdG2RlDAYqffQMwqQGN4q/KHvwJclZ4+
 LLdlS1kaYPSV+z54WA2a87bZgYiaE2v6sbxLrGl0KYT9mHYR0twK5eRYDilt0qsT/xto
 CKy2q2n+V11dvSLyyM3jXQPKQIDbRGpsyCP+UFpSlxP9ZHcaIww2cbAZYVIHdcXThVDT
 i7B+rLL6MBqqnh5uSX8pUTd1aJ2q6qut0GR6UDu+eSi+8EYJOVo3D2v16a/FaKhhbFHJ
 SJtg==
X-Gm-Message-State: AGi0PuYRUjPCbt6N+meKuufYobEMfw1dEnIezrp13MBI4AY3uxQKYpEn
 ipf2YhkG6EKvX6+qUPDl9G6ZyX+e2cE=
X-Google-Smtp-Source: APiQypK8vcXuxHEBubjpa3cEPNUc8tdrZTdup/jVsukhDaiYSy8fuW1zLZEYDmSzXKgcURvTFA53Rg==
X-Received: by 2002:a63:5853:: with SMTP id i19mr22901678pgm.288.1587529994937; 
 Tue, 21 Apr 2020 21:33:14 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l137sm4129613pfd.107.2020.04.21.21.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 21:33:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/18] accel/tcg: Add block comment for probe_access
Date: Tue, 21 Apr 2020 21:32:54 -0700
Message-Id: <20200422043309.18430-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422043309.18430-1-richard.henderson@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 350c4b451b..d656a1f05c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -330,6 +330,23 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 {
 }
 #endif
+/**
+ * probe_access:
+ * @env: CPUArchState
+ * @addr: guest virtual address to look up
+ * @size: size of the access
+ * @access_type: read, write or execute permission
+ * @mmu_idx: MMU index to use for lookup
+ * @retaddr: return address for unwinding
+ *
+ * Look up the guest virtual address @addr.  Raise an exception if the
+ * page does not satisfy @access_type.  Raise an exception if the
+ * access (@addr, @size) hits a watchpoint.  For writes, mark a clean
+ * page as dirty.
+ *
+ * Finally, return the host address for a page that is backed by RAM,
+ * or NULL if the page requires I/O.
+ */
 void *probe_access(CPUArchState *env, target_ulong addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
 
-- 
2.20.1


