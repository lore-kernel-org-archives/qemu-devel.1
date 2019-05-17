Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1742C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F8A21726
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F8A21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49431 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdpI-00034W-Ej
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:27:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiL-0005nO-L9
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hRdiK-0006IG-Iu
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hRdiK-0006HN-BD
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:20:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA844307D846;
	Fri, 17 May 2019 14:19:54 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E785E78578;
	Fri, 17 May 2019 14:19:52 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 16:19:24 +0200
Message-Id: <20190517141924.19024-10-vkuznets@redhat.com>
In-Reply-To: <20190517141924.19024-1-vkuznets@redhat.com>
References: <20190517141924.19024-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 17 May 2019 14:19:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 9/9] i386/kvm: add support for Direct Mode
 for Hyper-V synthetic timers
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

Hyper-V on KVM can only use Synthetic timers with Direct Mode (opting for
an interrupt instead of VMBus message). This new capability is only
announced in KVM_GET_SUPPORTED_HV_CPUID.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 docs/hyperv.txt            | 10 ++++++++++
 target/i386/cpu.c          |  2 ++
 target/i386/cpu.h          |  1 +
 target/i386/hyperv-proto.h |  1 +
 target/i386/kvm.c          |  9 +++++++++
 5 files changed, 23 insertions(+)

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
index beadb2d0d4..8fdf25c829 100644
--- a/docs/hyperv.txt
+++ b/docs/hyperv.txt
@@ -174,6 +174,16 @@ without the feature to find out if enabling it is be=
neficial.
=20
 Requires: hv-vapic
=20
+3.17. hv-stimer-direct
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Hyper-V specification allows synthetic timer operation in two modes: "cl=
assic",
+when expiration event is delivered as SynIC message and "direct", when t=
he event
+is delivered via normal interrupt. It is known that nested Hyper-V can o=
nly
+use synthetic timers in direct mode and thus 'hv-stimer-direct' needs to=
 be
+enabled.
+
+Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
+
=20
 4. Development features
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 063551ef55..3cfd85758c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5849,6 +5849,8 @@ static Property x86_cpu_properties[] =3D {
                       HYPERV_FEAT_EVMCS, 0),
     DEFINE_PROP_BIT64("hv-ipi", X86CPU, hyperv_features,
                       HYPERV_FEAT_IPI, 0),
+    DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
+                      HYPERV_FEAT_STIMER_DIRECT, 0),
     DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false=
),
=20
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1f1f8969b4..0b6b781ecb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -758,6 +758,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define HYPERV_FEAT_TLBFLUSH            11
 #define HYPERV_FEAT_EVMCS               12
 #define HYPERV_FEAT_IPI                 13
+#define HYPERV_FEAT_STIMER_DIRECT       14
=20
 #ifndef HYPERV_SPINLOCK_NEVER_RETRY
 #define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index c0272b3a01..cffac10b45 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -49,6 +49,7 @@
 #define HV_GUEST_IDLE_STATE_AVAILABLE           (1u << 5)
 #define HV_FREQUENCY_MSRS_AVAILABLE             (1u << 8)
 #define HV_GUEST_CRASH_MSR_AVAILABLE            (1u << 10)
+#define HV_STIMER_DIRECT_MODE_AVAILABLE         (1u << 19)
=20
 /*
  * HV_CPUID_ENLIGHTMENT_INFO.EAX bits
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 7ae2f63f72..fb29a3057b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -803,6 +803,14 @@ static struct {
         },
         .dependencies =3D BIT(HYPERV_FEAT_VPINDEX)
     },
+    [HYPERV_FEAT_STIMER_DIRECT] =3D {
+        .desc =3D "direct mode synthetic timers (hv-stimer-direct)",
+        .flags =3D {
+            {.fw =3D FEAT_HYPERV_EDX,
+             .bits =3D HV_STIMER_DIRECT_MODE_AVAILABLE}
+        },
+        .dependencies =3D BIT(HYPERV_FEAT_STIMER)
+    },
 };
=20
 static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
@@ -1125,6 +1133,7 @@ static int hyperv_handle_properties(CPUState *cs,
     r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TLBFLUSH);
     r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
     r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);
+    r |=3D hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER_DIRECT);
=20
     /* Additional dependencies not covered by kvm_hyperv_properties[] */
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
--=20
2.20.1


