Received: from eggs.gnu.org ([2001:4830:134:3::10]:55590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVI-0000XI-Jo
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003JR-UE
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:16 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:28 +0100
Message-Id: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 00/32] Allow configuring the qcow2 L2 cache
 entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

Hello all,

this is the new revision of the patch series to allow configuring the
entry size of the qcow2 L2 cache. Follow this link for the full
description from the first version:

   https://lists.gnu.org/archive/html/qemu-block/2017-10/msg00458.html

Here are some performance numbers with a fully populated 40GB qcow2
image doing random 4k reads.

The numbers are IOPS, columns are for a different cache sizes, rows
for different entry sizes.

This is with cluster_size = 64k

   |-----------------+------+------+-------+-------+-------|
   | cache size ---> |  1MB |  2MB |   3MB |   4MB |   5MB |
   | entry size      |      |      |       |       |       |
   |-----------------+------+------+-------+-------+-------|
   | 4k              | 6449 | 8398 | 11866 | 20513 | 65827 |
   | 8k              | 6048 | 7826 | 11137 | 19184 | 68301 |
   | 16k             | 5351 | 6810 |  9764 | 16900 | 68258 |
   | 32k             | 4126 | 5390 |  7735 | 13573 | 67467 |
   | 64k             | 2820 | 3752 |  5497 | 10165 | 68106 |
   |-----------------+------+------+-------+-------+-------|

This is with cluster_size = 256k

   |-----------------+------+------+-------+-------+-------|
   | cache size ---> | 256k | 512k |  768k | 1024k | 1280k |
   | entry size      |      |      |       |       |       |
   |-----------------+------+------+-------+-------+-------|
   | 4k              | 8360 | 8330 | 11834 | 20754 | 67554 |
   | 8k              | 7839 | 7843 | 10951 | 19210 | 68111 |
   | 16k             | 6831 | 6863 |  9739 | 16920 | 68356 |
   | 32k             | 5347 | 5356 |  7746 | 13567 | 68231 |
   | 64k             | 3755 | 3743 |  5456 |  9836 | 68291 |
   | 128k            | 2526 | 2551 |  3556 |  6601 | 66765 |
   | 256k            | 1952 | 2016 |  2550 |  4107 | 67636 |
   |-----------------+------+------+-------+-------+-------|

As you can see the the difference is clearly visible and the results
are what one would expect. In the rightmost column the cache covers
the whole image, that's why changing the entry size doesn't have an
effect.

I also tried with sequential reads but then the peformance is pretty
much the same in all cases (~98K IOPS) regardless of the cache and
entry size.

The results above are for an SSD backend. I also tried with an HDD but
the numbers are not very impressive:

   |-----------------+-----+-----+-----+-----+-----|
   | cache size ---> | 1MB | 2MB | 3MB | 4MB | 5MB |
   | entry size      |     |     |     |     |     |
   |-----------------+-----+-----+-----+-----+-----|
   | 4k              |  72 |  77 |  84 |  97 | 120 |
   | 8k              |  71 |  75 |  84 | 101 | 142 |
   | 16k             |  70 |  76 |  84 | 100 | 153 |
   | 32k             |  69 |  73 |  81 |  99 | 156 |
   | 64k             |  68 |  72 |  80 |  98 | 154 |
   |-----------------+-----+-----+-----+-----+-----|

The performance difference is there, but very slight. In the 5MB
scenario having a smaller cache actually makes things worse. I think
this is because with smaller entries the cache takes longer to fill
up, requires more disk accesses and therefore more seeks.

I think this is a good reason to keep entry_size == cluster_size by
default and let the user adjust the value depending on the storage
backend.

As usual, feedback is welcome.

Berto

Changes:

v1: https://lists.gnu.org/archive/html/qemu-block/2017-10/msg00458.html
- Initial version

v2:
- Rebased after the v2.11.0 release.
- Patch 2: Adjust the unaligned access check introduce by Max in 4efb1f7c612
- Patch 18: Prevent overflow when computing bytes_available in
  qcow2_get_cluster_offset()
- Patch 31: Fix typo in error message in read_cache_sizes()
- Patch 32 [new]: Add test for l2-cache-entry-size'

