Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D435C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390FC20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2N/q/wZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390FC20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngc4-0007yq-I3
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWk-0006Vg-58
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWi-0007eT-5I
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592909498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVjwKVhnoJ/NkeP5BdSwAibBor9Meggq390h5glu26Q=;
 b=M2N/q/wZWCsbXrbMyFFDz2nGxP4jntEOn/uNzDD0ziDT1MCUIR5FcCdowwQqKrJ09fDCHs
 2FoY9DfvsFEHj7YFt4D0C/O3I95vv2PKGeAkzNHdEp7G3CZVYjjGRCEaXlA82lU2RKVByO
 2YViMROPB6+0vqKEGwqqMWg7y8EiHQs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-ElwkCYZBP7ub7ibvuL6dPw-1; Tue, 23 Jun 2020 06:51:37 -0400
X-MC-Unique: ElwkCYZBP7ub7ibvuL6dPw-1
Received: by mail-wr1-f69.google.com with SMTP id i14so3909405wru.17
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LVjwKVhnoJ/NkeP5BdSwAibBor9Meggq390h5glu26Q=;
 b=LpW9lVIvkBpj/KoOtbzC4hh1d77JCsn/j2N9YN3N4F2lAO8E3I+MqeYrNU4jBkqG+i
 w+b2jG9gm3NrIh9FNxx+Q+WZcHvhfJnRazo042FZ35Df1SeoPypCgvbQMQy8DnidxIKE
 9Q7uDrMlksMrVeTVXG3eBGC+rwYwZUlkMRsL7Fus2ukvKiATCKz7rVTEpg3Qp9twbqNT
 DH4USd6F1YPH7SOroUoICWPNxBCimmgCElWpTTCvshPt8+DJF+yGBUXs3cA0L+5vmV3G
 +tC0dDYWJyI/uq9kXajylAfAoyNX36gnP+31l8l9WQnXkxdnzUpftQZr7mdTnN+khE35
 7Tpg==
X-Gm-Message-State: AOAM533l/CFP0EZfeYvwPWxKuMaxwA/WtdDy0m7BjfJVsH9U7MxYt0Qm
 rITeBnZtLqS1sykGJX8HVTID/X1/KTsYMMHjVBxvtFdjvKUF5YyMj4PBTEVakZ572reFiaU2a7z
 zJgk6YHkwJGr2rLI=
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr24504264wmh.78.1592909495620; 
 Tue, 23 Jun 2020 03:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+lUmsOxGGyNhicD4Qre6EUQ9uDD12JC437h5LIw7lhq7cKVmWoabmNrYpUWBP1jZa8ZjEtQ==
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr24504225wmh.78.1592909495383; 
 Tue, 23 Jun 2020 03:51:35 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id b201sm3199953wmb.36.2020.06.23.03.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 03:51:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 7/7] target/i386/kvm: Simplify
 kvm_get_supported_[feature]_msrs()
Date: Tue, 23 Jun 2020 12:50:52 +0200
Message-Id: <20200623105052.1700-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623105052.1700-1-philmd@redhat.com>
References: <20200623105052.1700-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the MSR supported features should be the same for all
VMs, it is safe to directly use the global kvm_state.
Remove the unnecessary KVMState* argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/i386/kvm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 626cb04d88..988ed3c238 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1887,7 +1887,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
     }
 }
 
-static int kvm_get_supported_feature_msrs(KVMState *s)
+static int kvm_get_supported_feature_msrs(void)
 {
     int ret = 0;
 
@@ -1902,7 +1902,7 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
     struct kvm_msr_list msr_list;
 
     msr_list.nmsrs = 0;
-    ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, &msr_list);
+    ret = kvm_ioctl(kvm_state, KVM_GET_MSR_FEATURE_INDEX_LIST, &msr_list);
     if (ret < 0 && ret != -E2BIG) {
         error_report("Fetch KVM feature MSR list failed: %s",
             strerror(-ret));
@@ -1915,7 +1915,8 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
                  msr_list.nmsrs * sizeof(msr_list.indices[0]));
 
     kvm_feature_msrs->nmsrs = msr_list.nmsrs;
-    ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, kvm_feature_msrs);
+    ret = kvm_ioctl(kvm_state, KVM_GET_MSR_FEATURE_INDEX_LIST,
+                    kvm_feature_msrs);
 
     if (ret < 0) {
         error_report("Fetch KVM feature MSR list failed: %s",
@@ -1928,7 +1929,7 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
     return 0;
 }
 
-static int kvm_get_supported_msrs(KVMState *s)
+static int kvm_get_supported_msrs(void)
 {
     int ret = 0;
     struct kvm_msr_list msr_list, *kvm_msr_list;
@@ -1938,7 +1939,7 @@ static int kvm_get_supported_msrs(KVMState *s)
      *  save/restore.
      */
     msr_list.nmsrs = 0;
-    ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, &msr_list);
+    ret = kvm_ioctl(kvm_state, KVM_GET_MSR_INDEX_LIST, &msr_list);
     if (ret < 0 && ret != -E2BIG) {
         return ret;
     }
@@ -1951,7 +1952,7 @@ static int kvm_get_supported_msrs(KVMState *s)
                                           sizeof(msr_list.indices[0])));
 
     kvm_msr_list->nmsrs = msr_list.nmsrs;
-    ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, kvm_msr_list);
+    ret = kvm_ioctl(kvm_state, KVM_GET_MSR_INDEX_LIST, kvm_msr_list);
     if (ret >= 0) {
         int i;
 
@@ -2107,12 +2108,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
2.21.3


