Received: from eggs.gnu.org ([2001:4830:134:3::10]:44863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDL-0006WY-Ra
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDH-00010R-20
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVHDG-0000zO-PA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CCs5ba127160
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:53 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj5hqkb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:53 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 13:57:51 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 14:57:40 +0200
In-Reply-To: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499864265-144136-7-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 06/11] s390x/cpumodel: provide compat handling
 for new cpu features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Provide a mechanism to disable features in compatibility machines.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_models.c | 26 ++++++++++++++++++++++++++
 target/s390x/cpu_models.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7cb55dc..fd3f459 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -77,6 +77,32 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
 };
 
+void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat)
+{
+    const S390CPUDef *def;
+
+    def = s390_find_cpu_def(0, gen, ec_ga, NULL);
+    clear_bit(feat, (unsigned long *)&def->default_feat);
+}
+
+void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat feat)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
+        const S390CPUDef *def = &s390_cpu_defs[i];
+
+        if (def->gen < gen) {
+            continue;
+        }
+        if (def->gen == gen && def->ec_ga < ec_ga) {
+            continue;
+        }
+
+        clear_bit(feat, (unsigned long *)&def->default_feat);
+    }
+}
+
 uint32_t s390_get_hmfai(void)
 {
     static S390CPU *cpu;
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index d41f8d6..c0bee15 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -72,6 +72,8 @@ typedef struct S390CPUModel {
 #define ibc_gen(x)        (x == 0 ? 0 : ((x >> 4) + S390_GEN_Z10))
 #define ibc_ec_ga(x)      (x & 0xf)
 
+void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat);
+void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat feat);
 uint32_t s390_get_hmfai(void);
 uint8_t s390_get_mha_pow(void);
 uint32_t s390_get_ibc_val(void);
-- 
2.7.4
