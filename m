Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B118C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0342F2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2UGZqrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0342F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUZ2-0001ft-4V
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCV-00040H-6N
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCT-0003BV-Ac
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsBQaU0PpGCwJ+2uAqO97DmSC929z/+d1sx9EfzBG4M=;
 b=d2UGZqrZTyR9NC8pQ4U6mKPUBE6cRu4qjzCsm3BKtt3Zd1QDnyDBKimtimPXNcDdiKwl0D
 UJmyoCK17SLeEELwQ2hzkKn9j6xt5tyqatJF1W7HZGATyyR3OPyub/BvgCPascOuL21Puz
 g2f5tUV2LwQHwz01kbU2kFv4evhSCpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-1G3WuifrO9Ok_46VvXSAgw-1; Mon, 06 Jul 2020 12:42:34 -0400
X-MC-Unique: 1G3WuifrO9Ok_46VvXSAgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF43461
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 16:42:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A95CE5F7D8;
 Mon,  6 Jul 2020 16:42:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/53] target/i386/kvm: Simplify kvm_get_mce_cap_supported()
Date: Mon,  6 Jul 2020 12:41:51 -0400
Message-Id: <20200706164155.24696-50-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As the MCE supported capabilities should be the same for
all VMs, it is safe to directly use the global kvm_state.
Remove the unnecessary KVMState* argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200623105052.1700-7-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 14be9917f4..cfb6bc15aa 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -530,7 +530,7 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
     }
 }
 
-static int kvm_get_mce_cap_supported(KVMState *s, uint64_t *mce_cap,
+static int kvm_get_mce_cap_supported(uint64_t *mce_cap,
                                      int *max_banks)
 {
     int r;
@@ -538,7 +538,7 @@ static int kvm_get_mce_cap_supported(KVMState *s, uint64_t *mce_cap,
     r = kvm_check_extension(KVM_CAP_MCE);
     if (r > 0) {
         *max_banks = r;
-        return kvm_ioctl(s, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
+        return kvm_ioctl(kvm_state, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
     }
     return -ENOSYS;
 }
@@ -1737,7 +1737,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         int banks;
         int ret;
 
-        ret = kvm_get_mce_cap_supported(cs->kvm_state, &mcg_cap, &banks);
+        ret = kvm_get_mce_cap_supported(&mcg_cap, &banks);
         if (ret < 0) {
             fprintf(stderr, "kvm_get_mce_cap_supported: %s", strerror(-ret));
             return ret;
-- 
2.26.2



