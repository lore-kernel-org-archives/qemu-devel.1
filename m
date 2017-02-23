Received: from eggs.gnu.org ([2001:4830:134:3::10]:41244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVl-0005Me-Jr
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVh-0001k5-FK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51834
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVh-0001jZ-Az
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJrkun077276
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:04 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28t4yqbq3x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:04 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:01 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:32 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-8-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 07/15] target/ppc: support for 32-bit carry
 and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

POWER ISA 3.0 adds CA32 and OV32 status in 64-bit mode. Add the flags
and corresponding defines.

Moreover, CA32 is updated when CA is updated and OV32 is updated when OV
is updated.

Arithmetic instructions:
    * Addition and Substractions:

        addic, addic., subfic, addc, subfc, adde, subfe, addme, subfme,
        addze, and subfze always updates CA and CA32.

        => CA reflects the carry out of bit 0 in 64-bit mode and out of
           bit 32 in 32-bit mode.
        => CA32 reflects the carry out of bit 32 independent of the
           mode.

        => SO and OV reflects overflow of the 64-bit result in 64-bit
           mode and overflow of the low-order 32-bit result in 32-bit
           mode
        => OV32 reflects overflow of the low-order 32-bit independent of
           the mode

    * Multiply Low and Divide:

        For mulld, divd, divde, divdu and divdeu: SO, OV, and OV32 bits
        reflects overflow of the 64-bit result

        For mullw, divw, divwe, divwu and divweu: SO, OV, and OV32 bits
        reflects overflow of the 32-bit result

     * Negate with OE=1 (nego)

       For 64-bit mode if the register RA contains
       0x8000_0000_0000_0000, OV and OV32 are set to 1.

       For 32-bit mode if the register RA contains 0x8000_0000, OV and
       OV32 are set to 1.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/cpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f1a7ca0..e789d4b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1369,14 +1369,20 @@ int ppc_compat_max_threads(PowerPCCPU *cpu);
 #define XER_SO_BIT  31
 #define XER_OV_BIT  30
 #define XER_CA_BIT  29
+#define XER_OV32_BIT  19
+#define XER_CA32_BIT  18
 #define XER_CMP_BIT  8
 #define XER_BC_BIT   0
 #define XER_SO  (1 << XER_SO_BIT)
 #define XER_OV  (1 << XER_OV_BIT)
 #define XER_CA  (1 << XER_CA_BIT)
+#define XER_OV32  (1 << XER_OV32_BIT)
+#define XER_CA32  (1 << XER_CA32_BIT)
 #define xer_so  ((env->xer & XER_SO) >> XER_SO_BIT)
 #define xer_ov  ((env->xer & XER_OV) >> XER_OV_BIT)
 #define xer_ca  ((env->xer & XER_CA) >> XER_CA_BIT)
+#define xer_ov32  ((env->xer & XER_OV32) >> XER_OV32_BIT)
+#define xer_ca32  ((env->xer & XER_CA32) >> XER_CA32_BIT)
 #define xer_cmp ((env->xer >> XER_CMP_BIT) & 0xFF)
 #define xer_bc  ((env->xer >> XER_BC_BIT)  & 0x7F)
 
@@ -2343,6 +2349,7 @@ enum {
 
 /*****************************************************************************/
 
+#define is_isa300(ctx) (!!(ctx->insns_flags2 & PPC2_ISA300))
 target_ulong cpu_read_xer(CPUPPCState *env);
 void cpu_write_xer(CPUPPCState *env, target_ulong xer);
 
-- 
2.7.4
