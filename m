Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4640EC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF6320760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiG+Ndfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF6320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhWU-0002ZT-ID
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQB-0002gX-TN
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:03 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:46270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ9-0001PU-Av
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id o5so12221901wrn.13
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1wBDqPu0Mh/k8EUaxsOa5LE93l3x7HmJK/nuzfwKfPY=;
 b=CiG+Ndfb7Yi+VakfHFYwq2ofJZZMpJX9NyRJhEuz00uucRfDIZ72jMnGwSHzzz3I+D
 mDXoLXNey7xtU1bBFO/lP/M7wJOkTbSdIJCRutlbNdO53zBbU0BDPbbj+LkDul20e86o
 MfuHwXqQCu79GsnPGTy9DiV1NA2Xq800pLBXYW30mFo8/SjnDTTKPmzRqr2xI13Ewapp
 MRTyjPPIWDWpAcq/Qlsqn6psdhroYKZukjs+KaXybmivhEVTDza3tsoBkNJzhe8p0Sge
 7OtsSiflsaXi2fHIMVhoC1Rf9eaQVINjrG4xuBqrejfWRKxlUnZDakGpWkTZsBml+F+E
 Y5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1wBDqPu0Mh/k8EUaxsOa5LE93l3x7HmJK/nuzfwKfPY=;
 b=MJH3TX4mC2zkG8RNuGJaUZ1OOKQgjF107TurOiS5Mmo8GC+sxaoGW+6QMQQcXR/9LC
 UW5n3ZRcDILlzTfg0GdlVf0Vy3vV6CXUZ/lNLy+woiMWygRce49W+ZowvNAhaGxEcs2a
 LQraoX8gk0yjrBLugxH8zDylVOwOgw+KwRZd2TU1TiLrLtwIYyKGRKUhjj0qVdB0yfGs
 5ZF7MqleRPNXlcQakiDRYB9TTYExCe4U9iwEyUu03/Qrcgpnm9yxaEMG+owLGJFCAljW
 uFp6dYftqhk51AZEg1jpE7k3lmnoVbgwIA8qLcb87lGV8+BNzPMmJdHXC3WXZxa1mBvG
 c5Ww==
X-Gm-Message-State: AOAM532rLaAfYuXJsSzKFyazyBiLOYWa6cDDkb4myTwACIRCiNX8DCGC
 3cDKPWncFb4FW6UqJJsJZh1FDKMnPJU=
X-Google-Smtp-Source: ABdhPJy7KQfpbD1gvvSG0FyhBXW9pm3+j0ZoKdNJSlwXm/f4uoRi8qTvpCQ697TUyGdDtfs+23ysZw==
X-Received: by 2002:adf:f504:: with SMTP id q4mr3217147wro.353.1601969399730; 
 Tue, 06 Oct 2020 00:29:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/37] hax: remove hax specific functions from global includes
Date: Tue,  6 Oct 2020 09:29:25 +0200
Message-Id: <20201006072947.487729-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/stubs/hax-stub.c    | 10 ----------
 include/sysemu/hax.h      | 17 -----------------
 target/i386/hax-all.c     |  1 -
 target/i386/hax-cpus.c    |  1 -
 target/i386/hax-cpus.h    | 16 ++++++++++++++++
 target/i386/hax-mem.c     |  2 +-
 target/i386/hax-posix.c   |  3 +--
 target/i386/hax-windows.c |  2 +-
 target/i386/hax-windows.h |  2 ++
 9 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/accel/stubs/hax-stub.c b/accel/stubs/hax-stub.c
index 7ad190cae2..1a9da83185 100644
--- a/accel/stubs/hax-stub.c
+++ b/accel/stubs/hax-stub.c
@@ -21,13 +21,3 @@ int hax_sync_vcpus(void)
 {
     return 0;
 }
-
-int hax_init_vcpu(CPUState *cpu)
-{
-    return -ENOSYS;
-}
-
-int hax_smp_cpu_exec(CPUState *cpu)
-{
-    return -ENOSYS;
-}
diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
index 9b27e65cc7..12fb54f990 100644
--- a/include/sysemu/hax.h
+++ b/include/sysemu/hax.h
@@ -22,29 +22,12 @@
 #ifndef QEMU_HAX_H
 #define QEMU_HAX_H
 
