Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8C2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1E220663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTG6E1lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1E220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENMr-0005jI-Tx
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLQ-00040I-Qx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLP-0000zz-KP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLP-0000yJ-Fb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNkB6gdZNo2jzcrcDf6k9nZn60z3vJ1C/KO3xYtIHdQ=;
 b=FTG6E1lU71Y5DH+E8nllHPgbNld8l1jCjeC2ujXfOPqEzH2uWZZyWMzxuKIKTifPLparUA
 CyqXWuBGEsoNaJchLjVsoU/76WMVq7oLG5545Q+hUOdI0Ydis4EG6n4I8Q6SSHK9sOIX11
 r26m2Vfs7IPJy0mwUhf1FpPUAcDwZrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-gK5R7Wh1M5KG5IVzAUPgeg-1; Tue, 17 Mar 2020 21:17:58 -0400
X-MC-Unique: gK5R7Wh1M5KG5IVzAUPgeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5E15800D50;
 Wed, 18 Mar 2020 01:17:57 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A48B5D9E5;
 Wed, 18 Mar 2020 01:17:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/13] i386: Add missing cpu feature bits in EPYC model
Date: Tue, 17 Mar 2020 21:17:38 -0400
Message-Id: <20200318011748.2104336-4-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Moger, Babu" <Babu.Moger@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Moger, Babu" <Babu.Moger@amd.com>

Adds the following missing CPUID bits:
perfctr-core : core performance counter extensions support. Enables the VM
               to use extended performance counter support. It enables six
               programmable counters instead of 4 counters.
clzero       : instruction zeroes out the 64 byte cache line specified in R=
AX.
xsaveerptr   : XSAVE, XSAVE, FXSAVEOPT, XSAVEC, XSAVES always save error
               pointers and FXRSTOR, XRSTOR, XRSTORS always restore error
               pointers.
ibpb         : Indirect Branch Prediction Barrie.
xsaves       : XSAVES, XRSTORS and IA32_XSS supported.

Depends on following kernel commits:
40bc47b08b6e ("kvm: x86: Enumerate support for CLZERO instruction")
504ce1954fba ("KVM: x86: Expose XSAVEERPTR to the guest")
52297436199d ("kvm: svm: Update svm_xsaves_supported")

These new features will be added in EPYC-v3. The -cpu help output after the=
 change.
x86 EPYC-v1               AMD EPYC Processor
x86 EPYC-v2               AMD EPYC Processor (with IBPB)
x86 EPYC-v3               AMD EPYC Processor

Signed-off-by: Babu Moger <babu.moger@amd.com>
Message-Id: <157314965662.23828.3063243729449408327.stgit@naples-babu.amd.c=
om>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dc78494167..54f42dcd25 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3942,10 +3942,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED=
 |
             CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSH=
OPT |
             CPUID_7_0_EBX_SHA_NI,
-        /* Missing: XSAVES (not supported by some Linux versions,
-         * including v4.1 to v4.12).
-         * KVM doesn't yet expose any XSAVES state save component.
-         */
         .features[FEAT_XSAVE] =3D
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1,
@@ -3968,6 +3964,19 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
                     { /* end of list */ }
                 }
             },
+            {
+                .version =3D 3,
+                .props =3D (PropValue[]) {
+                    { "ibpb", "on" },
+                    { "perfctr-core", "on" },
+                    { "clzero", "on" },
+                    { "xsaveerptr", "on" },
+                    { "xsaves", "on" },
+                    { "model-id",
+                      "AMD EPYC Processor" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
--=20
2.24.1


