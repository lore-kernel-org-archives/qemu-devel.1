Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7022CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D4B2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdi8J5G9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D4B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNf3I-00041j-GY
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj5-00085c-T7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj0-0007mh-MA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdj0-0007mK-FT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id w18so25704097wrt.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kzf1c4TzoS2R1SZRxcUgo2l6hUVF5Eo0UE969kM5Oa0=;
 b=Cdi8J5G9WR+ndYXf7tLlWejwFtV5vnf/Rr/CMx1lmiu1wk0LbSjBopudbufhFNvSZu
 CwMS/UTaAEoyJEAYewA6PdWbAejEEKBGPCKdzpcW1IjvF0pAwQi70HNwIKFdoBWmC7XN
 CxGuxJhP5+ni9LnBIG2ZctCYD8z90h7EH4VhPKLjYfwtImTqI+79Oiif0v4xbHbr1Pkz
 jAEM0HRMj/yI5MOQkkhht5BPkxzF/Yc7HM/sU4aaldng150RuM4Ix3JAWlOhklVYXhC8
 86VwYVf1J4QdwLHt+gLNGQ/hLmEGfcc4UEW14vqQhBIHNcj9IaMlW/U6wdCNHxfKHr4v
 40hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Kzf1c4TzoS2R1SZRxcUgo2l6hUVF5Eo0UE969kM5Oa0=;
 b=r5sbHEX7k7Jh3EPbwZIHFuYjp0yfDj+jgEBTzXA5c/2LdtNNcrIwpk+Qj+mAze0zoI
 TkK5Xfnd2JGiHB7RcWQlnpmbv8nbPggv/gF4Aa0pSeWDzX+AqSHUM2uZJZGudz0l2vLO
 +j/IhtPF9rE1Gf9pK8ckhC3D8bqxl3XoSq/Dds3VHsCvL6sE04I6CajM+wQOgq4Jtw/o
 47nN24IT0ZLboURHVvSbkCB+g/ZD9Wk36UJZZFeZv3lizHBz6PrX3GyddQcLvrY0aTjf
 U8SBW5YM2aEyowFkIdhlm1Xi1Zg1FNchRLHLj2W0DxJMZtZyKZOcBibAc8wqnZ6C8EFy
 Ltdg==
X-Gm-Message-State: APjAAAWY5xYJHTsCa1yBsW0vB8YRfd+TjSmf1Ok5bEGmSB8R/3rjmcAM
 pQGYKiFs/yQDJeVgprTPsR6PsP6J
X-Google-Smtp-Source: APXvYqwOPEWyxZCon/NCiEhGbJNTw9d6Hkezv6qcgkyZQTBlHdXrIvGsbi3b1XwO1HQ1rC6GjcNAeA==
X-Received: by 2002:a5d:674f:: with SMTP id l15mr4390717wrw.80.1571925864951; 
 Thu, 24 Oct 2019 07:04:24 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/39] x86/cpu: Add support for UMONITOR/UMWAIT/TPAUSE
Date: Thu, 24 Oct 2019 16:03:41 +0200
Message-Id: <1571925835-31930-26-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Tao Xu <tao3.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

UMONITOR, UMWAIT and TPAUSE are a set of user wait instructions.
This patch adds support for user wait instructions in KVM. Availability
of the user wait instructions is indicated by the presence of the CPUID
feature flag WAITPKG CPUID.0x07.0x0:ECX[5]. User wait instructions may
be executed at any privilege level, and use IA32_UMWAIT_CONTROL MSR to
set the maximum time.

The patch enable the umonitor, umwait and tpause features in KVM.
Because umwait and tpause can put a (psysical) CPU into a power saving
state, by default we dont't expose it to kvm and enable it only when
guest CPUID has it. And use QEMU command-line "-overcommit cpu-pm=on"
(enable_cpu_pm is enabled), a VM can use UMONITOR, UMWAIT and TPAUSE
instructions. If the instruction causes a delay, the amount of time
delayed is called here the physical delay. The physical delay is first
computed by determining the virtual delay (the time to delay relative to
the VMâ€™s timestamp counter). Otherwise, UMONITOR, UMWAIT and TPAUSE cause
an invalid-opcode exception(#UD).

The release document ref below link:
https://software.intel.com/sites/default/files/\
managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf

Co-developed-by: Jingqi Liu <jingqi.liu@intel.com>
Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20191011074103.30393-2-tao3.xu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 target/i386/kvm.c | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6c87c99..b635302 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1058,7 +1058,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            NULL /* ospke */, NULL, "avx512vbmi2", NULL,
+            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c50a9c7..112f867 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -731,6 +731,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_PKU               (1U << 3)
 /* OS Enable Protection Keys */
 #define CPUID_7_0_ECX_OSPKE             (1U << 4)
+/* UMONITOR/UMWAIT/TPAUSE Instructions */
+#define CPUID_7_0_ECX_WAITPKG           (1U << 5)
 /* Additional AVX-512 Vector Byte Manipulation Instruction */
 #define CPUID_7_0_ECX_AVX512_VBMI2      (1U << 6)
 /* Galois Field New Instructions */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 49a3011..94c2339 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -401,6 +401,12 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         if (host_tsx_blacklisted()) {
             ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
         }
+    } else if (function == 7 && index == 0 && reg == R_ECX) {
+        if (enable_cpu_pm) {
+            ret |= CPUID_7_0_ECX_WAITPKG;
+        } else {
+            ret &= ~CPUID_7_0_ECX_WAITPKG;
+        }
     } else if (function == 7 && index == 0 && reg == R_EDX) {
         /*
          * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
-- 
1.8.3.1