-
 int hax_sync_vcpus(void);
-int hax_init_vcpu(CPUState *cpu);
-int hax_smp_cpu_exec(CPUState *cpu);
-int hax_populate_ram(uint64_t va, uint64_t size);
-
-void hax_cpu_synchronize_state(CPUState *cpu);
-void hax_cpu_synchronize_post_reset(CPUState *cpu);
-void hax_cpu_synchronize_post_init(CPUState *cpu);
-void hax_cpu_synchronize_pre_loadvm(CPUState *cpu);
 
 #ifdef CONFIG_HAX
 
 int hax_enabled(void);
 
-#include "qemu/bitops.h"
-#include "exec/memory.h"
-int hax_vcpu_destroy(CPUState *cpu);
-void hax_raise_event(CPUState *cpu);
-void hax_reset_vcpu_state(void *opaque);
-#include "target/i386/hax-interface.h"
-#include "target/i386/hax-i386.h"
-
 #else /* CONFIG_HAX */
 
 #define hax_enabled() (0)
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index fd1ab673d7..fecfe8cd6e 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -28,7 +28,6 @@
 #include "exec/address-spaces.h"
 
 #include "qemu-common.h"
-#include "hax-i386.h"
 #include "sysemu/accel.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
diff --git a/target/i386/hax-cpus.c b/target/i386/hax-cpus.c
index 9aad98bc7a..99770e590c 100644
--- a/target/i386/hax-cpus.c
+++ b/target/i386/hax-cpus.c
@@ -22,7 +22,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "hax-i386.h"
 #include "sysemu/runstate.h"
 #include "sysemu/cpus.h"
 #include "qemu/guest-random.h"
diff --git a/target/i386/hax-cpus.h b/target/i386/hax-cpus.h
index a64417fe2d..ee8ab7a631 100644
--- a/target/i386/hax-cpus.h
+++ b/target/i386/hax-cpus.h
@@ -14,4 +14,20 @@
 
 extern const CpusAccel hax_cpus;
 
+#include "hax-interface.h"
+#include "hax-i386.h"
+
+int hax_init_vcpu(CPUState *cpu);
+int hax_smp_cpu_exec(CPUState *cpu);
+int hax_populate_ram(uint64_t va, uint64_t size);
+
+void hax_cpu_synchronize_state(CPUState *cpu);
+void hax_cpu_synchronize_post_reset(CPUState *cpu);
+void hax_cpu_synchronize_post_init(CPUState *cpu);
+void hax_cpu_synchronize_pre_loadvm(CPUState *cpu);
+
+int hax_vcpu_destroy(CPUState *cpu);
+void hax_raise_event(CPUState *cpu);
+void hax_reset_vcpu_state(void *opaque);
+
 #endif /* HAX_CPUS_H */
diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index 6bb5a24917..71e637cf16 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -13,7 +13,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 
-#include "target/i386/hax-i386.h"
+#include "hax-cpus.h"
 #include "qemu/queue.h"
 
 #define DEBUG_HAX_MEM 0
diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index 6fb7867d11..735a749d4b 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -14,9 +14,8 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
-#include "target/i386/hax-i386.h"
-
 #include "sysemu/cpus.h"
+#include "hax-cpus.h"
 
 hax_fd hax_mod_open(void)
 {
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index 469b48e608..6c82dfb54f 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hax-i386.h"
+#include "hax-cpus.h"
 
 /*
  * return 0 when success, -1 when driver not loaded,
diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
index 12cbd813dc..a5ce12d663 100644
--- a/target/i386/hax-windows.h
+++ b/target/i386/hax-windows.h
@@ -23,6 +23,8 @@
 #include <winioctl.h>
 #include <windef.h>
 
+#include "hax-cpus.h"
+
 #define HAX_INVALID_FD INVALID_HANDLE_VALUE
 
 static inline void hax_mod_close(struct hax_state *hax)
-- 
2.26.2



