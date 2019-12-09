Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A3C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC58208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC58208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNHN-0004GO-II
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieNFq-0002bC-Vv
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieNFo-0004L9-Ab
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:55:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48896
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieNFo-0004Kz-4s
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:55:28 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB9HmM6f143129
 for <qemu-devel@nongnu.org>; Mon, 9 Dec 2019 12:55:27 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wsqc02ddc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 12:55:27 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 9 Dec 2019 17:55:25 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Dec 2019 17:55:20 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xB9Hscce17957366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2019 17:54:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67BE24C040;
 Mon,  9 Dec 2019 17:55:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 032294C050;
 Mon,  9 Dec 2019 17:55:19 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.42.200])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Dec 2019 17:55:18 +0000 (GMT)
Subject: [for-5.0 PATCH v2 1/3] cpu: Introduce CPUReset callback typedef
From: Greg Kurz <groug@kaod.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 09 Dec 2019 18:55:18 +0100
In-Reply-To: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
References: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120917-0008-0000-0000-0000033F3708
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120917-0009-0000-0000-00004A5E6533
Message-Id: <157591411864.46967.18244018296239778673.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1034 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090144
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use it in include/hw/core/cpu.h and convert all targets to use it as
well with:

perl -pi \
 -e 's/void\s+\(\*(parent_reset)\)\(CPUState\s+\*\w+\)/CPUReset \1/;' \
 $(git ls-files 'target/*.h')

Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/core/cpu.h       |    4 +++-
 target/alpha/cpu-qom.h      |    2 +-
 target/arm/cpu-qom.h        |    2 +-
 target/cris/cpu-qom.h       |    2 +-
 target/hppa/cpu-qom.h       |    2 +-
 target/i386/cpu-qom.h       |    2 +-
 target/lm32/cpu-qom.h       |    2 +-
 target/m68k/cpu-qom.h       |    2 +-
 target/microblaze/cpu-qom.h |    2 +-
 target/mips/cpu-qom.h       |    2 +-
 target/moxie/cpu.h          |    2 +-
 target/nios2/cpu.h          |    2 +-
 target/openrisc/cpu.h       |    2 +-
 target/ppc/cpu-qom.h        |    2 +-
 target/riscv/cpu.h          |    2 +-
 target/s390x/cpu-qom.h      |    2 +-
 target/sh4/cpu-qom.h        |    2 +-
 target/sparc/cpu-qom.h      |    2 +-
 target/tilegx/cpu.h         |    2 +-
 target/tricore/cpu-qom.h    |    2 +-
 target/xtensa/cpu-qom.h     |    2 +-
 21 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 77c6f0529903..047e3972ecaf 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -74,6 +74,8 @@ typedef struct CPUWatchpoint CPUWatchpoint;
 
 struct TranslationBlock;
 
