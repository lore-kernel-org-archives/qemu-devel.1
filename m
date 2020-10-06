Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9BBC46466
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E929720760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7hXGuA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E929720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhi5-0002Kr-U8
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQA-0002d2-Ek
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:56152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ8-0001PN-H0
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id d4so1807682wmd.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YbI7t/qKpjjw8V58GUWV3d2iHhPFnbKHoCO06ALduuQ=;
 b=N7hXGuA940xm54rW47mYdGEhKzX6eHcyRTIokni4TOO0zin/A/2RinvTq3Gh+kS+ny
 Wticr+qJJ/6sset8Xd1ZL3Z4ZDuv8FRXT9X/Mhz9LU4GpDDEbTA8TglL9eN0Wln9KJlL
 /RiIS4G6GhSUcWGPBM+3dU7Bw+jCWoDX66vg63YAPCjD+QxxstGFAWWitVTdHG6IxmS/
 0k0VWqV0cV8RHq0ME6PH2Yf3dSbk92C3eMfTet1ES5MwqacasReqU/xK9HgV5jsH8pd4
 68U/tBEokCoJGGN9/t3wWarNU8Tjc+LdFvZEkZxHgbYPwzH7aWmfrwIMMkNihowlRZnL
 +gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YbI7t/qKpjjw8V58GUWV3d2iHhPFnbKHoCO06ALduuQ=;
 b=AdPowQfxi2a6aHpdjEHpS8oCKFunYDLAIm6auR2cmBzZq/qKGme3zoBTBp+uN3BV5n
 o5BXdZfBqm509JdGZbODz4w4DYTiziFXFxcp5HP4Sc7cFi1UOYT8C5VNSmpLdeTawUT6
 pU2xBQQQKyF2cWYz7531SaSvfRM3vzL6bJFOtY8zeWIXcSapD7FXFA7R2QziBZsXCu5J
 esCwvgksd/dv5vyrP059wVSRy4m4sgxKAEeNb8Npv1OAVNfi805D8RikzEopKrwrCzBN
 a+gVLiTdeTCk7xdzVRhKYGVUGcjJDiLsSAKm/XthZHGAnme8J9neIhGUcsFMkLr4GHN3
 nkXQ==
X-Gm-Message-State: AOAM530FVMVftwLVzm6dwk5W2/WjmAsPhcoCE0/AmkBGsWh6FhsPZUpr
 v0J/cYw6E587Z5vE0oRP0RZuz7kt6GY=
X-Google-Smtp-Source: ABdhPJzX0v3pzdRVJN0K1DR7Curs+00XAplo8N4ixFqPGiJwGs/piohMtwmt+nKOyeFnwKDLTjPi6w==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr3440758wmc.91.1601969398910; 
 Tue, 06 Oct 2020 00:29:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/37] whpx: remove whpx specific functions from global includes
Date: Tue,  6 Oct 2020 09:29:24 +0200
Message-Id: <20201006072947.487729-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32b.google.com
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
 accel/stubs/meson.build |  1 -
 accel/stubs/whpx-stub.c | 47 -----------------------------------------
 include/sysemu/whpx.h   | 19 -----------------
 target/i386/whpx-cpus.h | 17 +++++++++++++++
 4 files changed, 17 insertions(+), 67 deletions(-)
 delete mode 100644 accel/stubs/whpx-stub.c

diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 3fbe34e5bb..12dd1539af 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -2,4 +2,3 @@ specific_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
 specific_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 specific_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 specific_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
-specific_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
deleted file mode 100644
index 1efb89f25e..0000000000
--- a/accel/stubs/whpx-stub.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * QEMU Windows Hypervisor Platform accelerator (WHPX) stub
- *
- * Copyright Microsoft Corp. 2017
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "sysemu/whpx.h"
-
-int whpx_init_vcpu(CPUState *cpu)
-{
-    return -1;
-}
-
-int whpx_vcpu_exec(CPUState *cpu)
-{
-    return -1;
-}
-
-void whpx_destroy_vcpu(CPUState *cpu)
-{
-}
-
-void whpx_vcpu_kick(CPUState *cpu)
-{
-}
-
-void whpx_cpu_synchronize_state(CPUState *cpu)
-{
-}
-
-void whpx_cpu_synchronize_post_reset(CPUState *cpu)
-{
-}
-
-void whpx_cpu_synchronize_post_init(CPUState *cpu)
-{
-}
-
-void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
-{
-}
diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
index a84b49e749..59edf13742 100644
--- a/include/sysemu/whpx.h
+++ b/include/sysemu/whpx.h
@@ -13,18 +13,6 @@
 #ifndef QEMU_WHPX_H
 #define QEMU_WHPX_H
 
-
-int whpx_init_vcpu(CPUState *cpu);
-int whpx_vcpu_exec(CPUState *cpu);
-void whpx_destroy_vcpu(CPUState *cpu);
-void whpx_vcpu_kick(CPUState *cpu);
-
-
-void whpx_cpu_synchronize_state(CPUState *cpu);
-void whpx_cpu_synchronize_post_reset(CPUState *cpu);
-void whpx_cpu_synchronize_post_init(CPUState *cpu);
-void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
-
 #ifdef CONFIG_WHPX
 
 int whpx_enabled(void);
@@ -35,11 +23,4 @@ int whpx_enabled(void);
 
 #endif /* CONFIG_WHPX */
 
-/* state subset only touched by the VCPU itself during runtime */
-#define WHPX_SET_RUNTIME_STATE   1
-/* state subset modified during VCPU reset */
-#define WHPX_SET_RESET_STATE     2
-/* full state set, modified during initialization or on vmload */
-#define WHPX_SET_FULL_STATE      3
-
 #endif /* QEMU_WHPX_H */
diff --git a/target/i386/whpx-cpus.h b/target/i386/whpx-cpus.h
index 2393944954..bdb367d1d0 100644
--- a/target/i386/whpx-cpus.h
+++ b/target/i386/whpx-cpus.h
@@ -14,4 +14,21 @@
 
 extern const CpusAccel whpx_cpus;
 
+int whpx_init_vcpu(CPUState *cpu);
+int whpx_vcpu_exec(CPUState *cpu);
+void whpx_destroy_vcpu(CPUState *cpu);
+void whpx_vcpu_kick(CPUState *cpu);
+
+void whpx_cpu_synchronize_state(CPUState *cpu);
+void whpx_cpu_synchronize_post_reset(CPUState *cpu);
+void whpx_cpu_synchronize_post_init(CPUState *cpu);
+void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
+
+/* state subset only touched by the VCPU itself during runtime */
+#define WHPX_SET_RUNTIME_STATE   1
+/* state subset modified during VCPU reset */
+#define WHPX_SET_RESET_STATE     2
+/* full state set, modified during initialization or on vmload */
+#define WHPX_SET_FULL_STATE      3
+
 #endif /* WHPX_CPUS_H */
-- 
2.26.2



