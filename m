Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF99C2BA16
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC70920719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmV6VPC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC70920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5Fx-0002ly-Sl
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B1-0002UT-9p
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B0-0000Pn-1G
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35926
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5Az-0000NA-Pf
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyIXqJR9CGNVjmUsY7ssf4pvHmvsyrpi0UXASetzHqY=;
 b=SmV6VPC1caxvQexMLP44rUZ1QIohv8AQjBkMjxYRDqAL8olD63opvTovLRDzalzTLM4Cs7
 DJtXV9o/6K8cs7ngQ+jy3MagOc7r+2mkCOJZCgbYwKG5qX79T3YmNUymTWa7GJpRfTpAVa
 yeXj7sE7K2nP8AKv7mO9odrpd0JeATI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-pbkzwwDtMymCfL4SaJkWFg-1; Thu, 02 Apr 2020 15:06:51 -0400
X-MC-Unique: pbkzwwDtMymCfL4SaJkWFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB74A8017CE
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EBEE50BEE;
 Thu,  2 Apr 2020 19:06:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/15] target/i386: do not set unsupported VMX secondary
 execution controls
Date: Thu,  2 Apr 2020 15:06:36 -0400
Message-Id: <20200402190640.1693-12-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

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
Message-Id: <20200331162752.1209928-1-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 69eb43d796..4901c6dd74 100644
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
2.18.2



