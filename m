Received: from eggs.gnu.org ([2001:4830:134:3::10]:44065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqL9U-0000bD-Bp
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqL9P-0004p4-74
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40354
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dqL9P-0004oT-1I
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:24:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v88FNtf5005695
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 11:24:56 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cuw50jhk5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 11:24:56 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 16:24:55 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  8 Sep 2017 17:24:44 +0200
In-Reply-To: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170908152446.14606-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/4] s390x/css: fix NULL handling for CCW
 addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Back then in the time of df1fe5bb49 ("s390: Virtual channel subsystem
support.", 2013-01-24) -EIO used to map to a channel-program check (via
the default label of the switch statement).  Then 2dc95b4cac
("s390x/3270: 3270 data stream handling", 2016-04-01) came along
and that changed dramatically.

Let us roll back this undesired side effect, and go back to
channel-program check.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Fixes: 2dc95b4cac "s390x/3270: 3270 data stream handling"
---

I'm not sure 0 as CCW address  it's strictly illegal. Yes 0 is an
unlikely address for a CCW but I would appreciate a PoP reference
clarifying this...

Another reason to not use Unix/POSIX error codes like this.
---
 hw/s390x/css.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 09f6ba0310..a44d87ab3e 100644
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
