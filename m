Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CC2C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECAD20672
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOwcxgGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECAD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR75k-000296-II
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74V-0000Nf-Uj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74V-0004dD-Dn
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:15 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR74U-0004ZV-S4
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id v63so434008pfb.10
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wfD3qzrTNTYWcIz1faBmR4+bRJgKxyAneWjssHLJ1no=;
 b=fOwcxgGfIr5FBkD3yUmUPjqtuEW1Da+0ABHfYwu+6a3XUr9+WZaH9sFdq4ZRZNUR5N
 odFKdauq5u/AybXpMNThlWxPRVyzv7RdzEQMgxwm+fe0YHw29PP+jHZL/ARxqSkSXPXl
 F49HXdt6yh9snFAdIe2AgMKZZAzL8I+qNZcskD7fzWQOxpmtC90Dc+l3hqHUcIGEW9RQ
 iGI9D5b5PuSNHzmbceGiKYQg3EGCbhQxWsu8C690ZNZbNF7Zd/FnQAtxyQzV7nWH+A/J
 gAO4THKysdhZ0a7M1RwaoZNxWLCzofTiVNWGi0aPBxA/vyXKjaRaMz1wkoXC0yHxSxRA
 2jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wfD3qzrTNTYWcIz1faBmR4+bRJgKxyAneWjssHLJ1no=;
 b=UKPnn/WpoF0UhaeFaaPs6CveOzkIHSSrV8IwhO0tM3WX2SsNYB/LeMhQTxH5lKrhB1
 3X1miN6QOfEL8UC9qtiH/r8V1xCdkabH4nxlosOx+cvfqaQpOQkNhvc/YqkxWDxJfnkF
 tCnP1h4I9JnfOxv1Pgz5UtHGV1rB4/ey5MTkH9/97WjN9uj08vu+XHg8i1EO6hPMzGb2
 iz22j4Kmr2DwGGQ53l5xyRir3drmZwuY2NF8nkh8PgptBZyoXk3GMW/WenFy8ZAgl38F
 kumyOAm9YfRZt+HKN+wl64lwYZmv9cbSxuYAxv3pEL02HY60fgVUZR3MyHiZdRvv10dg
 AzKQ==
X-Gm-Message-State: AGi0PuZO1RBbo4X4TQn0n4wz7CBst4GOoKLDCReohyubCj4rDBR1CZ0g
 bN1hd/yC9Z1ItTqv0+68Mbd3lT9iXPE=
X-Google-Smtp-Source: APiQypJPL8d/Vs/9tTQY7Dr9jfQPclpj9hpAVs2PodDHeG8YsO3qXGo5nyaclJa1A9wJMqhdOee3kA==
X-Received: by 2002:a63:4646:: with SMTP id v6mr25769727pgk.426.1587529992763; 
 Tue, 21 Apr 2020 21:33:12 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l137sm4129613pfd.107.2020.04.21.21.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 21:33:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/18] exec: Add block comments for watchpoint routines
Date: Tue, 21 Apr 2020 21:32:52 -0700
Message-Id: <20200422043309.18430-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422043309.18430-1-richard.henderson@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::444
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5bf94d28cf..07f7698155 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1100,8 +1100,31 @@ int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, int flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
+
+/**
+ * cpu_check_watchpoint:
+ * @cpu: cpu context
+ * @addr: guest virtual address
+ * @len: access length
+ * @attrs: memory access attributes
+ * @flags: watchpoint access type
+ * @ra: unwind return address
+ *
+ * Check for a watchpoint hit in [addr, addr+len) of the type
+ * specified by @flags.  Exit via exception with a hit.
+ */
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, int flags, uintptr_t ra);
+
+/**
+ * cpu_watchpoint_address_matches:
+ * @cpu: cpu context
+ * @addr: guest virtual address
+ * @len: access length
+ *
+ * Return the watchpoint flags that apply to [addr, addr+len).
+ * If no watchpoint is registered for the range, the result is 0.
+ */
 int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
 #endif
 
-- 
2.20.1


