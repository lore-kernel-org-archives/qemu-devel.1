Received: from eggs.gnu.org ([2001:4830:134:3::10]:54260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpvR3-0002OW-5f
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpvQy-0002p9-Gz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:57:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47182
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpvQy-0002nu-CY
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:57:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v87BsEJe195801
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 07:57:22 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cu32y08ge-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 07:57:22 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 12:57:21 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu,  7 Sep 2017 13:57:00 +0200
Message-Id: <20170907115700.69911-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390x/css: drop data-check in
 interpretation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

The architecture says that channel-data check is indicating that
an uncorrected storage (memory) error has been detected in regard
to the data residing in main storage (memory) that is currently
used for an I/O operation. The described detection is done using
the CBC technology.

The ccw interpretation code is however generating a channel-data check
effectively when the (device specific) ccw_cb returns -EFAULT.  In case
of virtio-ccw devices this happens when mapping memory fails, or when a
NULL pointer is encountered. So this behavior is not architecture
conform.

Furthermore the best fit for these situations (null pointer, mapping a
piece of guest memory fails) from architectural perspective the condition
described as the channel subsystem refers to a location that is not
available, which when encountered shall result in a channel-program
check.

To fix this, all we have to do is to get rid of the switch case matching
-EFAULT: the default is generating a channel-program check.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

References
-----------

1. paragraph: PoP page 16-42 "Channel-Data Check".
3. paragraph: PoP page 15-59 "Designation of Storage Area"

Side note on usage of error codes
----------------------------------

I'm currently having a patch set under discussion which aims to move away
from mapping CSS conditions to error codes and back for the IO
instruction handlers. IMHO as of today the given usage of the error codes
is rather obfuscating the source code than contributing to clarity. I've
experimented with a bunch of changes to improve on the readability of the
code, but did not settle about if and what to do yet (the main problem is
the gains not solid and quite limited -- it's hard to justify churn).

If there is interest I would be happy to write up an RFC and start a
discussion on what makes sense and what does not.
---
 hw/s390x/css.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1880b1a0ff..72fb193676 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -980,15 +980,6 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
                     SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
             s->cpa = sch->channel_prog + 8;
             break;
-        case -EFAULT:
-            /* memory problem, generate channel data check */
-            s->ctrl &= ~SCSW_ACTL_START_PEND;
-            s->cstat = SCSW_CSTAT_DATA_CHECK;
-            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
-            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
-                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
-            s->cpa = sch->channel_prog + 8;
-            break;
         case -EBUSY:
             /* subchannel busy, generate deferred cc 1 */
             s->flags &= ~SCSW_FLAGS_MASK_CC;
-- 
2.13.5
