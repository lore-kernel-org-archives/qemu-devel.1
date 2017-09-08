Received: from eggs.gnu.org ([2001:4830:134:3::10]:44067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqL9U-0000bE-Cg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqL9P-0004pG-Ez
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54218
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dqL9P-0004ov-9A
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:24:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v88FNxLS078061
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 11:24:58 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cuw4mtmcj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 11:24:58 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 16:24:57 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  8 Sep 2017 17:24:45 +0200
In-Reply-To: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170908152446.14606-4-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/4] s390x/css: remove dubious error handling
 branch
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

The case in question actually never happens. Let us get rid of the dead
code.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index a44d87ab3e..a9cdd54efc 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -980,13 +980,6 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
                     SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
             s->cpa = sch->channel_prog + 8;
             break;
-        case -EBUSY:
-            /* subchannel busy, generate deferred cc 1 */
-            s->flags &= ~SCSW_FLAGS_MASK_CC;
-            s->flags |= (1 << 8);
-            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
-            s->ctrl |= SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
-            break;
         case -EINPROGRESS:
             /* channel program has been suspended */
             s->ctrl &= ~SCSW_ACTL_START_PEND;
-- 
2.13.5
