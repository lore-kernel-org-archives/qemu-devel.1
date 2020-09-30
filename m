Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AD1C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856E82071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpqABRIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856E82071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcbK-0006T5-G6
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMT-0006Ie-Ma
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMR-0005dX-Rd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:37 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601473295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WN4LE8t/DByIxTz/JRhY5PRr1t/M3a5mw6/p7Ud2ibE=;
 b=HpqABRIVZN6cGtwl1WyTHybpY9I99N1Qum2RQaMP2o/Qfv9YkMvms9IIY/j87aeXiuLZqW
 xxmxBjLGzjTTtiHFUWkBx9zZiuAO03iBumRgCy4gkLPGQLR8tt+QbW9Ig56qxP3u7MU2os
 MoEAK1Bvq+MZyzHJz4ELQuyxSRyl26A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-AHjjN0IzMvyyzKQhilpiSA-1; Wed, 30 Sep 2020 09:41:32 -0400
X-MC-Unique: AHjjN0IzMvyyzKQhilpiSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 654908030DF
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:41:31 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F322360C05;
 Wed, 30 Sep 2020 13:41:29 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 13/19] i386: split hyperv_handle_properties() into
 hyperv_expand_features()/hyperv_fill_cpuids()
Date: Wed, 30 Sep 2020 15:40:21 +0200
Message-Id: <20200930134027.1348021-14-vkuznets@redhat.com>
In-Reply-To: <20200930134027.1348021-1-vkuznets@redhat.com>
References: <20200930134027.1348021-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The intention is to call hyperv_expand_features() early, before vCPUs
are created and use the acquired data later when we set guest visible
CPUID data.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 86a5cfa1e12b..0808355bfcfd 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1200,16 +1200,15 @@ static uint32_t hv_build_cpuid_leaf(CPUState *cs, uint32_t func, int reg)
 }
 
 /*
- * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent in
- * case of success, errno < 0 in case of failure and 0 when no Hyper-V
- * extentions are enabled.
+ * Expand Hyper-V CPU features. In partucular, check that all the requested
+ * features are supported by the host and the sanity of the configuration
+ * (that all the required dependencies are included). Also, this takes care
+ * of 'hv_passthrough' mode and fills the environment with all supported
+ * Hyper-V features.
  */
-static int hyperv_handle_properties(CPUState *cs,
-                                    struct kvm_cpuid_entry2 *cpuid_ent)
+static int hyperv_expand_features(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
-    struct kvm_cpuid_entry2 *c;
-    uint32_t cpuid_i = 0;
     int r;
 
     if (!hyperv_enabled(cpu))
@@ -1307,6 +1306,19 @@ static int hyperv_handle_properties(CPUState *cs,
         return -ENOSYS;
     }
 
+    return 0;
+}
+
+/*
+ * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent.
+ */
+static int hyperv_fill_cpuids(CPUState *cs,
+                              struct kvm_cpuid_entry2 *cpuid_ent)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    struct kvm_cpuid_entry2 *c;
+    uint32_t cpuid_i = 0;
+
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
     c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
@@ -1514,11 +1526,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
     env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
 
     /* Paravirtualization CPUIDs */
-    r = hyperv_handle_properties(cs, cpuid_data.entries);
+    r = hyperv_expand_features(cs);
     if (r < 0) {
         return r;
-    } else if (r > 0) {
-        cpuid_i = r;
+    }
+
+    if (hyperv_enabled(cpu)) {
+        cpuid_i = hyperv_fill_cpuids(cs, cpuid_data.entries);
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall = true;
     }
-- 
2.25.4


