Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52E9C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5C120820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHfb9L2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5C120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39674 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha9pL-00082X-NE
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52903)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9do-0005jx-99
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9dn-0001cy-8k
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:32 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:37374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9dn-0001cY-1x
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:31 -0400
Received: by mail-pf1-x429.google.com with SMTP id 19so3484448pfa.4
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9aukZSJTtaEX+E6TYMtemh6Y/79Nrv8IxJ0VQThpXlk=;
 b=nHfb9L2XltDjexft8NMwFWzXXzLL9G0jfmvJh4JGDzhWyVokzo0UQx5p9BivwYIvmg
 TUT+9+NI3LGP+2ehz+8T8CaP2ATCwo3EqNVeg+t1aCf+8apSxZ+fZcTQ0PTZzqMixjEq
 v4zA9dHbdC87FMW3SJJeGQhPVlkwCf9u7+AarHMe1TjNJn2XqUY5SlClPDDImuF/sXqH
 UEgfAwjdWWt17sA/8uzQ0/5QG7oOameSX5wtBP4kofsU8czCVlakEzRCBwP6MorcoxMF
 uXNivDNUMxPcjyk5xb+J82zmPpGmmlokT2NhDgIaq5/r3mfqA5QFvtTE+U+Grmi1kmiE
 egcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9aukZSJTtaEX+E6TYMtemh6Y/79Nrv8IxJ0VQThpXlk=;
 b=ldb8YF9hcgrW0sGZtxbMPnu7vjs9fU5F5qr8uT1e+qJPjo/phZ7F+TlYEUYZymJWP5
 6azREbu9QPaBMC0/1og+E+7RZr41QWPpg1uuo/kNT4ppq76jLMZlSMLntrPOzCOG38D8
 tT2FIkptKs6LtKTiA/QYkwIoqDgICWhIxV0G8WVYvfH7vf/2BP9qbSDx+u2qcB32c9Lx
 4FuuLPVOMGNIJOA96O271I/FpNBsXa4cfY3kqGUJNIxF6tigROx8CHzMZg6HrBLTvMVz
 eap5AzPMt62/GWoqW+M9wfei4wlFSVPzFt1TfHfIcyXBzOwdZXtzTSpTzYPi/hiR7LpN
 oyVA==
X-Gm-Message-State: APjAAAUavh0FtaN4rf+UZl9XNX0YUkoNUV/kn0AC0/7pLQWO7XSF/0wZ
 HXgvLEpU1bhUls8fQOyOf5JsMptEVGU=
X-Google-Smtp-Source: APXvYqw17YHR83GqEmNaRlph29G7Bnyvj0XqnAD/pTwmjRyPCzxykPF6trKVYIwQpqi/xDQ6n+D61g==
X-Received: by 2002:a63:445b:: with SMTP id t27mr13571344pgk.56.1560132149435; 
 Sun, 09 Jun 2019 19:02:29 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:01:46 -0700
Message-Id: <20190610020218.9228-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: [Qemu-devel] [PULL 07/39] cpu: Introduce env_archcpu
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will replace foo_env_get_cpu with a generic definition.
No changes to the target specific code so far.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 454f6d663f..c62f07b354 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -371,6 +371,17 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
 
 int cpu_exec(CPUState *cpu);
 
+/**
+ * env_archcpu(env)
+ * @env: The architecture environment
+ *
+ * Return the ArchCPU associated with the environment.
+ */
+static inline ArchCPU *env_archcpu(CPUArchState *env)
+{
+    return container_of(env, ArchCPU, env);
+}
+
 /**
  * env_cpu(env)
  * @env: The architecture environment
@@ -379,8 +390,7 @@ int cpu_exec(CPUState *cpu);
  */
 static inline CPUState *env_cpu(CPUArchState *env)
 {
-    ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
-    return &arch_cpu->parent_obj;
+    return &env_archcpu(env)->parent_obj;
 }
 
 #endif /* CPU_ALL_H */
-- 
2.17.1


