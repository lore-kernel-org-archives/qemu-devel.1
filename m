Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E592C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0934F2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPA4ilfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0934F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCAu-0003yg-1k
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC2z-0001ZA-8D
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC2v-0006MR-LE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:24 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC2v-0006M6-91
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:21 -0400
Received: by mail-pl1-x641.google.com with SMTP id f15so2433121plr.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ar4ktbgi8ho4D2K0AlAA7ABuossIOEQqKwU/YvDdwbY=;
 b=kPA4ilfVPF+5jUmAE++MclnZDZt6AkP+V2y4utOwmCj2wNC/OsvuUKdEKer2A/8pqi
 2YzTkmSUvSwYi1FJTh7eimnc1B5y6F+IgQEGr8xbyaEJOG8n2WJfKg1X1lHWhPUuG40U
 RMmD5BuMVFw+o3IKCUD8kV8zlziFy9ksx2MPQ8e1stuucWZRVQRQEbs7sPc8+0iH78cg
 cMJQ16Zx7aKVsVMM/UCpoPTx7P+ijLzA15/Ec0qkTFd4T0blBNhNWQYJNJweNlJjgTTE
 E9CJLzEdVJOb28u6mcOKcC3QlCU0dO7WmbOI8bSE3Fbi7wi3GYy3QPLFUyir/uwDVJdu
 JiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ar4ktbgi8ho4D2K0AlAA7ABuossIOEQqKwU/YvDdwbY=;
 b=E9D96VU1fq4ziedvCgaWuJinvg2AnDbB3v/ZGMBM6pUa7+3lzJQ+hiKAOBFOr4zNwi
 O2Cs4cvNaFKlORv/vLnv0q5Swgo4V42Yv1cRuRqiXs+wgogr/8ts+tR47Z6BLsX1Arm7
 8Hie//7G6PBRiWCGbRZGbHyt/TOYnQ1ZFGUNQdFMDNLMZZyr9D4TocUoaB3GMWz6LfaT
 fTbmdgwgJrkc/qpM57jAUBPAU+l6sN7yml/Ewg2i0L4LGi1jAkXhljGSbRb67K261MjG
 tY8kH89pV8AXgVO6gHCMtFXB0VrnV+gusFFB4GHsmPst4FjKGBiWtfGcc+L2ADW6Zpjm
 FQ+w==
X-Gm-Message-State: AGi0Puapfmcy/vA8bznL38tC6X/VTzBNQTJbeWlc1jQDlge3NGfXfm77
 vMJkZSE4x0y8DbkZnraN7a7mEpo7S0c=
X-Google-Smtp-Source: APiQypJD8rnlv/Bz6w316u37pgsauAwmlZp/smHakdnsG+Qy+5pJD1CIIGLqty8+UdOvEQtKTyb8iw==
X-Received: by 2002:a17:90a:d192:: with SMTP id
 fu18mr3822147pjb.98.1588264099491; 
 Thu, 30 Apr 2020 09:28:19 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/18] accel/tcg: Add block comment for probe_access
Date: Thu, 30 Apr 2020 09:27:58 -0700
Message-Id: <20200430162813.17671-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
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


