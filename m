Received: from eggs.gnu.org ([209.51.188.92]:36404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goppL-00016i-Eo
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goppJ-00062W-Ka
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:22:51 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Jan 2019 14:22:07 +0100
Message-Id: <20190130132212.7376-2-cohuck@redhat.com>
In-Reply-To: <20190130132212.7376-1-cohuck@redhat.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/6] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>

When we get a solicited interrupt, the start function may have
been cleared by a csch, but we still have a channel program
structure allocated. Make it safe to call the cp accessors in
any case, so we can call them unconditionally.

While at it, also make sure that functions called from other parts
of the code return gracefully if the channel program structure
has not been initialized (even though that is a bug in the caller).

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c  | 20 +++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_cp.h  |  2 ++
 drivers/s390/cio/vfio_ccw_fsm.c |  5 +++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index ba08fe137c2e..0bc0c38edda7 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -335,6 +335,7 @@ static void cp_unpin_free(struct channel_program *cp)
 	struct ccwchain *chain, *temp;
 	int i;
 
+	cp->initialized = false;
 	list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
 		for (i = 0; i < chain->ch_len; i++) {
 			pfn_array_table_unpin_free(chain->ch_pat + i,
@@ -701,6 +702,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	 */
 	cp->orb.cmd.c64 = 1;
 
+	cp->initialized = true;
+
 	return ret;
 }
 
@@ -715,7 +718,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
  */
 void cp_free(struct channel_program *cp)
 {
-	cp_unpin_free(cp);
+	if (cp->initialized)
+		cp_unpin_free(cp);
 }
 
 /**
@@ -760,6 +764,10 @@ int cp_prefetch(struct channel_program *cp)
 	struct ccwchain *chain;
 	int len, idx, ret;
 
+	/* this is an error in the caller */
+	if (!cp || !cp->initialized)
+		return -EINVAL;
+
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		len = chain->ch_len;
 		for (idx = 0; idx < len; idx++) {
@@ -795,6 +803,10 @@ union orb *cp_get_orb(struct channel_program *cp, u32 intparm, u8 lpm)
 	struct ccwchain *chain;
 	struct ccw1 *cpa;
 
+	/* this is an error in the caller */
+	if (!cp || !cp->initialized)
+		return NULL;
+
 	orb = &cp->orb;
 
 	orb->cmd.intparm = intparm;
@@ -831,6 +843,9 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
 	u32 cpa = scsw->cmd.cpa;
 	u32 ccw_head, ccw_tail;
 
+	if (!cp->initialized)
+		return;
+
 	/*
 	 * LATER:
 	 * For now, only update the cmd.cpa part. We may need to deal with
@@ -869,6 +884,9 @@ bool cp_iova_pinned(struct channel_program *cp, u64 iova)
 	struct ccwchain *chain;
 	int i;
 
+	if (!cp->initialized)
+		return false;
+
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		for (i = 0; i < chain->ch_len; i++)
 			if (pfn_array_table_iova_pinned(chain->ch_pat + i,
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index a4b74fb1aa57..3c20cd208da5 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -21,6 +21,7 @@
  * @ccwchain_list: list head of ccwchains
  * @orb: orb for the currently processed ssch request
  * @mdev: the mediated device to perform page pinning/unpinning
+ * @initialized: whether this instance is actually initialized
  *
  * @ccwchain_list is the head of a ccwchain list, that contents the
  * translated result of the guest channel program that pointed out by
@@ -30,6 +31,7 @@ struct channel_program {
 	struct list_head ccwchain_list;
 	union orb orb;
 	struct device *mdev;
+	bool initialized;
 };
 
 extern int cp_init(struct channel_program *cp, struct device *mdev,
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index cab17865aafe..e7c9877c9f1e 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -31,6 +31,10 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	private->state = VFIO_CCW_STATE_BUSY;
 
 	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
+	if (!orb) {
+		ret = -EIO;
+		goto out;
+	}
 
 	/* Issue "Start Subchannel" */
 	ccode = ssch(sch->schid, orb);
@@ -64,6 +68,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	default:
 		ret = ccode;
 	}
+out:
 	spin_unlock_irqrestore(sch->lock, flags);
 	return ret;
 }
-- 
2.17.2
