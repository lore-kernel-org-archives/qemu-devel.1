Received: from eggs.gnu.org ([2001:4830:134:3::10]:35102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fDrFM-0008Ap-J5
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fDrFI-0005NF-N0
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:52:36 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  2 May 2018 14:52:21 +0200
Message-Id: <20180502125221.4877-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390-ccw: force diag 308 subcode to unsigned
 long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org

We currently pass an integer as the subcode parameter. However,
the upper bits of the register containing the subcode need to
be 0, which is not guaranteed unless we explicitly specify the
subcode to be an unsigned long value.

Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag 308/6")
Cc: qemu-stable@nongnu.org
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/iplb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 5357a36d51..ded20c834e 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -101,10 +101,11 @@ static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
 {
     register unsigned long addr asm("0") = (unsigned long) iplb;
     register unsigned long rc asm("1") = 0;
+    unsigned long subcode = store ? 6 : 5;
 
     asm volatile ("diag %0,%2,0x308\n"
                   : "+d" (addr), "+d" (rc)
-                  : "d" (store ? 6 : 5)
+                  : "d" (subcode)
                   : "memory", "cc");
     return rc == 0x01;
 }
-- 
2.14.3
