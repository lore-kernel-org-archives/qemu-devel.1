Received: from eggs.gnu.org ([2001:4830:134:3::10]:41790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eboYY-0004jz-VT
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eboYR-0003fC-IE
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:19:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eboYR-0003d6-8w
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:19:03 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0HEIsbE092859
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 09:19:00 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fj7yx8nr9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 09:18:59 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 17 Jan 2018 14:18:54 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 17 Jan 2018 15:18:49 +0100
In-Reply-To: <20180117141849.65757-1-borntraeger@de.ibm.com>
References: <20180117141849.65757-1-borntraeger@de.ibm.com>
Message-Id: <20180117141849.65757-4-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 3/3] s390x/cpumodel: fix transparency for
 non-hyp STFL features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Before cpu-models were introduced to QEMU with 2.8 the so called
non-hypervisor-managed STFL facilities (aka transparent facilities) were
handled transparently.

With the advent cpu models, for host model (means -cpu host), we started
fencing these of using the identified full model. The full models however
did not include all non-hypervisor-managed facilities, thus we end up
fencing some of these off.

New (non-hypervisor managed) facilities can be introduced with hardware
or firmware upgrades. Requiring a code change and thus a QEMU upgrade to
leverage such facilities is not acceptable. Namely the semantic of the host
model is 'give me all you can'.

Let us add non-hypervisor managed STFL facility bits to QEMU and to all
the full models. For now first two doublewords should be sufficient.

With this, when using host model, transparent facilities are presented to
the guest. Regarding default (and base)  models however, nothing really
changes, except that user can specify any non-hypervisor facility now.

Thus the so called transparent facilities, aren't handled transparently
with the default nor with the base models (because of migration
considerations).  For example -cpu z13 will not enable (and mandate) any
of the features added with this change for any compat machine types.

Emerging non-hypervisor managed facilities that are expected to be
present in any sane environment (in the context of the machine type)
should be added to the default model (for non-compat machine types).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_features.c     |  54 +++++++++++++++++++++
 target/s390x/cpu_features_def.h |  54 +++++++++++++++++++++
 target/s390x/gen-features.c     | 103 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 5d1c210..407864a 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -51,6 +51,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("parseh", S390_FEAT_TYPE_STFL, 26, "Parsing-enhancement facility"),
     FEAT_INIT("mvcos", S390_FEAT_TYPE_STFL, 27, "Move-with-optional-specification facility"),
     FEAT_INIT("tods-base", S390_FEAT_TYPE_STFL, 28, "TOD-clock-steering facility (excluding subfunctions)"),
+    FEAT_INIT("stfle29", S390_FEAT_TYPE_STFL, 29, "Facility that is provided by STFLE facility 29"),
     FEAT_INIT("etf3eh", S390_FEAT_TYPE_STFL, 30, "ETF3-enhancement facility"),
     FEAT_INIT("ectg", S390_FEAT_TYPE_STFL, 31, "Extract-CPU-time facility"),
     FEAT_INIT("csst", S390_FEAT_TYPE_STFL, 32, "Compare-and-swap-and-store facility"),
@@ -60,12 +61,14 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("emon", S390_FEAT_TYPE_STFL, 36, "Enhanced-monitor facility"),
     FEAT_INIT("fpe", S390_FEAT_TYPE_STFL, 37, "Floating-point extension facility"),
     FEAT_INIT("opc", S390_FEAT_TYPE_STFL, 38, "Order Preserving Compression facility"),
+    FEAT_INIT("stfle39", S390_FEAT_TYPE_STFL, 39, "Facility that is provided by STFLE facility 39"),
     FEAT_INIT("sprogp", S390_FEAT_TYPE_STFL, 40, "Set-program-parameters facility"),
     FEAT_INIT("fpseh", S390_FEAT_TYPE_STFL, 41, "Floating-point-support-enhancement facilities"),
     FEAT_INIT("dfp", S390_FEAT_TYPE_STFL, 42, "DFP (decimal-floating-point) facility"),
     FEAT_INIT("dfphp", S390_FEAT_TYPE_STFL, 43, "DFP (decimal-floating-point) facility has high performance"),
     FEAT_INIT("pfpo", S390_FEAT_TYPE_STFL, 44, "PFPO instruction"),
     FEAT_INIT("stfle45", S390_FEAT_TYPE_STFL, 45, "Various facilities introduced with z196"),
