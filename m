Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF0AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1421420714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hlS/aWTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1421420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEH6q-0000bq-6l
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmu-0003Of-UH
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGms-0008US-Kv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:00 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGms-0005V4-5G; Tue, 17 Mar 2020 14:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=IAkho++obSqBwVm+trYeykWewPsupKbSCEE/QCaFS0g=; 
 b=hlS/aWTcjY4FYwvDH+Mh9lGIdmp+c01pkiVh/FvVnWluV8zpPb7i9fkSEuAPxHLqAkxPvzB3ZEFO/bpsWt4qqzKbN3S4+/rcyhVOjyFY/Uuk693q36g/i78RDB6Z14ZhdAOmJwPiWj9qs/lXbY/+p/RhxKItDKVTeh7NNsTIohmENpxgdlVYD4PHgKiFWCJzgWGVbE29DHgh5MASCU4lSc8+mjjQ2PuQmtoHBIGyrprI+WqW/c8k+Ar7MWdd4w76T0zaXy85YjReQbPPPxy3JOBOVz7z+D+X6fJDe3eMKcP8BjayDWtZIo74RFX5ceOczh+AvCOSdxVI1/tckCv9Cg==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmC-00015T-VW; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006O3-28; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/30] Add subcluster allocation to qcow2
Date: Tue, 17 Mar 2020 19:15:57 +0100
Message-Id: <cover.1584468723.git.berto@igalia.com>
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
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

here's the new version of the patches to add subcluster allocation
support to qcow2.

Please refer to the cover letter of the first version for a full
description of the patches:

   https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html

I think that this version fixes all the problems pointed out by Max
and Eric during the review a couple of weeks ago. I also dropped the
RFC tag.

Berto

v4:
- Patch 01: New patch
- Patch 02: New patch
- Patch 05: Documentation updates [Eric]
- Patch 06: Fix rebase conflicts
- Patch 07: Change bit order in the subcluster allocation bitmap.
            Change incompatible bit number. [Max, Eric]
- Patch 09: Rename QCOW_MAX_SUBCLUSTERS_PER_CLUSTER to
            QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER [Eric]
- Patch 13: Change bit order in the subcluster allocation bitmap [Max, Eric]
            Add more documentation.
            Ignore the subcluster bitmap in the L2 entries of
            compressed clusters.
- Patch 14: New patch
- Patch 15: Update to work with the changes from patches 02 and 14.
- Patch 16: Update to work with the changes from patches 02 and 14.
- Patch 18: Update to work with the changes from patches 02 and 14.
            Update documentation.
            Fix return value on early exit.
- Patch 20: Make sure to clear the subcluster allocation bitmap when a
            cluster is unallocated.
- Patch 26: Update to work with the changes from patch 14.
- Patch 27: New patch [Max]
- Patch 28: Update version number, incompatible bit number and test
            expectations.
- Patch 30: Add new tests.
            Make the test verify its own results. [Max]

v3: https://lists.gnu.org/archive/html/qemu-block/2019-12/msg00587.html
- Patch 01: Rename host_offset to host_cluster_offset and make 'bytes'
            an unsigned int [Max]
- Patch 03: Rename cluster_needs_cow to cluster_needs_new_alloc and
            count_cow_clusters to count_single_write_clusters. Update
            documentation and add more assertions and checks [Max]
- Patch 09: Update qcow2_co_truncate() to properly support extended L2
            entries [Max]
- Patch 10: Forbid calling set_l2_bitmap() if the image does not have
            extended L2 entries [Max]
- Patch 11 (new): Add QCow2SubclusterType [Max]
- Patch 12 (new): Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*
- Patch 13 (new): Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
- Patch 14: Use QCow2SubclusterType instead of QCow2ClusterType [Max]
- Patch 15: Use QCow2SubclusterType instead of QCow2ClusterType [Max]
- Patch 19: Don't call set_l2_bitmap() if the image does not have
            extended L2 entries [Max]
- Patch 21: Use smaller data types.
- Patch 22: Don't call set_l2_bitmap() if the image does not have
            extended L2 entries [Max]
- Patch 23: Use smaller data types.
- Patch 25: Update test results and documentation. Move the check for
            the minimum subcluster size to validate_cluster_size().
- Patch 26 (new): Add subcluster support to qcow2_measure()
- Patch 27: Add more tests

v2: https://lists.gnu.org/archive/html/qemu-block/2019-10/msg01642.html
- Patch 12: Update after the changes in 88f468e546.
- Patch 21 (new): Clear the L2 bitmap when allocating a compressed
  cluster. Compressed clusters should have the bitmap all set to 0.
- Patch 24: Document the new fields in the QAPI documentation [Eric].
- Patch 25: Allow qcow2 preallocation with backing files.
- Patch 26: Add some tests for qcow2 images with extended L2 entries.

v1: https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html

