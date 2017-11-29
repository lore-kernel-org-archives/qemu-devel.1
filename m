Received: from eggs.gnu.org ([2001:4830:134:3::10]:59088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eK35c-0002Gm-MV
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eK35a-0004GO-J1
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:11:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:52215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eK35a-0003cm-Am
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:11:50 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 29 Nov 2017 21:55:26 +0800
Message-Id: <1511963726-34070-11-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v18 10/10] virtio-balloon: don't report free
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
Cc: david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

The guest free pages should not be discarded by the live migration thread
when page poisoning is enabled with PAGE_POISONING_NO_SANITY=n, because
skipping the transfer of such poisoned free pages will trigger false
positive when new pages are allocated and checked on the destination.
This patch skips the reporting of free pages in the above case.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
---
 drivers/virtio/virtio_balloon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 035bd3a..6ac4cff 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -652,7 +652,9 @@ static void report_free_page(struct work_struct *work)
 	/* Start by sending the obtained cmd id to the host with an outbuf */
 	send_one_desc(vb, vb->free_page_vq, virt_to_phys(&vb->start_cmd_id),
 		      sizeof(uint32_t), false, true, false);
-	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
+	if (!(page_poisoning_enabled() &&
+	    !IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY)))
+		walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
 	/*
 	 * End by sending the stop id to the host with an outbuf. Use the
 	 * non-batching mode here to trigger a kick after adding the stop id.
-- 
2.7.4
