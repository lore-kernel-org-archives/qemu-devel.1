Received: from eggs.gnu.org ([2001:4830:134:3::10]:36664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFzhI-0002SW-27
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFzhB-0002Bo-6p
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:18:14 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  8 May 2018 12:17:52 +0200
Message-Id: <1525774672-11913-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] pc-bios/s390-ccw: struct tpi_info must be
 declared as aligned(4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/cio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 55eaeee..1a0795f 100644
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
1.8.3.1
