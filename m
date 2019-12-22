Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13655C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 11:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15C720733
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FKJnxEuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15C720733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46917 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iizpf-0003uS-H3
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 06:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iizYq-0002o1-3c
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iizYn-0005bh-ST
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:11 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:34963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iizYn-0004Uo-Di; Sun, 22 Dec 2019 06:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=1kZJRo3wW2UbPV35/G27GSXgeH07jQhURSsYzZKVWsY=; 
 b=FKJnxEuW+D+atiGt0f7cwZfClVgHH66zv7PxQW99kumlb/AWOROV6+gpdoEn3tE4Tczly0gI5rigaSX903DGew3+FkRZwJ67rQC20lPA+eelddLYZdQhP5LbgTI5Pse13RscPAna6x8d+Ku3g2lSgB9JhZ4Dw31A1eu+cxekm5p5910dKfIqN5RQvC1i6IlFPjaZDoSPIm/yYSmwvqxA+6kgsji+3EJrhKtbKgYMg06rsYGFEM2ywXo369EYCWnDz2oCPrH1Z0eJHNJCIeOY76g7r1POCqBXReBW8RRLAgUMkOZ2IIIUhNIrWxUWeUVMznzc30UVZ3oe4VO008Mj2g==;
Received: from [80.30.182.172] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iizYU-0005d2-DC; Sun, 22 Dec 2019 12:37:51 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iizXu-0001VS-6p; Sun, 22 Dec 2019 12:37:14 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 00/27] Add subcluster allocation to qcow2
Date: Sun, 22 Dec 2019 12:36:41 +0100
Message-Id: <cover.1577014346.git.berto@igalia.com>
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

This version fixes many of the problems highlighted by Max. I decided
not to replace completely the cluster logic with subcluster logic in
all cases because I felt that sometimes it only complicated the code.
Let's see what you think :-)

Berto

v3:
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

Output of git backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/27:[0013] [FC] 'qcow2: Add calculate_l2_meta()'
002/27:[----] [-C] 'qcow2: Split cluster_needs_cow() out of count_cow_clusters()'
003/27:[0083] [FC] 'qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in handle_copied()'
004/27:[----] [-C] 'qcow2: Add get_l2_entry() and set_l2_entry()'
005/27:[----] [--] 'qcow2: Document the Extended L2 Entries feature'
006/27:[----] [--] 'qcow2: Add dummy has_subclusters() function'
007/27:[----] [--] 'qcow2: Add subcluster-related fields to BDRVQcow2State'
008/27:[----] [--] 'qcow2: Add offset_to_sc_index()'
009/27:[0008] [FC] 'qcow2: Add l2_entry_size()'
010/27:[0008] [FC] 'qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()'
011/27:[down] 'qcow2: Add QCow2SubclusterType and qcow2_get_subcluster_type()'
012/27:[down] 'qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*'
013/27:[down] 'qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC'
014/27:[0060] [FC] 'qcow2: Add subcluster support to calculate_l2_meta()'
015/27:[0091] [FC] 'qcow2: Add subcluster support to qcow2_get_cluster_offset()'
016/27:[----] [--] 'qcow2: Add subcluster support to zero_in_l2_slice()'
017/27:[----] [--] 'qcow2: Add subcluster support to discard_in_l2_slice()'
018/27:[----] [--] 'qcow2: Add subcluster support to check_refcounts_l2()'
019/27:[0008] [FC] 'qcow2: Add subcluster support to expand_zero_clusters_in_l1()'
020/27:[----] [--] 'qcow2: Fix offset calculation in handle_dependencies()'
021/27:[0007] [FC] 'qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()'
022/27:[0004] [FC] 'qcow2: Clear the L2 bitmap when allocating a compressed cluster'
023/27:[0002] [FC] 'qcow2: Add subcluster support to handle_alloc_space()'
024/27:[----] [-C] 'qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only'
025/27:[0049] [FC] 'qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit'
026/27:[down] 'qcow2: Add subcluster support to qcow2_measure()'
027/27:[0046] [FC] 'iotests: Add tests for qcow2 images with extended L2 entries'

Alberto Garcia (27):
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
  qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*
  qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
  qcow2: Add subcluster support to calculate_l2_meta()
  qcow2: Add subcluster support to qcow2_get_cluster_offset()
  qcow2: Add subcluster support to zero_in_l2_slice()
  qcow2: Add subcluster support to discard_in_l2_slice()
  qcow2: Add subcluster support to check_refcounts_l2()
  qcow2: Add subcluster support to expand_zero_clusters_in_l1()
  qcow2: Fix offset calculation in handle_dependencies()
  qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()
  qcow2: Clear the L2 bitmap when allocating a compressed cluster
  qcow2: Add subcluster support to handle_alloc_space()
  qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only
  qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit
  qcow2: Add subcluster support to qcow2_measure()
  iotests: Add tests for qcow2 images with extended L2 entries

 block/qcow2-cluster.c            | 645 ++++++++++++++++++++-----------
 block/qcow2-refcount.c           |  38 +-
 block/qcow2.c                    | 200 +++++++---
 block/qcow2.h                    | 150 ++++++-
 docs/interop/qcow2.txt           |  68 +++-
 docs/qcow2-cache.txt             |  19 +-
 include/block/block_int.h        |   1 +
 qapi/block-core.json             |   7 +
 tests/qemu-iotests/031.out       |   8 +-
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 ++---
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061.out       |  20 +-
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
 tests/qemu-iotests/271           | 256 ++++++++++++
 tests/qemu-iotests/271.out       | 208 ++++++++++
 tests/qemu-iotests/273.out       |   9 +-
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/group         |   1 +
 28 files changed, 1455 insertions(+), 420 deletions(-)
 create mode 100755 tests/qemu-iotests/271
 create mode 100644 tests/qemu-iotests/271.out

-- 
2.20.1


