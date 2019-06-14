Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E324DC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43FE21841
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3sZ4Pnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43FE21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53850 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqER-00007R-W6
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58595)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqh-0005ap-3b
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqe-00077D-Bx
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpqd-0006b4-T2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id x4so3333234wrt.6
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IwZdpz8vUj//qW3TG8z9CwKHzzC4bqX+Vltp43bJ1yk=;
 b=o3sZ4PnpU7FHbCcoy45V70DS9r+zSw5ECniTV+Evo0WkDiAXXUAan11CUevOdMEY8n
 Nai+SerQO/wxlFsTX1Pr5YgRozUk4r9KbBlyEO3VNzQRFQszReDQ93r0H6fTkOzrtPGl
 XBTDQIvJmwhuL4bPnmk5p3Ri8cPANLkvz1fFcCWZ0AApk4fvr6FwyhJ+N1Q4H5GpZvi1
 HqWPCy1XJY+UiQ1BZ0h4Sb6XP82C7rrQ8VWioBrnY28FrFgVfQgvgd53nzGiFQVs8Kdy
 MJVkRe+HRUOCN9NP6fz5/JO2muJQDyTbKBPs8fgVhTTND0cnKJYiqGt0Rhx/eXMeob0L
 6LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IwZdpz8vUj//qW3TG8z9CwKHzzC4bqX+Vltp43bJ1yk=;
 b=fMoMXNbzt/1Kkb+BP1A8dRv3yHHEMfbyNgjGflLOGGVBO6F6sABZOgj1opCutxp2M3
 5haXsz+dpvbgSveMoXf4jn5OsF3M0dOCqZMOYzbyQr7JKgRF40WqYhe4aLQccg2OkWY3
 AL6J/7QiL28GUYv9CPbuvZMHReo6iDE+wgPBlc67isvRDYvFiWu/uV87i4v7CovOAa9q
 gCF/lbzWpfwzAc33OGLBSWzqU0FRuNTD18eUDfJAQqr3utc4Qv9+c9IYZDsuK0FXJVuV
 td0CUUAbvHT+jBCB7TK4btf+NajEEYa8E/Jnx3PeIEiuTp+mrOUa/TFtkMBYl5XyU7l0
 8hjg==
X-Gm-Message-State: APjAAAXSHkAykLCe9J3qoiVtwXbYqs/Qqgs0Dd548HYOSN2cVh2Ostet
 /P1TJ79jWNswSx8Kqu9RDgwJNw==
X-Google-Smtp-Source: APXvYqz31UqvKCNHZO9xGIlxVAazLGxYSQHiG8W5YLcZ8elMnr2BWRfeaX9+8IOYzyTN3T7LSPGzig==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr6522617wrp.353.1560532707867; 
 Fri, 14 Jun 2019 10:18:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q20sm6518030wra.36.2019.06.14.10.18.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:18:26 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9594B1FFAB;
 Fri, 14 Jun 2019 18:12:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:33 +0100
Message-Id: <20190614171200.21078-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH  v3 23/50] cpu: hook plugin vcpu events
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus.c    | 10 ++++++++++
 exec.c    |  2 ++
 qom/cpu.c |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/cpus.c b/cpus.c
index dde3b7b981..2f86af9a87 100644
--- a/cpus.c
+++ b/cpus.c
@@ -46,6 +46,7 @@
 #include "exec/exec-all.h"
 
 #include "qemu/thread.h"
+#include "qemu/plugin.h"
 #include "sysemu/cpus.h"
 #include "sysemu/qtest.h"
 #include "qemu/main-loop.h"
@@ -1243,9 +1244,18 @@ static void qemu_tcg_rr_wait_io_event(void)
 
 static void qemu_wait_io_event(CPUState *cpu)
 {
+    bool slept = false;
+
     while (cpu_thread_is_idle(cpu)) {
+        if (!slept) {
+            slept = true;
+            qemu_plugin_vcpu_idle_cb(cpu);
+        }
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
+    if (slept) {
+        qemu_plugin_vcpu_resume_cb(cpu);
+    }
 
 #ifdef _WIN32
     /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
diff --git a/exec.c b/exec.c
index e7622d1956..4a29471c3d 100644
--- a/exec.c
+++ b/exec.c
@@ -974,6 +974,8 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
     }
     tlb_init(cpu);
 
+    qemu_plugin_vcpu_init_hook(cpu);
+
 #ifndef CONFIG_USER_ONLY
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
diff --git a/qom/cpu.c b/qom/cpu.c
index f376f782d8..90ebb214bb 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -33,6 +33,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
+#include "qemu/plugin.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
 
@@ -354,6 +355,7 @@ static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
     CPUState *cpu = CPU(dev);
     /* NOTE: latest generic point before the cpu is fully unrealized */
     trace_fini_vcpu(cpu);
+    qemu_plugin_vcpu_exit_hook(cpu);
     cpu_exec_unrealizefn(cpu);
 }
 
-- 
2.20.1