+    FEAT_INIT("stfle46", S390_FEAT_TYPE_STFL, 46, "Facility that is provided by STFLE facility 46"),
     FEAT_INIT("cmpsceh", S390_FEAT_TYPE_STFL, 47, "CMPSC-enhancement facility"),
     FEAT_INIT("dfpzc", S390_FEAT_TYPE_STFL, 48, "Decimal-floating-point zoned-conversion facility"),
     FEAT_INIT("stfle49", S390_FEAT_TYPE_STFL, 49, "Various facilities introduced with zEC12"),
@@ -74,10 +77,15 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("iacc2", S390_FEAT_TYPE_STFL, 52, "Interlocked-access facility 2"),
     FEAT_INIT("stfle53", S390_FEAT_TYPE_STFL, 53, "Various facilities introduced with z13"),
     FEAT_INIT("eec", S390_FEAT_TYPE_STFL, 54, "Entropy encoding compression facility"),
+    FEAT_INIT("stfle55", S390_FEAT_TYPE_STFL, 55, "Facility that is provided by STFLE facility 55"),
+    FEAT_INIT("stfle56", S390_FEAT_TYPE_STFL, 56, "Facility that is provided by STFLE facility 56"),
     FEAT_INIT("msa5-base", S390_FEAT_TYPE_STFL, 57, "Message-security-assist-extension-5 facility (excluding subfunctions)"),
     FEAT_INIT("minste2", S390_FEAT_TYPE_STFL, 58, "Miscellaneous-instruction-extensions facility 2"),
     FEAT_INIT("sema", S390_FEAT_TYPE_STFL, 59, "Semaphore-assist facility"),
     FEAT_INIT("tsi", S390_FEAT_TYPE_STFL, 60, "Time-slice Instrumentation facility"),
+    FEAT_INIT("stfle61", S390_FEAT_TYPE_STFL, 61, "Facility that is provided by STFLE facility 61"),
+    FEAT_INIT("stfle62", S390_FEAT_TYPE_STFL, 62, "Facility that is provided by STFLE facility 62"),
+    FEAT_INIT("stfle63", S390_FEAT_TYPE_STFL, 63, "Facility that is provided by STFLE facility 63"),
     FEAT_INIT("ri", S390_FEAT_TYPE_STFL, 64, "CPU runtime-instrumentation facility"),
     FEAT_INIT("zpci", S390_FEAT_TYPE_STFL, 69, "z/PCI facility"),
     FEAT_INIT("aen", S390_FEAT_TYPE_STFL, 71, "General-purpose-adapter-event-notification facility"),
@@ -89,7 +97,53 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security-assist-extension-4 facility (excluding subfunctions)"),
     FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2"),
     FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
+    FEAT_INIT("stfle81", S390_FEAT_TYPE_STFL, 81, "Facility that is provided by STFLE facility 81"),
     FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch Prediction Blocking"),
