Received: from eggs.gnu.org ([2001:4830:134:3::10]:43886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORb-0004mx-T4
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORX-0007r7-22
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:31 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Dec 2017 14:47:37 +0100
Message-Id: <20171211134740.8235-13-david@redhat.com>
In-Reply-To: <20171211134740.8235-1-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2-12 12/15] s390x/tcg: fix size +
 content of STSI blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

All blocks are 4k in size, which is only true for two of them right now.
Also some reserved fields were wrong, fix it and convert all reserved
fields to u8.

This also fixes the LPAR part output in /proc/sysinfo under TCG. (for
now, everything was indicated as 0)

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b4a88830de..bfe650c46e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -437,25 +437,27 @@ static inline void setcc(S390CPU *cpu, uint64_t cc)
 
 /* Basic Machine Configuration */
 struct sysib_111 {
-    uint32_t res1[8];
+    uint8_t  res1[32];
     uint8_t  manuf[16];
     uint8_t  type[4];
     uint8_t  res2[12];
     uint8_t  model[16];
     uint8_t  sequence[16];
     uint8_t  plant[4];
-    uint8_t  res3[156];
+    uint8_t  res3[3996];
 };
+QEMU_BUILD_BUG_ON(sizeof(struct sysib_111) != 4096);
 
 /* Basic Machine CPU */
 struct sysib_121 {
-    uint32_t res1[80];
+    uint8_t  res1[80];
     uint8_t  sequence[16];
     uint8_t  plant[4];
     uint8_t  res2[2];
     uint16_t cpu_addr;
-    uint8_t  res3[152];
+    uint8_t  res3[3992];
 };
+QEMU_BUILD_BUG_ON(sizeof(struct sysib_121) != 4096);
 
 /* Basic Machine CPUs */
 struct sysib_122 {
@@ -467,20 +469,22 @@ struct sysib_122 {
     uint16_t reserved_cpus;
     uint16_t adjustments[2026];
 };
+QEMU_BUILD_BUG_ON(sizeof(struct sysib_122) != 4096);
 
 /* LPAR CPU */
 struct sysib_221 {
-    uint32_t res1[80];
+    uint8_t  res1[80];
     uint8_t  sequence[16];
     uint8_t  plant[4];
     uint16_t cpu_id;
     uint16_t cpu_addr;
-    uint8_t  res3[152];
+    uint8_t  res3[3992];
 };
+QEMU_BUILD_BUG_ON(sizeof(struct sysib_221) != 4096);
 
 /* LPAR CPUs */
 struct sysib_222 {
-    uint32_t res1[32];
+    uint8_t  res1[32];
     uint16_t lpar_num;
     uint8_t  res2;
     uint8_t  lcpuc;
@@ -493,8 +497,9 @@ struct sysib_222 {
     uint8_t  res3[16];
     uint16_t dedicated_cpus;
     uint16_t shared_cpus;
-    uint8_t  res4[180];
+    uint8_t  res4[4020];
 };
+QEMU_BUILD_BUG_ON(sizeof(struct sysib_222) != 4096);
 
 /* VM CPUs */
 struct sysib_322 {
@@ -517,6 +522,7 @@ struct sysib_322 {
     uint8_t res4[1504];
     uint8_t ext_names[8][256];
 };
+QEMU_BUILD_BUG_ON(sizeof(struct sysib_322) != 4096);
 
 /* MMU defines */
 #define _ASCE_ORIGIN            ~0xfffULL /* segment table origin             */
-- 
2.14.3
