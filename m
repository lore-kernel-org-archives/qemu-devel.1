Received: from eggs.gnu.org ([2001:4830:134:3::10]:40873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIU-0001cF-7Y
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIQ-0002g9-1z
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:10 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:29 -0500
Message-Id: <20180723201748.25573-21-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 20/99] pc-bios/s390-ccw: struct tpi_info must
 be declared as aligned(4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

I've run into a compilation error today with the current version of GCC 8:

In file included from s390-ccw.h:49,
                 from main.c:12:
cio.h:128:1: error: alignment 1 of 'struct tpi_info' is less than 4 [-Werror=packed-not-aligned]
 } __attribute__ ((packed));
 ^
cc1: all warnings being treated as errors

Since the struct tpi_info contains an element ("struct subchannel_id schid")
which is marked as aligned(4), we've got to mark the struct tpi_info as
aligned(4), too.

CC: qemu-stable@nongnu.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1525774672-11913-1-git-send-email-thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit a6e4385dea94850d7b06b0542e7960c1063fdabd)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/cio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 55eaeee4b6..1a0795f645 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -125,7 +125,7 @@ struct tpi_info {
     __u32 reserved3  : 12;
     __u32 int_type   : 3;
     __u32 reserved4  : 12;
-} __attribute__ ((packed));
+} __attribute__ ((packed, aligned(4)));
 
 /* channel command word (type 1) */
 struct ccw1 {
-- 
2.17.1
