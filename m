Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D94C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 03:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB3420773
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 03:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHFflM4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB3420773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKv3c-0003l1-KF
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 23:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKv31-0003Jy-PF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 23:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKv2z-0004Ln-L2
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 23:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600830140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bbtrO+37cFttzFZAyBMwpUbGiI9V5ZD2swnhvaKMJMk=;
 b=AHFflM4g4okpSo7zUcdjhtzqpzASdwm9WAfqYPLK2JdJaco3KJE7XLbcyhNeWszUzWR3lq
 QuPqp+FGcblCm75PterH7xQozjEyHYKunNVzpXNgnZMTd2h4uN9iYGWKsnC2xRj5YsJTJ8
 o4DsHw3pq8GAQVuhJF6zxNr85fcrEfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-4D1mg-fxPKSVm8Ge-BFTwQ-1; Tue, 22 Sep 2020 23:02:18 -0400
X-MC-Unique: 4D1mg-fxPKSVm8Ge-BFTwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 363C91008308
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:02:17 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAA9D5D9CC;
 Wed, 23 Sep 2020 03:02:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: kvm: do not use kvm_check_extension to find
 paravirtual capabilities
Date: Tue, 22 Sep 2020 23:02:16 -0400
Message-Id: <20200923030216.1527921-2-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: ehabkost@redhat.com
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
index 3996cf9764..ccc65ad0f5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -279,30 +279,6 @@ static struct kvm_cpuid2 *get_supported_cpuid(KVMState *s)
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
@@ -362,13 +338,11 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
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
 
@@ -443,12 +417,6 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
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


