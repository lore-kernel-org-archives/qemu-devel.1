Received: from eggs.gnu.org ([2001:4830:134:3::10]:52781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cJarG-0007QN-OG
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cJarD-0006dL-L7
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:58:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:16597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cJarD-0006dB-BA
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:58:35 -0500
From: Liang Li <liang.z.li@intel.com>
Date: Wed, 21 Dec 2016 14:52:23 +0800
Message-Id: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
Subject: [Qemu-devel] [PATCH v6 kernel 0/5] Extend virtio-balloon for fast
 (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, amit.shah@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, mst@redhat.com, david@redhat.com, aarcange@redhat.com, dgilbert@redhat.com, quintela@redhat.com, Liang Li <liang.z.li@intel.com>

This patch set contains two parts of changes to the virtio-balloon.
 
One is the change for speeding up the inflating & deflating process,
the main idea of this optimization is to use {pfn|length} to present
the page information instead of the PFNs, to reduce the overhead of
virtio data transmission, address translation and madvise(). This can
help to improve the performance by about 85%.
 
Another change is for speeding up live migration. By skipping process
guest's unused pages in the first round of data copy, to reduce needless
data processing, this can help to save quite a lot of CPU cycles and
network bandwidth. We put guest's unused page information in a
{pfn|length} array and send it to host with the virt queue of
virtio-balloon. For an idle guest with 8GB RAM, this can help to shorten
the total live migration time from 2Sec to about 500ms in 10Gbps network
environment. For an guest with quite a lot of page cache and with little
unused pages, it's possible to let the guest drop it's page cache before
live migration, this case can benefit from this new feature too.
 
Changes from v5 to v6:
    * Drop the bitmap from the virtio ABI, use {pfn|length} only.
    * Enhance the API to get the unused page information from mm. 

Changes from v4 to v5:
    * Drop the code to get the max_pfn, use another way instead.
    * Simplify the API to get the unused page information from mm. 

Changes from v3 to v4:
    * Use the new scheme suggested by Dave Hansen to encode the bitmap.
    * Add code which is missed in v3 to handle migrate page. 
    * Free the memory for bitmap intime once the operation is done.
    * Address some of the comments in v3.

Changes from v2 to v3:
    * Change the name of 'free page' to 'unused page'.
    * Use the scatter & gather bitmap instead of a 1MB page bitmap.
    * Fix overwriting the page bitmap after kicking.
    * Some of MST's comments for v2.
 
Changes from v1 to v2:
    * Abandon the patch for dropping page cache.
    * Put some structures to uapi head file.
    * Use a new way to determine the page bitmap size.
    * Use a unified way to send the free page information with the bitmap
    * Address the issues referred in MST's comments

Liang Li (5):
  virtio-balloon: rework deflate to add page to a list
  virtio-balloon: define new feature bit and head struct
  virtio-balloon: speed up inflate/deflate process
  virtio-balloon: define flags and head for host request vq
  virtio-balloon: tell host vm's unused page info

 drivers/virtio/virtio_balloon.c     | 510 ++++++++++++++++++++++++++++++++----
 include/linux/mm.h                  |   3 +
 include/uapi/linux/virtio_balloon.h |  34 +++
 mm/page_alloc.c                     | 120 +++++++++
 4 files changed, 621 insertions(+), 46 deletions(-)

-- 
1.9.1
