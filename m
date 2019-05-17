Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48159C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6E6218C9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6E6218C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49347 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdk9-0006yF-Ay
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:21:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiD-0005io-10
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiB-00067I-OP
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:19:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hRdiB-00066S-Gv
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:19:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C7BF18DF7A;
	Fri, 17 May 2019 14:19:47 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA14C78578;
	Fri, 17 May 2019 14:19:43 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 16:19:21 +0200
Message-Id: <20190517141924.19024-7-vkuznets@redhat.com>
In-Reply-To: <20190517141924.19024-1-vkuznets@redhat.com>
References: <20190517141924.19024-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 17 May 2019 14:19:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 6/9] i386/kvm: hv-stimer requires hv-time
 and hv-synic
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Synthetic timers operate in hv-time time and Windows won't use these
without SynIC.

Add .dependencies field to kvm_hyperv_properties[] and a generic mechanis=
m
to check dependencies between features.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index e876dc6118..d8b83031a5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -690,6 +690,7 @@ static struct {
         uint32_t fw;
         uint32_t bits;
     } flags[2];
+    uint64_t dependencies;
 } kvm_hyperv_properties[] =3D {
     [HYPERV_FEAT_RELAXED] =3D {
         .desc =3D "relaxed timing (hv-relaxed)",
@@ -757,7 +758,8 @@ static struct {
         .flags =3D {
             {.fw =3D FEAT_HYPERV_EAX,
              .bits =3D HV_SYNTIMERS_AVAILABLE}
-        }
+        },
+        .dependencies =3D BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_TIME)
     },
     [HYPERV_FEAT_FREQUENCIES] =3D {
         .desc =3D "frequency MSRs (hv-frequencies)",
@@ -987,12 +989,25 @@ static int hv_cpuid_check_and_set(CPUState *cs, str=
uct kvm_cpuid2 *cpuid,
     X86CPU *cpu =3D X86_CPU(cs);
     CPUX86State *env =3D &cpu->env;
     uint32_t r, fw, bits;
-    int i;
+    uint64_t deps;
+    int i, dep_feat =3D 0;
=20
     if (!hyperv_feat_enabled(cpu, feature) && !cpu->hyperv_passthrough) =
{
         return 0;
     }
=20
+    deps =3D kvm_hyperv_properties[feature].dependencies;
+    while ((dep_feat =3D find_next_bit(&deps, 64, dep_feat)) < 64) {
+        if (!(hyperv_feat_enabled(cpu, dep_feat))) {
+                fprintf(stderr,
+                        "Hyper-V %s requires Hyper-V %s\n",
+                        kvm_hyperv_properties[feature].desc,
+                        kvm_hyperv_properties[dep_feat].desc);
+                return 1;
+        }
+        dep_feat++;
+    }
+
     for (i =3D 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); =
i++) {
         fw =3D kvm_hyperv_properties[feature].flags[i].fw;
         bits =3D kvm_hyperv_properties[feature].flags[i].bits;
@@ -1108,11 +1123,11 @@ static int hyperv_handle_properties(CPUState *cs,
     r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
     r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);
=20
-    /* Dependencies */
+    /* Additional dependencies not covered by kvm_hyperv_properties[] */
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
         !cpu->hyperv_synic_kvm_only &&
         !hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
-        fprintf(stderr, "Hyper-V %s requires %s\n",
+        fprintf(stderr, "Hyper-V %s requires Hyper-V %s\n",
                 kvm_hyperv_properties[HYPERV_FEAT_SYNIC].desc,
                 kvm_hyperv_properties[HYPERV_FEAT_VPINDEX].desc);
         r |=3D 1;
--=20
2.20.1


