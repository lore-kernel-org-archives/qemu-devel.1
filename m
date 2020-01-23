Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33263C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC6C20704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhIxhHfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC6C20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iug0D-0004ou-CJ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuctT-0008IR-7x
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuctR-0007wa-1P
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuctQ-0007wM-Ux
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tN1ejZZNNDpwR2f7hBVHJMLYu8kEqjTbMs1ArQbeLlc=;
 b=QhIxhHfKex44neOcvhjcqoU6fJoNPAMZBxucVmCo+8a/vwFeA/hVODDr1rMQPbIdB51I6h
 KlrkrCyorZITJBebCR6I+e4+c3nZGOIR489A3mN/+2YeacjVRMJ1+lY8ZEG7vamASZrrT1
 8JJUEL0zASXC0hkFR4yKMUODOVDyPFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-jIf9gV7IPEqPV03uNt2n1Q-1; Thu, 23 Jan 2020 08:51:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2D52100550E
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:29 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26AC785785
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/59] target/i386: kvm: initialize microcode revision from KVM
Date: Thu, 23 Jan 2020 14:50:10 +0100
Message-Id: <1579787449-27599-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jIf9gV7IPEqPV03uNt2n1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM can return the host microcode revision as a feature MSR.
Use it as the default value for -cpu host.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1579544504-3616-4-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++++
 target/i386/kvm.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 790254e..ffe5de0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6416,6 +6416,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
                        &cpu->mwait.ecx, &cpu->mwait.edx);
             env->features[FEAT_1_ECX] |=3D CPUID_EXT_MONITOR;
         }
+        if (kvm_enabled() && cpu->ucode_rev =3D=3D 0) {
+            cpu->ucode_rev =3D kvm_arch_get_supported_msr_feature(kvm_stat=
e,
+                                                                MSR_IA32_U=
CODE_REV);
+        }
     }
=20
     if (cpu->ucode_rev =3D=3D 0) {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f6dd6b7..1b67090 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2696,6 +2696,11 @@ static void kvm_init_msrs(X86CPU *cpu)
                           env->features[FEAT_CORE_CAPABILITY]);
     }
=20
+    if (kvm_arch_get_supported_msr_feature(kvm_state,
+                                           MSR_IA32_UCODE_REV)) {
+        kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
+    }
+
     /*
      * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, bu=
t
      * all kernels with MSR features should have them.
--=20
1.8.3.1



