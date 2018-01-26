Received: from eggs.gnu.org ([2001:4830:134:3::10]:47628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5yy-0000Ju-2O
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5yq-0001qj-9I
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:32:00 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 26 Jan 2018 16:59:27 +0200
Message-Id: <cover.1516978645.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 00/39] Allow configuring the qcow2 L2 cache
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

this is the new revision of the patch series to allow configuring the
entry size of the qcow2 L2 cache. Follow this link for the full
description from the first version:

   https://lists.gnu.org/archive/html/qemu-block/2017-10/msg00458.html

And here are some numbers showing the performance improvements:

   https://lists.gnu.org/archive/html/qemu-block/2017-12/msg00507.html

There are more patches in this revision but that's because I split the
hairiest ones as Eric suggested. Those should be much easier to review
now. There's also a few new test cases.

Regards,

Berto

Changes:

v3:
- Rebased on top of 1867d97b372d452184c65e8fcc273cfc45937541
- Patch 2: Use QEMU_IS_ALIGNED() instead of doing the bit operations
           manually [Eric]
- Patch 13: Clarify that l2_slice_size means size in entries, not
            bytes [Eric].
- Patch 16-17: The previous code has been splitted into patches 16 and
               17 for clarity.
- Patch 17: Use slice_size2 for storing the size of the slice in bytes
            (keeping the existing convention used in l1_size2 or
            refcount_table_size2)
- Patch 17: Flush the cache only once [Anton, Eric]
- Patch 17: Call l2_load() after qcow2_free_clusters() [Anton]
- Patch 18 [new]: Refactor the l2_load() call in get_cluster_table()
           [Anton]
- Patch 19: Fix typo [Eric]
- Patch 26-27: The previous code has been splitted into patches 26 and
               27 for clarity.
- Patch 27: Use slice_size2 for storing the size of the slice in bytes
- Patch 28-30: The previous code has been splitted into patches 28, 29
               and 30 for clarity.
- Patch 30: Use slice_size2 for storing the size of the slice in bytes
- Patch 30: Replace bdrv_read/write() with bdrv_pread/pwrite() [Eric]
- Patch 30: Initialize l2_dirty inside the inner loop [Anton]
- Patch 36: Fix maybe-uninitialized warning of l2_cache_entry_size
            [Anton]
- Patch 36: Make MIN_L2_CACHE_SIZE the minimum number of cache
            entries, not clusters [Anton]
- Patch 36: Add l2-cache-entry-size to BlockdevOptionsQcow2 [Eric]
- Patch 37-39: New iotests.

v2: https://lists.gnu.org/archive/html/qemu-block/2017-12/msg00507.html
- Rebased after the v2.11.0 release.
- Patch 2: Adjust the unaligned access check introduce by Max in 4efb1f7c612
- Patch 18: Prevent overflow when computing bytes_available in
  qcow2_get_cluster_offset()
- Patch 31: Fix typo in error message in read_cache_sizes()
- Patch 32 [new]: Add test for l2-cache-entry-size'

v1: https://lists.gnu.org/archive/html/qemu-block/2017-10/msg00458.html
- Initial version