+typedef void (*CPUReset)(CPUState *cpu);
+
 /**
  * CPUClass:
  * @class_by_name: Callback to map -cpu command line model name to an
@@ -165,7 +167,7 @@ typedef struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
-    void (*reset)(CPUState *cpu);
+    CPUReset reset;
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
diff --git a/target/alpha/cpu-qom.h b/target/alpha/cpu-qom.h
index 6f0a0adb9efa..0c974805481b 100644
--- a/target/alpha/cpu-qom.h
+++ b/target/alpha/cpu-qom.h
@@ -44,7 +44,7 @@ typedef struct AlphaCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } AlphaCPUClass;
 
 typedef struct AlphaCPU AlphaCPU;
diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 7f5b244bde35..aeaa84afcc9a 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -51,7 +51,7 @@ typedef struct ARMCPUClass {
 
     const ARMCPUInfo *info;
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } ARMCPUClass;
 
 typedef struct ARMCPU ARMCPU;
diff --git a/target/cris/cpu-qom.h b/target/cris/cpu-qom.h
index 308c1f95bdf6..079ffe6bda0a 100644
--- a/target/cris/cpu-qom.h
+++ b/target/cris/cpu-qom.h
@@ -45,7 +45,7 @@ typedef struct CRISCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 
     uint32_t vr;
 } CRISCPUClass;
diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
index 6367dc479391..5c129de148a8 100644
--- a/target/hppa/cpu-qom.h
+++ b/target/hppa/cpu-qom.h
@@ -44,7 +44,7 @@ typedef struct HPPACPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } HPPACPUClass;
 
 typedef struct HPPACPU HPPACPU;
diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index 0efab2fc670f..1e962518e68e 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -71,7 +71,7 @@ typedef struct X86CPUClass {
 
     DeviceRealize parent_realize;
     DeviceUnrealize parent_unrealize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } X86CPUClass;
 
 typedef struct X86CPU X86CPU;
diff --git a/target/lm32/cpu-qom.h b/target/lm32/cpu-qom.h
index dc9ac9ac9f7b..e105a315aa3e 100644
--- a/target/lm32/cpu-qom.h
+++ b/target/lm32/cpu-qom.h
@@ -44,7 +44,7 @@ typedef struct LM32CPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } LM32CPUClass;
 
 typedef struct LM32CPU LM32CPU;
diff --git a/target/m68k/cpu-qom.h b/target/m68k/cpu-qom.h
index b56da8a21374..0a196775e5d1 100644
--- a/target/m68k/cpu-qom.h
+++ b/target/m68k/cpu-qom.h
@@ -44,7 +44,7 @@ typedef struct M68kCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } M68kCPUClass;
 
 typedef struct M68kCPU M68kCPU;
diff --git a/target/microblaze/cpu-qom.h b/target/microblaze/cpu-qom.h
index 49b07cc697b9..7a4ff4a11e33 100644
--- a/target/microblaze/cpu-qom.h
+++ b/target/microblaze/cpu-qom.h
@@ -44,7 +44,7 @@ typedef struct MicroBlazeCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } MicroBlazeCPUClass;
 
 typedef struct MicroBlazeCPU MicroBlazeCPU;
diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
index a430c0fe4bbf..818401a501cb 100644
--- a/target/mips/cpu-qom.h
+++ b/target/mips/cpu-qom.h
@@ -48,7 +48,7 @@ typedef struct MIPSCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
     const struct mips_def_t *cpu_def;
 } MIPSCPUClass;
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 01dca548e5d5..20dafc80f6ac 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -69,7 +69,7 @@ typedef struct MoxieCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } MoxieCPUClass;
 
 /**
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 361b06ffeb61..59a07a5d0ee0 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -50,7 +50,7 @@ typedef struct Nios2CPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } Nios2CPUClass;
 
 #define TARGET_HAS_ICE 1
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 0ad02eab7946..d77976ccce7f 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -48,7 +48,7 @@ typedef struct OpenRISCCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } OpenRISCCPUClass;
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index e499575dc873..9a20e5a1bfea 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -166,7 +166,7 @@ typedef struct PowerPCCPUClass {
 
     DeviceRealize parent_realize;
     DeviceUnrealize parent_unrealize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
     void (*parent_parse_features)(const char *type, char *str, Error **errp);
 
     uint32_t pvr;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e59343e13c02..2246f95b3f33 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -185,7 +185,7 @@ typedef struct RISCVCPUClass {
     CPUClass parent_class;
     /*< public >*/
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } RISCVCPUClass;
 
 /**
diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index dbe5346ec901..daa955f08907 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -61,7 +61,7 @@ typedef struct S390CPUClass {
     const char *desc;
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
     void (*load_normal)(CPUState *cpu);
     void (*reset)(CPUState *cpu, cpu_reset_type type);
 } S390CPUClass;
diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
index 0c56d055bada..35732a367427 100644
--- a/target/sh4/cpu-qom.h
+++ b/target/sh4/cpu-qom.h
@@ -51,7 +51,7 @@ typedef struct SuperHCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 
     uint32_t pvr;
     uint32_t prr;
diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
index 7442e2768e88..93165bd24f1c 100644
--- a/target/sparc/cpu-qom.h
+++ b/target/sparc/cpu-qom.h
@@ -49,7 +49,7 @@ typedef struct SPARCCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
     sparc_def_t *cpu_def;
 } SPARCCPUClass;
 
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 9cbec247d238..68bd509898d4 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -118,7 +118,7 @@ typedef struct TileGXCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } TileGXCPUClass;
 
 /**
diff --git a/target/tricore/cpu-qom.h b/target/tricore/cpu-qom.h
index 7c1e130b4ede..f613452b00e0 100644
--- a/target/tricore/cpu-qom.h
+++ b/target/tricore/cpu-qom.h
@@ -36,7 +36,7 @@ typedef struct TriCoreCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 } TriCoreCPUClass;
 
 typedef struct TriCoreCPU TriCoreCPU;
diff --git a/target/xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
index 9ac54241bd69..685d7b8d823a 100644
--- a/target/xtensa/cpu-qom.h
+++ b/target/xtensa/cpu-qom.h
@@ -56,7 +56,7 @@ typedef struct XtensaCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    CPUReset parent_reset;
 
     const XtensaConfig *config;
 } XtensaCPUClass;


