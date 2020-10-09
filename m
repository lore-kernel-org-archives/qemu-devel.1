Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8656DC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0F722284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BebPKZio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0F722284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrYR-0003ij-02
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMo-0008Qi-U1
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMn-0007xj-26
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602245956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+L48HxNUF/CF2ENqTmbBr9TXViabH+p1EZikdcCXpI=;
 b=BebPKZio8eEqBWZXdcsvtqbtn4idGfVI9jjdcVdQdl/cxIioHZEIIFuyuuiYQeb0ohvh1d
 fmwXFNUjnfL0R0fMg7ox8GY3UlWJdV88sRvZBz4oUtEtaHyCx0IvdNvOH/to49iXFUTJkc
 GQ7tQc2LVL7znW29aApbWNCroifDyYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-ZgBrw1f2ORqv1ymm_E-QxA-1; Fri, 09 Oct 2020 08:19:13 -0400
X-MC-Unique: ZgBrw1f2ORqv1ymm_E-QxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE41FAFD02
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 12:19:12 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33CD45C1BB;
 Fri,  9 Oct 2020 12:19:11 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 13/23] i386: introduce hv_cpuid_get_host()
Date: Fri,  9 Oct 2020 14:18:32 +0200
Message-Id: <20201009121842.1938010-14-vkuznets@redhat.com>
In-Reply-To: <20201009121842.1938010-1-vkuznets@redhat.com>
References: <20201009121842.1938010-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a preparation to implementing hv_cpuid_cache intro introduce
hv_cpuid_get_host(). No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 100 ++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 44 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 73f0d3cd0c37..24636ce4bc69 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1106,6 +1106,19 @@ static int hv_cpuid_get_fw(struct kvm_cpuid2 *cpuid, int fw, uint32_t *r)
     return 0;
 }
 
+static uint32_t hv_cpuid_get_host(struct kvm_cpuid2 *cpuid, uint32_t func,
+                                  int reg)
+{
+    struct kvm_cpuid_entry2 *entry;
+
+    entry = cpuid_find_entry(cpuid, func, 0);
+    if (!entry) {
+        return 0;
+    }
+
+    return cpuid_entry_get_reg(entry, reg);
+}
+
 static bool hyperv_feature_supported(struct kvm_cpuid2 *cpuid, int feature)
 {
     uint32_t r, fw, bits;
@@ -1202,7 +1215,7 @@ static int hyperv_handle_properties(CPUState *cs,
 {
     X86CPU *cpu = X86_CPU(cs);
     struct kvm_cpuid2 *cpuid;
-    struct kvm_cpuid_entry2 *c, *c2;
+    struct kvm_cpuid_entry2 *c;
     uint32_t cpuid_i = 0;
     int r;
 
@@ -1234,45 +1247,46 @@ static int hyperv_handle_properties(CPUState *cs,
     }
 
     if (cpu->hyperv_passthrough) {
-        c = cpuid_find_entry(cpuid, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, 0);
-        if (c) {
-            cpu->hyperv_vendor_id[0] = c->ebx;
-            cpu->hyperv_vendor_id[1] = c->ecx;
-            cpu->hyperv_vendor_id[2] = c->edx;
-            cpu->hyperv_vendor = g_realloc(cpu->hyperv_vendor,
-                                           sizeof(cpu->hyperv_vendor_id) + 1);
-            memcpy(cpu->hyperv_vendor, cpu->hyperv_vendor_id,
-                   sizeof(cpu->hyperv_vendor_id));
-        }
-
-        c = cpuid_find_entry(cpuid, HV_CPUID_INTERFACE, 0);
-        if (c) {
-            cpu->hyperv_interface_id[0] = c->eax;
-            cpu->hyperv_interface_id[1] = c->ebx;
-            cpu->hyperv_interface_id[2] = c->ecx;
-            cpu->hyperv_interface_id[3] = c->edx;
-        }
-
-        c = cpuid_find_entry(cpuid, HV_CPUID_VERSION, 0);
-        if (c) {
-            cpu->hyperv_version_id[0] = c->eax;
-            cpu->hyperv_version_id[1] = c->ebx;
-            cpu->hyperv_version_id[2] = c->ecx;
-            cpu->hyperv_version_id[3] = c->edx;
-        }
-
-        c = cpuid_find_entry(cpuid, HV_CPUID_IMPLEMENT_LIMITS, 0);
-        if (c) {
-            cpu->hv_max_vps = c->eax;
-            cpu->hyperv_limits[0] = c->ebx;
-            cpu->hyperv_limits[1] = c->ecx;
-            cpu->hyperv_limits[2] = c->edx;
-        }
-
-        c = cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
-        if (c) {
-            cpu->hyperv_spinlock_attempts = c->ebx;
-        }
+        cpu->hyperv_vendor_id[0] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, R_EBX);
+        cpu->hyperv_vendor_id[1] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, R_ECX);
+        cpu->hyperv_vendor_id[2] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, R_EDX);
+        cpu->hyperv_vendor = g_realloc(cpu->hyperv_vendor,
+                                       sizeof(cpu->hyperv_vendor_id) + 1);
+        memcpy(cpu->hyperv_vendor, cpu->hyperv_vendor_id,
+               sizeof(cpu->hyperv_vendor_id));
+
+        cpu->hyperv_interface_id[0] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_INTERFACE, R_EAX);
+        cpu->hyperv_interface_id[1] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_INTERFACE, R_EBX);
+        cpu->hyperv_interface_id[2] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_INTERFACE, R_ECX);
+        cpu->hyperv_interface_id[3] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_INTERFACE, R_EDX);
+
+        cpu->hyperv_version_id[0] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_VERSION, R_EAX);
+        cpu->hyperv_version_id[1] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_VERSION, R_EBX);
+        cpu->hyperv_version_id[2] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_VERSION, R_ECX);
+        cpu->hyperv_version_id[3] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_VERSION, R_EDX);
+
+        cpu->hv_max_vps = hv_cpuid_get_host(cpuid, HV_CPUID_IMPLEMENT_LIMITS,
+                                            R_EAX);
+        cpu->hyperv_limits[0] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_IMPLEMENT_LIMITS, R_EBX);
+        cpu->hyperv_limits[1] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_IMPLEMENT_LIMITS, R_ECX);
+        cpu->hyperv_limits[2] =
+            hv_cpuid_get_host(cpuid, HV_CPUID_IMPLEMENT_LIMITS, R_EDX);
+
+        cpu->hyperv_spinlock_attempts =
+            hv_cpuid_get_host(cpuid, HV_CPUID_ENLIGHTMENT_INFO, R_EBX);
     }
 
     /* Features */
@@ -1346,10 +1360,8 @@ static int hyperv_handle_properties(CPUState *cs,
     if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
         c->eax |= HV_NO_NONARCH_CORESHARING;
     } else if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO) {
-        c2 = cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
-        if (c2) {
-            c->eax |= c2->eax & HV_NO_NONARCH_CORESHARING;
-        }
+        c->eax |= hv_cpuid_get_host(cpuid, HV_CPUID_ENLIGHTMENT_INFO, R_EAX) &
+            HV_NO_NONARCH_CORESHARING;
     }
 
     c = &cpuid_ent[cpuid_i++];
-- 
2.25.4


