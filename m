Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E101AC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC13F207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZV4UF0qW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC13F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJy3u-000074-Es
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvV-0007YQ-2d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvQ-0006C6-05
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvP-0006Aj-Pm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:03 -0400
Received: by mail-wr1-x442.google.com with SMTP id r5so19091396wrm.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uvacSGmjYgiAWweJmrehENexJyDt68fPjc90zp076LQ=;
 b=ZV4UF0qWD7rw1Lw82K8YUQjXqUDe1AKrCsnHw50HvXWPYaQmmSaNZhtUgPXXEzlrCK
 JK7Mw4FcSBiyOObR3orFFGTyq6iMk3UVWfrY7EZc4R7zMYyWsWR1+0PSy5+B8+LtnNcd
 Gk0c63zJJA/1ImzoQ7eMSPIqp17sicz6sBVBh5QwJ8FFjJAx+NoVolZBhG4NzK0Gk14V
 ddoAkoZk2m/nLB0MI3LB2fAuxQgwxSoyOmnkO63z151aIdbekXuycKcXCMEimKuJ6WHP
 +lq40Tu4dbXiV3B2ded3RbyQXCjrT8aqAJIAarmZUpvdibVov8sHuwSBO+LZZ5Jz4Ri4
 Ih9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uvacSGmjYgiAWweJmrehENexJyDt68fPjc90zp076LQ=;
 b=CcsxH+nF7PRmN/FX3BJ905VWQPP7sqYpj9D/24RDyI+O8kxRLxw8RhDq0XrVf+eVQR
 i0AnWy43lKBH1rbw3QiYrovRRCLWrgBIk+UzsJS2bBnBSzRb2Uu+frxUSHtexYE0tBcN
 AAydYqUp5NO6O0l5+DlUZji6HuoVd/E3QfjGp4xi+YKMUWRzpyEkAErYgmtSvYv4KZR8
 pr0JH2fwwOuxgI19b/H++Ln7WdT33JeIHRh5gkbQetb8RPVedlZ7+ERwruan9G0Kg1YB
 r0/BRJ+3z3gsp8C+ZPNUd5n/3uk1hbepVxQuojHthr+O/L2ZGkQ2kKno70kiP1ohu8mH
 iz8g==
X-Gm-Message-State: APjAAAVTPS6+nHBjj5VtSLZ8//vVe9wRy/8p4UJCX5CuYcUmKFuYOAh5
 +3amugwSolpaOooq1PDy5zRWjg==
X-Google-Smtp-Source: APXvYqyn+YDxTEBv3FaiLLS+h4UXvLGUgnl3hcqKDOf5ph9pjnAjsdZTAmAEDNwOUE77W2X6MBbbTQ==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr539987wru.120.1571050202758;
 Mon, 14 Oct 2019 03:50:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f143sm30441224wme.40.2019.10.14.03.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3099B1FFAA;
 Mon, 14 Oct 2019 11:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 21/55] cpu: hook plugin vcpu events
Date: Mon, 14 Oct 2019 11:49:14 +0100
Message-Id: <20191014104948.4291-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c        | 10 ++++++++++
 exec.c        |  2 ++
 hw/core/cpu.c |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/cpus.c b/cpus.c
index d2c61ff155..98f00ffba7 100644
--- a/cpus.c
+++ b/cpus.c
@@ -45,6 +45,7 @@
 #include "exec/exec-all.h"
 
 #include "qemu/thread.h"
+#include "qemu/plugin.h"
 #include "sysemu/cpus.h"
 #include "sysemu/qtest.h"
 #include "qemu/main-loop.h"
@@ -1255,9 +1256,18 @@ static void qemu_tcg_rr_wait_io_event(void)
 
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
index bdcfcdff3f..7be7adb8f5 100644
--- a/exec.c
+++ b/exec.c
@@ -975,6 +975,8 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
     }
     tlb_init(cpu);
 
+    qemu_plugin_vcpu_init_hook(cpu);
+
 #ifndef CONFIG_USER_ONLY
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 73b1ee34d0..db1a03c6bb 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -32,6 +32,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
+#include "qemu/plugin.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
 
@@ -352,6 +353,7 @@ static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
     CPUState *cpu = CPU(dev);
     /* NOTE: latest generic point before the cpu is fully unrealized */
     trace_fini_vcpu(cpu);
+    qemu_plugin_vcpu_exit_hook(cpu);
     cpu_exec_unrealizefn(cpu);
 }
 
-- 
2.20.1


