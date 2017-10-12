Received: from eggs.gnu.org ([2001:4830:134:3::10]:45497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dKa-0004pA-UW
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dKY-000709-02
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:15:20 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:14 +0300
Message-Id: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 00/31] Allow configuring the qcow2 L2 cache
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>

Hello all,

in September I sent an e-mail with a proposal to allow reducing the
size of entries in the qcow2 L2 cache in order to improve performance
and make a more efficient use of the cache memory. You can follow this
link for the full details:

   https://lists.gnu.org/archive/html/qemu-block/2017-09/msg00635.html

This series is the implementation of this feature. It adds a new
parameter for the qcow2 driver named l2-cache-entry-size (related to
the existing l2-cache-size). With this, the qcow2 driver no longer
needs to read full L2 tables for cluster lookups but smaller chunks
which I call L2 slices, following John Snow's suggestion.

The L2 slice size has the same restrictions as the cluster size: it
has to be a power of wo between 512 bytes and the image's cluster
size.

I tried to be conservative in general so the slice size is equal to
the cluster size by default (i.e. there should be no user-visible
changes if you don't enable this). I believe that 4KB is probably the
best default, but I'd like to test a bit with different scenarios and
cluster sizes, and we can decide on a default value in the next
revision of the series, or later.

About the patches themselves, please do not be discouraged by the size
of the series :) Many of the changes are trivial and don't introduce
any semantic changes but instead simply rename variable names or
remove obsolete parameters. The patches that do introduce semantic
changes are -I believe- easy to follow. The ones that seem more
complicated are because they have a new nested loop. I suggest that
you read them with 'diff -w' in order to hide the effects of the
indentation changes.

I also tried to keep each patch touching one single function. The
nature of the changes allows for that, and should make the code easier
to review.

Here's a general overview of the series:

- Patch 1 is a documentation fix.
- Patch 2 adds a field to Qcow2Cache to store the table size.
- Patches 3-11 remove obsolete BDS parameters from the API as a result
  of the changes in patch 2.
- Patches 12-14 add new auxiliary functions to calculate offsets.
- Patches 15-26 update existing functions to handle L2 slices
  correctly (the important part of the series is here).
- Patches 27-30 rename variables but don't change semantics.
- Patch 31 adds the new l2-cache-entry-size parameter.

As usual, feedback is very welcome.

Thanks in advance,

Berto

Alberto Garcia (31):
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

 block/qcow2-cache.c    |  78 ++++----
 block/qcow2-cluster.c  | 493 ++++++++++++++++++++++++++-----------------------
 block/qcow2-refcount.c | 200 ++++++++++----------
 block/qcow2.c          |  59 ++++--
 block/qcow2.h          |  29 ++-
 5 files changed, 469 insertions(+), 390 deletions(-)

-- 
2.11.0
