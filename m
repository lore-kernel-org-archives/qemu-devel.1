Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F058EC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D1A2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fq+88HsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D1A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDAM-000585-SL
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED80-0000Pc-SA
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED7z-0007D0-1a
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599231346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1j58fbN+P75M6Py9JVnizkwxPGW9WRczMd8yOQC698=;
 b=Fq+88HsWmU2hvC9aIsW7l5Dkl5QJSFTmg1WZlZ3kZQBvCY0dc5bSEscLVZxbXKH1+ojtSX
 0ipRa4UAVhIk5cvhTXDp1UeikqLiEM9I0kJZN7JdWN6TpphMuNwKps/15RwrFOYocC05W1
 u+N2pQ9HdNOYa/yweGRCN9wXL4Z+RII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-zkH7E7V8PRaXWCRcAK3ePg-1; Fri, 04 Sep 2020 10:54:39 -0400
X-MC-Unique: zkH7E7V8PRaXWCRcAK3ePg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0966C8D327D
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 14:54:39 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEEA27A1F4;
 Fri,  4 Sep 2020 14:54:37 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 03/22] i386: move hyperv_vendor_id initialization to
 x86_cpu_realizefn()
Date: Fri,  4 Sep 2020 16:54:12 +0200
Message-Id: <20200904145431.196885-4-vkuznets@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:46:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

As a preparation to expanding Hyper-V CPU features early, move
hyperv_vendor_id initialization to x86_cpu_realizefn().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c | 15 ++++++++++++++-
 target/i386/cpu.h |  3 ++-
 target/i386/kvm.c | 25 ++++++++++---------------
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 14489def2177..07e9da9e567e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6625,6 +6625,19 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    if (!cpu->hyperv_vendor) {
+        memcpy(cpu->hyperv_vendor_id, "Microsoft Hv", 12);
+    } else {
+        size_t len = strlen(cpu->hyperv_vendor);
+
+        if (len > 12) {
+            warn_report("hv-vendor-id truncated to 12 characters");
+            len = 12;
+        }
+        memset(cpu->hyperv_vendor_id, 0, 12);
+        memcpy(cpu->hyperv_vendor_id, cpu->hyperv_vendor, len);
+    }
+
     if (cpu->ucode_rev == 0) {
         /* The default is the same as KVM's.  */
         if (IS_AMD_CPU(env)) {
@@ -7313,7 +7326,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
-    DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor_id),
+    DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d3097be6a50a..903994818093 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1654,11 +1654,12 @@ struct X86CPU {
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
index 205b68bc0ce8..47779c5e1efd 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1225,6 +1225,13 @@ static int hyperv_handle_properties(CPUState *cs,
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
@@ -1299,23 +1306,11 @@ static int hyperv_handle_properties(CPUState *cs,
 
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


