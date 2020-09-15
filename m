Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B08206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFRm7GpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B08206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIF88-000286-Aj
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIF2b-0001fa-6w
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:46:53 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIF2T-0007GS-9J
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:46:52 -0400
Received: by mail-pf1-x442.google.com with SMTP id d6so2362768pfn.9
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JotyD3Qtuzk8QZcm87RVQJeRfD10PDp771HanSJw7Xg=;
 b=TFRm7GpV/Tqur/hNAsBGULyP9RhpLzW9LMYgch50eVr8abDtCo4Hl71F83GUwogm4P
 uomGjLgkG/WUsxXuKVlv8Zv3fa1L0wGbbmYgi51MzdmA/3w/O0mJhKAIlILFFU5mY8fW
 MKWQEcHH/wExKtXgqdWkEjqQ6XMNqqjZnSU9BWgwDGfPKlmgr1KJprX+w300tk3T8KYW
 48/Yk1YxAIyNy5WN+BhFrXlAX3yzjxDSkZaK+pqChSUu0PgU4eVffvIxxDatBkz4Zkjq
 sOo7RuFsvLxvCpwiVPLSf0ys6+abKNULT3eGKEkB9HZSE2l1roTKtqb3ZaVDgT3n4sva
 inUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JotyD3Qtuzk8QZcm87RVQJeRfD10PDp771HanSJw7Xg=;
 b=XGxrGd4nqBIxdQJ+AuMcIHb/dglK5ra3q57zUGlNsAhxPp/DggMlPUaVdvGxVJjx3/
 Ev/q89sNvRGTUJWWee/bQC1/m+QHqTFMJWvGKCtPcdc59v2P54s/SHPy5GdMpb+SFuPV
 1fyALv5+Dyf2o5Ahw/Q59bSor0nOmk9Fa6c4edofRnYi7OoobGCMm0cqMgkGn2LLb324
 0uUsv3Kh1GjvrmObq74Vp5hhtn7vUAjmLnRNRAiur0yivIGbgl/xl+u8Zqr2vzQmpcHh
 51JYoXm3Qbcy3tXcOn/DR9MpzCcfJjDUo7QSP93BbTFGKVRMi2fuos9s9n32KLuTCiN5
 Z5Lw==
X-Gm-Message-State: AOAM532kReuvGz6E+QrBoczHwS8skF2fPloUYhJF3vxuECZCw55V+3Vz
 xgUntXaw7lJdOfsDH41eRYAO1+hEtm4Jow==
X-Google-Smtp-Source: ABdhPJxXH6KOyPteR7lyoeVqBO5q8aZL4gQu9BXNKdb5awaGSTtuAVl5sndjARHnyma8PCEOWyGTIw==
X-Received: by 2002:a65:5ac1:: with SMTP id d1mr13618608pgt.230.1600192003205; 
 Tue, 15 Sep 2020 10:46:43 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id cf7sm147896pjb.52.2020.09.15.10.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:46:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/s390x: Set instance_align on S390CPU TypeInfo
Date: Tue, 15 Sep 2020 10:46:35 -0700
Message-Id: <20200915174635.2333553-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200915174635.2333553-1-richard.henderson@linaro.org>
References: <20200915174635.2333553-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix alignment of CPUS390XState.vregs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org
---
 target/s390x/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 749cd548f0..e350edc9f5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -517,6 +517,7 @@ static const TypeInfo s390_cpu_type_info = {
     .name = TYPE_S390_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(S390CPU),
+    .instance_align = __alignof__(S390CPU),
     .instance_init = s390_cpu_initfn,
     .instance_finalize = s390_cpu_finalize,
     .abstract = true,
-- 
2.25.1


