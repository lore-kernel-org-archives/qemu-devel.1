Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99940C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF1B20661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VizeC4qQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF1B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Zlt-00019D-M8
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1Zkh-0000Vn-OQ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1Zkg-00013Y-KK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:55:15 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1Zkg-00011G-Dq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:55:14 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so4734650wma.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2i4yZbAT6VIHVdjq0v1VKjxBoqIFHH8QmiF0k9spAdY=;
 b=VizeC4qQBeRZHBPDNY7O/8CSOvd8TR+Y1q/eVnvHJTr3rft0b4GcperQA9N+ZUvLHK
 uH7OBg23+zzqYMhfKfr7vP7xpsOPBNB8Sk2vgmATKJMNpomX8ACs+eFbArrLGPngaGjj
 h3rbgKQP+s/cXKxwck8x57iQuq6pqnoh1hzoDXuZshfmrfHb5Y4Gn+20D9QxF3mVsl38
 2xbAAr3DQUOB//EdlK+Ol7euG50BHt7PDSyIbCkvyw4eIWvz4j8IGKP00ejGsZ1KU2HX
 je/xPN1AVpPynf/XSMbt/acQ4J2eiZXvJDHjYN473p0NgfNzE0Cqm8Yyzh6EM6tvinf9
 x+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=2i4yZbAT6VIHVdjq0v1VKjxBoqIFHH8QmiF0k9spAdY=;
 b=fYL+dWd4O5xKNYsoVGi76n7Qyj8NpjD6kPriLgazBd9nylN8Dubfya5L4SDny5yrOT
 YenyB0J5cS9hvtVv232Szipxz5L/d6194l+va2/E7A1M90hBX+DTk0llISeDOgeJpeV4
 cZ0+weUJUqsRPmABS7kCPOgvXUJE7xYZF7TwAoelt213gtrz2Q3Bt6D6Q1OQyLQkeFXy
 jaPJUsWw47+2aNmQEcwqEQnY7Dip1brw5rKsLSX3KphofejhUk73HwTkXlv5mYjn8VvV
 q5mVMQujqPGOpU2cw2cv2hkQl4LBt7CJoC2t+2ipEhGSApr5kpnSE1CzEOjiqV2Amd8v
 2BSg==
X-Gm-Message-State: APjAAAUVl5SePFPWDqpMKIvus5E1Xs+QpBH17lnSnCUDsEKkGfriaRNW
 n9C8mNlEEDtvCzayb47O/PbLCd7w
X-Google-Smtp-Source: APXvYqy24FyXpvf1hjCiopE688m9G/nlMjwgl1bi2VFyEfQlDDb6OcXPKS8kUFOFSBznUVRyq+bPbg==
X-Received: by 2002:a1c:6a15:: with SMTP id f21mr6638585wmc.126.1581443711831; 
 Tue, 11 Feb 2020 09:55:11 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:652c:29a6:517b:66d9])
 by smtp.gmail.com with ESMTPSA id a62sm4816828wmh.33.2020.02.11.09.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:55:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: check for availability of MSR_IA32_UCODE_REV as
 an emulated MSR
Date: Tue, 11 Feb 2020 18:55:16 +0100
Message-Id: <20200211175516.10716-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


