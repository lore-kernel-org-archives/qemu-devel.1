Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DA8C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF742147A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF742147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjWrQ-0004Vc-IL
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 18:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjWVG-0008FO-Do
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjWVF-0003q5-8F
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:16:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjWVE-0003pf-Go
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:16:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C697368E3;
 Fri,  5 Jul 2019 22:16:23 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2805189E3;
 Fri,  5 Jul 2019 22:16:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Fri,  5 Jul 2019 19:14:54 -0300
Message-Id: <20190705221504.25166-33-ehabkost@redhat.com>
In-Reply-To: <20190705221504.25166-1-ehabkost@redhat.com>
References: <20190705221504.25166-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 05 Jul 2019 22:16:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v6 32/42] i386: Add x-force-features option for
 testing
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

Add a new option that can be used to disable feature flag
filtering.  This will allow CPU model compatibility test cases to
work without host hardware dependencies.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190628002844.24894-3-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 6 ++++++
 target/i386/cpu.c | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0a96c78669..4727226a6a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1417,6 +1417,12 @@ struct X86CPU {
=20
     bool check_cpuid;
     bool enforce_cpuid;
+    /*
+     * Force features to be enabled even if the host doesn't support the=
m.
+     * This is dangerous and should be done only for testing CPUID
+     * compatibility.
+     */
+    bool force_features;
     bool expose_kvm;
     bool expose_tcg;
     bool migratable;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 62043fee54..8852b57c0b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5250,8 +5250,11 @@ static int x86_cpu_filter_features(X86CPU *cpu)
         uint32_t host_feat =3D
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features =3D env->features[w];
-        env->features[w] &=3D host_feat;
-        cpu->filtered_features[w] =3D requested_features & ~env->feature=
s[w];
+        uint32_t available_features =3D requested_features & host_feat;
+        if (!cpu->force_features) {
+            env->features[w] =3D available_features;
+        }
+        cpu->filtered_features[w] =3D requested_features & ~available_fe=
atures;
         if (cpu->filtered_features[w]) {
             rv =3D 1;
         }
@@ -5980,6 +5983,7 @@ static Property x86_cpu_properties[] =3D {
=20
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
+    DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
     DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
--=20
2.18.0.rc1.1.g3f1ff2140


