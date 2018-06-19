Received: from eggs.gnu.org ([2001:4830:134:3::10]:46652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5j3-0002e5-6I
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5j1-0000Np-DJ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:29 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:29 -0500
Message-Id: <20180619014319.28272-64-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 063/113] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Cornelia Huck <cohuck@redhat.com>

We currently pass an integer as the subcode parameter. However,
the upper bits of the register containing the subcode need to
be 0, which is not guaranteed unless we explicitly specify the
subcode to be an unsigned long value.

Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag 308/6")
Cc: qemu-stable@nongnu.org
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 63d8b5ace31c1e1f3996fe4cd551d6d377594d5a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/iplb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 40fc2d8e21..da0cab0102 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -81,10 +81,11 @@ static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
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
2.11.0
