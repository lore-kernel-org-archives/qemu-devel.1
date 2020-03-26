Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8B8C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008DB206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQCr56Tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008DB206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYt0-0002jV-5q
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLN-0000H7-6D
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLM-0002D0-0p
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:09 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:40828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLL-0002Cq-Sg
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:07 -0400
Received: by mail-qv1-xf41.google.com with SMTP id cy12so3696541qvb.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eeSLak8+K7WugRHnssmk7+JwZVy31ZcBf2Dmq4ryGYA=;
 b=IQCr56TpmVCBKEnOe0s36sZGQuJYgCJw5F4xi+RQQAzQ+IZx0OdCfZkFaSJLP+ktv5
 paGiFf+cOLUK4GiecYBIKNiKo+ZmfYzmRhThgZ5EwY1SKwA8WsqsRzFlb5iXxXDATam9
 hE9yHABChK1IAiJ0DnO3j3xPBHh6fTJeYm5HUco2Rs9I5kEqgOJXit9/EPe5jZGF9DG3
 DnsmVA1Bs0bFKLzxHNFDqXFpFlbA80wANd0c/pIxYoDOiofANASYdcsSAash2zrVT9/J
 PYYkjGKpNNxPbETvOnKH6DH5a0zjeoSuGm7mSXnPkuC33i6nF1Vv+v7EouP1gln/RqEF
 J11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eeSLak8+K7WugRHnssmk7+JwZVy31ZcBf2Dmq4ryGYA=;
 b=jbu6s7fzFiY8V7Vt6ODZe/jJG+oq2Kpt6SsfcHeY9sZXXxh+d9EVWQrkQ30Z/XmC1s
 39dsdItaANFsm7k2LjsMA7jbp/uyJ/fxOLwRXW9ojq1zxAtLkr2Kp6dP4s0peYrA0GNe
 1mdx5RV+gvdCRYly8wWo6xHV1RjHi3q/e+eqMh7y8L6vFgrgNI/dq8iZiyIp0m3VxGzx
 gxAW1R7NtPq+Mqy2F4RTRH1PTNMJPT8nSFocqO2B8jL4k3Rf96rS9a/zp/QBqPyK4m5F
 ibuVaHMaKGorABmVO9fuwX0HSkOgfIfemEm7/FH+cSLU2OSgg7bHe99FdM7eij5BJThs
 v4Lg==
X-Gm-Message-State: ANhLgQ2a9YcEgnnH3Y7yEuE2gWGF8/nsUN116YcLdEa3Yq0MngG6R436
 xmn0G56KlLgeSx1MIooThnlZkxLhubjIzw==
X-Google-Smtp-Source: ADFU+vt+PSNhxZAILBIVqyO3bPDq7tbbDSkLrykmh3ITI2r66OFc9PdfSnRPMU8koCAbFNQwfTvkyQ==
X-Received: by 2002:ad4:45e9:: with SMTP id q9mr10083008qvu.199.1585251547072; 
 Thu, 26 Mar 2020 12:39:07 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:39:06 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 67/74] riscv: convert to cpu_has_work_with_iothread_lock
Date: Thu, 26 Mar 2020 15:31:49 -0400
Message-Id: <20200326193156.4322-68-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: robert.foley@linaro.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e578239d3..ebc2483bec 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -314,6 +314,9 @@ static bool riscv_cpu_has_work(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+
+    g_assert(qemu_mutex_iothread_locked());
+
     /*
      * Definition of the WFI instruction requires it to ignore the privilege
      * mode and delegation registers, but respect individual enables
@@ -515,7 +518,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_reset(dc, riscv_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = riscv_cpu_class_by_name;
-    cc->has_work = riscv_cpu_has_work;
+    cc->has_work_with_iothread_lock = riscv_cpu_has_work;
     cc->do_interrupt = riscv_cpu_do_interrupt;
     cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt;
     cc->dump_state = riscv_cpu_dump_state;
-- 
2.17.1


