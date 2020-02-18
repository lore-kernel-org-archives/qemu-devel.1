Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DBAC3403D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD09208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U71jTdXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD09208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j448W-0005PD-DZ
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1j447s-0004kh-BT
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1j447q-00028I-QI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:45:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1j447q-00027q-M5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582037125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SIt7IVA/IaNTX1LTHUGaMRWSTb1qsasGNgHzug3FDbQ=;
 b=U71jTdXXo2YaWIBTui4KPQvOJ9VvgkLCRDGogLSb/zZOKN+8hVHhn95YHyPlyfXu1oz03v
 UnvVDEzsvMVZ7mTPQhjdRMXAQ+JSGP4vlAKWUPWQP4mIVBTsurbyR/oKEGYBHf6gk0kD4j
 SYNXiKhqTsDXNUTTZSsINn5mEiowhko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-7kHA0MCaPUq4umLiaLW0yg-1; Tue, 18 Feb 2020 09:44:19 -0500
Received: by mail-wm1-f71.google.com with SMTP id t17so147177wmi.7
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 06:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fhZ0I3YWrEhOWa29fWSP+eeinOmrWp9ss357sd3bjMY=;
 b=YyGf5LZXaWrTcwlVQ1N3qHOXGNpzVHXNm6j0U2gLSDVJaiSKz433NhjY6IlzFn2xaz
 nmCXFXMyHBx6YPRTQwRGAOWnvuevW22SypZDKybxmVMfFY17TEN74UBCsJVpimRr4682
 v0bz+23HFQNUnggyHpbKPSkApiwcQamjNBGUpCPoCzuZjt2j9m4F2u4ZcG7yVzjNlrnd
 lK06CewcAsYPojpOB8Rr0olvTGS7JAT4uvc7z8bQeKYW9ot33t+0W3lx5mwpYf7BqrrH
 UIZbI2ME7bee1oCBsXSngxVvRH+fTaAJhnve01JXpo7o9Q3Dg26nzLJtDphFPP2B5kws
 E0/g==
X-Gm-Message-State: APjAAAUgfQVAUBL2TqQwiskH3QsEkwMtQ4EyUEguI/YLKmUdRPXElljB
 MciWMcn6bH5zwUhj2puy6umtgAk4jANPXeIXy7jAtFpYSjSkPW3Ocf9oKyK0ZwdRkLPpDxW1Fpj
 mXsHBCg6HyFYgWQg=
X-Received: by 2002:a1c:7717:: with SMTP id t23mr3688913wmi.17.1582037058139; 
 Tue, 18 Feb 2020 06:44:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqyat2sqLbmEAil4KU1aSm4DesjlvwfePK23mCqjFAU6F67Sm42Y9pWvOTl46vSBYIORUf+A==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr3688887wmi.17.1582037057826; 
 Tue, 18 Feb 2020 06:44:17 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id l15sm6201826wrv.39.2020.02.18.06.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 06:44:17 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC] target/i386: filter out VMX_PIN_BASED_POSTED_INTR when
 enabling SynIC
Date: Tue, 18 Feb 2020 15:44:15 +0100
Message-Id: <20200218144415.94722-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-MC-Unique: 7kHA0MCaPUq4umLiaLW0yg-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Liran Alon <liran.alon@oracle.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a multi-vCPU guest is created with hv_synic, secondary vCPUs fail
to initialize with

qemu-system-x86_64: error: failed to set MSR 0x48d to 0xff00000016

This is caused by SynIC enablement on the boot CPU: when we do this
KVM disables apicv for the whole guest so we can't set
VMX_PIN_BASED_POSTED_INTR bit in MSR_IA32_VMX_TRUE_PINBASED_CTLS anymore.
(see nested_vmx_setup_ctls_msrs() in KVM).

This used to work before fine-grained VMX feature enablement because
we were not setting VMX MSRs.

Fix the issue by filtering out VMX_PIN_BASED_POSTED_INTR when enabling
SynIC. We also need to re-order kvm_init_msrs() with hyperv_init_vcpu()
so filtering on secondary CPUs happens before.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
RFC: This is somewhat similar to eVMCS breakage and it is likely possible
to fix this in KVM. I decided to try QEMU first as this is a single
control and unlike eVMCS we don't need to keep a list of things to disable.
---
 target/i386/kvm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 69eb43d796e6..6829b597fdbf 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1366,6 +1366,7 @@ static Error *hv_no_nonarch_cs_mig_blocker;
 static int hyperv_init_vcpu(X86CPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
+    CPUX86State *env =3D &cpu->env;
     Error *local_err =3D NULL;
     int ret;
=20
@@ -1431,6 +1432,9 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             return ret;
         }
=20
+        /* When SynIC is enabled, APICv controls become unavailable */
+        env->features[FEAT_VMX_PINBASED_CTLS] &=3D ~VMX_PIN_BASED_POSTED_I=
NTR;
+
         if (!cpu->hyperv_synic_kvm_only) {
             ret =3D hyperv_x86_synic_add(cpu);
             if (ret < 0) {
@@ -1845,13 +1849,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_tsc_aux =3D false;
     }
=20
-    kvm_init_msrs(cpu);
-
     r =3D hyperv_init_vcpu(cpu);
     if (r) {
         goto fail;
     }
=20
+    kvm_init_msrs(cpu);
+
     return 0;
=20
  fail:
--=20
2.24.1