+    FEAT_INIT("stfle83", S390_FEAT_TYPE_STFL, 83, "Facility that is provided by STFLE facility 83"),
+    FEAT_INIT("stfle84", S390_FEAT_TYPE_STFL, 84, "Facility that is provided by STFLE facility 84"),
+    FEAT_INIT("stfle85", S390_FEAT_TYPE_STFL, 85, "Facility that is provided by STFLE facility 85"),
+    FEAT_INIT("stfle86", S390_FEAT_TYPE_STFL, 86, "Facility that is provided by STFLE facility 86"),
+    FEAT_INIT("stfle87", S390_FEAT_TYPE_STFL, 87, "Facility that is provided by STFLE facility 87"),
+    FEAT_INIT("stfle88", S390_FEAT_TYPE_STFL, 88, "Facility that is provided by STFLE facility 88"),
+    FEAT_INIT("stfle89", S390_FEAT_TYPE_STFL, 89, "Facility that is provided by STFLE facility 89"),
+    FEAT_INIT("stfle90", S390_FEAT_TYPE_STFL, 90, "Facility that is provided by STFLE facility 90"),
+    FEAT_INIT("stfle91", S390_FEAT_TYPE_STFL, 91, "Facility that is provided by STFLE facility 91"),
+    FEAT_INIT("stfle92", S390_FEAT_TYPE_STFL, 92, "Facility that is provided by STFLE facility 92"),
+    FEAT_INIT("stfle93", S390_FEAT_TYPE_STFL, 93, "Facility that is provided by STFLE facility 93"),
+    FEAT_INIT("stfle94", S390_FEAT_TYPE_STFL, 94, "Facility that is provided by STFLE facility 94"),
+    FEAT_INIT("stfle95", S390_FEAT_TYPE_STFL, 95, "Facility that is provided by STFLE facility 95"),
+    FEAT_INIT("stfle96", S390_FEAT_TYPE_STFL, 96, "Facility that is provided by STFLE facility 96"),
+    FEAT_INIT("stfle97", S390_FEAT_TYPE_STFL, 97, "Facility that is provided by STFLE facility 97"),
+    FEAT_INIT("stfle98", S390_FEAT_TYPE_STFL, 98, "Facility that is provided by STFLE facility 98"),
+    FEAT_INIT("stfle99", S390_FEAT_TYPE_STFL, 99, "Facility that is provided by STFLE facility 99"),
+    FEAT_INIT("stfle100", S390_FEAT_TYPE_STFL, 100, "Facility that is provided by STFLE facility 100"),
+    FEAT_INIT("stfle101", S390_FEAT_TYPE_STFL, 101, "Facility that is provided by STFLE facility 101"),
+    FEAT_INIT("stfle102", S390_FEAT_TYPE_STFL, 102, "Facility that is provided by STFLE facility 102"),
+    FEAT_INIT("stfle103", S390_FEAT_TYPE_STFL, 103, "Facility that is provided by STFLE facility 103"),
+    FEAT_INIT("stfle104", S390_FEAT_TYPE_STFL, 104, "Facility that is provided by STFLE facility 104"),
+    FEAT_INIT("stfle105", S390_FEAT_TYPE_STFL, 105, "Facility that is provided by STFLE facility 105"),
+    FEAT_INIT("stfle106", S390_FEAT_TYPE_STFL, 106, "Facility that is provided by STFLE facility 106"),
+    FEAT_INIT("stfle107", S390_FEAT_TYPE_STFL, 107, "Facility that is provided by STFLE facility 107"),
+    FEAT_INIT("stfle108", S390_FEAT_TYPE_STFL, 108, "Facility that is provided by STFLE facility 108"),
+    FEAT_INIT("stfle109", S390_FEAT_TYPE_STFL, 109, "Facility that is provided by STFLE facility 109"),
+    FEAT_INIT("stfle110", S390_FEAT_TYPE_STFL, 110, "Facility that is provided by STFLE facility 110"),
+    FEAT_INIT("stfle111", S390_FEAT_TYPE_STFL, 111, "Facility that is provided by STFLE facility 111"),
+    FEAT_INIT("stfle112", S390_FEAT_TYPE_STFL, 112, "Facility that is provided by STFLE facility 112"),
+    FEAT_INIT("stfle113", S390_FEAT_TYPE_STFL, 113, "Facility that is provided by STFLE facility 113"),
+    FEAT_INIT("stfle114", S390_FEAT_TYPE_STFL, 114, "Facility that is provided by STFLE facility 114"),
+    FEAT_INIT("stfle115", S390_FEAT_TYPE_STFL, 115, "Facility that is provided by STFLE facility 115"),
+    FEAT_INIT("stfle116", S390_FEAT_TYPE_STFL, 116, "Facility that is provided by STFLE facility 116"),
+    FEAT_INIT("stfle117", S390_FEAT_TYPE_STFL, 117, "Facility that is provided by STFLE facility 117"),
+    FEAT_INIT("stfle118", S390_FEAT_TYPE_STFL, 118, "Facility that is provided by STFLE facility 118"),
+    FEAT_INIT("stfle119", S390_FEAT_TYPE_STFL, 119, "Facility that is provided by STFLE facility 119"),
+    FEAT_INIT("stfle120", S390_FEAT_TYPE_STFL, 120, "Facility that is provided by STFLE facility 120"),
+    FEAT_INIT("stfle121", S390_FEAT_TYPE_STFL, 121, "Facility that is provided by STFLE facility 121"),
+    FEAT_INIT("stfle122", S390_FEAT_TYPE_STFL, 122, "Facility that is provided by STFLE facility 122"),
+    FEAT_INIT("stfle123", S390_FEAT_TYPE_STFL, 123, "Facility that is provided by STFLE facility 123"),
+    FEAT_INIT("stfle124", S390_FEAT_TYPE_STFL, 124, "Facility that is provided by STFLE facility 124"),
+    FEAT_INIT("stfle125", S390_FEAT_TYPE_STFL, 125, "Facility that is provided by STFLE facility 125"),
+    FEAT_INIT("stfle126", S390_FEAT_TYPE_STFL, 126, "Facility that is provided by STFLE facility 126"),
+    FEAT_INIT("stfle127", S390_FEAT_TYPE_STFL, 127, "Facility that is provided by STFLE facility 127"),
     FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
     FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-protection facility"),
     FEAT_INIT("sea_esop2", S390_FEAT_TYPE_STFL, 131, "Side-effect-access facility and Enhanced-suppression-on-protection facility 2"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 4487cfd..fd15362 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -42,6 +42,7 @@ typedef enum {
     S390_FEAT_PARSING_ENH,
     S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
     S390_FEAT_TOD_CLOCK_STEERING,
+    S390_FEAT_STFLE_29,
     S390_FEAT_ETF3_ENH,
     S390_FEAT_EXTRACT_CPU_TIME,
     S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
@@ -51,12 +52,14 @@ typedef enum {
     S390_FEAT_ENHANCED_MONITOR,
     S390_FEAT_FLOATING_POINT_EXT,
     S390_FEAT_ORDER_PRESERVING_COMPRESSION,
+    S390_FEAT_STFLE_39,
     S390_FEAT_SET_PROGRAM_PARAMETERS,
     S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
     S390_FEAT_DFP,
     S390_FEAT_DFP_FAST,
     S390_FEAT_PFPO,
     S390_FEAT_STFLE_45,
+    S390_FEAT_STFLE_46,
     S390_FEAT_CMPSC_ENH,
     S390_FEAT_DFP_ZONED_CONVERSION,
     S390_FEAT_STFLE_49,
@@ -65,10 +68,15 @@ typedef enum {
     S390_FEAT_INTERLOCKED_ACCESS_2,
     S390_FEAT_STFLE_53,
     S390_FEAT_ENTROPY_ENC_COMP,
+    S390_FEAT_STFLE_55,
+    S390_FEAT_STFLE_56,
     S390_FEAT_MSA_EXT_5,
     S390_FEAT_MISC_INSTRUCTION_EXT,
     S390_FEAT_SEMAPHORE_ASSIST,
     S390_FEAT_TIME_SLICE_INSTRUMENTATION,
+    S390_FEAT_STFLE_61,
+    S390_FEAT_STFLE_62,
+    S390_FEAT_STFLE_63,
     S390_FEAT_RUNTIME_INSTRUMENTATION,
     S390_FEAT_ZPCI,
     S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
@@ -80,7 +88,53 @@ typedef enum {
     S390_FEAT_MSA_EXT_4,
     S390_FEAT_EDAT_2,
     S390_FEAT_DFP_PACKED_CONVERSION,
+    S390_FEAT_STFLE_81,
     S390_FEAT_BPB,
+    S390_FEAT_STFLE_83,
+    S390_FEAT_STFLE_84,
+    S390_FEAT_STFLE_85,
+    S390_FEAT_STFLE_86,
+    S390_FEAT_STFLE_87,
+    S390_FEAT_STFLE_88,
+    S390_FEAT_STFLE_89,
+    S390_FEAT_STFLE_90,
+    S390_FEAT_STFLE_91,
+    S390_FEAT_STFLE_92,
+    S390_FEAT_STFLE_93,
+    S390_FEAT_STFLE_94,
+    S390_FEAT_STFLE_95,
+    S390_FEAT_STFLE_96,
+    S390_FEAT_STFLE_97,
+    S390_FEAT_STFLE_98,
+    S390_FEAT_STFLE_99,
+    S390_FEAT_STFLE_100,
+    S390_FEAT_STFLE_101,
+    S390_FEAT_STFLE_102,
+    S390_FEAT_STFLE_103,
+    S390_FEAT_STFLE_104,
+    S390_FEAT_STFLE_105,
+    S390_FEAT_STFLE_106,
+    S390_FEAT_STFLE_107,
+    S390_FEAT_STFLE_108,
+    S390_FEAT_STFLE_109,
+    S390_FEAT_STFLE_110,
+    S390_FEAT_STFLE_111,
+    S390_FEAT_STFLE_112,
+    S390_FEAT_STFLE_113,
+    S390_FEAT_STFLE_114,
+    S390_FEAT_STFLE_115,
+    S390_FEAT_STFLE_116,
+    S390_FEAT_STFLE_117,
+    S390_FEAT_STFLE_118,
+    S390_FEAT_STFLE_119,
+    S390_FEAT_STFLE_120,
+    S390_FEAT_STFLE_121,
+    S390_FEAT_STFLE_122,
+    S390_FEAT_STFLE_123,
+    S390_FEAT_STFLE_124,
+    S390_FEAT_STFLE_125,
+    S390_FEAT_STFLE_126,
+    S390_FEAT_STFLE_127,
     S390_FEAT_VECTOR,
     S390_FEAT_INSTRUCTION_EXEC_PROT,
     S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 95ee870..6c6a6ba 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -350,6 +350,11 @@ static uint16_t base_GEN14_GA1[] = {
  * Automatically includes corresponding base features.
  * Full features are all features this hardware supports even if kvm/QEMU do not
  * support these features yet.
+ *
+ * Non hypervisor managed  bits are supposed to be transparent with host-model.
+ * To achieve this the non-hypervisor managed bits are added to the full model.
+ * Thus full features does not necessarily reflect the hardware for the
+ * non-hypervisor managed bits.
  */
 static uint16_t full_GEN7_GA1[] = {
     S390_FEAT_SIE_F2,
@@ -357,7 +362,105 @@ static uint16_t full_GEN7_GA1[] = {
     S390_FEAT_SIE_GPERE,
     S390_FEAT_SIE_IB,
     S390_FEAT_SIE_CEI,
+
+    /* non-hyp 16-63*/
+    S390_FEAT_EXTENDED_TRANSLATION_2,
+    S390_FEAT_MSA,
+    S390_FEAT_LONG_DISPLACEMENT,
+    S390_FEAT_LONG_DISPLACEMENT_FAST,
+    S390_FEAT_HFP_MADDSUB,
+    S390_FEAT_EXTENDED_IMMEDIATE,
+    S390_FEAT_EXTENDED_TRANSLATION_3,
+    S390_FEAT_HFP_UNNORMALIZED_EXT,
+    S390_FEAT_ETF2_ENH,
+    S390_FEAT_STORE_CLOCK_FAST,
+    S390_FEAT_PARSING_ENH,
+    S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
+    S390_FEAT_TOD_CLOCK_STEERING,
+    S390_FEAT_STFLE_29,
+    S390_FEAT_ETF3_ENH,
+    S390_FEAT_EXTRACT_CPU_TIME,
+    S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
+    S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
+    S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
+    S390_FEAT_EXECUTE_EXT,
+    S390_FEAT_ENHANCED_MONITOR,
+    S390_FEAT_FLOATING_POINT_EXT,
+    S390_FEAT_ORDER_PRESERVING_COMPRESSION,
+    S390_FEAT_STFLE_39,
+    S390_FEAT_SET_PROGRAM_PARAMETERS,
+    S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
+    S390_FEAT_DFP,
+    S390_FEAT_DFP_FAST,
+    S390_FEAT_PFPO,
+    S390_FEAT_STFLE_45,
+    S390_FEAT_STFLE_46,
+    S390_FEAT_CMPSC_ENH,
+    S390_FEAT_DFP_ZONED_CONVERSION,
+    S390_FEAT_STFLE_49,
+    S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
+    S390_FEAT_LOCAL_TLB_CLEARING,
+    S390_FEAT_INTERLOCKED_ACCESS_2,
+    S390_FEAT_STFLE_53,
+    S390_FEAT_ENTROPY_ENC_COMP,
+    S390_FEAT_STFLE_55,
+    S390_FEAT_STFLE_56,
+    S390_FEAT_MSA_EXT_5,
+    S390_FEAT_MISC_INSTRUCTION_EXT,
+    S390_FEAT_SEMAPHORE_ASSIST,
+    S390_FEAT_TIME_SLICE_INSTRUMENTATION,
+    S390_FEAT_STFLE_61,
+    S390_FEAT_STFLE_62,
+    S390_FEAT_STFLE_63,
+    /* non-hyp 80-127*/
+    S390_FEAT_DFP_PACKED_CONVERSION,
+    S390_FEAT_STFLE_81,
     S390_FEAT_BPB,
+    S390_FEAT_STFLE_83,
+    S390_FEAT_STFLE_84,
+    S390_FEAT_STFLE_85,
+    S390_FEAT_STFLE_86,
+    S390_FEAT_STFLE_87,
+    S390_FEAT_STFLE_88,
+    S390_FEAT_STFLE_89,
+    S390_FEAT_STFLE_90,
+    S390_FEAT_STFLE_91,
+    S390_FEAT_STFLE_92,
+    S390_FEAT_STFLE_93,
+    S390_FEAT_STFLE_94,
+    S390_FEAT_STFLE_95,
+    S390_FEAT_STFLE_96,
+    S390_FEAT_STFLE_97,
+    S390_FEAT_STFLE_98,
+    S390_FEAT_STFLE_99,
+    S390_FEAT_STFLE_100,
+    S390_FEAT_STFLE_101,
+    S390_FEAT_STFLE_102,
+    S390_FEAT_STFLE_103,
+    S390_FEAT_STFLE_104,
+    S390_FEAT_STFLE_105,
+    S390_FEAT_STFLE_106,
+    S390_FEAT_STFLE_107,
+    S390_FEAT_STFLE_108,
+    S390_FEAT_STFLE_109,
+    S390_FEAT_STFLE_110,
+    S390_FEAT_STFLE_111,
+    S390_FEAT_STFLE_112,
+    S390_FEAT_STFLE_113,
+    S390_FEAT_STFLE_114,
+    S390_FEAT_STFLE_115,
+    S390_FEAT_STFLE_116,
+    S390_FEAT_STFLE_117,
+    S390_FEAT_STFLE_118,
+    S390_FEAT_STFLE_119,
+    S390_FEAT_STFLE_120,
+    S390_FEAT_STFLE_121,
+    S390_FEAT_STFLE_122,
+    S390_FEAT_STFLE_123,
+    S390_FEAT_STFLE_124,
+    S390_FEAT_STFLE_125,
+    S390_FEAT_STFLE_126,
+    S390_FEAT_STFLE_127,
 };
 
 static uint16_t full_GEN7_GA2[] = {
-- 
2.9.4
