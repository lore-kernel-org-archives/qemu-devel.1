Received: from eggs.gnu.org ([2001:4830:134:3::10]:40450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cuKGK-0005qp-AL
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cuKGH-0003tY-8e
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:44:20 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat,  1 Apr 2017 20:14:32 +0530
Message-Id: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v3 0/6] Optiomize VMDK I/O by allocating
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

This series helps to optimize the I/O performance of VMDK driver.

Patch 1 helps us to move vmdk_find_offset_in_cluster.

Patch 2 performs a simple function re-naming task.

Patch 3 adds new functions to help us allocate multiple clusters according to
the size requested, perform COW if required and return the offset of the first
newly allocated cluster. Also make loading of metadata tables easier and
avoid code duplication.

Patch 4 performs a simple function re-naming task and re-factors it to make use of
new metadata functions to avoid code duplication.

Patch 5 helps to set the upper limit of the bytes handled in one cycle.

Patch 6 changes the metadata update code to update the L2 tables for multiple
clusters at once.

Note: v3 has an addition of new optimization of calling bdrv_pwrite_sync() only
once for atmost 512 clusters, as a result performance has increased to a great
extent (earlier till v2 it was 29%).

Optimization test results:

This patch series improves 128 KB sequential write performance to an
empty VMDK file by 54%

Benchmark command: ./qemu-img bench -w -c 1024 -s 128K -d 1 -t none -f
vmdk test.vmdk

Note: These patches pass all 41/41 tests suitable for the VMDK driver.

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

Ashijeet Acharya (6):
  vmdk: Move vmdk_find_offset_in_cluster() to the top
  vmdk: Rename get_whole_cluster() to vmdk_perform_cow()
  vmdk: New functions to assist allocating multiple clusters
  vmdk: Rename get_cluster_offset() to vmdk_get_cluster_offset()
  vmdk: Set maximum bytes allocated in one cycle
  vmdk: Update metadata for multiple clusters

 block/vmdk.c | 608 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 456 insertions(+), 152 deletions(-)

-- 
2.6.2
