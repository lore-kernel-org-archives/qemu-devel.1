Received: from eggs.gnu.org ([2001:4830:134:3::10]:52536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ga1RC-0000EM-0a
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ga1RB-0004Di-Ez
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:44:41 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 20 Dec 2018 17:44:33 +0100
Message-Id: <20181220164433.21705-3-cohuck@redhat.com>
In-Reply-To: <20181220164433.21705-1-cohuck@redhat.com>
References: <20181220164433.21705-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] hw/s390x: Fix bad mask in time2tod()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Since "s390x/tcg: avoid overflows in time2tod/tod2time", the
time2tod() function tries to deal with the 9 uppermost bits in the
time value, but uses the wrong mask for this: 0xff80000000000000 should
be used instead of 0xff10000000000000 here.

Fixes: 14055ce53c2d901d826ffad7fb7d6bb8ab46bdfd
Cc: qemu-stable@nongnu.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1544792887-14575-1-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[CH: tweaked commit message]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/hw/s390x/tod.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index cbd7552e7a..47ef9de869 100644
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
2.17.2
