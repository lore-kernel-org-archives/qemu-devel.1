Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB45C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780A720714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDUwGT8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780A720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1v7H-0008Qt-GV
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v57-0003Wv-F2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v56-0001np-Dk
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1v56-0001nA-7W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:44 -0500
Received: by mail-wm1-x32b.google.com with SMTP id p17so3298652wma.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=km9KJtTEdqE+REKT3Wda2LEqxI4SZkYCzOPSCu2gScg=;
 b=rDUwGT8f8rgrm6XX38PBo5572jgZvebxLekk3lKpX9mrdw1cAQaGjm+p5NyxLzY1ku
 T+RET/yaVlu2Uz59Yzs9n977ZfSkpg8ww/cxTSDjuwFzNsChrqiG9WSMz/0LaEx/8quw
 1jGzdmR+OyVOwJNt7nZ6IliowpEGmZz+Z2qAPA7aaTrTnVbF98LDs2FPpOhS7a7WcGH4
 iAZ7wQmyqOgsXCJX1N8XtsH7VS8UIuGi0yzaVY63njOt2RAw1b8E1t/dRRWwaF+Js8bG
 sO2Z4F5uqFjF/d0gzfncIu5ZGJI0vM6dAl0FJr1Q7uNbpPae3ReEiRMrbApmflqeiiZV
 MXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=km9KJtTEdqE+REKT3Wda2LEqxI4SZkYCzOPSCu2gScg=;
 b=iN20zXdvxHMZtvnhFe8A7oayqEKJ6/jGmjaaMIACSbSBrNQm4VkqydGuYFu/ro3rah
 7K8SoGLTL/GWX5DmcXq8xSicbrV/gRPXG9rre+7YXyntrU5SzcRTrgnLmZ/YJ/dUJnLZ
 NSbize8xkOBDI6oCiALtKYTI/RVv+AbeKBUNI+M3FNeDMG1kub75YMtVf7PNwv28kQgZ
 j+6qzUY1xGosWEOFE9U/InFBNe4tZcVQbq2rxGBaq8HB/PMyPrssojxmpc2Kq47/IXcV
 7Q3wmnXIo7trdWmesltJWtsgXmZYaAY+7XopIGNXNdKrYGukNKnwWBsfYvD8Tlwo3b/Q
 CGFg==
X-Gm-Message-State: APjAAAW4izybUIPU2I1JWn/sofAwq6Ii6HrJUaroFp5X/F8hYxA+9B9N
 JVe1Wgxm/a+F2/1d4POse/fM+GOI
X-Google-Smtp-Source: APXvYqxQwTW4aCkBGV3itmTgHXaBdqc2aEKrNRR29zsryCOSlw4fvNvyhyUjN1pYjOSU5RAMihj67Q==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr13752212wmh.18.1581525702376; 
 Wed, 12 Feb 2020 08:41:42 -0800 (PST)
Received: from donizetti.fritz.box ([151.30.86.140])
 by smtp.gmail.com with ESMTPSA id a16sm1195122wrt.30.2020.02.12.08.41.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:41:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] target/i386: fix TCG UCODE_REV access
Date: Wed, 12 Feb 2020 17:41:27 +0100
Message-Id: <20200212164129.6968-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200212164129.6968-1-pbonzini@redhat.com>
References: <20200212164129.6968-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This was a very interesting semantic conflict that caused git to move
the MSR_IA32_UCODE_REV read to helper_wrmsr.  Not a big deal, but
still should be fixed...

Fixes: 4e45aff398 ("target/i386: add a ucode-rev property", 2020-01-24)
Message-id: <20200206171022.9289-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/misc_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index aed16fe3f0..7d61221024 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -229,7 +229,6 @@ void helper_rdmsr(CPUX86State *env)
 #else
 void helper_wrmsr(CPUX86State *env)
 {
-    X86CPU *x86_cpu = env_archcpu(env);
     uint64_t val;
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
@@ -372,9 +371,6 @@ void helper_wrmsr(CPUX86State *env)
         env->msr_bndcfgs = val;
         cpu_sync_bndcs_hflags(env);
         break;
-     case MSR_IA32_UCODE_REV:
-        val = x86_cpu->ucode_rev;
-        break;
     default:
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
@@ -393,6 +389,7 @@ void helper_wrmsr(CPUX86State *env)
 
 void helper_rdmsr(CPUX86State *env)
 {
+    X86CPU *x86_cpu = env_archcpu(env);
     uint64_t val;
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
@@ -526,6 +523,9 @@ void helper_rdmsr(CPUX86State *env)
     case MSR_IA32_BNDCFGS:
         val = env->msr_bndcfgs;
         break;
+     case MSR_IA32_UCODE_REV:
+        val = x86_cpu->ucode_rev;
+        break;
     default:
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
-- 
2.21.0



