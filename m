Received: from eggs.gnu.org ([2001:4830:134:3::10]:60914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1RY-0006e2-C6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db1RW-0006UA-8r
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1db1RW-0006So-3k
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:22 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 28 Jul 2017 11:20:00 +0200
Message-Id: <20170728092000.19216-5-cohuck@redhat.com>
In-Reply-To: <20170728092000.19216-1-cohuck@redhat.com>
References: <20170728092000.19216-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 4/4] s390x/css: fix bits must be zero
 check for TIC
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

According to the PoP bit positions 0-3 and 8-32 of the format-1 CCW must
contain zeros.  Bits 0-3 are already covered by cmd_code validity
checking, and bit 32 is covered by the CCW address checking.

Bits 8-31 correspond to CCW1.flags and CCW1.count.  Currently we only
check for the absence of certain flags.  Let's fix this.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20170725224442.13383-3-pasic@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
[CH: tweaked comment]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 177cbfc92d..1880b1a0ff 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -885,7 +885,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
             ret = -EINVAL;
             break;
         }
-        if (ccw.flags & (CCW_FLAG_CC | CCW_FLAG_DC)) {
+        if (ccw.flags || ccw.count) {
+            /* We have already sanitized these if converted from fmt 0. */
             ret = -EINVAL;
             break;
         }
-- 
2.13.3
