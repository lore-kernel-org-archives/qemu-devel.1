Received: from eggs.gnu.org ([2001:4830:134:3::10]:55259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVek-0004Eo-M6
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVef-0006b6-Pi
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:22:34 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 29 Jun 2017 14:53:33 +0530
Message-Id: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v7 0/8] Optimize VMDK I/O by allocating
 multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Previously posted series patches:
v1 - http://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg02044.html
v2 - http://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg05080.html
v3 - http://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg00074.html
v4 - http://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg03851.html
v5 - http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg00929.html
v6 - http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg00947.html

This series helps to optimize the I/O performance of VMDK driver.

Patch 1 helps us to move vmdk_find_offset_in_cluster.

Patch 2 & 3 perform a simple function re-naming tasks.

Patch 4 is used to factor out metadata loading code and implement it in separate
functions. This will help us to avoid code duplication in future patches of this
series.

Patch 5 helps to set the upper limit of the bytes handled in one cycle.

Patch 6 adds new functions to help us allocate multiple clusters according to
the size requested, perform COW if required and return the offset of the first
newly allocated cluster.

Patch 7 changes the metadata update code to update the L2 tables for multiple
clusters at once.

Patch 8 helps us to finally change vmdk_get_cluster_offset() to find cluster offset
only as cluster allocation task is now handled by vmdk_alloc_clusters()

Optimization test results:

This patch series improves 128 KB sequential write performance to an
empty VMDK file by 54%

Benchmark command: ./qemu-img bench -w -c 1024 -s 128K -d 1 -t none -f
vmdk test.vmdk

Changes in v7:
- comment the use of MIN() in calculating skip_end_bytes
- use extent->cluster_sectors instead of 128
- place check for m_data != NULL
- use g_new0(VmdkMetaData, 1) instead of g_malloc0(sizeof(*m_data))

Changes in v6:
- rename total_alloc_clusters as alloc_clusters_counter (fam)

Changes in v5:
- fix commit message and comment in patch 4 (fam)
- add vmdk_ prefix to handle_alloc() (fam)
- fix alignment issue in patch 6 (fam)
- use BDRV_SECTOR_BITS (fam)
- fix endianness calculation in patch 7 (fam)

Changes in v4:
- fix commit message in patch 1 (fam)
- drop size_to_clusters() function (fam)
- fix grammatical errors in function documentations (fam)
- factor out metadata loading coding in a separate patch (patch 4) (fam)
- rename vmdk_alloc_cluster_offset() to vmdk_alloc_clusters() (fam)
- break patch 4(in v3) into separate patches (patch 3 and 8) (fam)
- rename extent_size to extent_end (fam)
- use QEMU_ALIGN_UP instead of vmdk_align_offset. (fam)
- drop next and simply do m_data = m_data->next (fam)

Changes in v3:
- move size_to_clusters() from patch 1 to 3 (fam)
- use DIV_ROUND_UP in size_to_clusters (fam)
- make patch 2 compilable (fam)
- rename vmdk_L2update as vmdk_l2update and use UINT32_MAX (fam)
- combine patch 3 and patch 4 (as in v2) to make them compilable (fam)
- call bdrv_pwrite_sync() for batches of atmost 512 clusters at once (fam)

Changes in v2:
- segregate the ugly Patch 1 in v1 into 6 readable and sensible patches
- include benchmark test results in v2

Ashijeet Acharya (8):
  vmdk: Move vmdk_find_offset_in_cluster() to the top
  vmdk: Rename get_whole_cluster() to vmdk_perform_cow()
  vmdk: Rename get_cluster_offset() to vmdk_get_cluster_offset()
  vmdk: Factor out metadata loading code out of
    vmdk_get_cluster_offset()
  vmdk: Set maximum bytes allocated in one cycle
  vmdk: New functions to assist allocating multiple clusters
  vmdk: Update metadata for multiple clusters
  vmdk: Make vmdk_get_cluster_offset() return cluster offset only

 block/vmdk.c | 537 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 415 insertions(+), 122 deletions(-)

-- 
2.6.2
