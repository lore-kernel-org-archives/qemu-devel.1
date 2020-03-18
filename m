Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDC6C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9898E20663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJKoVGPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9898E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENSL-00058U-QP
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLj-0004Tv-Ld
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLg-0002Lg-Rs
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLg-0002JN-MO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hhOfX8bgYV0VL7iu+967tvvfoSww6+QsiDTuUBu5Ebk=;
 b=EJKoVGPa30A78uwTiE74Re6RUOSnf9ZgXHaQyFkCKdkeRPHXeI711AbD+RO2FbcmPXbE5J
 5dpduGAc4npg9qx5xNJJkhjXsrtBGN7+a4i95cqcpHUMAYONUJcijGC765tWUYtEGpKsns
 VqxUZ8dPZg0aSE1kNpYqzG0TZqQwP3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-GHtJ3AZkNFyYz_UBzwy0SQ-1; Tue, 17 Mar 2020 21:18:01 -0400
X-MC-Unique: GHtJ3AZkNFyYz_UBzwy0SQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6C4B1005509;
 Wed, 18 Mar 2020 01:17:59 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B98093509;
 Wed, 18 Mar 2020 01:17:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/13] i386: Add 2nd Generation AMD EPYC processors
Date: Tue, 17 Mar 2020 21:17:39 -0400
Message-Id: <20200318011748.2104336-5-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Adds the support for 2nd Gen AMD EPYC Processors. The model display
name will be EPYC-Rome.

Adds the following new feature bits on top of the feature bits from the
first generation EPYC models.
perfctr-core : core performance counter extensions support. Enables the VM =
to
               use extended performance counter support. It enables six
               programmable counters instead of four counters.
clzero       : instruction zeroes out the 64 byte cache line specified in R=
AX.
xsaveerptr   : XSAVE, XSAVE, FXSAVEOPT, XSAVEC, XSAVES always save error
               pointers and FXRSTOR, XRSTOR, XRSTORS always restore error
               pointers.
wbnoinvd     : Write back and do not invalidate cache
ibpb         : Indirect Branch Prediction Barrier
amd-stibp    : Single Thread Indirect Branch Predictor
clwb         : Cache Line Write Back and Retain
xsaves       : XSAVES, XRSTORS and IA32_XSS support
rdpid        : Read Processor ID instruction support
umip         : User-Mode Instruction Prevention support

The  Reference documents are available at
https://developer.amd.com/wp-content/resources/55803_0.54-PUB.pdf
https://www.amd.com/system/files/TechDocs/24594.pdf

Depends on following kernel commits:
40bc47b08b6e ("kvm: x86: Enumerate support for CLZERO instruction")
504ce1954fba ("KVM: x86: Expose XSAVEERPTR to the guest")
6d61e3c32248 ("kvm: x86: Expose RDPID in KVM_GET_SUPPORTED_CPUID")
52297436199d ("kvm: svm: Update svm_xsaves_supported")

Signed-off-by: Babu Moger <babu.moger@amd.com>
Message-Id: <157314966312.23828.17684821666338093910.stgit@naples-babu.amd.=
com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 102 +++++++++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h |   2 +
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 54f42dcd25..350b51b346 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1133,7 +1133,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORD=
S] =3D {
             "clzero", NULL, "xsaveerptr", NULL,
             NULL, NULL, NULL, NULL,
             NULL, "wbnoinvd", NULL, NULL,
-            "ibpb", NULL, NULL, NULL,
+            "ibpb", NULL, NULL, "amd-stibp",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             "amd-ssbd", "virt-ssbd", "amd-no-ssb", NULL,
@@ -1798,6 +1798,56 @@ static CPUCaches epyc_cache_info =3D {
     },
 };
=20
+static CPUCaches epyc_rome_cache_info =3D {
+    .l1d_cache =3D &(CPUCacheInfo) {
+        .type =3D DATA_CACHE,
+        .level =3D 1,
+        .size =3D 32 * KiB,
+        .line_size =3D 64,
+        .associativity =3D 8,
+        .partitions =3D 1,
+        .sets =3D 64,
+        .lines_per_tag =3D 1,
+        .self_init =3D 1,
+        .no_invd_sharing =3D true,
+    },
+    .l1i_cache =3D &(CPUCacheInfo) {
+        .type =3D INSTRUCTION_CACHE,
+        .level =3D 1,
+        .size =3D 32 * KiB,
+        .line_size =3D 64,
+        .associativity =3D 8,
+        .partitions =3D 1,
+        .sets =3D 64,
+        .lines_per_tag =3D 1,
+        .self_init =3D 1,
+        .no_invd_sharing =3D true,
+    },
+    .l2_cache =3D &(CPUCacheInfo) {
+        .type =3D UNIFIED_CACHE,
+        .level =3D 2,
+        .size =3D 512 * KiB,
+        .line_size =3D 64,
+        .associativity =3D 8,
+        .partitions =3D 1,
+        .sets =3D 1024,
+        .lines_per_tag =3D 1,
+    },
+    .l3_cache =3D &(CPUCacheInfo) {
+        .type =3D UNIFIED_CACHE,
+        .level =3D 3,
+        .size =3D 16 * MiB,
+        .line_size =3D 64,
+        .associativity =3D 16,
+        .partitions =3D 1,
+        .sets =3D 16384,
+        .lines_per_tag =3D 1,
+        .self_init =3D true,
+        .inclusive =3D true,
+        .complex_indexing =3D true,
+    },
+};
+
 /* The following VMX features are not supported by KVM and are left out in=
 the
  * CPU definitions:
  *
@@ -4030,6 +4080,56 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
         .model_id =3D "Hygon Dhyana Processor",
         .cache_info =3D &epyc_cache_info,
     },
+    {
+        .name =3D "EPYC-Rome",
+        .level =3D 0xd,
+        .vendor =3D CPUID_VENDOR_AMD,
+        .family =3D 23,
+        .model =3D 49,
+        .stepping =3D 0,
+        .features[FEAT_1_EDX] =3D
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUS=
H |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =3D
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =3D
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =3D
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT | CPUID_EXT3_PERFCORE,
+        .features[FEAT_8000_0008_EBX] =3D
+            CPUID_8000_0008_EBX_CLZERO | CPUID_8000_0008_EBX_XSAVEERPTR |
+            CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_IBPB |
+            CPUID_8000_0008_EBX_STIBP,
+        .features[FEAT_7_0_EBX] =3D
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AV=
X2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED=
 |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSH=
OPT |
+            CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_CLWB,
+        .features[FEAT_7_0_ECX] =3D
+            CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_RDPID,
+        .features[FEAT_XSAVE] =3D
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_6_EAX] =3D
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =3D
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
+        .xlevel =3D 0x8000001E,
+        .model_id =3D "AMD EPYC-Rome Processor",
+        .cache_info =3D &epyc_rome_cache_info,
+    },
 };
=20
 /* KVM-specific features that are automatically added/removed
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 576f309bbf..68b186d258 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -792,6 +792,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_8000_0008_EBX_WBNOINVD    (1U << 9)
 /* Indirect Branch Prediction Barrier */
 #define CPUID_8000_0008_EBX_IBPB        (1U << 12)
+/* Single Thread Indirect Branch Predictors */
+#define CPUID_8000_0008_EBX_STIBP       (1U << 15)
=20
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
--=20
2.24.1


