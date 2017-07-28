Received: from eggs.gnu.org ([2001:4830:134:3::10]:60912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1RY-0006e0-B5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1RU-0006PY-7c
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1db1RU-0006P7-0Q
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:20 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 28 Jul 2017 11:19:59 +0200
Message-Id: <20170728092000.19216-4-cohuck@redhat.com>
In-Reply-To: <20170728092000.19216-1-cohuck@redhat.com>
References: <20170728092000.19216-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 3/4] s390x/css: check ccw address
 validity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

According to the PoP channel command words (CCW) must be doubleword
aligned and 31 bit addressable for format 1 and 24 bit addressable for
format 0 CCWs.

If the channel subsystem encounters a ccw address which does not satisfy
this alignment requirement a program-check condition is recognised.

The situation with 31 bit addressable is a bit more complicated: both the
ORB and a format 1 CCW TIC hold the address of (the rest of) the channel
program, that is the address of the next CCW in a word, and the PoP
mandates that bit 0 of that word shall be zero -- or a program-check
condition is to be recognized -- and does not belong to the field holding
the ccw address.

Since in code the corresponding fields span across the whole word (unlike
in PoP where these are defined as 31 bit wide) we can check this by
applying a mask. The 24 addressable case isn't affecting TIC because the
address is composed of a halfword and a byte portion (no additional zero
bit requirements) and just slightly complicates the ORB case where also
bits 1-7 need to be zero.

The same requirements (especially n-bit addressability) apply to the
ccw addresses generated while chaining.

Let's make our CSS implementation follow the AR more closely.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20170727154842.23427-1-pasic@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 6a42b95cee..177cbfc92d 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -795,6 +795,10 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     if (!ccw_addr) {
         return -EIO;
     }
+    /* Check doubleword aligned and 31 or 24 (fmt 0) bit addressable. */
+    if (ccw_addr & (sch->ccw_fmt_1 ? 0x80000007 : 0xff000007)) {
+        return -EINVAL;
+    }
 
     /* Translate everything to format-1 ccws - the information is the same. */
     ccw = copy_ccw_from_guest(ccw_addr, sch->ccw_fmt_1);
-- 
2.13.3
