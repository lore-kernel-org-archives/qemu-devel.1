Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B83CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D297214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YJh3uCNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D297214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8Oq-00032S-OT
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7PZ-0005Di-Eh
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7PY-0003q2-0y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:29 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7PX-0003pY-S2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:27 -0400
Received: by mail-pf1-x443.google.com with SMTP id v4so7155125pff.6
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=HIR+c06Wfqq3ZkFGxgsdg0iHWKtF3xHcneoz3/psN0Y=;
 b=YJh3uCNo2S9W9t3kF+BKtmjUFPIDp/7/zMEDIJY6puZ37YfFLh+y7dEiHV7coE2BMP
 Zi+9DxvkuxBVzzaIopYEYELn6kkx8WZbC7iJwRrC6Gz6+It4fnsbQEeX5Zd80Kfb/ceW
 tsTwX+b8CsC2XPfWuJrliGJBbUEhUkMuKm1CXIwD+BfSnuGhYxHkxJZ8rTJrNtpHdNvf
 cBTM/iRi2d3gR9z1jCW//2uGutTO7gtf4KxqpuQ8KUTrco+GsX2iKTQTZlGiDXbPW5V9
 UPo1G1R/B/iqo1D/YQtUaL4dInTc/oGqjxA+MAfn+X1APEQD5V4BYFVVZfPWi6DW9Igg
 VuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=HIR+c06Wfqq3ZkFGxgsdg0iHWKtF3xHcneoz3/psN0Y=;
 b=OdTYQUsb/hDdZ2sChoFGCttI7a+JP/VWUppiWNYbqWqh54CbB/gswu7ebyOz6Vm+aw
 DeTBx0DAT+3kSUvL9HzZQwRuCSwYKXigq4P+055tgo/EtHh7OkH3qJTtRTVffXvHWgyL
 vOfyag0ATTSczTRGnEuSyZTJ4bY2QaRGgBRQetgiOWkNohwxfnVAUprktLcLu1TegI1Z
 pK5h6LUW3YYuJW18tdPyxCuFQdj/vwWmeznjhesP6RTb5Lc9EAb/IBlr5WVWwdNxZd3+
 Sbw7UMAAQBi+JF5p5dDsQ/QXqD+fiiHDlWkMt3A6Wfj7u1g953R91oHPLakW7YoSerm1
 I+yw==
X-Gm-Message-State: APjAAAV5caAeMkVXuO/P+EzDNroUjKXu+1feJz1xxQ9EP2RhxtGxBMQY
 YbSWsJAvVNky7eKaRAaySmKmg7vhpBL2bw==
X-Google-Smtp-Source: APXvYqy/cnTueqbJqpZmDFmGsbVAM6uHUE0dlQQ+8TE2OKciOXXgJe1NKCMiqE+2LhqCrkKCP/G0ZQ==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr846179pjh.97.1572278306521; 
 Mon, 28 Oct 2019 08:58:26 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 66sm3855027pgi.49.2019.10.28.08.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:25 -0700 (PDT)
Subject: [PULL 06/18] linux-user/riscv: Propagate fault address
Date: Mon, 28 Oct 2019 08:48:50 -0700
Message-Id: <20191028154902.32491-7-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Giuseppe Musacchio <thatlemon@gmail.com>

The CPU loop tagged all the queued signals as QEMU_SI_KILL while it was
filling the `_sigfault` part of `siginfo`: this caused QEMU to copy the
wrong fields over to the userspace program.

Make sure the fault address recorded by the MMU is is stored in the CPU
environment structure.

In case of memory faults store the exception address into `siginfo`.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 linux-user/riscv/cpu_loop.c | 3 ++-
 target/riscv/cpu_helper.c   | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 12aa3c0f16..aa9e437875 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -89,6 +89,7 @@ void cpu_loop(CPURISCVState *env)
         case RISCV_EXCP_STORE_PAGE_FAULT:
             signum = TARGET_SIGSEGV;
             sigcode = TARGET_SEGV_MAPERR;
+            sigaddr = env->badaddr;
             break;
         case EXCP_DEBUG:
         gdbstep:
@@ -108,7 +109,7 @@ void cpu_loop(CPURISCVState *env)
                 .si_code = sigcode,
                 ._sifields._sigfault._addr = sigaddr
             };
-            queue_signal(env, info.si_signo, QEMU_SI_KILL, &info);
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
         }
 
         process_pending_signals(env);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 917252f71b..f13131a51b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -455,9 +455,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
-#ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+#ifndef CONFIG_USER_ONLY
     hwaddr pa = 0;
     int prot;
     bool pmp_violation = false;
@@ -508,7 +508,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     case MMU_DATA_STORE:
         cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
         break;
+    default:
+        g_assert_not_reached();
     }
+    env->badaddr = address;
     cpu_loop_exit_restore(cs, retaddr);
 #endif
 }
-- 
2.21.0


