Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B2CC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3BD2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACatc0j1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3BD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGR3d-0003UK-Db
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvc-0007SU-6L
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvZ-0001xI-Ga
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iGQvZ-0001wo-9n
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id a6so6542802wma.5
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=Dzd4Mr7ZIdxJK23W1XqRBzN6e9anASFYpHHxSbZiu7I=;
 b=ACatc0j1FYuAcTaTIP7Ccau5wEDVSYh2NQx/E12DnMQdUCVquNVy7ujYIS9MTHJOIt
 JU+ZzhIjpvwbOFIQxOaXA99tYNTedI/Nw8vm3vk3vzEijjq8jH8dXlTzdd2rgrx3gMEA
 sZFnm9vQIK+zDyw/7Jz3g2l+Emubb+X2rwKtb5vQbxNRwEl+4bk8yzZHgdwwfJVWwWOI
 dGChAVww+0rZT8kLLhyiYznylmTqhh1moH/YNiZ9PlwY3l2pL7rFHldK5HSa7MTxvqz+
 Kiqo88m6It7FX+RQP6M/293pO49XjFc8BBqwlKPkGV9vVAm1aeUUJ6UHgmcowWHf++5S
 kckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=Dzd4Mr7ZIdxJK23W1XqRBzN6e9anASFYpHHxSbZiu7I=;
 b=OgVhfIOjznAW8qLjg1SwGJf9Sq+2n8b/TaMjN5dcfwILJ4zsORx0mOmEE6bkL35If1
 ZwdVFuDmV9lfJuG0VoVjKu/PcMSByBZQypfmryWE0KbECzUgMHsmBxLgLV5ldt+YS/JY
 51URet1UisV6dWHYQ/d8DmPBymckHpvHXcm4E/Gon6vdZSQh1IZe04POiCGRHgqj3bdc
 ncJmudElcvysuqPkXEV1P+LQYGcM50lRxaw3J7is17++1VTNXDFxVBFRs5/hOabQcGs2
 t1cA31qvk9eOUF/GCluYtLJ4/UHdW0rPWyqld241igYjdfotDAdzOyuw4nNvPDIWtQH9
 Y8FA==
X-Gm-Message-State: APjAAAXbLNQGgmOB/P08NZhOEKXBjIFN7ILYnQoWd68R/MR+5SVNRbQc
 pU3wG8/F2HqgFxs4ApRfgiNfEDbu
X-Google-Smtp-Source: APXvYqzqXwU4GTe/MrBoAyc3DixU96dJAZKd2S1MXxJJAZyTtSf7oMB3wrnniutk5SgnxnPQLa78/Q==
X-Received: by 2002:a1c:6841:: with SMTP id d62mr11950449wmc.48.1570208375936; 
 Fri, 04 Oct 2019 09:59:35 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u7sm7041270wrp.19.2019.10.04.09.59.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 09:59:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/29] target/i386: work around KVM_GET_MSRS bug for secondary
 execution controls
Date: Fri,  4 Oct 2019 18:59:22 +0200
Message-Id: <1570208363-11948-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
References: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some secondary controls are automatically enabled/disabled based on the CPUID
values that are set for the guest.  However, they are still available at a
global level and therefore should be present when KVM_GET_MSRS is sent to
/dev/kvm.

Unfortunately KVM forgot to include those, so fix that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 45f0a1f..be4bbfb 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -479,6 +479,23 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
     value = msr_data.entries[0].data;
     switch (index) {
     case MSR_IA32_VMX_PROCBASED_CTLS2:
+        /* KVM forgot to add these bits for some time, do this ourselves.  */
+        if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) & CPUID_XSAVE_XSAVES) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) & CPUID_EXT_RDRAND) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX_INVPCID) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX_RDSEED) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) & CPUID_EXT2_RDTSCP) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
+        }
+        /* fall through */
     case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
     case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
     case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
-- 
1.8.3.1



