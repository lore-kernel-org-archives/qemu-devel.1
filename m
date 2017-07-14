Received: from eggs.gnu.org ([2001:4830:134:3::10]:55864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyO9-0007P7-Vy
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyO6-0003WS-Tq
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56092
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyO6-0003WJ-Of
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:03:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB2r2l122542
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:03:58 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bps8e02s5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:03:58 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:03:56 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:33 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-7-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 06/40] s390x/cpumodel: provide compat handling
 for new cpu features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

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
