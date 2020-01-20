Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4111C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9498422525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOGGbMS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9498422525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itbiz-0001xQ-IR
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 13:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itbga-00079Z-DW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itbgU-0008Ht-FZ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:22:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itbgT-0008HL-RO
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579544517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+jR/1rAbzkovhkdRzOKFOz/6Lyar651g9ecZc89aww=;
 b=SOGGbMS3kNCUStQKE6g24B/Hg2IUPTUDkzGK6UG62hRkIhiJL53wcUvaJXozGCBg/w2iBV
 V7k+pwtq9GhJfexFWgWYsEjSgh1GH+O1TeWqTt1zkq36vzxlK67RspZEDrPBdZi1qQ+ODA
 gYtNdOnHlkRMfCt6tRFKS0gkG5KmnYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-dkxmx-gzPbCPowLYZXsV4Q-1; Mon, 20 Jan 2020 13:21:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C4731854335;
 Mon, 20 Jan 2020 18:21:53 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC4AE60BF7;
 Mon, 20 Jan 2020 18:21:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/i386: kvm: initialize microcode revision from KVM
Date: Mon, 20 Jan 2020 19:21:44 +0100
Message-Id: <1579544504-3616-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579544504-3616-1-git-send-email-pbonzini@redhat.com>
References: <1579544504-3616-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dkxmx-gzPbCPowLYZXsV4Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: vkuznets@redhat.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM can return the host microcode revision as a feature MSR.
Use it as the default value for -cpu host.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++++
 target/i386/kvm.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 05ce64c..1f731c1 100644
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
index f6dd6b7..26c1e78 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2696,6 +2696,11 @@ static void kvm_init_msrs(X86CPU *cpu)
                           env->features[FEAT_CORE_CAPABILITY]);
     }
=20
+    if (kvm_arch_get_supported_msr_feature(kvm_state,
+=09=09=09=09=09   MSR_IA32_UCODE_REV)) {
+        kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
+    }
+
     /*
      * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, bu=
t
      * all kernels with MSR features should have them.
--=20
1.8.3.1