Output of git backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/30:[down] 'qcow2: Make Qcow2AioTask store the full host offset'
002/30:[down] 'qcow2: Convert qcow2_get_cluster_offset() into qcow2_get_host_offset()'
003/30:[----] [-C] 'qcow2: Add calculate_l2_meta()'
004/30:[----] [--] 'qcow2: Split cluster_needs_cow() out of count_cow_clusters()'
005/30:[0020] [FC] 'qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in handle_copied()'
006/30:[0010] [FC] 'qcow2: Add get_l2_entry() and set_l2_entry()'
007/30:[0020] [FC] 'qcow2: Document the Extended L2 Entries feature'
008/30:[----] [--] 'qcow2: Add dummy has_subclusters() function'
009/30:[0004] [FC] 'qcow2: Add subcluster-related fields to BDRVQcow2State'
010/30:[----] [--] 'qcow2: Add offset_to_sc_index()'
011/30:[----] [-C] 'qcow2: Add l2_entry_size()'
012/30:[----] [--] 'qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()'
013/30:[0046] [FC] 'qcow2: Add QCow2SubclusterType and qcow2_get_subcluster_type()'
014/30:[down] 'qcow2: Add cluster type parameter to qcow2_get_host_offset()'
015/30:[0082] [FC] 'qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*'
016/30:[0002] [FC] 'qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC'
017/30:[----] [-C] 'qcow2: Add subcluster support to calculate_l2_meta()'
018/30:[down] 'qcow2: Add subcluster support to qcow2_get_host_offset()'
019/30:[----] [--] 'qcow2: Add subcluster support to zero_in_l2_slice()'
020/30:[0012] [FC] 'qcow2: Add subcluster support to discard_in_l2_slice()'
021/30:[----] [--] 'qcow2: Add subcluster support to check_refcounts_l2()'
022/30:[----] [--] 'qcow2: Fix offset calculation in handle_dependencies()'
023/30:[----] [-C] 'qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()'
024/30:[----] [--] 'qcow2: Clear the L2 bitmap when allocating a compressed cluster'
025/30:[----] [--] 'qcow2: Add subcluster support to handle_alloc_space()'
026/30:[0006] [FC] 'qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only'
027/30:[down] 'qcow2: Assert that expand_zero_clusters_in_l1() does not support subclusters'
028/30:[0019] [FC] 'qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit'
029/30:[----] [--] 'qcow2: Add subcluster support to qcow2_measure()'
030/30:[0313] [FC] 'iotests: Add tests for qcow2 images with extended L2 entries'

Alberto Garcia (30):
  qcow2: Make Qcow2AioTask store the full host offset
  qcow2: Convert qcow2_get_cluster_offset() into qcow2_get_host_offset()
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
  qcow2: Add QCow2SubclusterType and qcow2_get_subcluster_type()
  qcow2: Add cluster type parameter to qcow2_get_host_offset()
  qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*
  qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
  qcow2: Add subcluster support to calculate_l2_meta()
  qcow2: Add subcluster support to qcow2_get_host_offset()
  qcow2: Add subcluster support to zero_in_l2_slice()
  qcow2: Add subcluster support to discard_in_l2_slice()
  qcow2: Add subcluster support to check_refcounts_l2()
  qcow2: Fix offset calculation in handle_dependencies()
  qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()
  qcow2: Clear the L2 bitmap when allocating a compressed cluster
  qcow2: Add subcluster support to handle_alloc_space()
  qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only
  qcow2: Assert that expand_zero_clusters_in_l1() does not support
    subclusters
  qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit
  qcow2: Add subcluster support to qcow2_measure()
  iotests: Add tests for qcow2 images with extended L2 entries

 docs/interop/qcow2.txt           |  68 ++-
 docs/qcow2-cache.txt             |  19 +-
 qapi/block-core.json             |   7 +
 block/qcow2.h                    | 178 +++++++-
 include/block/block_int.h        |   1 +
 block/qcow2-cluster.c            | 696 ++++++++++++++++++++-----------
 block/qcow2-refcount.c           |  38 +-
 block/qcow2.c                    | 257 +++++++-----
 tests/qemu-iotests/031.out       |   8 +-
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 ++---
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061           |   6 +
 tests/qemu-iotests/061.out       |  25 +-
 tests/qemu-iotests/065           |  18 +-
 tests/qemu-iotests/082.out       |  48 ++-
 tests/qemu-iotests/085.out       |  38 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/198.out       |   2 +
 tests/qemu-iotests/206.out       |   4 +
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/271           | 359 ++++++++++++++++
 tests/qemu-iotests/271.out       | 244 +++++++++++
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/group         |   1 +
 29 files changed, 1682 insertions(+), 472 deletions(-)
 create mode 100755 tests/qemu-iotests/271
 create mode 100644 tests/qemu-iotests/271.out

-- 
2.20.1


