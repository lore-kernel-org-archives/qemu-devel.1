Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147A9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E5F2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NggRqcRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E5F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYq8-0004SV-48
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkP-0004Jw-61
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkO-0007YN-CT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:36 -0400
Received: by mail-wr1-x430.google.com with SMTP id q11so20094364wrp.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zwLwjsoqgTFgZrqe9d7QANVT2RwPZgdh3/KDYhJg9q4=;
 b=NggRqcRL1dgsJBdnw+Z401yh/8hzAW9WwO0IoKb32n+qFpa4ar4xYNrWdz+9vyo/GC
 6FMr17Ea/Y9Wt27Sykq8bgO+CHwt22TsIl6zvYEFPq3TOb8excMa5I3fTY4Stk8oLWs7
 HaMabCcX/QkZ3PJzCbdP+2PSLxluHgtbbE7pIF014+oi6Gt2zLr7xaEIcvr8IiaFMYRz
 TLDJgeRFiVFUTCXksNEeie0Vmap9XeBilsVAhNv4+OIjgFCNzB970KctK5KIyrXWjcwC
 MYsUC/m9N+KtOfVdHfdWSFcnzTvj82/U8sPP7B2z2e7Xf3mceUIxB2xSaT8vNXU3xIOT
 T+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zwLwjsoqgTFgZrqe9d7QANVT2RwPZgdh3/KDYhJg9q4=;
 b=uNy/UCx4gkT0Ph/IxlvqAsycfb2dj1YP+HdTW86zGwiQ++J0UrUN/7hOdEhiyTrxAf
 q0sMLDOQUsVeVKE31mcY/qD08CPPB2qLnNEk85QFrwYIjWh4jl0GBgHBCCsYIbjkfzhf
 lHMYFTTd1yZwVAto/JNHW6suWiRWOyY4gAqyjxrfG1xRU0kFo2yxbCk4IqpKamEMjyFb
 OzDxYqDbMRBvCI4n5llI6b8xFXXAm4uXxUgILPoNUdXnE3ZvfjMJ+ELHFDhGLx8EeEOv
 yrFWXrMn95+qFTQhn3t4DQtDye9ior/vrAmO658O1ISz2j1L/3vxmSDtcQ6gy8GoziJq
 HQFw==
X-Gm-Message-State: AOAM533UDF+7zaz02TPHKHUN3+jVmDfe7huNupEnsT6j8J0R54PsU192
 Zb3IdziuL6Vj17Vg/GJzkANG8173
X-Google-Smtp-Source: ABdhPJw4x+X9Le+6CgfIMJ07XpbJsFk8TLYpGTXwUBKZT9TJkLn98ef/8yoN2NmHEQiAd+PJ4/Vk5g==
X-Received: by 2002:a05:6000:1192:: with SMTP id
 g18mr3020148wrx.326.1591687954787; 
 Tue, 09 Jun 2020 00:32:34 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] target/sparc/int32_helper: Extract and use
 excp_name_str()
Date: Tue,  9 Jun 2020 09:32:14 +0200
Message-Id: <20200609073214.14079-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve exception error report:

Before:

  qemu: fatal: Trap 0x06 while interrupts disabled, Error state

After:

  qemu: fatal: Trap 0x06 (Window Underflow) while interrupts disabled, Error state

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20200331105048.27989-8-f4bug@amsat.org>
---
 target/sparc/int32_helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index c56dd3df18..9a71e1abd8 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -57,6 +57,14 @@ static const char * const excp_names[0x80] = {
     [TT_NCP_INSN] = "Coprocessor Disabled",
 };
 
+static const char *excp_name_str(int32_t exception_index)
+{
+    if (exception_index < 0 || exception_index >= ARRAY_SIZE(excp_names)) {
+        return "Unknown";
+    }
+    return excp_names[exception_index];
+}
+
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
@@ -77,10 +85,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         } else if (intno >= 0x80) {
             name = "Trap Instruction";
         } else {
-            name = excp_names[intno];
-            if (!name) {
-                name = "Unknown";
-            }
+            name = excp_name_str(intno);
         }
 
         qemu_log("%6d: %s (v=%02x)\n", count, name, intno);
@@ -106,8 +111,9 @@ void sparc_cpu_do_interrupt(CPUState *cs)
             env->def.features & CPU_FEATURE_TA0_SHUTDOWN) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
-            cpu_abort(cs, "Trap 0x%02x while interrupts disabled, Error state",
-                      cs->exception_index);
+            cpu_abort(cs, "Trap 0x%02x (%s) while interrupts disabled, "
+                          "Error state",
+                      cs->exception_index, excp_name_str(cs->exception_index));
         }
         return;
     }
-- 
2.21.3


