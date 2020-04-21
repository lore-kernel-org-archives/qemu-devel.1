Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C53C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7E820656
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnQAf2Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7E820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34949 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyRn-0000tK-ON
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQa-0007hJ-Bb
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQZ-0007h6-05
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:28 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:39335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmerdabbelt@google.com>)
 id 1jQyQY-0007g6-Iy
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id 18so3404980pfx.6
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=cZPeewRwiJVRdUYRTxdn8RCJkKDKnsBX9QxOz+unSto=;
 b=BnQAf2Cad4prW/7YASlz4IQP8J4m59IwwQM1M3NugT8rHkZNle+/H6Ca7hYcgQHikQ
 8cnw69rrJ5FI9um8qbM6LCAEso8OtkcKhg+8A+ThoCriciEY9xunauxfmE+r1gq4B/VZ
 EWZhaSNiw/Mxo10hotzTPYSR54k5KwjxZLYqSJaKwVIQnmA8K+Z5ID9vOK8HD7wQoNAN
 LloUCa4qQVCN8IB6sP8E3ePSTYHKYJ83pasRrRvwWKPge058uhXgQwJBSHtxZeiZIt2G
 evNxzd3liYc5hUC6LIjpljZPyXkC62BDJQUJkFIQLfwEUOwbMMUF+3Wk8xSO6DI042Q7
 2L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=cZPeewRwiJVRdUYRTxdn8RCJkKDKnsBX9QxOz+unSto=;
 b=A2NYfP0ob4bhvzh7pd5lqHmSupN/DJDaevUWMxJweFxSEnSJj/WJPDdm0kJcYf8Gbn
 r1vC8mF+5uIfeJVO4ZgVbNiyZmzex7E+A1i//2jru4hvJFCg5xLfubG12+AzYFg3h1oK
 tRF7Tt0SkQCapH5qGvFUxzMwFZOODHnR4KYpl84LV/9O/4MjGXjQLykPPmAl7dU4Stsd
 TRafj4cqVsDN/IBMXAvR49M053+MHVGj6cCWgTJLGCBNT46gMZQcay91H+PqnZy1LsqT
 9z7SimCTT5RcrQuht37sYSW/9rwPeymbKsAidctRwr0o1ff5eBJG9LTncZpjSGZF64OC
 BApg==
X-Gm-Message-State: AGi0PubIf0d1n+p+75xtZUXSzGt26Jd8gYKEALfa9Qks92WP8nbpDRlM
 5skToM7J4LtoB6j/YnO5g6H7zA==
X-Google-Smtp-Source: APiQypLVvMwxS5H7oRV02Lz94Xw0U0xOwQWypvN2+mi7Irq6BjAZTB9R4ob1fJ/r+zDWzCyhSTFyIA==
X-Received: by 2002:a62:5c07:: with SMTP id q7mr23741046pfb.200.1587496765135; 
 Tue, 21 Apr 2020 12:19:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id o11sm2928763pgh.78.2020.04.21.12.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 12:19:24 -0700 (PDT)
Subject: [PULL 2/6] riscv: Don't use stage-2 PTE lookup protection flags
Date: Tue, 21 Apr 2020 12:09:57 -0700
Message-Id: <20200421191001.92644-3-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421191001.92644-1-palmerdabbelt@google.com>
References: <20200421191001.92644-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=palmerdabbelt@google.com; helo=mail-pf1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::436
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

When doing the fist of a two stage lookup (Hypervisor extensions) don't
set the current protection flags from the second stage lookup of the
base address PTE.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e2da2a4787..48e112808b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -452,10 +452,11 @@ restart:
         hwaddr pte_addr;
 
         if (two_stage && first_stage) {
+            int vbase_prot;
             hwaddr vbase;
 
             /* Do the second stage translation on the base PTE address. */
-            get_physical_address(env, &vbase, prot, base, access_type,
+            get_physical_address(env, &vbase, &vbase_prot, base, access_type,
                                  mmu_idx, false, true);
 
             pte_addr = vbase + idx * ptesize;
-- 
2.26.1.301.g55bc3eb7cb9-goog


