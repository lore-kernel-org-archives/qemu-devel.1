Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA245C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61052074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61052074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kED92-0002B7-P3
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8C-0000jI-Me
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8A-0007Da-RL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:00 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-EoRsuv_DMCGyaHXgzGJK7A-1; Fri, 04 Sep 2020 10:54:45 -0400
X-MC-Unique: EoRsuv_DMCGyaHXgzGJK7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A379E1017DC1
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 14:54:44 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3497D7E416;
 Fri,  4 Sep 2020 14:54:42 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 06/22] i386: move hyperv_limits initialization to
 x86_cpu_realizefn()
Date: Fri,  4 Sep 2020 16:54:15 +0200
Message-Id: <20200904145431.196885-7-vkuznets@redhat.com>
In-Reply-To: <20200904145431.196885-1-vkuznets@redhat.com>
References: <20200904145431.196885-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
hyperv_limits initialization to x86_cpu_realizefn().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c |  5 +++++
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e605399eb8c0..ef3c672cf415 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6648,6 +6648,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     cpu->hyperv_version_id[0] = 0x00001bbc;
     cpu->hyperv_version_id[1] = 0x00060001;
 
+    /* Hypervisor implementation limits */
+    cpu->hyperv_limits[0] = 64;
+    cpu->hyperv_limits[1] = 0;
+    cpu->hyperv_limits[2] = 0;
+
     if (cpu->ucode_rev == 0) {
         /* The default is the same as KVM's.  */
         if (IS_AMD_CPU(env)) {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2630ffd2d4b2..095d0bf75493 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1662,6 +1662,7 @@ struct X86CPU {
     uint32_t hyperv_vendor_id[3];
     uint32_t hyperv_interface_id[4];
     uint32_t hyperv_version_id[4];
+    uint32_t hyperv_limits[3];
 
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 169bae2779a4..720c30e9df17 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1253,6 +1253,15 @@ static int hyperv_handle_properties(CPUState *cs,
             env->features[FEAT_HYPERV_EBX] = c->ebx;
             env->features[FEAT_HYPERV_EDX] = c->eax;
         }
+
+        c = cpuid_find_entry(cpuid, HV_CPUID_IMPLEMENT_LIMITS, 0);
+        if (c) {
+            cpu->hv_max_vps = c->eax;
+            cpu->hyperv_limits[0] = c->ebx;
+            cpu->hyperv_limits[1] = c->ecx;
+            cpu->hyperv_limits[2] = c->edx;
+        }
+
         c = cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
         if (c) {
             env->features[FEAT_HV_RECOMM_EAX] = c->eax;
@@ -1355,7 +1364,9 @@ static int hyperv_handle_properties(CPUState *cs,
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_IMPLEMENT_LIMITS;
     c->eax = cpu->hv_max_vps;
-    c->ebx = 0x40;
+    c->ebx = cpu->hyperv_limits[0];
+    c->ecx = cpu->hyperv_limits[1];
+    c->edx = cpu->hyperv_limits[2];
 
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
         __u32 function;
-- 
2.25.4


