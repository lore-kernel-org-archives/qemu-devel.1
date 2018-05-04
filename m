Received: from eggs.gnu.org ([2001:4830:134:3::10]:34350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV6G-0004cm-6u
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV6F-0007ZB-5r
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:52 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:25:13 +0200
Message-Id: <20180504072514.8450-15-cohuck@redhat.com>
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org

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
