Received: from eggs.gnu.org ([209.51.188.92]:45028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1glXNn-0002ZJ-JB
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1glXNg-0003qd-Le
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:04:46 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 21 Jan 2019 12:03:50 +0100
Message-Id: <20190121110354.2247-2-cohuck@redhat.com>
In-Reply-To: <20190121110354.2247-1-cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] vfio-ccw: make it safe to access
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

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 3 +++
 drivers/s390/cio/vfio_ccw_cp.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 70a006ba4d05..714987ceea9a 100644
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
-- 
2.17.2
