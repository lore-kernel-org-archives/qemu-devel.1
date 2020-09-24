Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0639FC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1C023600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TivnqBiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1C023600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOJ8-0003am-HF
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUy-0003OQ-4b
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUm-0006FB-4n
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvWsDQRvOIEcysZ3nwL++baQRnEt5hvqcP2jWVNSRd8=;
 b=TivnqBiEyRyZ3GipHzdVOSwtDruNNGJHFtZbg0exBTHifVMownl94+5rfW90rRIeyOVnPs
 NUo1A1TfMXjzfRRbDzF36FykbQXH7A040DSHGY9XejYsLg+AMnPo5TbZOWbfrHCxm638zS
 t19WITvFdxHqYFGkTnRhJu6wlhWGlHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-SL3FMOtiMiGDW7vSVVWGAQ-1; Thu, 24 Sep 2020 05:24:50 -0400
X-MC-Unique: SL3FMOtiMiGDW7vSVVWGAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 677FD8799F0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19F3255764;
 Thu, 24 Sep 2020 09:24:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 82/92] target/i386: Fix VM migration when interrupt based APF
 is enabled
Date: Thu, 24 Sep 2020 05:23:04 -0400
Message-Id: <20200924092314.1722645-83-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

VM with  interrupt based APF enabled fails to migrate:
qemu-system-x86_64: error: failed to set MSR 0x4b564d02 to 0xf3

We have two issues:
1) There is a typo in kvm_put_msrs() and we write async_pf_int_msr
to MSR_KVM_ASYNC_PF_EN (instead of MSR_KVM_ASYNC_PF_INT)

2) We restore MSR_KVM_ASYNC_PF_EN before MSR_KVM_ASYNC_PF_INT is set
and this violates the check in KVM.

Re-order MSR_KVM_ASYNC_PF_EN/MSR_KVM_ASYNC_PF_INT setting (and
kvm_get_msrs() for consistency) and fix the typo.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20200917102316.814804-1-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 06c2025c67..b327e8706f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2819,12 +2819,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
         kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
         kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
+        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
+            kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, env->async_pf_int_msr);
+        }
         if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
             kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_en_msr);
         }
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
-            kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_int_msr);
-        }
         if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
             kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, env->pv_eoi_en_msr);
         }
@@ -3207,12 +3207,12 @@ static int kvm_get_msrs(X86CPU *cpu)
 #endif
     kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
     kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
-        kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, 0);
-    }
     if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
         kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
     }
+    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
+        kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, 0);
+    }
     if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
         kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, 0);
     }
-- 
2.26.2



