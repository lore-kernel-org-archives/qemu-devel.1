Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B14C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7912075F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="D9Pgp5Rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7912075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcs5D-0006az-Pi
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 10:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzc-0001nt-C3; Sun, 24 May 2020 10:52:48 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzX-0002kH-3u; Sun, 24 May 2020 10:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=0alsiT7h9gTZsCNws6LIPedeURXinc7BXLzitGeVRhc=; 
 b=D9Pgp5RsyFWS62pQ+PvEQeMvbSLUPEjaQ3XRsctLKStTFyPzyawPhiPV+pCP3Dw0Zu3IsnUL/173RRSBdasvz7mC8m77R0QSaJmlBAggiWbPLYPWgqrfbaJvNjWP0ejmS7+6LahSKjkyuaCJfFT+RXR6SlUhg6Vxn4xyDcKhAUyFmcfV3+s5429YzApl7dQtnqRP6PleQ09LAs1aLTM6hZSNPdgLr6az2eFPWncFxjDAATgtvrPEDAhH2Xn/7mDBCgb2uhe0o9L2EXAihGf9lw9gjI1AWPcZ52sWmN0utTKIzD2CofRlyEozqTTP7+9s2azQAcnQo6+2q1K4mimlCQ==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jcrz9-0007G9-4z; Sun, 24 May 2020 16:52:19 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jcryu-0005Jy-Jm; Sun, 24 May 2020 16:52:04 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/32] Add subcluster allocation to qcow2
Date: Sun, 24 May 2020 16:51:20 +0200
Message-Id: <cover.1590331741.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 10:52:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Derek Su <dereksu@qnap.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

here's the new version of the patches to add subcluster allocation
support to qcow2.

Please refer to the cover letter of the first version for a full
description of the patches:

   https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html

The big change here is that the code does not need to iterate over
every subcluster anymore. There's now a new function called
qcow2_get_subcluster_range_type() that checks a group of subclusters
in one go using cto and ctz operations.

Berto

v6:
- Patch 07: Fix indentation issues in the documentation [Eric]
- Patch 14: Use half-open intervals for the subcluster macros.
            New method to detected invalid subclusters.
- Patch 15: New patch
- Patch 20: Use a faster method to check the status of a groups of
            subclusters without having to iterate over each one of
            them.
- Patch 21: Optimize count_contiguous_subclusters() by removing the
            iteration over every subcluster.
            Earlier detection of invalid subclusters.
            Minor documentation updates [Eric]
- Patch 25: Update after the macro changes in patch 14
- Patch 28: Update after the macro changes in patch 14
- Patch 29: Change patch order so this goes before patch 30
- Patch 30: Fix rebase conflicts now that compression_type has been
            merged.
            Disable toggling extended_l2 using amend [Eric]
- Patch 32: Many new tests and refactoring

v5: https://lists.gnu.org/archive/html/qemu-block/2020-05/msg00251.html
v4: https://lists.gnu.org/archive/html/qemu-block/2020-03/msg00966.html
v3: https://lists.gnu.org/archive/html/qemu-block/2019-12/msg00587.html
v2: https://lists.gnu.org/archive/html/qemu-block/2019-10/msg01642.html
v1: https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html

