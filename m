Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A1AC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A0C20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do9JqFBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A0C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1v9c-00047E-Mw
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v58-0003a2-Hv
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v57-0001oi-Gq
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:46 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1v57-0001o0-Ae
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:45 -0500
Received: by mail-wm1-x342.google.com with SMTP id b17so3322428wmb.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3v35o9BfB+j3gudZ3LlZULM6oRAe5V+pWxwM58xyau8=;
 b=do9JqFBKX7zxOu4Ay6ioYUzyMUasZBY2ARIEs6apLWqTEK4rGLD08trPW5zj66w7wy
 9oq3Zd3ad11cRYYK20b93zSRUZfrAjoQwH9PVfeliaNgCqxr8PZ+o6ufnl9VyAh6KeHp
 JNbq6+IygjrrXwc58ggj3OI2Uft8KUwuhej4IhYGrgEnbP0xcZdmYy9ytUSWj3lI2D83
 sW1+9XnqntmBTwAxUw110MO35spBa541BHVuD1UstMhk97grTwvZvpnvSh7ErxWLx3qd
 i6AwpwZovsyrrtfqgKUxDBONKmSTvq1/IjIx/4Wukt/tq6NdPeERulEKQZgx2ZuKKvL/
 1TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3v35o9BfB+j3gudZ3LlZULM6oRAe5V+pWxwM58xyau8=;
 b=LZ7JMRRiVppblL9EXcYicU1BJbweLJMqxc18nhIqtgGVr28kAP/3dy4YHYNBnR45iT
 wYhI7Cn3g27FbrlrIKq1aAaoXWoxCurdSFE31IdxhP6V89/FCeIpecKET5KnKkOAwYQm
 40kGOjtawehU4JEtovv+RuaFwm0QJMt/HLv8PgMcoEUI0beKglroSd9hQRpMOSMX4oyy
 PtKoAvmnSJvxJOuLEhhgovnW4SflKI+Vu1dJGONPNrsxKKanOnCbTjCY8+QFZAe5sP9Y
 UcQZiulgzPUNfi21riVOzR8oXjc325cnGUhr/NVr9/YLt8PMSWGulzMRnyQAQ9HSjPGJ
 CEMA==
X-Gm-Message-State: APjAAAU4pAqKqp0P5Sv1RFhzyk0C8FQzxaPWCMRymd4tqsXZTW4cwDeZ
 Ba35y5oQHgqWcVlRKqGGEq/QvUdG
X-Google-Smtp-Source: APXvYqzANyiP4a6CSLDOVSplqGpyTQ3S2zWyc5Ezx48yQZutiGgXWA6f8Zf+9IsPdQUT3R7QFbBPAw==
X-Received: by 2002:a05:600c:2207:: with SMTP id
 z7mr13098782wml.167.1581525704105; 
 Wed, 12 Feb 2020 08:41:44 -0800 (PST)
Received: from donizetti.fritz.box ([151.30.86.140])
 by smtp.gmail.com with ESMTPSA id a16sm1195122wrt.30.2020.02.12.08.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:41:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] target/i386: check for availability of MSR_IA32_UCODE_REV
 as an emulated MSR
Date: Wed, 12 Feb 2020 17:41:28 +0100
Message-Id: <20200212164129.6968-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200212164129.6968-1-pbonzini@redhat.com>
References: <20200212164129.6968-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Even though MSR_IA32_UCODE_REV has been available long before Linux 5.6,
which added it to the emulated MSR list, a bug caused the microcode
version to revert to 0x100000000 on INIT.  As a result, processors other
than the bootstrap processor would not see the host microcode revision;
some Windows version complain loudly about this and crash with a
fairly explicit MICROCODE REVISION MISMATCH error.

[If running 5.6 prereleases, the kernel fix "KVM: x86: do not reset
 microcode version on INIT or RESET" should also be applied.]

Reported-by: Alex Williamson <alex.williamson@redhat.com>
Message-id: <20200211175516.10716-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6ef291d580..69eb43d796 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -105,6 +105,7 @@ static bool has_msr_smi_count;
 static bool has_msr_arch_capabs;
 static bool has_msr_core_capabs;
 static bool has_msr_vmx_vmfunc;
+static bool has_msr_ucode_rev;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -2056,6 +2057,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_VMX_VMFUNC:
                 has_msr_vmx_vmfunc = true;
                 break;
+            case MSR_IA32_UCODE_REV:
+                has_msr_ucode_rev = true;
+                break;
             }
         }
     }
@@ -2696,8 +2700,7 @@ static void kvm_init_msrs(X86CPU *cpu)
                           env->features[FEAT_CORE_CAPABILITY]);
     }
 
-    if (kvm_arch_get_supported_msr_feature(kvm_state,
-                                           MSR_IA32_UCODE_REV)) {
+    if (has_msr_ucode_rev) {
         kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
     }
 
-- 
2.21.0



