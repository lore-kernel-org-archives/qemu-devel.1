Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611D6C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDDF208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9dUujAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDDF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJN0n-00083u-7o
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJMzI-0006Vp-P8
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:28:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51467
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJMzG-0003ph-AA
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600460885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L3cjk35aVUeH0V89TyoXg2jKoacEF7LRbN9bwQItQ+Q=;
 b=f9dUujAXHEGltA8NB0XgQIwBBTCxa/n0FTHvsnyIPUvJRQBmdGsYmIlLuDo8NtTP63Fnrr
 gQvr7NB3CBqRT88gxfuXkB+/iz9304o2UjE60BvopQGvGpjfnHmxDpOlhXm5ZKQETxOUPM
 n/SeNUG36awjaSM8fNg6dSlCEvTqQMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-WpF5Sl3BPxecuIy6bMKyFA-1; Fri, 18 Sep 2020 16:28:01 -0400
X-MC-Unique: WpF5Sl3BPxecuIy6bMKyFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 261861074646;
 Fri, 18 Sep 2020 20:28:00 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9995A10013C1;
 Fri, 18 Sep 2020 20:27:55 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/4] i386/kvm: correct the meaning of '0xffffffff' value for
 hv-spinlocks
Date: Fri, 18 Sep 2020 16:27:47 -0400
Message-Id: <20200918202750.10358-2-ehabkost@redhat.com>
In-Reply-To: <20200918202750.10358-1-ehabkost@redhat.com>
References: <20200918202750.10358-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:24:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Hyper-V TLFS prior to version 6.0 had a mistake in it: special value
'0xffffffff' for CPUID 0x40000004.EBX was called 'never to retry', this
looked weird (like why it's not '0' which supposedly have the same effect?)
but nobody raised the question. In TLFS version 6.0 the mistake was
corrected to 'never notify' which sounds logical. Fix QEMU accordingly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20200515114847.74523-1-vkuznets@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/hyperv.txt   | 2 +-
 target/i386/cpu.h | 4 ++--
 target/i386/cpu.c | 2 +-
 target/i386/kvm.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
index 6518b716a9..5df00da54f 100644
--- a/docs/hyperv.txt
+++ b/docs/hyperv.txt
@@ -49,7 +49,7 @@ more efficiently. In particular, this enlightenment allows paravirtualized
 ======================
 Enables paravirtualized spinlocks. The parameter indicates how many times
 spinlock acquisition should be attempted before indicating the situation to the
-hypervisor. A special value 0xffffffff indicates "never to retry".
+hypervisor. A special value 0xffffffff indicates "never notify".
 
 3.4. hv-vpindex
 ================
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d3097be6a5..f519d2bfd4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -991,8 +991,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define HYPERV_FEAT_IPI                 13
 #define HYPERV_FEAT_STIMER_DIRECT       14
 
-#ifndef HYPERV_SPINLOCK_NEVER_RETRY
-#define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
+#ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
+#define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
 #endif
 
 #define EXCP00_DIVZ	0
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49d8958528..37725bd354 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7263,7 +7263,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
-                       HYPERV_SPINLOCK_NEVER_RETRY),
+                       HYPERV_SPINLOCK_NEVER_NOTIFY),
     DEFINE_PROP_BIT64("hv-relaxed", X86CPU, hyperv_features,
                       HYPERV_FEAT_RELAXED, 0),
     DEFINE_PROP_BIT64("hv-vapic", X86CPU, hyperv_features,
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d87af57a23..9efb07e7c8 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -730,7 +730,7 @@ static bool hyperv_enabled(X86CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
     return kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0 &&
-        ((cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_RETRY) ||
+        ((cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_NOTIFY) ||
          cpu->hyperv_features || cpu->hyperv_passthrough);
 }
 
@@ -1236,7 +1236,7 @@ static int hyperv_handle_properties(CPUState *cs,
             env->features[FEAT_HV_RECOMM_EAX] = c->eax;
 
             /* hv-spinlocks may have been overriden */
-            if (cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_RETRY) {
+            if (cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_NOTIFY) {
                 c->ebx = cpu->hyperv_spinlock_attempts;
             }
         }
-- 
2.26.2


