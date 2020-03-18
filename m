Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD41C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E96C20663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCEN4Mvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E96C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENPX-0001PI-I1
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLg-0004QD-Ne
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLe-00024P-B9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29269)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLe-00021W-5x
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgCYaxcuR7r23GCYXzW2vstRGQBikD2Yxmp3zeSsAUI=;
 b=hCEN4MvcelRNN2tBxS79Lg4sX205wBwYkNe8hv4HWCs9VPEctvg5RL1jtGYLTTpaHzpBXt
 kSkRd+0xDcm0Pa4bGBA4UgnKVZ15SgI6pAJWcVEfhtIxJOA3y80kaGl2oaFQ4um1fxEBEb
 xKAKfI1QQNf/p5XGBm8UIsFDONh5n24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-yoJMSAO9Mzi2yBPx04yAbw-1; Tue, 17 Mar 2020 21:18:14 -0400
X-MC-Unique: yoJMSAO9Mzi2yBPx04yAbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54A13477;
 Wed, 18 Mar 2020 01:18:13 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36BA560BF3;
 Wed, 18 Mar 2020 01:18:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/13] hw/i386: Consolidate topology functions
Date: Tue, 17 Mar 2020 21:17:44 -0400
Message-Id: <20200318011748.2104336-10-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

Now that we have all the parameters in X86CPUTopoInfo, we can just
pass the structure to calculate the offsets and width.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <158396717953.58170.5628042059144117669.stgit@naples-babu.amd.c=
om>
---
 include/hw/i386/topology.h | 68 ++++++++++++-------------------------
 target/i386/cpu.c          | 23 ++++++-------
 tests/test-x86-cpuid.c     | 69 ++++++++++++++++++++++++--------------
 3 files changed, 75 insertions(+), 85 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 7ea507f376..ba52d49079 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -69,56 +69,42 @@ static unsigned apicid_bitwidth_for_count(unsigned coun=
t)
=20
 /* Bit width of the SMT_ID (thread ID) field on the APIC ID
  */
-static inline unsigned apicid_smt_width(unsigned nr_dies,
-                                        unsigned nr_cores,
-                                        unsigned nr_threads)
+static inline unsigned apicid_smt_width(X86CPUTopoInfo *topo_info)
 {
-    return apicid_bitwidth_for_count(nr_threads);
+    return apicid_bitwidth_for_count(topo_info->threads_per_core);
 }
=20
 /* Bit width of the Core_ID field
  */
-static inline unsigned apicid_core_width(unsigned nr_dies,
-                                         unsigned nr_cores,
-                                         unsigned nr_threads)
+static inline unsigned apicid_core_width(X86CPUTopoInfo *topo_info)
 {
-    return apicid_bitwidth_for_count(nr_cores);
+    return apicid_bitwidth_for_count(topo_info->cores_per_die);
 }
=20
 /* Bit width of the Die_ID field */
-static inline unsigned apicid_die_width(unsigned nr_dies,
-                                        unsigned nr_cores,
-                                        unsigned nr_threads)
+static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
 {
-    return apicid_bitwidth_for_count(nr_dies);
+    return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
 }
=20
 /* Bit offset of the Core_ID field
  */
-static inline unsigned apicid_core_offset(unsigned nr_dies,
-                                          unsigned nr_cores,
-                                          unsigned nr_threads)
+static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
 {
-    return apicid_smt_width(nr_dies, nr_cores, nr_threads);
+    return apicid_smt_width(topo_info);
 }
=20
 /* Bit offset of the Die_ID field */
-static inline unsigned apicid_die_offset(unsigned nr_dies,
-                                          unsigned nr_cores,
-                                           unsigned nr_threads)
+static inline unsigned apicid_die_offset(X86CPUTopoInfo *topo_info)
 {
-    return apicid_core_offset(nr_dies, nr_cores, nr_threads) +
-           apicid_core_width(nr_dies, nr_cores, nr_threads);
+    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
 }
=20
 /* Bit offset of the Pkg_ID (socket ID) field
  */
