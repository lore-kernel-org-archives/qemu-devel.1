Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364EEC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB9B2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpbD0Lid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB9B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDBx-0000Ft-VZ
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8G-0000r9-FW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8E-0007Dz-CI
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599231361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJaA8+NmorZsbhCkvkIm/fNDPNgoVlNN4owknRbS5ag=;
 b=dpbD0LidMfA/UAU6VeIJzftvO5ov37qDg6NFhJl5AUi1ke7wesIaoVZW56WoBkOe70OJdX
 y5cE/fEQcKDXEdrzKltMI2EOqz1Y17yPwZOHrd0jeT0clyW4JtOWkfrpBVZSmByexfGRmL
 bTcVuELJnt1xAokr+ZIu6F5ks+G+1b0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-287JcF02NjCQqC9zHO-A0g-1; Fri, 04 Sep 2020 10:54:55 -0400
X-MC-Unique: 287JcF02NjCQqC9zHO-A0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C4CD1017DC0
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 14:54:54 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B45157A1F4;
 Fri,  4 Sep 2020 14:54:52 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 11/22] i386: add reserved FEAT_HV_NESTED_EBX/ECX/EDX CPUID
 leaves
Date: Fri,  4 Sep 2020 16:54:20 +0200
Message-Id: <20200904145431.196885-12-vkuznets@redhat.com>
In-Reply-To: <20200904145431.196885-1-vkuznets@redhat.com>
References: <20200904145431.196885-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

As a preparation to expanding Hyper-V CPU features early, add reserved
FEAT_HV_NESTED_EBX/ECX/EDX CPUID leaves.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c | 15 +++++++++++++++
 target/i386/cpu.h |  3 +++
 target/i386/kvm.c |  6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3665f22093e9..479c4bbbf459 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1035,6 +1035,21 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = { .eax = 0x4000000A, .reg = R_EAX, },
     },
+    [FEAT_HV_NESTED_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        /* reserved */
+        .cpuid = { .eax = 0x4000000A, .reg = R_EBX, },
+    },
+    [FEAT_HV_NESTED_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        /* reserved */
+        .cpuid = { .eax = 0x4000000A, .reg = R_ECX, },
+    },
+    [FEAT_HV_NESTED_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        /* reserved */
+        .cpuid = { .eax = 0x4000000A, .reg = R_EDX, },
+    },
     [FEAT_SVM] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0668fe74df4f..0aad60e0c707 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -527,6 +527,9 @@ typedef enum FeatureWord {
     FEAT_HV_RECOMM_ECX, /* CPUID[4000_0004].ECX */
     FEAT_HV_RECOMM_EDX, /* CPUID[4000_0004].EDX */
     FEAT_HV_NESTED_EAX, /* CPUID[4000_000A].EAX */
+    FEAT_HV_NESTED_EBX, /* CPUID[4000_000A].EBX */
+    FEAT_HV_NESTED_ECX, /* CPUID[4000_000A].ECX */
+    FEAT_HV_NESTED_EDX, /* CPUID[4000_000A].EDX */
     FEAT_SVM,           /* CPUID[8000_000A].EDX */
     FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
     FEAT_6_EAX,         /* CPUID[6].EAX */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index c18f221cd301..87b83a2aa2cb 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1274,6 +1274,9 @@ static int hyperv_handle_properties(CPUState *cs,
         c = cpuid_find_entry(cpuid, HV_CPUID_NESTED_FEATURES, 0);
         if (c) {
             env->features[FEAT_HV_NESTED_EAX] = c->eax;
+            env->features[FEAT_HV_NESTED_EBX] = c->ebx;
+            env->features[FEAT_HV_NESTED_ECX] = c->ecx;
+            env->features[FEAT_HV_NESTED_EDX] = c->edx;
         }
     }
 
@@ -1384,6 +1387,9 @@ static int hyperv_handle_properties(CPUState *cs,
         c = &cpuid_ent[cpuid_i++];
         c->function = HV_CPUID_NESTED_FEATURES;
         c->eax = env->features[FEAT_HV_NESTED_EAX];
+        c->ebx = env->features[FEAT_HV_NESTED_EBX];
+        c->ecx = env->features[FEAT_HV_NESTED_ECX];
+        c->edx = env->features[FEAT_HV_NESTED_EDX];
     }
     r = cpuid_i;
 
-- 
2.25.4


