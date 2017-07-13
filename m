Received: from eggs.gnu.org ([2001:4830:134:3::10]:59647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVgaL-0004US-Pz
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVgaI-0005Wk-Nu
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37490
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVgaI-0005WV-If
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DG35fi092712
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 12:03:21 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bp61g00qb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 12:03:18 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 17:03:15 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 18:03:08 +0200
In-Reply-To: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
References: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499961789-127874-7-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 6/7] s390x/arch_dump: also dump guarded storage
 control block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Write the new note section of type 30b (guarded storage control block).

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/elf.h            |  1 +
 target/s390x/arch_dump.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index 0dbd3e9..cd51434 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1476,6 +1476,7 @@ typedef struct elf64_shdr {
 #define NT_TASKSTRUCT	4
 #define NT_AUXV		6
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
+#define NT_S390_GS_CB   0x30b           /* s390 guarded storage registers */
 #define NT_S390_VXRS_HIGH 0x30a         /* s390 vector registers 16-31 */
 #define NT_S390_VXRS_LOW  0x309         /* s390 vector registers 0-15 (lower half) */
 #define NT_S390_PREFIX  0x305           /* s390 prefix register */
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 105ae9a..96c9fb9 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -57,6 +57,12 @@ struct S390xElfVregsHiStruct {
 
 typedef struct S390xElfVregsHiStruct S390xElfVregsHi;
 
+struct S390xElfGSCBStruct {
+    uint64_t gsregs[4];
+} QEMU_PACKED;
+
+typedef struct S390xElfGSCBStruct S390xElfGSCB;
+
 typedef struct noteStruct {
     Elf64_Nhdr hdr;
     char name[8];
@@ -65,6 +71,7 @@ typedef struct noteStruct {
         S390xElfFpregset fpregset;
         S390xElfVregsLo vregslo;
         S390xElfVregsHi vregshi;
+        S390xElfGSCB gscb;
         uint32_t prefix;
         uint64_t timer;
         uint64_t todcmp;
@@ -126,6 +133,16 @@ static void s390x_write_elf64_vregshi(Note *note, S390CPU *cpu, int id)
     }
 }
 
+static void s390x_write_elf64_gscb(Note *note, S390CPU *cpu, int id)
+{
+    int i;
+
+    note->hdr.n_type = cpu_to_be32(NT_S390_GS_CB);
+    for (i = 0; i < 4; i++) {
+        note->contents.gscb.gsregs[i] = cpu_to_be64(cpu->env.gscb[i]);
+    }
+}
+
 static void s390x_write_elf64_timer(Note *note, S390CPU *cpu, int id)
 {
     note->hdr.n_type = cpu_to_be32(NT_S390_TIMER);
@@ -181,6 +198,7 @@ static const NoteFuncDesc note_linux[] = {
     {sizeof(((Note *)0)->contents.todpreg),  s390x_write_elf64_todpreg},
     {sizeof(((Note *)0)->contents.vregslo),  s390x_write_elf64_vregslo},
     {sizeof(((Note *)0)->contents.vregshi),  s390x_write_elf64_vregshi},
+    {sizeof(((Note *)0)->contents.gscb),     s390x_write_elf64_gscb},
     { 0, NULL}
 };
 
-- 
2.7.4
