Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66768C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2127220640
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VdCNRYCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2127220640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOqx-0004yd-Mu
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iKOgz-0002l0-56
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iKOgw-0003ff-S3
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:24:57 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iKOgw-0003ZI-58; Tue, 15 Oct 2019 11:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=bWkkZk8wHajg+H7Xkl8htXn0YTrSQIy/ZE4ciLqOUSg=; 
 b=VdCNRYCLnd77Es/6UsqYqyJdbj6uypQEycITBnTL4bOuBC4XNiDkmU+3fkm3+Hp9+z3rg2yeORwPouyYppAUg5E8iIjxrlLgcW0NZgVkSLfIzxfh9JBXNliAyJeMVwFmsa/L7V2GuTUK33KUH+/FMgYDXQ5xlR0VOM5y7BQe91wGvCRopdj0v9q/aAa3j56SdiHHLl3kGg//xMxivK2/leNU0s9iCbtJMfrE51z0GoiTmeJxg9oDCkPh7hqe0zz7rXigekamPFPnzHcdDCNqcwk8RUHt3xkEi6tOt6c+c5wvQGQ+dAZKdIJ0TGZBV/MyXfBn/+LL5lWGg4upcUfD/Q==;
Received: from 82-181-115-92.bb.dnainternet.fi ([82.181.115.92]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iKOge-0003aO-0k; Tue, 15 Oct 2019 17:24:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iKOfm-000613-Ez; Tue, 15 Oct 2019 18:23:42 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/23] Add subcluster allocation to qcow2
Date: Tue, 15 Oct 2019 18:23:11 +0300
Message-Id: <cover.1571152571.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

this series adds a new feature to the qcow2 on-disk format called
"Extended L2 Entries", which allows us to do subcluster allocation.

This cover letter explains the reasons behind this proposal, the
changes to the on-disk format, test results and pending work. If you
are curious you can also have a look at previous discussions about
this feature:

   https://lists.gnu.org/archive/html/qemu-block/2017-04/msg00178.html
   https://lists.gnu.org/archive/html/qemu-block/2019-06/msg01155.html

This is the first proper version of the patches, and I believe that
the implementation is complete. However since I'm proposing a change
to the on-disk format I'm labeling this as RFC because I'm expecting
some debate. I'll remove the RFC tag and add more tests in future
revisions.

=== Problem ===

A qcow2 image is divided into units of constant size called clusters,
and among other things it contains metadata that maps guest addresses
to host addresses (the so-called L1 and L2 tables).

There are two basic problems that result from this:

1) Reading from or writing to a qcow2 image involves reading the
   corresponding entry on the L2 table that maps the guest address to
   the host address. This is very slow because it involves two I/O
   operations: one on the L2 table and the other one on the actual
   data cluster.

2) A cluster is the smallest unit of allocation. Therefore writing a
   mere 512 bytes to an empty disk requires allocating a complete
   cluster and filling it with zeroes (or with data from the backing
   image if there is one). This wastes more disk space and also has a
   negative impact on I/O.

Problem (1) can be solved by caching the L2 tables in memory. The
maximum amount of disk space used by L2 tables depends on the virtual
disk size and the cluster size:

   max_l2_size = virtual_disk_size * 8 / cluster_size

Because of this, the only way to reduce the size of the L2 tables is
by increasing the cluster size (which can be any power of two between
512 bytes and 2 MB). But then we hit problem (2): I/O is slower and
more disk space is wasted.

=== The proposal ===

The proposal is to extend the qcow2 format by allowing subcluster
allocation. The on-disk format remains essentially the same, except
that each data cluster is internally divided into 32 subclusters of
equal size.

The way it works in practice is with a new optional feature called
"Extended L2 Entries", that needs to be enabled when an image is
created. With this, each entry on an L2 table is accompanied by a
bitmap indicating the allocation state of each one of the subclusters
for that cluster. The size of an L2 entry doubles from 64 to 128 bits.

Other than L2 entries, all other data structures remain unchanged, but
for data clusters the smallest unit of allocation is now the
subcluster. Reference counting is still at the cluster level, because
there is no way to reference individual subclusters. Copy-on-write on
internal snapshots needs to copy complete clusters, so that scenario
would not benefit from this change.

