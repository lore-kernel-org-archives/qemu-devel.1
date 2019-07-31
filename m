Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17C1C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2547206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHZEjEKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2547206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrXM-0005Zf-VB
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45267)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPq-00059d-Hb
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPp-0000PI-Gk
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPp-0000Om-9u
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id 31so70406825wrm.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NZPJc3zYVl2nOnmRetp03IWG86OpIb2lpqWUrvn/Bks=;
 b=lHZEjEKgtFtZ3MYo1QDovaqQEGDCTQU9V1WKGUbhfugZV/k2qg8DGVOHf2WZ4ruwf9
 f9vi2n/WI2xOpMc6IBKsFtlKnzZomjLimL3kstT7tlPCiuI0HqFoNGm1LKm1JgVFUEvA
 zcJo3WxONnl8WAliaISdt0MCxqaVYed9I/fiDb6aR9DJWggCjELVwkCEWC4O2LZfQzN4
 wCe9BiseZvPOPHqiaipcuAtozt1eXxXzJCck+OzNpLAbyTLCBjbcJkssgJ0nMArld9fM
 rj3bPEc4BvHWOYcMnxZXxayuwUgWKgqxO/fEHzTTne5XkdxizVc/5SXoo2DK6N343PLc
 CYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NZPJc3zYVl2nOnmRetp03IWG86OpIb2lpqWUrvn/Bks=;
 b=aFerla8RHXJAzHS58xXtPCOXJ388EV1HTTOjOKjQ6oActuTIXA65Ur8Pj+t1BxHKKP
 T3aP19xh1HqvjZN6xpDU5X/X+SDDU7+HtQ7I+LaUWniEpXTqLQcEW99HUAEU34AKY3M+
 osMrnNGj9jYgvsH2XR6ZjLTXNbc7BpDzmXHDYfZ/KIS/Uvo+N7+38Os1kDKEow3UpHwC
 gqUVDCd47JMxNVpqgMIyFjm0cW25JPEvGSv4BChSPTp++Xpdq6q5cMA1AnPIwCRHjvSu
 bkJHRSq7KUa5q7DGn7HNuNJenj3egs+c4H41zEQIi6+hdoGy/Jzs7A/Stc9X7A4K0JtE
 Wmdg==
X-Gm-Message-State: APjAAAV+3ZE69u1pXt+KtimZAH+zfdKVn1hEFRZnUuw9eLRnh93ZOr3F
 0NCt5tbd3lvmB48CYZK9VFw0Ug==
X-Google-Smtp-Source: APXvYqzBTEH4lk4w9QsZyu+x5cZzGeG4LKxuI5fKhOpCRit1RzuzDYJJbd8+vH08DKaoa61fUXcdwA==
X-Received: by 2002:a5d:4cca:: with SMTP id
 c10mr129112522wrt.233.1564590324261; 
 Wed, 31 Jul 2019 09:25:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l17sm47513161wrr.94.2019.07.31.09.25.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:22 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2CB3E1FFB1;
 Wed, 31 Jul 2019 17:07:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:53 +0100
Message-Id: <20190731160719.11396-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH  v4 28/54] cpu: hook plugin vcpu events
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, aaron@os.amperecomputing.com,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
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
 cpus.c    | 10 ++++++++++
 exec.c    |  2 ++
 qom/cpu.c |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/cpus.c b/cpus.c
index 927a00aa90b..cef94560e31 100644
--- a/cpus.c
+++ b/cpus.c
@@ -44,6 +44,7 @@
 #include "exec/exec-all.h"
 
 #include "qemu/thread.h"
+#include "qemu/plugin.h"
 #include "sysemu/cpus.h"
 #include "sysemu/qtest.h"
 #include "qemu/main-loop.h"
@@ -1241,9 +1242,18 @@ static void qemu_tcg_rr_wait_io_event(void)
 
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
index 3e78de3b8f8..65374d0bdc8 100644
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
index f376f782d83..90ebb214bb2 100644
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


