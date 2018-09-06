Received: from eggs.gnu.org ([2001:4830:134:3::10]:59962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipan@linux.ibm.com>) id 1fxoEY-00082G-Gi
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipan@linux.ibm.com>) id 1fxoEU-00030i-FQ
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:57:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33762
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sandipan@linux.ibm.com>)
	id 1fxoEU-0002zk-88
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:57:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w866u64c048430
	for <qemu-devel@nongnu.org>; Thu, 6 Sep 2018 02:57:37 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2maxm7243a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 02:57:37 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sandipan@linux.ibm.com>;
	Thu, 6 Sep 2018 07:57:35 +0100
From: Sandipan Das <sandipan@linux.ibm.com>
Date: Thu,  6 Sep 2018 12:27:29 +0530
Message-Id: <20180906065729.2487-1-sandipan@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] target-ppc: Extend HWCAP2 bits for ISA 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, riku.voipio@iki.fi, nikunj@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com

This adds the HWCAP2 bit to detect if a linux user process is
running on an ISA 3.0 compliant cpu like POWER9. This can be
verified using a simple test program that prints the value in
the auxiliary vector for AT_HWCAP2 as shown below.

Before:
  $ qemu-ppc64le -cpu power8 test
  0x8c000000

  $ qemu-ppc64le -cpu power9 test
  0x8c000000

After:
  $ qemu-ppc64le -cpu power8 test
  0x8c000000

  $ qemu-ppc64le -cpu power9 test
  0x8c800000

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8638612aec..e97c4cde49 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -710,6 +710,7 @@ enum {
     QEMU_PPC_FEATURE2_HAS_EBB = 0x10000000, /* Event Base Branching */
     QEMU_PPC_FEATURE2_HAS_ISEL = 0x08000000, /* Integer Select */
     QEMU_PPC_FEATURE2_HAS_TAR = 0x04000000, /* Target Address Register */
+    QEMU_PPC_FEATURE2_ARCH_3_00 = 0x00800000, /* ISA 3.00 */
 };
 
 #define ELF_HWCAP get_elf_hwcap()
@@ -764,6 +765,7 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE2(PPC2_BCTAR_ISA207, QEMU_PPC_FEATURE2_HAS_TAR);
     GET_FEATURE2((PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                   PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07);
+    GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00);
 
 #undef GET_FEATURE
 #undef GET_FEATURE2
-- 
2.14.4
