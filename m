Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E3BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F99121582
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpvG60qV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F99121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUc6-0000B6-Gg
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCW-00043D-Ar
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57918
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCU-0003Bv-7m
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZKxFGBfi7ktBiQQWEIVD7IKAvRu3iTLqw1HKoGGDWo=;
 b=BpvG60qVPncj6/wFUtZ06Uf+utumq790+horb2m2viWOyau3An0ui0oYuvEBza2dsbBVXO
 wt6ATFtL4vlG6Ex09DLqefco+3e1GkLQNInMMZfFeXDniOlwbWMdWFjMbICUwcaJHlzSpW
 9pcuOcpeLffYhyfBGVHJ3SgvKTp7wOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-Xb39vgnuPLe2eNWaWPe_Og-1; Mon, 06 Jul 2020 12:42:35 -0400
X-MC-Unique: Xb39vgnuPLe2eNWaWPe_Og-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B51A08015CB
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 16:42:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 691E3100238C;
 Mon,  6 Jul 2020 16:42:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/53] target/i386/kvm: Simplify
 kvm_get_supported_[feature]_msrs()
Date: Mon,  6 Jul 2020 12:41:52 -0400
Message-Id: <20200706164155.24696-51-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

As the MSR supported features should be the same for all
VMs, it is safe to directly use the global kvm_state.
Remove the unnecessary KVMState* argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200623105052.1700-8-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index cfb6bc15aa..a19a1e6769 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1919,7 +1919,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
     }
 }
 
-static int kvm_get_supported_feature_msrs(KVMState *s)
+static int kvm_get_supported_feature_msrs(void)
 {
     int ret = 0;
 
@@ -1934,7 +1934,7 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
     struct kvm_msr_list msr_list;
 
     msr_list.nmsrs = 0;
-    ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, &msr_list);
+    ret = kvm_ioctl(kvm_state, KVM_GET_MSR_FEATURE_INDEX_LIST, &msr_list);
     if (ret < 0 && ret != -E2BIG) {
         error_report("Fetch KVM feature MSR list failed: %s",
             strerror(-ret));
@@ -1947,7 +1947,8 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
                  msr_list.nmsrs * sizeof(msr_list.indices[0]));
 
     kvm_feature_msrs->nmsrs = msr_list.nmsrs;
-    ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, kvm_feature_msrs);
+    ret = kvm_ioctl(kvm_state, KVM_GET_MSR_FEATURE_INDEX_LIST,
+                    kvm_feature_msrs);
 
     if (ret < 0) {
         error_report("Fetch KVM feature MSR list failed: %s",
@@ -1960,7 +1961,7 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
     return 0;
 }
 
-static int kvm_get_supported_msrs(KVMState *s)
+static int kvm_get_supported_msrs(void)
 {
     int ret = 0;
     struct kvm_msr_list msr_list, *kvm_msr_list;
@@ -1970,7 +1971,7 @@ static int kvm_get_supported_msrs(KVMState *s)
      *  save/restore.
      */
     msr_list.nmsrs = 0;
-    ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, &msr_list);
+    ret = kvm_ioctl(kvm_state, KVM_GET_MSR_INDEX_LIST, &msr_list);
     if (ret < 0 && ret != -E2BIG) {
         return ret;
     }
@@ -1983,7 +1984,7 @@ static int kvm_get_supported_msrs(KVMState *s)
                                           sizeof(msr_list.indices[0])));
 
     kvm_msr_list->nmsrs = msr_list.nmsrs;
-    ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, kvm_msr_list);
+    ret = kvm_ioctl(kvm_state, KVM_GET_MSR_INDEX_LIST, kvm_msr_list);
     if (ret >= 0) {
         int i;
 
@@ -2139,12 +2140,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    ret = kvm_get_supported_msrs(s);
+    ret = kvm_get_supported_msrs();
     if (ret < 0) {
         return ret;
     }
 
-    kvm_get_supported_feature_msrs(s);
+    kvm_get_supported_feature_msrs();
 
     uname(&utsname);
     lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
-- 
2.26.2