I see two main use cases for this feature:

a) The qcow2 image is not too large / the L2 cache is not a problem,
   but you want to increase the allocation performance. In this case
   you can have a 128KB cluster with 4KB subclusters (with 4KB being a
   common block size in ext4 and other filesystems)

b) The qcow2 image is very large and you want to save metadata space
   in order to have a smaller L2 cache. In this case you can go for
   the maximum cluster size (2MB) but you want to have smaller
   subclusters to increase the allocation performance and optimize the
   disk usage.

=== Changes to the on-disk format ===

An L2 entry is 64 bits wide, with this format (for uncompressed
clusters):

63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
**<----> <--------------------------------------------------><------->*
  Rsrved              host cluster offset of data             Reserved
  (6 bits)                (47 bits)                           (8 bits)

    bit 63: refcount == 1   (QCOW_OFLAG_COPIED)
    bit 62: compressed = 1  (QCOW_OFLAG_COMPRESSED)
    bit  0: all zeros       (QCOW_OFLAG_ZERO)

If Extended L2 Entries are enabled, bit 0 becomes reserved and must be
unset, and this 64-bit bitmap follows the entry:

63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
<---------------------------------> <--------------------------------->
     subcluster reads as zeros            subcluster is allocated
             (32 bits)                           (32 bits)

All this applies to uncompressed clusters. Compressed clusters are not
divided into subclusters, the cluster descriptor remains exactly the
same, and the 64-bit bitmap is not used (i.e. all bits are always 0).

=== Test results ===

I made all tests on an SSD drive, writing to an empty qcow2 image with
a fully populated 40GB backing image, performing random writes using
fio with a block size of 4KB. I ran the tests with all available
cluster sizes starting from 4KB.

It's important to point out that once a cluster has been completely
allocated then having subclusters offers no performance benefit. For
this reason the size of the image for these tests (40GB) was chosen to
be large enough to guarantee that there are always new clusters being
allocated. This is therefore a worst-case scenario (or best-case for
this feature, if you want).

Subcluster sizes are in brackets:

|-----------------+----------------+-----------------|
|   Cluster size  | subclusters=on | subclusters=off |
|-----------------+----------------+-----------------|
|    4 KB ( N/A ) |            N/A |         95 IOPS |
|    8 KB ( N/A ) |            N/A |        599 IOPS |
|   16 KB (512 B) |      4129 IOPS |       3597 IOPS |
|   32 KB  (1 KB) |     11255 IOPS |       2642 IOPS |
|   64 KB  (2 KB) |     13341 IOPS |       1671 IOPS |
|  128 KB  (4 KB) |     12391 IOPS |        870 IOPS |
|  256 KB  (8 KB) |      9645 IOPS |        566 IOPS |
|  512 KB (16 KB) |      4960 IOPS |        359 IOPS |
| 1024 KB (32 KB) |      2732 IOPS |        215 IOPS |
| 2048 KB (64 KB) |      1630 IOPS |        214 IOPS |
|-----------------+----------------+-----------------|

Here are the same tests, but without any backing image:

|-----------------+----------------+-----------------|
|   Cluster size  | subclusters=on | subclusters=off |
|-----------------+----------------+-----------------|
|    4 KB ( N/A ) |            N/A |         93 IOPS |
|    8 KB ( N/A ) |            N/A |        539 IOPS |
|   16 KB (512 B) |      4174 IOPS |       7598 IOPS |
|   32 KB  (1 KB) |     11326 IOPS |      11957 IOPS |
|   64 KB  (2 KB) |     13516 IOPS |      13375 IOPS |
|  128 KB  (4 KB) |     12435 IOPS |      13274 IOPS |
|  256 KB  (8 KB) |     12071 IOPS |      14174 IOPS |
|  512 KB (16 KB) |     12169 IOPS |      14343 IOPS |
| 1024 KB (32 KB) |     12307 IOPS |      14622 IOPS |
| 2048 KB (64 KB) |     12784 IOPS |      14574 IOPS |
|-----------------+----------------+-----------------|

Some comments about the results:

- The smallest allowed cluster size for an image with subclusters is
  16 KB (in this case the subclusters size is 512 bytes), hence the
  missing values in the 4 KB and 8 KB rows.

