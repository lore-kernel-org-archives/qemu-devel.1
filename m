Received: from eggs.gnu.org ([2001:4830:134:3::10]:35065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1crji1-00014x-HE
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1crjhy-0000n3-E2
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:18:13 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat, 25 Mar 2017 16:48:14 +0530
Message-Id: <1490440701-12037-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/7] Optiomize VMDK I/O by allocating
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
http://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg02044.html

This series helps to optimize the I/O performance of VMDK driver.

Patch 1 helps us to refactor and introduce some new helper functions.

Patch 2 performs a simple function re-naming task.

Patch 3 introduces two new functions to make loading of metadata tables easier and
avoid code duplication.

Patch 4 adds two new functions to help us allocate multiple clusters according to
the size requested, perform COW if required and return the offset of the first
newly allocated cluster.

Patch 5 performs a simple function re-naming task and re-factors it to make use of
new metadata functions to avoid code duplication.

Patch 6 helps to allocate multiple clusters by making use of the new cluster
allocation functions and sets bytes requested in one cycle to be not more than the
extent size.

Patch 7 changes the metadata update code to update the L2 tables for multiple
clusters at once.

Optimization test results:

This patch series improves 128 KB sequential write performance to an
empty VMDK file by 29%.

Benchmark command: ./qemu-img bench -w -c 1024 -s 128K -d 1 -t none -f
vmdk test.vmdk

Note: These patches pass all 41/41 tests suitable for the VMDK driver.

Changes in v2:
- segregate the ugly Patch 1 in v1 into 6 readable and sensible patches
- include benchmark test results in v2

Ashijeet Acharya (7):
  vmdk: Refactor and introduce new helper functions
  vmdk: Rename get_whole_cluster() to vmdk_perform_cow()
  vmdk: Factor out metadata loading code out of get_cluster_offset()
  vmdk: New functions to allocate multiple clusters and cluster offset
  vmdk: Rename get_cluster_offset() to vmdk_get_cluster_offset()
  vmdk: Allocate multiple clusters at once
  vmdk: Update metadata for multiple clusters

 block/vmdk.c | 595 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 443 insertions(+), 152 deletions(-)

-- 
2.6.2
