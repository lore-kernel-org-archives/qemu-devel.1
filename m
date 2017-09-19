Received: from eggs.gnu.org ([2001:4830:134:3::10]:38761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdK-0005wh-1p
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdI-0002ht-NF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLdI-0002hZ-FC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:24 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:07 +0200
Message-Id: <20170919164337.18555-9-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 08/38] s390x/css: fix NULL handling for CCW
 addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Back then in the time of df1fe5bb49 ("s390: Virtual channel subsystem
support.", 2013-01-24) -EIO used to map to a channel-program check (via
the default label of the switch statement).  Then 2dc95b4cac
("s390x/3270: 3270 data stream handling", 2016-04-01) came along
and that changed dramatically.

Let us roll back this undesired side effect, and go back to
channel-program check.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Fixes: 2dc95b4cac "s390x/3270: 3270 data stream handling"
Message-Id: <20170908152446.14606-3-pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index bab78fc79a..6d599477b2 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -793,7 +793,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     CCW1 ccw;
 
     if (!ccw_addr) {
-        return -EIO;
+        return -EINVAL; /* channel-program check */
     }
     /* Check doubleword aligned and 31 or 24 (fmt 0) bit addressable. */
     if (ccw_addr & (sch->ccw_fmt_1 ? 0x80000007 : 0xff000007)) {
-- 
2.13.5
