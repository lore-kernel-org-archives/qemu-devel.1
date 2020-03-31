Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7087BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9EA20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfRQf8LA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9EA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJmE-0000SE-FZ
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1jJJlF-0008SM-OW
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1jJJlE-000508-5i
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:29:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1jJJlE-0004zo-23
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585672147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+KClM/tGg2dVBhaTwfWTOqVeJrWy18CMjePmpZSUs1o=;
 b=BfRQf8LA4ml5AhYauq0B5BG6vOvc+8yyOmi0BRMVJPffyutWth9CPzHdJUQUR9NHpLeTOM
 PQ5MEZx99DVuiFGBHkSATJYduKP/A5m1pM+InzG+S+zhbTM7LApppMNg6o6sjucv+u354j
 HYbXEL7x09XqNPIjIGaAXao+p2ztHVg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-EQ4ikF5jNEm1vRBez7qCQQ-1; Tue, 31 Mar 2020 12:27:57 -0400
X-MC-Unique: EQ4ikF5jNEm1vRBez7qCQQ-1
Received: by mail-wr1-f69.google.com with SMTP id h95so7985642wrh.11
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 09:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=px1f25RapIts9SG9mOrFjmwWSzuqNrLClSb/lU6fHz0=;
 b=SWffaXxyCSjxyOYnX5WqXgm14jf3EzfBuUIrIpa54xGUByNB4S86C5lNlmWrvqp7pX
 2qmSv/P4iyAS+f1+Dn4Hf+e1FCyAvJ9UH8NPiIrXTga/OVfOYiunxTUUegw8gY+nDBaH
 q0lIqFZu35Atcaw6hvkuSMVXx9fndrf8nNkEhHfoKNbWjI88/eVrZQlOQRB9BPJsudE4
 6iMOSdHtKE9/wBSAsHIEVU3RvTXROzMSSLWbdV+5htesVqe2OPVWfVQ3YlvtgmOhMOLb
 F6Z7Dc0IFtx3tANsJcMGhrPYlNoveuv/X2AHnrvDH6ZIyXxced67aB+DmbrBFfvFIePM
 m2Yg==
X-Gm-Message-State: ANhLgQ1aVtHOOuCn3hMh6QDcryuAB/RxfJXVtEGv26AqgGJd/M+BTKOB
 4+ubudOpqmh/49MvV8Vbkv+G6Oh+HXMheoUDUrIWIY0bRpIqNs4/8gsYYFOhNLryxr7+Q7C7CC6
 kykyNSZoN3TpDViY=
X-Received: by 2002:adf:e942:: with SMTP id m2mr21094979wrn.364.1585672076184; 
 Tue, 31 Mar 2020 09:27:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvZ+evo3GG49ezM1f4zpcnAROunclwLKdfgj1o1VRxuXE6R4CUaLOyKODU+Mid9XUEvVNFqJg==
X-Received: by 2002:adf:e942:: with SMTP id m2mr21094950wrn.364.1585672075936; 
 Tue, 31 Mar 2020 09:27:55 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id j188sm4633267wmj.36.2020.03.31.09.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 09:27:55 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: do not set unsupported VMX secondary execution
 controls
Date: Tue, 31 Mar 2020 18:27:52 +0200
Message-Id: <20200331162752.1209928-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 048c95163b4 ("target/i386: work around KVM_GET_MSRS bug for
secondary execution controls") added a workaround for KVM pre-dating
commit 6defc591846d ("KVM: nVMX: include conditional controls in /dev/kvm
KVM_GET_MSRS") which wasn't setting certain available controls. The
workaround uses generic CPUID feature bits to set missing VMX controls.

It was found that in some cases it is possible to observe hosts which
have certain CPUID features but lack the corresponding VMX control.

In particular, it was reported that Azure VMs have RDSEED but lack
VMX_SECONDARY_EXEC_RDSEED_EXITING; attempts to enable this feature
bit result in QEMU abort.

Resolve the issue but not applying the workaround when we don't have
to. As there is no good way to find out if KVM has the fix itself, use
95c5c7c77c ("KVM: nVMX: list VMX MSRs in KVM_GET_MSR_INDEX_LIST") instead
as these [are supposed to] come together.

Fixes: 048c95163b4 ("target/i386: work around KVM_GET_MSRS bug for secondar=
y execution controls")
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 69eb43d796e6..4901c6dd747d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -106,6 +106,7 @@ static bool has_msr_arch_capabs;
 static bool has_msr_core_capabs;
 static bool has_msr_vmx_vmfunc;
 static bool has_msr_ucode_rev;
+static bool has_msr_vmx_procbased_ctls2;
=20
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -490,21 +491,28 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState =
*s, uint32_t index)
     value =3D msr_data.entries[0].data;
     switch (index) {
     case MSR_IA32_VMX_PROCBASED_CTLS2:
-        /* KVM forgot to add these bits for some time, do this ourselves. =
 */
-        if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) & CPUID_XSAVE_X=
SAVES) {
-            value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
-        }
-        if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) & CPUID_EXT_RDRAN=
D) {
-            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << 32;
-        }
-        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX_I=
NVPCID) {
-            value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << 32;
-        }
-        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX_R=
DSEED) {
-            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << 32;
-        }
-        if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) & CPUID_=
EXT2_RDTSCP) {
-            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
+        if (!has_msr_vmx_procbased_ctls2) {
+            /* KVM forgot to add these bits for some time, do this ourselv=
es. */
+            if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) &
+                CPUID_XSAVE_XSAVES) {
+                value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
+            }
+            if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) &
+                CPUID_EXT_RDRAND) {
+                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << =
32;
+            }
+            if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
+                CPUID_7_0_EBX_INVPCID) {
+                value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << =
32;
+            }
+            if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
+                CPUID_7_0_EBX_RDSEED) {
+                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << =
32;
+            }
+            if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) &
+                CPUID_EXT2_RDTSCP) {
+                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
+            }
         }
         /* fall through */
     case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
@@ -2060,6 +2068,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_UCODE_REV:
                 has_msr_ucode_rev =3D true;
                 break;
+            case MSR_IA32_VMX_PROCBASED_CTLS2:
+                has_msr_vmx_procbased_ctls2 =3D true;
+                break;
             }
         }
     }
--=20
2.25.1


