Received: from eggs.gnu.org ([2001:4830:134:3::10]:50156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yj-0007G6-II
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yg-0006I4-FM
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dn5yg-0006HN-5o
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:30 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UGYFin061836
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:28 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cnyf4p67p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:28 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 17:36:26 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 18:36:03 +0200
In-Reply-To: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170830163609.50260-4-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/9] s390x/css: be more consistent if broken
 beyond repair
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

If we detect that the internally manged state of the subchannel
is broken beyond repair while in do_subchannel_work in case of
virtual we just abort the operation and pretend all went well,
while in case of pass-through we honor the situation with -ENODEV
which results in cc 3 for the instruction whose handler triggered
the call.

Let's be consistent on this and do the -ENODEV also for virtual
subchannels.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 0822538cde..bc47bf5b20 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1078,7 +1078,7 @@ int do_subchannel_work_virtual(SubchDev *sch)
         sch_handle_start_func_virtual(sch);
     } else {
         /* Cannot happen. */
-        return 0;
+        return -ENODEV;
     }
     css_inject_io_interrupt(sch);
     return 0;
-- 
2.13.5