Here's the ouput of git backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/39:[----] [--] 'qcow2: Fix documentation of get_cluster_table()'
002/39:[0002] [FC] 'qcow2: Add table size field to Qcow2Cache'
003/39:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_get_table_addr()'
004/39:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_get_table_idx()'
005/39:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_table_release()'
006/39:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_entry_mark_dirty()'
007/39:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_put()'
008/39:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_destroy()'
009/39:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_clean_unused()'
010/39:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_discard()'
011/39:[----] [--] 'qcow2: Remove BDS parameter from qcow2_cache_is_table_offset()'
012/39:[----] [--] 'qcow2: Add offset_to_l1_index()'
013/39:[0002] [FC] 'qcow2: Add l2_slice_size field to BDRVQcow2State'
014/39:[----] [--] 'qcow2: Add offset_to_l2_slice_index()'
015/39:[----] [--] 'qcow2: Update l2_load() to support L2 slices'
016/39:[down] 'qcow2: Prepare l2_allocate() for adding L2 slice support'
017/39:[0088] [FC] 'qcow2: Update l2_allocate() to support L2 slices'
018/39:[down] 'qcow2: Refactor get_cluster_table()'
019/39:[0016] [FC] 'qcow2: Update get_cluster_table() to support L2 slices'
020/39:[----] [--] 'qcow2: Update qcow2_get_cluster_offset() to support L2 slices'
021/39:[----] [--] 'qcow2: Update qcow2_alloc_cluster_link_l2() to support L2 slices'
022/39:[----] [--] 'qcow2: Update handle_copied() to support L2 slices'
023/39:[----] [--] 'qcow2: Update handle_alloc() to support L2 slices'
024/39:[----] [--] 'qcow2: Update discard_single_l2() to support L2 slices'
025/39:[----] [--] 'qcow2: Update zero_single_l2() to support L2 slices'
026/39:[down] 'qcow2: Prepare qcow2_update_snapshot_refcount() for adding L2 slice support'
027/39:[0147] [FC] 'qcow2: Update qcow2_update_snapshot_refcount() to support L2 slices'
028/39:[down] 'qcow2: Read refcount before L2 table in expand_zero_clusters_in_l1()'
029/39:[down] 'qcow2: Prepare expand_zero_clusters_in_l1() for adding L2 slice support'
030/39:[0211] [FC] 'qcow2: Update expand_zero_clusters_in_l1() to support L2 slices'
031/39:[----] [--] 'qcow2: Update qcow2_truncate() to support L2 slices'
032/39:[----] [--] 'qcow2: Rename l2_table in qcow2_alloc_compressed_cluster_offset()'
033/39:[----] [--] 'qcow2: Rename l2_table in count_contiguous_clusters()'
034/39:[----] [--] 'qcow2: Rename l2_table in count_contiguous_clusters_unallocated()'
035/39:[----] [--] 'qcow2: Rename l2_table in count_cow_clusters()'
036/39:[0015] [FC] 'qcow2: Allow configuring the L2 slice size'
037/39:[down] 'iotests: Test valid values of l2-cache-entry-size'
038/39:[down] 'iotests: Test downgrading an image using a small L2 slice size'
039/39:[down] 'iotests: Add l2-cache-entry-size to iotest 137'

Alberto Garcia (39):
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
  qcow2: Prepare l2_allocate() for adding L2 slice support
  qcow2: Update l2_allocate() to support L2 slices
  qcow2: Refactor get_cluster_table()
  qcow2: Update get_cluster_table() to support L2 slices
  qcow2: Update qcow2_get_cluster_offset() to support L2 slices
  qcow2: Update qcow2_alloc_cluster_link_l2() to support L2 slices
  qcow2: Update handle_copied() to support L2 slices
  qcow2: Update handle_alloc() to support L2 slices
  qcow2: Update discard_single_l2() to support L2 slices
  qcow2: Update zero_single_l2() to support L2 slices
  qcow2: Prepare qcow2_update_snapshot_refcount() for adding L2 slice
    support
  qcow2: Update qcow2_update_snapshot_refcount() to support L2 slices
  qcow2: Read refcount before L2 table in expand_zero_clusters_in_l1()
  qcow2: Prepare expand_zero_clusters_in_l1() for adding L2 slice
    support
  qcow2: Update expand_zero_clusters_in_l1() to support L2 slices
  qcow2: Update qcow2_truncate() to support L2 slices
  qcow2: Rename l2_table in qcow2_alloc_compressed_cluster_offset()
  qcow2: Rename l2_table in count_contiguous_clusters()
  qcow2: Rename l2_table in count_contiguous_clusters_unallocated()
  qcow2: Rename l2_table in count_cow_clusters()
  qcow2: Allow configuring the L2 slice size
  iotests: Test valid values of l2-cache-entry-size
  iotests: Test downgrading an image using a small L2 slice size
  iotests: Add l2-cache-entry-size to iotest 137

 block/qcow2-cache.c        |  80 ++++----
 block/qcow2-cluster.c      | 492 ++++++++++++++++++++++++---------------------
 block/qcow2-refcount.c     | 199 +++++++++---------
 block/qcow2.c              |  60 ++++--
 block/qcow2.h              |  31 ++-
 qapi/block-core.json       |   6 +
 tests/qemu-iotests/061     |  16 ++
 tests/qemu-iotests/061.out |  61 ++++++
 tests/qemu-iotests/103     |  17 ++
 tests/qemu-iotests/103.out |   3 +
 tests/qemu-iotests/137     |   5 +
 tests/qemu-iotests/137.out |   2 +
 12 files changed, 575 insertions(+), 397 deletions(-)

-- 
2.11.0
