Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFF9C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054032173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfA4h5x4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054032173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFwe-0002wy-Jm
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <catherine.hecx@gmail.com>) id 1idEmR-0001sA-Ua
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <catherine.hecx@gmail.com>) id 1idEmF-00037b-Qh
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:40:19 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
 id 1idEmF-00035N-4m
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:40:15 -0500
Received: by mail-qk1-x743.google.com with SMTP id t129so1633944qke.10
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=poU4coC1wpEnGRHnApg5z8cKyUslXoAMtkEQeEix3YE=;
 b=OfA4h5x466F13+EJ6RAM3rEK2XQXeqRQWVoYD9x7iKGEqTUVkJVKX2xdBb0uK7Wiy8
 +K3lV6Ttr9mWyHEWzqLfsOXpVaoyIgO0Z7sucDUc5ml8tWFEQx/VSTgDfzKC/7ts+9tw
 Uo0K8cEOVQCNU+30QTyVLUHJ2glanPx6QqbpFY+xVb6A3XF0oMul+CpcqSe8Z35w2dZo
 ewoSVe3v+Tq8NBBaubsauIIlFA/zUxnBp8Pw/r37SJwO+aI5dxmsVQ7EzGHFv/9Bo/ks
 M4iMFTRX1g39U7AWBmfcXeI9aiBakRBcEVi2x8Bs2FWOfBsJCaLVK7xPUmK3LcBKuPUg
 94Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=poU4coC1wpEnGRHnApg5z8cKyUslXoAMtkEQeEix3YE=;
 b=ovqfMxZJ6yHbzgMjk1LdMNSr2HnY/r0QehRs2x3DlSGMzjgzDSpZ74gzMxTg40RRWF
 otqySnhmKCq4wUHjUufhCWEtMoA1UF40Zb24+ryCDlXiIFvXu8jykV7rQh1rDcyAOb+B
 7NW2xrtzpOzoeZKgQ+XDu4rAzioZO2+9RkS1kQxzeAYAac92FOoBSvXoZCb4WT0f40i/
 Htiw1AQU2vBVXpx42Xlhtr0shq67a9bWEE9208cUjO+xTXFE5wkkPHH8K873gfgde3xp
 JTRGyRSPOJSLryxIfnZuSoE8A5Q4Ki0OThVRQXZ/iDNLudvleLGSgwWskb/J0a4lhAX1
 tH9Q==
X-Gm-Message-State: APjAAAVol5+FdWIdSjCfeK6lr/0qveSkOZYw0ifdQUB2gAXrgobLb8HO
 8AldXbUtrGjfNz/ifZpUHAe/H7uNaLw=
X-Google-Smtp-Source: APXvYqyHAGUvqCWHS5evYFAogikSLDtFd1xrmclCYnoYpwWw+dIWtypuzUWGf2XoUfxoQEICD0mGNQ==
X-Received: by 2002:a37:a257:: with SMTP id l84mr13084095qke.22.1575627933529; 
 Fri, 06 Dec 2019 02:25:33 -0800 (PST)
Received: from host.localdomain (104.129.187.94.16clouds.com. [104.129.187.94])
 by smtp.gmail.com with ESMTPSA id o7sm2117654qkd.119.2019.12.06.02.25.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Dec 2019 02:25:32 -0800 (PST)
From: Catherine Ho <catherine.hecx@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] target/i386: skip kvm_msr_entry_add when kvm_vmx_basic is 0
Date: Fri,  6 Dec 2019 05:23:37 -0500
Message-Id: <1575627817-24625-1-git-send-email-catherine.hecx@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <3a1c97b2-789f-dd21-59ba-f780cf3bad92@redhat.com>
References: <3a1c97b2-789f-dd21-59ba-f780cf3bad92@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Catherine Ho <catherine.hecx@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 1389309c811b ("KVM: nVMX: expose VMX capabilities for nested
hypervisors to userspace") expands the msr_based_features with
MSR_IA32_VMX_BASIC and others. Then together with an old kernel before
1389309c811b, the qemu call KVM_GET_MSR_FEATURE_INDEX_LIST and got the
smaller kvm_feature_msrs. Then in kvm_arch_get_supported_msr_feature(),
searching VMX_BASIC will be failed and return 0. At last kvm_vmx_basic
will be assigned to 0.

Without this patch, it will cause a qemu crash (host kernel 4.15
ubuntu 18.04+qemu 4.1):
qemu-system-x86_64: error: failed to set MSR 0x480 to 0x0
target/i386/kvm.c:2932: kvm_put_msrs: Assertion `ret ==
cpu->kvm_msr_buf->nmsrs' failed.

This fixes it by skipping kvm_msr_entry_add when kvm_vmx_basic is 0

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
---
 target/i386/kvm.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index a8c44bf..8cf84a2 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2632,8 +2632,13 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
                                          f[FEAT_VMX_SECONDARY_CTLS]));
     kvm_msr_entry_add(cpu, MSR_IA32_VMX_EPT_VPID_CAP,
                       f[FEAT_VMX_EPT_VPID_CAPS] | fixed_vmx_ept_vpid);
-    kvm_msr_entry_add(cpu, MSR_IA32_VMX_BASIC,
+
+    if (kvm_vmx_basic) {
+	/* Only add the entry when host supports it */
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_BASIC,
                       f[FEAT_VMX_BASIC] | fixed_vmx_basic);
+    }
+
     kvm_msr_entry_add(cpu, MSR_IA32_VMX_MISC,
                       f[FEAT_VMX_MISC] | fixed_vmx_misc);
     if (has_msr_vmx_vmfunc) {
-- 
1.7.1