-static inline unsigned apicid_pkg_offset(unsigned nr_dies,
-                                         unsigned nr_cores,
-                                         unsigned nr_threads)
+static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
 {
-    return apicid_die_offset(nr_dies, nr_cores, nr_threads) +
-           apicid_die_width(nr_dies, nr_cores, nr_threads);
+    return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
=20
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
@@ -128,16 +114,9 @@ static inline unsigned apicid_pkg_offset(unsigned nr_d=
ies,
 static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
                                              const X86CPUTopoIDs *topo_ids=
)
 {
-    unsigned nr_dies =3D topo_info->dies_per_pkg;
-    unsigned nr_cores =3D topo_info->cores_per_die;
-    unsigned nr_threads =3D topo_info->threads_per_core;
-
-    return (topo_ids->pkg_id  <<
-               apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
-           (topo_ids->die_id  <<
-               apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
-           (topo_ids->core_id <<
-               apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
+    return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
+           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
+           (topo_ids->core_id << apicid_core_offset(topo_info)) |
            topo_ids->smt_id;
 }
=20
@@ -165,20 +144,15 @@ static inline void x86_topo_ids_from_apicid(apic_id_t=
 apicid,
                                             X86CPUTopoInfo *topo_info,
                                             X86CPUTopoIDs *topo_ids)
 {
-    unsigned nr_dies =3D topo_info->dies_per_pkg;
-    unsigned nr_cores =3D topo_info->cores_per_die;
-    unsigned nr_threads =3D topo_info->threads_per_core;
-
     topo_ids->smt_id =3D apicid &
-            ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threa=
ds));
+            ~(0xFFFFFFFFUL << apicid_smt_width(topo_info));
     topo_ids->core_id =3D
-            (apicid >> apicid_core_offset(nr_dies, nr_cores, nr_threads)) =
&
-            ~(0xFFFFFFFFUL << apicid_core_width(nr_dies, nr_cores, nr_thre=
ads));
+            (apicid >> apicid_core_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
     topo_ids->die_id =3D
-            (apicid >> apicid_die_offset(nr_dies, nr_cores, nr_threads)) &
-            ~(0xFFFFFFFFUL << apicid_die_width(nr_dies, nr_cores, nr_threa=
ds));
-    topo_ids->pkg_id =3D
-            apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
+            (apicid >> apicid_die_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
+    topo_ids->pkg_id =3D apicid >> apicid_pkg_offset(topo_info);
 }
=20
 /* Make APIC ID for the CPU 'cpu_index'
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fb3f3c54bb..f1ac572efd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5497,6 +5497,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,=
 uint32_t count,
     uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
+    X86CPUTopoInfo topo_info;
+
+    topo_info.dies_per_pkg =3D env->nr_dies;
+    topo_info.cores_per_die =3D cs->nr_cores;
+    topo_info.threads_per_core =3D cs->nr_threads;
=20
     /* Calculate & apply limits for different index ranges */
     if (index >=3D 0xC0000000) {
@@ -5583,8 +5588,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
uint32_t count,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
-                die_offset =3D apicid_die_offset(env->nr_dies,
-                                        cs->nr_cores, cs->nr_threads);
+                die_offset =3D apicid_die_offset(&topo_info);
                 if (cpu->enable_l3_cache) {
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
                                         (1 << die_offset), cs->nr_cores,
@@ -5675,14 +5679,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
=20
         switch (count) {
         case 0:
-            *eax =3D apicid_core_offset(env->nr_dies,
-                                      cs->nr_cores, cs->nr_threads);
+            *eax =3D apicid_core_offset(&topo_info);
             *ebx =3D cs->nr_threads;
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax =3D apicid_pkg_offset(env->nr_dies,
-                                     cs->nr_cores, cs->nr_threads);
+            *eax =3D apicid_pkg_offset(&topo_info);
             *ebx =3D cs->nr_cores * cs->nr_threads;
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -5706,20 +5708,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
         *edx =3D cpu->apic_id;
         switch (count) {
         case 0:
-            *eax =3D apicid_core_offset(env->nr_dies, cs->nr_cores,
-                                                    cs->nr_threads);
+            *eax =3D apicid_core_offset(&topo_info);
             *ebx =3D cs->nr_threads;
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax =3D apicid_die_offset(env->nr_dies, cs->nr_cores,
-                                                   cs->nr_threads);
+            *eax =3D apicid_die_offset(&topo_info);
             *ebx =3D cs->nr_cores * cs->nr_threads;
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax =3D apicid_pkg_offset(env->nr_dies, cs->nr_cores,
-                                                   cs->nr_threads);
+            *eax =3D apicid_pkg_offset(&topo_info);
             *ebx =3D env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_DIE;
             break;
diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index 66b953113b..bfabc0403a 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -31,9 +31,10 @@ static void test_topo_bits(void)
     X86CPUTopoInfo topo_info =3D {0};
=20
     /* simple tests for 1 thread per core, 1 core per die, 1 die per packa=
ge */
-    g_assert_cmpuint(apicid_smt_width(1, 1, 1), =3D=3D, 0);
-    g_assert_cmpuint(apicid_core_width(1, 1, 1), =3D=3D, 0);
-    g_assert_cmpuint(apicid_die_width(1, 1, 1), =3D=3D, 0);
+    topo_info =3D (X86CPUTopoInfo) {1, 1, 1};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 0);
+    g_assert_cmpuint(apicid_core_width(&topo_info), =3D=3D, 0);
+    g_assert_cmpuint(apicid_die_width(&topo_info), =3D=3D, 0);
=20
     topo_info =3D (X86CPUTopoInfo) {1, 1, 1};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), =3D=3D, 0);
@@ -44,35 +45,51 @@ static void test_topo_bits(void)
=20
     /* Test field width calculation for multiple values
      */
-    g_assert_cmpuint(apicid_smt_width(1, 1, 2), =3D=3D, 1);
-    g_assert_cmpuint(apicid_smt_width(1, 1, 3), =3D=3D, 2);
-    g_assert_cmpuint(apicid_smt_width(1, 1, 4), =3D=3D, 2);
-
-    g_assert_cmpuint(apicid_smt_width(1, 1, 14), =3D=3D, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 1, 15), =3D=3D, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 1, 16), =3D=3D, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 1, 17), =3D=3D, 5);
-
-
-    g_assert_cmpuint(apicid_core_width(1, 30, 2), =3D=3D, 5);
-    g_assert_cmpuint(apicid_core_width(1, 31, 2), =3D=3D, 5);
-    g_assert_cmpuint(apicid_core_width(1, 32, 2), =3D=3D, 5);
-    g_assert_cmpuint(apicid_core_width(1, 33, 2), =3D=3D, 6);
-
-    g_assert_cmpuint(apicid_die_width(1, 30, 2), =3D=3D, 0);
-    g_assert_cmpuint(apicid_die_width(2, 30, 2), =3D=3D, 1);
-    g_assert_cmpuint(apicid_die_width(3, 30, 2), =3D=3D, 2);
-    g_assert_cmpuint(apicid_die_width(4, 30, 2), =3D=3D, 2);
+    topo_info =3D (X86CPUTopoInfo) {1, 1, 2};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 1);
+    topo_info =3D (X86CPUTopoInfo) {1, 1, 3};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 2);
+    topo_info =3D (X86CPUTopoInfo) {1, 1, 4};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 2);
+
+    topo_info =3D (X86CPUTopoInfo) {1, 1, 14};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 4);
+    topo_info =3D (X86CPUTopoInfo) {1, 1, 15};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 4);
+    topo_info =3D (X86CPUTopoInfo) {1, 1, 16};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 4);
+    topo_info =3D (X86CPUTopoInfo) {1, 1, 17};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 5);
+
+
+    topo_info =3D (X86CPUTopoInfo) {1, 30, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), =3D=3D, 5);
+    topo_info =3D (X86CPUTopoInfo) {1, 31, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), =3D=3D, 5);
+    topo_info =3D (X86CPUTopoInfo) {1, 32, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), =3D=3D, 5);
+    topo_info =3D (X86CPUTopoInfo) {1, 33, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), =3D=3D, 6);
+
+    topo_info =3D (X86CPUTopoInfo) {1, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), =3D=3D, 0);
+    topo_info =3D (X86CPUTopoInfo) {2, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), =3D=3D, 1);
+    topo_info =3D (X86CPUTopoInfo) {3, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), =3D=3D, 2);
+    topo_info =3D (X86CPUTopoInfo) {4, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), =3D=3D, 2);
=20
     /* build a weird topology and see if IDs are calculated correctly
      */
=20
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    g_assert_cmpuint(apicid_smt_width(1, 6, 3), =3D=3D, 2);
-    g_assert_cmpuint(apicid_core_offset(1, 6, 3), =3D=3D, 2);
-    g_assert_cmpuint(apicid_die_offset(1, 6, 3), =3D=3D, 5);
-    g_assert_cmpuint(apicid_pkg_offset(1, 6, 3), =3D=3D, 5);
+    topo_info =3D (X86CPUTopoInfo) {1, 6, 3};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), =3D=3D, 2);
+    g_assert_cmpuint(apicid_core_offset(&topo_info), =3D=3D, 2);
+    g_assert_cmpuint(apicid_die_offset(&topo_info), =3D=3D, 5);
+    g_assert_cmpuint(apicid_pkg_offset(&topo_info), =3D=3D, 5);
=20
     topo_info =3D (X86CPUTopoInfo) {1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), =3D=3D, 0);
--=20
2.24.1