Output of git backport-diff against v5:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/32:[----] [--] 'qcow2: Make Qcow2AioTask store the full host offset'
002/32:[----] [--] 'qcow2: Convert qcow2_get_cluster_offset() into qcow2_get_host_offset()'
003/32:[----] [--] 'qcow2: Add calculate_l2_meta()'
004/32:[----] [--] 'qcow2: Split cluster_needs_cow() out of count_cow_clusters()'
005/32:[----] [--] 'qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in handle_copied()'
006/32:[----] [--] 'qcow2: Add get_l2_entry() and set_l2_entry()'
007/32:[0006] [FC] 'qcow2: Document the Extended L2 Entries feature'
008/32:[----] [--] 'qcow2: Add dummy has_subclusters() function'
009/32:[----] [--] 'qcow2: Add subcluster-related fields to BDRVQcow2State'
010/32:[----] [--] 'qcow2: Add offset_to_sc_index()'
011/32:[----] [--] 'qcow2: Add offset_into_subcluster() and size_to_subclusters()'
012/32:[----] [--] 'qcow2: Add l2_entry_size()'
013/32:[----] [--] 'qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()'
014/32:[0039] [FC] 'qcow2: Add QCow2SubclusterType and qcow2_get_subcluster_type()'
015/32:[down] 'qcow2: Add qcow2_get_subcluster_range_type()'
016/32:[----] [--] 'qcow2: Add qcow2_cluster_is_allocated()'
017/32:[----] [--] 'qcow2: Add cluster type parameter to qcow2_get_host_offset()'
018/32:[----] [--] 'qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*'
019/32:[----] [--] 'qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC'
020/32:[0111] [FC] 'qcow2: Add subcluster support to calculate_l2_meta()'
021/32:[0091] [FC] 'qcow2: Add subcluster support to qcow2_get_host_offset()'
022/32:[----] [--] 'qcow2: Add subcluster support to zero_in_l2_slice()'
023/32:[----] [--] 'qcow2: Add subcluster support to discard_in_l2_slice()'
024/32:[----] [--] 'qcow2: Add subcluster support to check_refcounts_l2()'
025/32:[0004] [FC] 'qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()'
026/32:[----] [--] 'qcow2: Clear the L2 bitmap when allocating a compressed cluster'
027/32:[----] [--] 'qcow2: Add subcluster support to handle_alloc_space()'
028/32:[0004] [FC] 'qcow2: Add subcluster support to qcow2_co_pwrite_zeroes()'
029/32:[0001] [FC] 'qcow2: Add subcluster support to qcow2_measure()'
030/32:[0549] [FC] 'qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit'
031/32:[----] [--] 'qcow2: Assert that expand_zero_clusters_in_l1() does not support subclusters'
032/32:[0775] [FC] 'iotests: Add tests for qcow2 images with extended L2 entries'

Alberto Garcia (32):
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
  qcow2: Add offset_into_subcluster() and size_to_subclusters()
  qcow2: Add l2_entry_size()
  qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()
  qcow2: Add QCow2SubclusterType and qcow2_get_subcluster_type()
  qcow2: Add qcow2_get_subcluster_range_type()
  qcow2: Add qcow2_cluster_is_allocated()
  qcow2: Add cluster type parameter to qcow2_get_host_offset()
  qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*
  qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
  qcow2: Add subcluster support to calculate_l2_meta()
  qcow2: Add subcluster support to qcow2_get_host_offset()
  qcow2: Add subcluster support to zero_in_l2_slice()
  qcow2: Add subcluster support to discard_in_l2_slice()
  qcow2: Add subcluster support to check_refcounts_l2()
  qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()
  qcow2: Clear the L2 bitmap when allocating a compressed cluster
  qcow2: Add subcluster support to handle_alloc_space()
  qcow2: Add subcluster support to qcow2_co_pwrite_zeroes()
  qcow2: Add subcluster support to qcow2_measure()
  qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit
  qcow2: Assert that expand_zero_clusters_in_l1() does not support
    subclusters
  iotests: Add tests for qcow2 images with extended L2 entries

 docs/interop/qcow2.txt           |  68 ++-
 docs/qcow2-cache.txt             |  19 +-
 qapi/block-core.json             |   7 +
 block/qcow2.h                    | 203 ++++++-
 include/block/block_int.h        |   1 +
 block/qcow2-cluster.c            | 911 +++++++++++++++++++++----------
 block/qcow2-refcount.c           |  38 +-
 block/qcow2.c                    | 291 ++++++----
 block/trace-events               |   2 +-
 tests/qemu-iotests/031.out       |   8 +-
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 ++--
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061           |   6 +
 tests/qemu-iotests/061.out       |  25 +-
 tests/qemu-iotests/065           |  12 +-
 tests/qemu-iotests/082.out       |  48 +-
 tests/qemu-iotests/085.out       |  38 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/198.out       |   2 +
 tests/qemu-iotests/206.out       |   4 +
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/271           | 705 ++++++++++++++++++++++++
 tests/qemu-iotests/271.out       | 603 ++++++++++++++++++++
 tests/qemu-iotests/274.out       |  49 +-
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/group         |   1 +
 31 files changed, 2616 insertions(+), 562 deletions(-)
 create mode 100755 tests/qemu-iotests/271
 create mode 100644 tests/qemu-iotests/271.out

-- 
2.20.1


