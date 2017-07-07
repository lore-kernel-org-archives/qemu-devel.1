Received: from eggs.gnu.org ([2001:4830:134:3::10]:35326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTQTj-0002T0-9d
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTQTi-0001o2-Bv
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dTQTi-0001nY-5c
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:14 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  7 Jul 2017 12:26:58 +0200
Message-Id: <1499423224-23060-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1499423224-23060-1-git-send-email-thuth@redhat.com>
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 2/8] pc-bios/s390-ccw: Move ebc2asc to
 sclp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

We will later need this array in a file that we will link to the
netboot code, too. Since there is some ebcdic convertion done
in sclp_get_loadparm_ascii(), the sclp.c file seems to be a good
candidate.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 11 -----------
 pc-bios/s390-ccw/sclp.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 40cba8d..0580eac 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -17,17 +17,6 @@ static SubChannelId blk_schid = { .one = 1 };
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
 
-const unsigned char ebc2asc[256] =
-      /* 0123456789abcdef0123456789abcdef */
-        "................................" /* 1F */
-        "................................" /* 3F */
-        " ...........<(+|&.........!$*);." /* 5F first.chr.here.is.real.space */
-        "-/.........,%_>?.........`:#@'=\""/* 7F */
-        ".abcdefghi.......jklmnopqr......" /* 9F */
-        "..stuvwxyz......................" /* BF */
-        ".ABCDEFGHI.......JKLMNOPQR......" /* DF */
-        "..STUVWXYZ......0123456789......";/* FF */
-
 /*
  * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
  * a subsystem-identification is at 184-187 and bytes 188-191 are zero
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index aa1c862..2ee204a 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -14,6 +14,17 @@
 
 static char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
 
+const unsigned char ebc2asc[256] =
+      /* 0123456789abcdef0123456789abcdef */
+        "................................" /* 1F */
+        "................................" /* 3F */
+        " ...........<(+|&.........!$*);." /* 5F first.chr.here.is.real.space */
+        "-/.........,%_>?.........`:#@'=\""/* 7F */
+        ".abcdefghi.......jklmnopqr......" /* 9F */
+        "..stuvwxyz......................" /* BF */
+        ".ABCDEFGHI.......JKLMNOPQR......" /* DF */
+        "..STUVWXYZ......0123456789......";/* FF */
+
 /* Perform service call. Return 0 on success, non-zero otherwise. */
 static int sclp_service_call(unsigned int command, void *sccb)
 {
-- 
1.8.3.1
