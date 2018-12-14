Received: from eggs.gnu.org ([2001:4830:134:3::10]:32878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXnCV-0005pC-A6
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXnCS-0007PW-Jl
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:08:19 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 14 Dec 2018 14:08:07 +0100
Message-Id: <1544792887-14575-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/s390x: Fix bad mask in time2tod()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org

The time2tod() function tries to deal with the 9 uppermost bits in the
time value, but uses the wrong mask for this: 0xff80000000000000 should
be used instead of 0xff10000000000000 here.

Fixes: 14055ce53c2d901d826ffad7fb7d6bb8ab46bdfd
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/tod.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index cbd7552..47ef9de 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -56,7 +56,7 @@ typedef struct S390TODClass {
 /* Converts ns to s390's clock format */
 static inline uint64_t time2tod(uint64_t ns)
 {
-    return (ns << 9) / 125 + (((ns & 0xff10000000000000ull) / 125) << 9);
+    return (ns << 9) / 125 + (((ns & 0xff80000000000000ull) / 125) << 9);
 }
 
 /* Converts s390's clock format to ns */
-- 
1.8.3.1
