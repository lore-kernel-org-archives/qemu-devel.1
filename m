Received: from eggs.gnu.org ([2001:4830:134:3::10]:49615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eRH71-0003pS-Kb
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eRH70-0000OH-JH
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:35:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:51438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eRH70-0000Bf-9e
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:35:10 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 19 Dec 2017 20:17:59 +0800
Message-Id: <1513685879-21823-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v20 7/7] virtio-balloon: don't report free
 pages when page poisoning is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

The guest free pages should not be discarded by the live migration thread
when page poisoning is enabled with PAGE_POISONING_NO_SANITY=n, because
skipping the transfer of such poisoned free pages will trigger false
positive when new pages are allocated and checked on the destination.
This patch adds a config field, poison_val. Guest writes to the config
field to tell the host about the poisoning value. The value will be 0 in
the following cases:
1) PAGE_POISONING_NO_SANITY is enabled;
2) page poisoning is disabled; or
3) PAGE_POISONING_ZERO is enabled.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
---
 drivers/virtio/virtio_balloon.c     | 8 ++++++++
 include/uapi/linux/virtio_balloon.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index eae65c1..1fa8598 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -860,6 +860,7 @@ static struct file_system_type balloon_fs = {
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
+	__u32 poison_val;
 	int err;
 
 	if (!vdev->config->get) {
@@ -897,6 +898,13 @@ static int virtballoon_probe(struct virtio_device *vdev)
 					WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
 		INIT_WORK(&vb->report_free_page_work, report_free_page);
 		vb->stop_cmd_id = VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID;
+		if (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
+		    !page_poisoning_enabled())
+			poison_val = 0;
+		else
+			poison_val = PAGE_POISON;
+		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
+			      poison_val, &poison_val);
 	}
 
 	vb->nb.notifier_call = virtballoon_oom_notify;
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 58f1274..f270e9e 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -48,6 +48,8 @@ struct virtio_balloon_config {
 	__u32 actual;
 	/* Free page report command id, readonly by guest */
 	__u32 free_page_report_cmd_id;
+	/* Stores PAGE_POISON if page poisoning with sanity check is in use */
+	__u32 poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
2.7.4
