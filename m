Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5C4C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8992071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuFJNXrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8992071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcYo-00031V-Jy
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMR-0006ER-HO
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcML-0005c9-W1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601473284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WyKspBYuAkv+mkQrGRTfCl9R6UGLSu0mbqmmr6qQfGo=;
 b=RuFJNXrQmaerXnZbzb3oxhu5/4MqASGR80O8ZLf05gaoOoGRNbEmjeEd5UYdkc1T6QANul
 n2aTrDtsrcOfB5cocv0X7tH4Wo8VCvuB9tX2DF98jK8SovnuZBW7yjMxTt1iMYxz36BH4+
 9pbpXi1kuqHKVyF702yQKb++1KdBNJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-eHPg2FnEO8WxrMN7NaJGfQ-1; Wed, 30 Sep 2020 09:41:22 -0400
X-MC-Unique: eHPg2FnEO8WxrMN7NaJGfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60B9C1868413
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:41:20 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00B2260C05;
 Wed, 30 Sep 2020 13:41:18 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 07/19] i386: move hyperv_limits initialization to
 x86_cpu_realizefn()
Date: Wed, 30 Sep 2020 15:40:15 +0200
Message-Id: <20200930134027.1348021-8-vkuznets@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
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

As a preparation to expanding Hyper-V CPU features early, move
hyperv_limits initialization to x86_cpu_realizefn().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c |  5 +++++
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 99bcfcbb448a..d657590ab55d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6515,6 +6515,11 @@ static void x86_cpu_hyperv_realize(X86CPU *cpu)
     /* Hypervisor system identity */
     cpu->hyperv_version_id[0] = 0x00001bbc;
     cpu->hyperv_version_id[1] = 0x00060001;
+
+    /* Hypervisor implementation limits */
+    cpu->hyperv_limits[0] = 64;
+    cpu->hyperv_limits[1] = 0;
+    cpu->hyperv_limits[2] = 0;
 }
 
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 077c19c5642b..187e4a09e65d 100644
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
index b335b3a3d1c7..afddc9a4a260 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1253,6 +1253,15 @@ static int hyperv_handle_properties(CPUState *cs,
             env->features[FEAT_HYPERV_EBX] = c->ebx;
             env->features[FEAT_HYPERV_EDX] = c->edx;
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


