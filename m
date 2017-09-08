Received: from eggs.gnu.org ([2001:4830:134:3::10]:44057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqL9T-0000bA-Ek
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqL9O-0004of-Ez
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45748
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dqL9O-0004nj-8q
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:24:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v88FO09h032292
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 11:24:55 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cuvvtb7gr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 11:24:54 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 16:24:53 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  8 Sep 2017 17:24:43 +0200
In-Reply-To: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170908152446.14606-2-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/4] s390x/css: drop data-check in
 interpretation
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

---

Was posted as stand alone patch. See:
http://patchwork.ozlabs.org/patch/810995/

If you are going to, *please review there*.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 901dc6a0f3..09f6ba0310 100644
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
