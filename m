Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82382C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAE3221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DknfTQrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAE3221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLO5t-0006Xb-2r
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUv-0003Nh-4S
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUm-0006HW-Bv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUhoTZ0x3F+69mKQh+X9V4uzzg/R6UFDfUeQRh/ugYg=;
 b=DknfTQrnJQTKsZ0uaHb/Gy0fPAWCMmuR1uCTlV/t+puVVKa9QTJO+ZD1g1nCvDZHUKQeak
 nM0m4p4PNy9bYn0TE6y+00CsCYTAXvaMwAzmD3NRI6sSV48CCZ75A4WvZsFK7jXvFtqxNK
 4ktZ4+oxaAAj2gQ5jbImhEtnQAOETQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-YknI5lcXPn6Z87h938HYaQ-1; Thu, 24 Sep 2020 05:24:52 -0400
X-MC-Unique: YknI5lcXPn6Z87h938HYaQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 225DB81F00F
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBD6B55764
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 85/92] target/i386: kvm: do not use kvm_check_extension to find
 paravirtual capabilities
Date: Thu, 24 Sep 2020 05:23:07 -0400
Message-Id: <20200924092314.1722645-86-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paravirtualized features have been listed in KVM_GET_SUPPORTED_CPUID since
Linux 2.6.35 (commit 84478c829d0f, "KVM: x86: export paravirtual cpuid flags
in KVM_GET_SUPPORTED_CPUID", 2010-05-19).  It has been more than 10 years,
so remove the fallback code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 4fc6e8b9d5..f6dae4cfb6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -284,30 +284,6 @@ static struct kvm_cpuid2 *get_supported_cpuid(KVMState *s)
     return cpuid;
 }
 
-static const struct kvm_para_features {
-    int cap;
-    int feature;
-} para_features[] = {
-    { KVM_CAP_CLOCKSOURCE, KVM_FEATURE_CLOCKSOURCE },
-    { KVM_CAP_NOP_IO_DELAY, KVM_FEATURE_NOP_IO_DELAY },
-    { KVM_CAP_PV_MMU, KVM_FEATURE_MMU_OP },
-    { KVM_CAP_ASYNC_PF, KVM_FEATURE_ASYNC_PF },
-    { KVM_CAP_ASYNC_PF_INT, KVM_FEATURE_ASYNC_PF_INT },
-};
-
-static int get_para_features(KVMState *s)
-{
-    int i, features = 0;
-
-    for (i = 0; i < ARRAY_SIZE(para_features); i++) {
-        if (kvm_check_extension(s, para_features[i].cap)) {
-            features |= (1 << para_features[i].feature);
-        }
-    }
-
-    return features;
-}
-
 static bool host_tsx_broken(void)
 {
     int family, model, stepping;\
@@ -367,13 +343,11 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     struct kvm_cpuid2 *cpuid;
     uint32_t ret = 0;
     uint32_t cpuid_1_edx;
-    bool found = false;
 
     cpuid = get_supported_cpuid(s);
 
     struct kvm_cpuid_entry2 *entry = cpuid_find_entry(cpuid, function, index);
     if (entry) {
-        found = true;
         ret = cpuid_entry_get_reg(entry, reg);
     }
 
@@ -448,12 +422,6 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         }
     } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
         ret |= 1U << KVM_HINTS_REALTIME;
-        found = 1;
-    }
-
-    /* fallback for older kernels */
-    if ((function == KVM_CPUID_FEATURES) && !found) {
-        ret = get_para_features(s);
     }
 
     return ret;
-- 
2.26.2



