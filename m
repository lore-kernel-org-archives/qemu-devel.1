Received: from eggs.gnu.org ([2001:4830:134:3::10]:38686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdF-0005tb-24
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdE-0002di-66
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLdE-0002cL-1L
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:20 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:06 +0200
Message-Id: <20170919164337.18555-8-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 07/38] s390x/css: drop data-check in
 interpretation
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
Message-Id: <20170908152446.14606-2-pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 5d3de71c4c..bab78fc79a 100644
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
