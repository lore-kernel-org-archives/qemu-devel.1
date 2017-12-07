Received: from eggs.gnu.org ([2001:4830:134:3::10]:39468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMzRG-0004Xy-2J
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMzRB-00074K-7w
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:22 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Dec 2017 17:53:47 +0100
Message-Id: <20171207165355.7559-3-david@redhat.com>
In-Reply-To: <20171207165355.7559-1-david@redhat.com>
References: <20171207165355.7559-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 02/10] s390x/tcg: ALSI/ALSGI are
 atomic with interlocked-acccess facility 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

We can simply reuse our ASI implementation. Only the way CC is
calculated differs.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 57f2e5133f..166ee7c80b 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -70,9 +70,9 @@
     C(0xc20b, ALFI,    RIL_a, EI,  r1, i2_32u, new, r1_32, add, addu32)
     C(0xc20a, ALGFI,   RIL_a, EI,  r1, i2_32u, r1, 0, add, addu64)
 /* ADD LOGICAL WITH SIGNED IMMEDIATE */
-    C(0xeb6e, ALSI,    SIY,   GIE, m1_32u, i2, new, m1_32, add, addu32)
+    D(0xeb6e, ALSI,    SIY,   GIE, la1, i2, new, 0, asi, addu32, MO_TEUL)
     C(0xecda, ALHSIK,  RIE_d, DO,  r3, i2, new, r1_32, add, addu32)
-    C(0xeb7e, ALGSI,   SIY,   GIE, m1_64, i2, new, m1_64, add, addu64)
+    D(0xeb7e, ALGSI,   SIY,   GIE, la1, i2, new, 0, asi, addu64, MO_TEQ)
     C(0xecdb, ALGHSIK, RIE_d, DO,  r3, i2, r1, 0, add, addu64)
 /* ADD LOGICAL WITH SIGNED IMMEDIATE HIGH */
     C(0xcc0a, ALSIH,   RIL_a, HW,  r1_sr32, i2, new, r1_32h, add, addu32)
-- 
2.14.3
