Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22FFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84AA820709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO/Od1tP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AA820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYqZ-00068O-Kz
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jZYpk-0004zu-2G
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:48:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23111
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jZYpi-0002Eb-Ig
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589543332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4sZCVbBZwAwxMCNzqSwUWyPYyZ+QolaNeecOJbi68l4=;
 b=EO/Od1tP18xzMHPQBbLTqI4rZ4FhKQFjkaI8I0K8lejSTO9sk3CbYH4umRdtGwJKgYIelH
 bRzSI2N1/Hxb1xvy5Tu1bdv8MVbqgOQTtuZRynat/q7veGkY9lUVHsH18LKJ0VliRToDD5
 /fbhWaOcSTR+9o+KTZRcTDw01Hi9LIM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-h6C7gFflOZq6bEtHf6NBeA-1; Fri, 15 May 2020 07:48:51 -0400
X-MC-Unique: h6C7gFflOZq6bEtHf6NBeA-1
Received: by mail-wr1-f72.google.com with SMTP id l12so1073635wrw.9
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 04:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4sZCVbBZwAwxMCNzqSwUWyPYyZ+QolaNeecOJbi68l4=;
 b=TIV3NhXvSg8KGJ4al11uoo3T44ZbhXS+xAIcE1+S8abN+XBDjldadcGAZJyMOrMPdr
 sUpnBIxJmA9olQRC5q6ub5v0SNP1l0qW3/wBFIEJKI9kq8klAUjV86LEN4Fg/Y3h7Ym9
 NFiOaWVUmvMoz/IYvSqDo5QjhCU78mB1WOUI/tO17TamuPVynkzzhIB0ulZHT29BsS4r
 Pd8rXMbEasX9G8HyP8Ss0/c7GrO+mNcPF79d1wtjHAXZ7hu2fUDwJt+lrc9BQhFWMUk7
 aQDhUWCbO8qKQhMm5u3I6TV7091HVcn0Nlq9yA6hlfbokbGK6ysRk+Q+M9nig7YTj82V
 38pQ==
X-Gm-Message-State: AOAM533JAyiyPeH68m5gxpqV1tFKP0R6qnJY43R4TWHRUNMq4ELVwCzg
 oIz0xlc6olXVIE7n8X6XxDGE+CpIfEfmlqu94lYEoydK0TGLhVk6s4J6OfkjKWjBWuLuy7LhRUr
 GWfRlNyOyWOO7tu0=
X-Received: by 2002:adf:a118:: with SMTP id o24mr3752868wro.330.1589543329673; 
 Fri, 15 May 2020 04:48:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbmFDEYaZT3RntLZgMsaG71g7veMFXIA2FRvbUJIlXm/8vfl0ILyJrOqbxvS521RZd1z1Drg==
X-Received: by 2002:adf:a118:: with SMTP id o24mr3752848wro.330.1589543329453; 
 Fri, 15 May 2020 04:48:49 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id n6sm3243394wrt.58.2020.05.15.04.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 04:48:48 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] i386/kvm: correct the meaning of '0xffffffff' value for
 hv-spinlocks
Date: Fri, 15 May 2020 13:48:47 +0200
Message-Id: <20200515114847.74523-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hyper-V TLFS prior to version 6.0 had a mistake in it: special value
'0xffffffff' for CPUID 0x40000004.EBX was called 'never to retry', this
looked weird (like why it's not '0' which supposedly have the same effect?)
but nobody raised the question. In TLFS version 6.0 the mistake was
corrected to 'never notify' which sounds logical. Fix QEMU accordingly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 docs/hyperv.txt   | 2 +-
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 4 ++--
 target/i386/kvm.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
index 6518b716a958..5df00da54fc4 100644
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
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7a4a8e3847f0..5bb9a8017523 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7133,7 +7133,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
-                       HYPERV_SPINLOCK_NEVER_RETRY),
+                       HYPERV_SPINLOCK_NEVER_NOTIFY),
     DEFINE_PROP_BIT64("hv-relaxed", X86CPU, hyperv_features,
                       HYPERV_FEAT_RELAXED, 0),
     DEFINE_PROP_BIT64("hv-vapic", X86CPU, hyperv_features,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 408392dbf6f4..80253d1c373b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -980,8 +980,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define HYPERV_FEAT_IPI                 13
 #define HYPERV_FEAT_STIMER_DIRECT       14
 
-#ifndef HYPERV_SPINLOCK_NEVER_RETRY
-#define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
+#ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
+#define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
 #endif
 
 #define EXCP00_DIVZ	0
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 34f838728dd6..28e9c73cc2a5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -731,7 +731,7 @@ static bool hyperv_enabled(X86CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
     return kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0 &&
-        ((cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_RETRY) ||
+        ((cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_NOTIFY) ||
          cpu->hyperv_features || cpu->hyperv_passthrough);
 }
 
@@ -1201,7 +1201,7 @@ static int hyperv_handle_properties(CPUState *cs,
             env->features[FEAT_HV_RECOMM_EAX] = c->eax;
 
             /* hv-spinlocks may have been overriden */
-            if (cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_RETRY) {
+            if (cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_NOTIFY) {
                 c->ebx = cpu->hyperv_spinlock_attempts;
             }
         }
-- 
2.25.4