Here's the ouput of git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/32:[----] [--] 'qcow2: Fix documentation of get_cluster_table()'
002/32:[0002] [FC] 'qcow2: Add table size field to Qcow2Cache'
003/32:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_get_table_addr()'
004/32:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_get_table_idx()'
005/32:[----] [-C] 'qcow2: Remove BDS parameter from qcow2_cache_table_release()'
006/32:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_entry_mark_dirty()'
007/32:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_put()'
008/32:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_destroy()'
009/32:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_clean_unused()'
010/32:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_discard()'
011/32:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_is_table_offset()'
012/32:[----] [--] 'qcow2: Add offset_to_l1_index()'
013/32:[----] [--] 'qcow2: Add l2_slice_size field to BDRVQcow2State'
014/32:[----] [--] 'qcow2: Add offset_to_l2_slice_index()'
015/32:[----] [--] 'qcow2: Update l2_load() to support L2 slices'
016/32:[----] [--] 'qcow2: Update l2_allocate() to support L2 slices'
017/32:[----] [--] 'qcow2: Update get_cluster_table() to support L2 slices'
018/32:[0003] [FC] 'qcow2: Update qcow2_get_cluster_offset() to support L2 slices'
019/32:[----] [--] 'qcow2: Update qcow2_alloc_cluster_link_l2() to support L2 slices'
020/32:[----] [--] 'qcow2: Update handle_copied() to support L2 slices'
021/32:[----] [-C] 'qcow2: Update handle_alloc() to support L2 slices'
022/32:[----] [--] 'qcow2: Update discard_single_l2() to support L2 slices'
023/32:[----] [--] 'qcow2: Update zero_single_l2() to support L2 slices'
024/32:[----] [--] 'qcow2: Update qcow2_update_snapshot_refcount() to support L2 slices'
025/32:[----] [--] 'qcow2: Update expand_zero_clusters_in_l1() to support L2 slices'
026/32:[----] [--] 'qcow2: Update qcow2_truncate() to support L2 slices'
027/32:[----] [--] 'qcow2: Rename l2_table in qcow2_alloc_compressed_cluster_offset()'
028/32:[----] [--] 'qcow2: Rename l2_table in count_contiguous_clusters()'
029/32:[----] [--] 'qcow2: Rename l2_table in count_contiguous_clusters_unallocated()'
030/32:[----] [--] 'qcow2: Rename l2_table in count_cow_clusters()'
031/32:[0002] [FC] 'qcow2: Allow configuring the L2 slice size'
032/32:[down] 'iotests: Add test for l2-cache-entry-size'

Alberto Garcia (32):
  qcow2: Fix documentation of get_cluster_table()
  qcow2: Add table size field to Qcow2Cache
  qcow2: Remove BDS parameter from qcow2_cache_get_table_addr()
  qcow2: Remove BDS parameter from qcow2_cache_get_table_idx()
  qcow2: Remove BDS parameter from qcow2_cache_table_release()
  qcow2: Remove BDS parameter from qcow2_cache_entry_mark_dirty()
  qcow2: Remove BDS parameter from qcow2_cache_put()
  qcow2: Remove BDS parameter from qcow2_cache_destroy()
  qcow2: Remove BDS parameter from qcow2_cache_clean_unused()
  qcow2: Remove BDS parameter from qcow2_cache_discard()
  qcow2: Remove BDS parameter from qcow2_cache_is_table_offset()
  qcow2: Add offset_to_l1_index()
  qcow2: Add l2_slice_size field to BDRVQcow2State
  qcow2: Add offset_to_l2_slice_index()
  qcow2: Update l2_load() to support L2 slices
  qcow2: Update l2_allocate() to support L2 slices
  qcow2: Update get_cluster_table() to support L2 slices
  qcow2: Update qcow2_get_cluster_offset() to support L2 slices
  qcow2: Update qcow2_alloc_cluster_link_l2() to support L2 slices
  qcow2: Update handle_copied() to support L2 slices
  qcow2: Update handle_alloc() to support L2 slices
  qcow2: Update discard_single_l2() to support L2 slices
  qcow2: Update zero_single_l2() to support L2 slices
  qcow2: Update qcow2_update_snapshot_refcount() to support L2 slices
  qcow2: Update expand_zero_clusters_in_l1() to support L2 slices
  qcow2: Update qcow2_truncate() to support L2 slices
  qcow2: Rename l2_table in qcow2_alloc_compressed_cluster_offset()
  qcow2: Rename l2_table in count_contiguous_clusters()
  qcow2: Rename l2_table in count_contiguous_clusters_unallocated()
  qcow2: Rename l2_table in count_cow_clusters()
  qcow2: Allow configuring the L2 slice size
  iotests: Add test for l2-cache-entry-size

 block/qcow2-cache.c        |  80 ++++----
 block/qcow2-cluster.c      | 494 ++++++++++++++++++++++++---------------------
 block/qcow2-refcount.c     | 200 +++++++++---------
 block/qcow2.c              |  59 ++++--
 block/qcow2.h              |  29 ++-
 tests/qemu-iotests/103     |  17 ++
 tests/qemu-iotests/103.out |   3 +
 7 files changed, 491 insertions(+), 391 deletions(-)

-- 
2.11.0
