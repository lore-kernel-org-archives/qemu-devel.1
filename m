Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D731C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4831420720
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrgkhIdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4831420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHxM-0000fG-IJ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqHvU-0007KQ-TM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:12:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26400
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqHvS-0006ez-HH
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593529917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uP0c6irLZ6kVnyOWAa7zHg/TP/Hw78U+sog6plFEIVI=;
 b=VrgkhIdzJ9zisVpVK9hX98keT7qiuuvCLCFf/GDR/xNKiAE5lGxZa+FXa/Jsb3RJVd7NI2
 Bv9iKl7WwApzQJyxExIugJIjGI15a2VCmDJmSOw3lhoOskolUFShfcklorpIF+bdp7ANBs
 /9gS02KBcLdp1iTQtTE/pGX4caokJ8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-rG4X1N2nPsGDflZhM7zf1g-1; Tue, 30 Jun 2020 11:11:52 -0400
X-MC-Unique: rG4X1N2nPsGDflZhM7zf1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E9E1EC1A0;
 Tue, 30 Jun 2020 15:11:51 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0C7A60C81;
 Tue, 30 Jun 2020 15:11:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] KVM: x86: believe what KVM says about WAITPKG
Date: Tue, 30 Jun 2020 11:11:50 -0400
Message-Id: <20200630151150.536580-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-stable@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, QEMU is overriding KVM_GET_SUPPORTED_CPUID's answer for
the WAITPKG bit depending on the "-overcommit cpu-pm" setting.  This is a
bad idea because it does not even check if the host supports it, but it
can be done in x86_cpu_realizefn just like we do for the MONITOR bit.

This patch moves it there, of course making it conditional on host
availability which is not being done for the MONITOR bit.  It also makes
MONITOR conditional, though not strictly necessary, so that the code
looks the same for both and generally more natural.

Cc: qemu-stable@nongnu.org
Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 5 ++++-
 target/i386/kvm.c | 6 ------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c44cc510e1..0de8dc569a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6535,7 +6535,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         if (enable_cpu_pm) {
             host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
                        &cpu->mwait.ecx, &cpu->mwait.edx);
-            env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
+            env->features[FEAT_1_ECX] |=
+                x86_cpu_get_supported_feature_word(FEAT_1_ECX, cpu->migratable) & CPUID_EXT_MONITOR;
+            env->features[FEAT_7_0_ECX] |=
+                x86_cpu_get_supported_feature_word(FEAT_7_0_ECX, cpu->migratable) & CPUID_7_0_ECX_WAITPKG;
         }
         if (kvm_enabled() && cpu->ucode_rev == 0) {
             cpu->ucode_rev = kvm_arch_get_supported_msr_feature(kvm_state,
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2b6b7443d2..c9ef27080d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -411,12 +411,6 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         if (host_tsx_blacklisted()) {
             ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
         }
-    } else if (function == 7 && index == 0 && reg == R_ECX) {
-        if (enable_cpu_pm) {
-            ret |= CPUID_7_0_ECX_WAITPKG;
-        } else {
-            ret &= ~CPUID_7_0_ECX_WAITPKG;
-        }
     } else if (function == 7 && index == 0 && reg == R_EDX) {
         /*
          * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
-- 
2.26.2


