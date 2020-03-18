Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE4C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A908120663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i26Ea9Ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A908120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENUg-0007Yu-IK
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLs-0004c7-Bw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLq-000342-Ox
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLq-000315-2r
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Di2bKwmkhcLLcha49rb/0iGLRVyTDpUbFOqJuBsw3Q=;
 b=i26Ea9EfERCEPzBUJU7HqmBijvu5B5NOejEAMXNU/IG6dw3Yq9zJI+15zxMxDzNWa5fbW1
 pblf9F4fkRGoeij5s7Gi3/Ks59fKsVVHwnp64wy705LL/26rAnl1j3r3kNZaPClGRS9Lrp
 x6xCB28Gzgr0ILop7nXT9g2sGpxVzYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-c5vFYE3UMxGiuItKiUPyRg-1; Tue, 17 Mar 2020 21:18:27 -0400
X-MC-Unique: c5vFYE3UMxGiuItKiUPyRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F8FE8017CC;
 Wed, 18 Mar 2020 01:18:26 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD6F05D9E5;
 Wed, 18 Mar 2020 01:18:23 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/13] hw/i386: Update structures to save the number of nodes
 per package
Date: Tue, 17 Mar 2020 21:17:47 -0400
Message-Id: <20200318011748.2104336-13-ehabkost@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Babu Moger <babu.moger@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

Update structures X86CPUTopoIDs and CPUX86State to hold the number of
nodes per package. This is required to build EPYC mode topology.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <158396720035.58170.1973738805301006456.stgit@naples-babu.amd.c=
om>
---
 hw/i386/pc.c               |  1 +
 hw/i386/x86.c              |  1 +
 include/hw/i386/topology.h |  1 +
 target/i386/cpu.c          |  1 +
 target/i386/cpu.h          |  1 +
 tests/test-x86-cpuid.c     | 40 +++++++++++++++++++-------------------
 6 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05e7f1090f..ee89fcd1c3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1525,6 +1525,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_d=
ev,
     init_topo_info(&topo_info, x86ms);
=20
     env->nr_dies =3D x86ms->smp_dies;
+    env->nr_nodes =3D topo_info.nodes_per_pkg;
=20
     /*
      * If APIC ID is not set,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 41b884605f..87b73fe33c 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -62,6 +62,7 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
 {
     MachineState *ms =3D MACHINE(x86ms);
=20
+    topo_info->nodes_per_pkg =3D ms->numa_state->num_nodes / ms->smp.socke=
ts;
     topo_info->dies_per_pkg =3D x86ms->smp_dies;
     topo_info->cores_per_die =3D ms->smp.cores;
     topo_info->threads_per_core =3D ms->smp.threads;
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index ba52d49079..04f01e2a09 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -53,6 +53,7 @@ typedef struct X86CPUTopoIDs {
 } X86CPUTopoIDs;
=20
 typedef struct X86CPUTopoInfo {
+    unsigned nodes_per_pkg;
     unsigned dies_per_pkg;
     unsigned cores_per_die;
     unsigned threads_per_core;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f1ac572efd..34b511f078 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6957,6 +6957,7 @@ static void x86_cpu_initfn(Object *obj)
     FeatureWord w;
=20
     env->nr_dies =3D 1;
+    env->nr_nodes =3D 1;
     cpu_set_cpustate_pointers(cpu);
=20
     object_property_add(obj, "family", "int",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 68b186d258..7e9e963d78 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1609,6 +1609,7 @@ typedef struct CPUX86State {
     TPRAccess tpr_access_type;
=20
     unsigned nr_dies;
+    unsigned nr_nodes;
 } CPUX86State;
=20
 struct kvm_msrs;
diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index bfabc0403a..049030a50e 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -31,12 +31,12 @@ static void test_topo_bits(void)
     X86CPUTopoInfo topo_info =3D {0};
=20
     /* simple tests for 1 thread per core, 1 core per die, 1 die per packa=
ge */
-    topo_info =3D (X86CPUTopoInfo) {1, 1, 1};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 1, 1};
     g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 0);
     g_assert_cmpuint(apicid_core_width(&topo_info), =3D=3D, 0);
     g_assert_cmpuint(apicid_die_width(&topo_info), =3D=3D, 0);
=20
-    topo_info =3D (X86CPUTopoInfo) {1, 1, 1};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 1, 1};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), =3D=3D, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), =3D=3D, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), =3D=3D, 2);
@@ -45,39 +45,39 @@ static void test_topo_bits(void)
=20
     /* Test field width calculation for multiple values
      */
-    topo_info =3D (X86CPUTopoInfo) {1, 1, 2};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 1, 2};
     g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 1);
-    topo_info =3D (X86CPUTopoInfo) {1, 1, 3};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 1, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 2);
-    topo_info =3D (X86CPUTopoInfo) {1, 1, 4};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 1, 4};
     g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 2);
=20
-    topo_info =3D (X86CPUTopoInfo) {1, 1, 14};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 1, 14};
     g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 4);
-    topo_info =3D (X86CPUTopoInfo) {1, 1, 15};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 1, 15};
     g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 4);
-    topo_info =3D (X86CPUTopoInfo) {1, 1, 16};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 1, 16};
     g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 4);
-    topo_info =3D (X86CPUTopoInfo) {1, 1, 17};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 1, 17};
     g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 5);
=20
=20
-    topo_info =3D (X86CPUTopoInfo) {1, 30, 2};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 30, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), =3D=3D, 5);
-    topo_info =3D (X86CPUTopoInfo) {1, 31, 2};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 31, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), =3D=3D, 5);
-    topo_info =3D (X86CPUTopoInfo) {1, 32, 2};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 32, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), =3D=3D, 5);
-    topo_info =3D (X86CPUTopoInfo) {1, 33, 2};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 33, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), =3D=3D, 6);
=20
-    topo_info =3D (X86CPUTopoInfo) {1, 30, 2};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), =3D=3D, 0);
-    topo_info =3D (X86CPUTopoInfo) {2, 30, 2};
+    topo_info =3D (X86CPUTopoInfo) {0, 2, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), =3D=3D, 1);
-    topo_info =3D (X86CPUTopoInfo) {3, 30, 2};
+    topo_info =3D (X86CPUTopoInfo) {0, 3, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), =3D=3D, 2);
-    topo_info =3D (X86CPUTopoInfo) {4, 30, 2};
+    topo_info =3D (X86CPUTopoInfo) {0, 4, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), =3D=3D, 2);
=20
     /* build a weird topology and see if IDs are calculated correctly
@@ -85,18 +85,18 @@ static void test_topo_bits(void)
=20
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    topo_info =3D (X86CPUTopoInfo) {1, 6, 3};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 6, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 2);
     g_assert_cmpuint(apicid_core_offset(&topo_info), =3D=3D, 2);
     g_assert_cmpuint(apicid_die_offset(&topo_info), =3D=3D, 5);
     g_assert_cmpuint(apicid_pkg_offset(&topo_info), =3D=3D, 5);
=20
-    topo_info =3D (X86CPUTopoInfo) {1, 6, 3};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), =3D=3D, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), =3D=3D, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), =3D=3D, 2);
=20
-    topo_info =3D (X86CPUTopoInfo) {1, 6, 3};
+    topo_info =3D (X86CPUTopoInfo) {0, 1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), =3D=
=3D,
                      (1 << 2) | 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), =3D=
=3D,
--=20
2.24.1


