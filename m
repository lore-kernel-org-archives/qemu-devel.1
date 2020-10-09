Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FB3C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B0722284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0tY97fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B0722284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrQz-0005Al-4c
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMT-0008JU-RV
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMP-0007uR-6C
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602245936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSM/rOeYu7Cp3+SfWmmaUaIqAxpZuN/FkBdYNwSMXKE=;
 b=R0tY97fJ40YDIl29bRoaoBt/ZRm1Nfakn1zSDt6q9WsUXCMvjW/o3TSCQRZPyZHrzaHnOL
 JjoBGzKx4214GC70b8o40zQ7NKuew2HNTZDPWNS5uZLIGxzoj4oKzgjIccfk23cvh/YBSb
 FzcWJDlMdE9dX2/Op2W5y8tCtYpPOfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-1TUhStcXOgu977pvdDwACw-1; Fri, 09 Oct 2020 08:18:54 -0400
X-MC-Unique: 1TUhStcXOgu977pvdDwACw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA1801029D20
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 12:18:53 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F32A5C1C7;
 Fri,  9 Oct 2020 12:18:51 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 04/23] i386: move hyperv_vendor_id initialization to
 x86_cpu_realizefn()
Date: Fri,  9 Oct 2020 14:18:23 +0200
Message-Id: <20201009121842.1938010-5-vkuznets@redhat.com>
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

As a preparation to expanding Hyper-V CPU features early, move
hyperv_vendor_id initialization to x86_cpu_realizefn(). Introduce
x86_cpu_hyperv_realize() to not not pollute x86_cpu_realizefn()
itself.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c | 23 ++++++++++++++++++++++-
 target/i386/cpu.h |  3 ++-
 target/i386/kvm.c | 25 ++++++++++---------------
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bbfdfb8a3f88..ce485dd9afd9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6491,6 +6491,24 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
     }
 }
 
+static void x86_cpu_hyperv_realize(X86CPU *cpu)
+{
+    size_t len;
+
+    if (!cpu->hyperv_vendor) {
+        memcpy(cpu->hyperv_vendor_id, "Microsoft Hv", 12);
+    } else {
+        len = strlen(cpu->hyperv_vendor);
+
+        if (len > 12) {
+            warn_report("hv-vendor-id truncated to 12 characters");
+            len = 12;
+        }
+        memset(cpu->hyperv_vendor_id, 0, 12);
+        memcpy(cpu->hyperv_vendor_id, cpu->hyperv_vendor, len);
+    }
+}
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -6541,6 +6559,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Process Hyper-V enlightenments */
+    x86_cpu_hyperv_realize(cpu);
+
     x86_cpu_expand_features(cpu, &local_err);
     if (local_err) {
         goto out;
@@ -7212,7 +7233,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
-    DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor_id),
+    DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51c1d5f60a74..2e7ee40372de 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1655,11 +1655,12 @@ struct X86CPU {
     uint64_t ucode_rev;
 
     uint32_t hyperv_spinlock_attempts;
-    char *hyperv_vendor_id;
+    char *hyperv_vendor;
     bool hyperv_synic_kvm_only;
     uint64_t hyperv_features;
     bool hyperv_passthrough;
     OnOffAuto hyperv_no_nonarch_cs;
+    uint32_t hyperv_vendor_id[3];
 
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0098be701511..75d4cb17a5ba 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1210,6 +1210,13 @@ static int hyperv_handle_properties(CPUState *cs,
         memcpy(cpuid_ent, &cpuid->entries[0],
                cpuid->nent * sizeof(cpuid->entries[0]));
 
+        c = cpuid_find_entry(cpuid, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, 0);
+        if (c) {
+            cpu->hyperv_vendor_id[0] = c->ebx;
+            cpu->hyperv_vendor_id[1] = c->ecx;
+            cpu->hyperv_vendor_id[2] = c->edx;
+        }
+
         c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
         if (c) {
             env->features[FEAT_HYPERV_EAX] = c->eax;
@@ -1284,23 +1291,11 @@ static int hyperv_handle_properties(CPUState *cs,
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
-    if (!cpu->hyperv_vendor_id) {
-        memcpy(signature, "Microsoft Hv", 12);
-    } else {
-        size_t len = strlen(cpu->hyperv_vendor_id);
-
-        if (len > 12) {
-            error_report("hv-vendor-id truncated to 12 characters");
-            len = 12;
-        }
-        memset(signature, 0, 12);
-        memcpy(signature, cpu->hyperv_vendor_id, len);
-    }
     c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
         HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
-    c->ebx = signature[0];
-    c->ecx = signature[1];
-    c->edx = signature[2];
+    c->ebx = cpu->hyperv_vendor_id[0];
+    c->ecx = cpu->hyperv_vendor_id[1];
+    c->edx = cpu->hyperv_vendor_id[2];
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_INTERFACE;
-- 
2.25.4