- In images with a backing file: allocation is much faster when
  subclusters are enabled. As expected, images with a cluster size of
  64KB perform similar to images with a subcluster size of 64KB. When
  there is no copy-on-write involved (subcluster size <= 4KB) then the
  maximum performance is achieved.

- In images without a backing file: Since commit c8bb23cbdb when empty
  clusters are allocated for the first time they are filled with
  zeroes using an efficient method (typically fallocate() with
  FALLOC_FL_ZERO_RANGE). This is so fast that having subclusters here
  is actually a bit slower in most cases (although it still saves disk
  space).

- The 16 KB cluster / 512 byte subcluster case is quite slow.
  I haven't debugged this but I suspect that this is because new
  clusters need to be allocated all the time, and also L2 and refcount
  tables are very small and need to grow all the time. The same pattern
  can be seen in images without subclusters.

=== To do ===

A couple of things are missing from this series:

- The ability to efficiently zero individual subclusters using
  qcow2_co_pwrite_zeroes(). At the moment only full clusters can be
  zeroed with this method.

- Alternatively we could get rid of the individual "all zeroes" bits
  altogether and have 64 subclusters per cluster. We would still have
  the QCOW_OFLAG_ZERO bit in the standard cluster descriptor.

- The number of subclusters per cluster is always 32. It would be
  trivial to allow configuring this, but I don't see any use case.

- Tests: I have a few written that I'll add in future revisions of
  this series.

- handle_alloc_space() works at the subclusters level. That is, if you
  have an unallocated 2MB cluster with 64KB subclusters, no backing
  image and you write 4KB of data, QEMU won't write zeroes to the
  affected subcluster(s) and will use handle_alloc_space() instead.
  The other subclusters won't be touched and will remain unallocated.
  This behavior is consistent with how subclusters work and saves disk
  space, but offers slightly lower performance (see test results
  above). Theoretically we could offer a setting to configure this,
  but I'm not convinced that this is very useful.

===========================

As usual, feedback is welcome,

Berto

Alberto Garcia (23):
  qcow2: Add calculate_l2_meta()
  qcow2: Split cluster_needs_cow() out of count_cow_clusters()
  qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in handle_copied()
  qcow2: Add get_l2_entry() and set_l2_entry()
  qcow2: Document the Extended L2 Entries feature
  qcow2: Add dummy has_subclusters() function
  qcow2: Add subcluster-related fields to BDRVQcow2State
  qcow2: Add offset_to_sc_index()
  qcow2: Add l2_entry_size()
  qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()
  qcow2: Add qcow2_get_subcluster_type()
  qcow2: Handle QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER
  qcow2: Add subcluster support to calculate_l2_meta()
  qcow2: Add subcluster support to qcow2_get_cluster_offset()
  qcow2: Add subcluster support to zero_in_l2_slice()
  qcow2: Add subcluster support to discard_in_l2_slice()
  qcow2: Add subcluster support to check_refcounts_l2()
  qcow2: Add subcluster support to expand_zero_clusters_in_l1()
  qcow2: Fix offset calculation in handle_dependencies()
  qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()
  qcow2: Add subcluster support to handle_alloc_space()
  qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only
  qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit

 block/qcow2-cluster.c            | 547 ++++++++++++++++++++-----------
 block/qcow2-refcount.c           |  38 ++-
 block/qcow2.c                    |  83 ++++-
 block/qcow2.h                    | 121 ++++++-
 docs/interop/qcow2.txt           |  68 +++-
 docs/qcow2-cache.txt             |  19 +-
 include/block/block_int.h        |   1 +
 qapi/block-core.json             |   2 +
 tests/qemu-iotests/031.out       |   8 +-
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 +++---
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061.out       |  20 +-
 tests/qemu-iotests/065           |  18 +-
 tests/qemu-iotests/082.out       |  48 ++-
 tests/qemu-iotests/085.out       |  38 +--
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/198.out       |   2 +
 tests/qemu-iotests/206.out       |   4 +
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/common.filter |   1 +
 24 files changed, 817 insertions(+), 335 deletions(-)

-- 
2.20.1


