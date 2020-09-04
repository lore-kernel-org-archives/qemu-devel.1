Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1720C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B074C2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B074C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDF3-0005JK-Sb
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8H-0000tV-HK
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51253
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8D-0007Dn-Ql
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:05 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-QYIsYuIaM0O86e4oCghf1Q-1; Fri, 04 Sep 2020 10:54:43 -0400
X-MC-Unique: QYIsYuIaM0O86e4oCghf1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B15808D3289
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 14:54:42 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41BD07A1F4;
 Fri,  4 Sep 2020 14:54:41 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 05/22] i386: move hyperv_version_id initialization to
 x86_cpu_realizefn()
Date: Fri,  4 Sep 2020 16:54:14 +0200
Message-Id: <20200904145431.196885-6-vkuznets@redhat.com>
In-Reply-To: <20200904145431.196885-1-vkuznets@redhat.com>
References: <20200904145431.196885-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As a preparation to expanding Hyper-V CPU features early, move
hyperv_version_id initialization to x86_cpu_realizefn().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c |  4 ++++
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 14 ++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 16888125a30a..e605399eb8c0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6644,6 +6644,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     cpu->hyperv_interface_id[2] = 0;
     cpu->hyperv_interface_id[3] = 0;
 
+    /* Hypervisor system identity */
+    cpu->hyperv_version_id[0] = 0x00001bbc;
+    cpu->hyperv_version_id[1] = 0x00060001;
+
     if (cpu->ucode_rev == 0) {
         /* The default is the same as KVM's.  */
         if (IS_AMD_CPU(env)) {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 91edc54a268c..2630ffd2d4b2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1661,6 +1661,7 @@ struct X86CPU {
     OnOffAuto hyperv_no_nonarch_cs;
     uint32_t hyperv_vendor_id[3];
     uint32_t hyperv_interface_id[4];
+    uint32_t hyperv_version_id[4];
 
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index a36c65100cd0..169bae2779a4 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1239,6 +1239,14 @@ static int hyperv_handle_properties(CPUState *cs,
             cpu->hyperv_interface_id[3] = c->edx;
         }
 
+        c = cpuid_find_entry(cpuid, HV_CPUID_VERSION, 0);
+        if (c) {
+            cpu->hyperv_version_id[0] = c->eax;
+            cpu->hyperv_version_id[1] = c->ebx;
+            cpu->hyperv_version_id[2] = c->ecx;
+            cpu->hyperv_version_id[3] = c->edx;
+        }
+
         c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
         if (c) {
             env->features[FEAT_HYPERV_EAX] = c->eax;
@@ -1328,8 +1336,10 @@ static int hyperv_handle_properties(CPUState *cs,
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_VERSION;
-    c->eax = 0x00001bbc;
-    c->ebx = 0x00060001;
+    c->eax = cpu->hyperv_version_id[0];
+    c->ebx = cpu->hyperv_version_id[1];
+    c->ecx = cpu->hyperv_version_id[2];
+    c->edx = cpu->hyperv_version_id[3];
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_FEATURES;
-- 
2.25.4


