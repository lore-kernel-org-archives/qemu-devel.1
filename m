Received: from eggs.gnu.org ([2001:4830:134:3::10]:41102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fGRKQ-0000b3-KF
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fGRKP-0006Aj-6c
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:30 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  9 May 2018 17:48:22 +0200
Message-Id: <20180509154822.23510-3-cohuck@redhat.com>
In-Reply-To: <20180509154822.23510-1-cohuck@redhat.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Currently, vfio-ccw only relays start subchannel requests to the real
hardware, which is enough in many cases but falls short e.g. during
error recovery.

Fortunately, it is easy to add support for halt and clear subchannel
requests to the existing infrastructure. User space can detect
support for halt/clear subchannel easily, as we always returned
-EOPNOTSUPP before and therefore we do not need any capability to
make this support discoverable.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 10 ++++-
 drivers/s390/cio/vfio_ccw_fsm.c | 94 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 92 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ea6a2d0b2894..6212d577117f 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -76,8 +76,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	irb = &private->irb;
 
 	if (scsw_is_solicited(&irb->scsw)) {
-		cp_update_scsw(&private->cp, &irb->scsw);
-		cp_free(&private->cp);
+		/*
+		 * For the start function, we need to update based on the
+		 * channel program. Nothing needs to be done for halt/clear.
+		 */
+		if (scsw_fctl(&irb->scsw) & SCSW_FCTL_START_FUNC) {
+			cp_update_scsw(&private->cp, &irb->scsw);
+			cp_free(&private->cp);
+		}
 	}
 	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
 
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 3c800642134e..94cae2984c35 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -3,8 +3,10 @@
  * Finite state machine for vfio-ccw device handling
  *
  * Copyright IBM Corp. 2017
+ * Copyright Red Hat, Inc. 2018
  *
  * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Cornelia Huck <cohuck@redhat.com>
  */
 
 #include <linux/vfio.h>
@@ -65,6 +67,70 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	return ret;
 }
 
+static int fsm_halt_helper(struct vfio_ccw_private *private)
+{
+	struct subchannel *sch;
+	int ccode;
+	unsigned long flags;
+	int ret;
+
+	sch = private->sch;
+
+	spin_lock_irqsave(sch->lock, flags);
+	private->state = VFIO_CCW_STATE_BUSY;
+
+	/* Issue "Halt Subchannel" */
+	ccode = hsch(sch->schid);
+
+	switch (ccode) {
+	case 0:
+		/*
+		 * Initialize device status information
+		 */
+		sch->schib.scsw.cmd.actl |= SCSW_ACTL_HALT_PEND;
+		ret = 0;
+		break;
+	case 1:		/* Status pending */
+	case 2:		/* Busy */
+		ret = -EBUSY;
+		break;
+	default:	/* Device not operational */
+		ret = -ENODEV;
+	}
+	spin_unlock_irqrestore(sch->lock, flags);
+	return ret;
+}
+
+static int fsm_clear_helper(struct vfio_ccw_private *private)
+{
+	struct subchannel *sch;
+	int ccode;
+	unsigned long flags;
+	int ret;
+
+	sch = private->sch;
+
+	spin_lock_irqsave(sch->lock, flags);
+	private->state = VFIO_CCW_STATE_BUSY;
+
+	/* Issue "Clear Subchannel" */
+	ccode = csch(sch->schid);
+
+	switch (ccode) {
+	case 0:
+		/*
+		 * Initialize device status information
+		 */
+		sch->schib.scsw.cmd.actl |= SCSW_ACTL_CLEAR_PEND;
+		ret = 0;
+		break;
+	default:	/* Device not operational */
+		ret = -ENODEV;
+	}
+	spin_unlock_irqrestore(sch->lock, flags);
+	return ret;
+}
+
 static void fsm_notoper(struct vfio_ccw_private *private,
 			enum vfio_ccw_event event)
 {
@@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 
 	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
 
-	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
+	/*
+	 * Start processing with the clear function, then halt, then start.
+	 * We may still be start pending when the caller wants to clean
+	 * up things via halt/clear.
+	 */
+	if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
+		/* issue clear and wait for interupt */
+		io_region->ret_code = fsm_clear_helper(private);
+		if (io_region->ret_code)
+			goto err_out;
+		return;
+	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
+		/* issue halt and wait for interrupt */
+		io_region->ret_code = fsm_halt_helper(private);
+		if (io_region->ret_code)
+			goto err_out;
+		return;
+	} else if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
 		orb = (union orb *)io_region->orb_area;
 
 		/* Don't try to build a cp if transport mode is specified. */
@@ -152,16 +235,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 			goto err_out;
 		}
 		return;
-	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
-		/* XXX: Handle halt. */
-		io_region->ret_code = -EOPNOTSUPP;
-		goto err_out;
-	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
-		/* XXX: Handle clear. */
-		io_region->ret_code = -EOPNOTSUPP;
-		goto err_out;
 	}
-
 err_out:
 	private->state = VFIO_CCW_STATE_IDLE;
 }
-- 
2.14.3
