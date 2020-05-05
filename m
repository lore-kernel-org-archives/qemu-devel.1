Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F6C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7E520735
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="binznVaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7E520735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1o8-0007mY-2X
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 13:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xr-000767-0i; Tue, 05 May 2020 13:39:51 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:39073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xe-0008Qu-Uq; Tue, 05 May 2020 13:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=hI7khqv+PAioy6SOMVq2SOT9cEJFi4V9qI3Bt69JXDU=; 
 b=binznVaKrJZMBiY8MhkZOnHC4f4tMlC0HJdCymAFQRLyOJIp6WdFn6hHocsul53UO9c5+G4pcD1FKhir5Zsl1Y4wBf9SuOBirHwd9u5CyuATpChSINpPVym9J5yTDvGV/G9KpwyULOcz4FMasCin+Th+PAT2WHNlA4PM1ehEsHtOLoYrJkH/HZEpmqO+TjxMuvzmo/bY19dCW/L8Qc/xG098l6Qnc8HgfciUWj25EfCTTIbB0jDGks30tKo9ru8aOK9rMIg176HnlXGFHFlXblRhjY0M6wFxrNLxKjGROD8fyY7N+9/PC9oseOO9l5648ohhLXeYcdLLolRc6EBzQw==;
Received: from static.160.43.0.81.ibercom.com ([81.0.43.160]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jW1Ws-00025G-D4; Tue, 05 May 2020 19:38:50 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jW1Wc-00043W-CX; Tue, 05 May 2020 19:38:34 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/31] Add subcluster allocation to qcow2
Date: Tue,  5 May 2020 19:38:00 +0200
Message-Id: <cover.1588699789.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 13:38:50
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

here's the new version of the patches to add subcluster allocation
support to qcow2.

Please refer to the cover letter of the first version for a full
description of the patches:

   https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html

Important changes here:

- I fixed hopefully all of the issues mentioned in the previous
  review. Thanks to everyone who contributed.

- There's now support for partial zeroing of clusters (i.e. at the
  subcluster level).

- Many more tests.

- QCOW_OFLAG_ZERO is simply ignored now and not considered a sign of a
  corrupt image anymore. I hesitated about this, but we could still
  add that check later. I think there's a case for adding a new
  QCOW2_CLUSTER_INVALID type and include this and other scenarios that
  we already consider corrupt (for example: clusters with unaligned
  offsets). We would need to see if for 'qemu-img check' adding
  QCOW2_CLUSTER_INVALID complicates things or not. But I think that
  all is material for its own series.

And I think that's all. See below for the detailed list of changes,
and thanks again for the feedback.

Berto

v5:
- Patch 01: Fix indentation [Max], add trace event [Vladimir]
- Patch 02: Add host_cluster_offset variable [Vladirmir]
- Patch 05: Have separate l2_entry and cluster_offset variables [Vladimir]
- Patch 06: Only context changes due to patch 05
- Patch 11: New patch
- Patch 13: Change documentation of get_l2_entry()
- Patch 14: Add QCOW_OFLAG_SUB_{ALLOC,ZERO}_RANGE [Eric] and rewrite
            the other macros.
            Ignore QCOW_OFLAG_ZERO on images with subclusters
            (i.e. don't treat them as corrupted).
- Patch 15: New patch
- Patch 19: Optimize cow by skipping all leading and trailing zero and
            unallocated subclusters [Vladimir]
            Return 0 on success [Vladimir]
            Squash patch that updated handle_dependencies() [Vladirmir]
- Patch 20: Call count_contiguous_subclusters() after the main switch
            in qcow2_get_host_offset() [Vladimir]
            Add assertion and remove goto statement [Vladimir]
- Patch 21: Rewrite algorithm.
- Patch 22: Rewrite algorithm.
- Patch 24: Replace loop with the _RANGE macros from patch 14 [Eric]
- Patch 27: New patch
- Patch 28: Update version number and expected output from tests.
- Patch 31: Add many more new tests

v4: https://lists.gnu.org/archive/html/qemu-block/2020-03/msg00966.html
v3: https://lists.gnu.org/archive/html/qemu-block/2019-12/msg00587.html
v2: https://lists.gnu.org/archive/html/qemu-block/2019-10/msg01642.html
v1: https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html

Output of git backport-diff against v4:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/31:[0005] [FC] 'qcow2: Make Qcow2AioTask store the full host offset'
002/31:[0018] [FC] 'qcow2: Convert qcow2_get_cluster_offset() into qcow2_get_host_offset()'
003/31:[----] [--] 'qcow2: Add calculate_l2_meta()'
004/31:[----] [--] 'qcow2: Split cluster_needs_cow() out of count_cow_clusters()'
005/31:[0038] [FC] 'qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in handle_copied()'
006/31:[0004] [FC] 'qcow2: Add get_l2_entry() and set_l2_entry()'
007/31:[----] [--] 'qcow2: Document the Extended L2 Entries feature'
008/31:[----] [--] 'qcow2: Add dummy has_subclusters() function'
009/31:[----] [--] 'qcow2: Add subcluster-related fields to BDRVQcow2State'
010/31:[----] [--] 'qcow2: Add offset_to_sc_index()'
011/31:[down] 'qcow2: Add offset_into_subcluster() and size_to_subclusters()'
012/31:[----] [--] 'qcow2: Add l2_entry_size()'
013/31:[0003] [FC] 'qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()'
014/31:[0023] [FC] 'qcow2: Add QCow2SubclusterType and qcow2_get_subcluster_type()'
015/31:[down] 'qcow2: Add qcow2_cluster_is_allocated()'
016/31:[----] [--] 'qcow2: Add cluster type parameter to qcow2_get_host_offset()'
017/31:[----] [--] 'qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*'
018/31:[----] [--] 'qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC'
019/31:[0066] [FC] 'qcow2: Add subcluster support to calculate_l2_meta()'
020/31:[0022] [FC] 'qcow2: Add subcluster support to qcow2_get_host_offset()'
021/31:[0040] [FC] 'qcow2: Add subcluster support to zero_in_l2_slice()'
022/31:[0061] [FC] 'qcow2: Add subcluster support to discard_in_l2_slice()'
023/31:[----] [--] 'qcow2: Add subcluster support to check_refcounts_l2()'
024/31:[0019] [FC] 'qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()'
025/31:[----] [--] 'qcow2: Clear the L2 bitmap when allocating a compressed cluster'
026/31:[----] [--] 'qcow2: Add subcluster support to handle_alloc_space()'
027/31:[down] 'qcow2: Add subcluster support to qcow2_co_pwrite_zeroes()'
028/31:[0105] [FC] 'qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit'
029/31:[----] [-C] 'qcow2: Assert that expand_zero_clusters_in_l1() does not support subclusters'
030/31:[----] [--] 'qcow2: Add subcluster support to qcow2_measure()'
031/31:[0694] [FC] 'iotests: Add tests for qcow2 images with extended L2 entries'

Alberto Garcia (31):
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
  qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit
  qcow2: Assert that expand_zero_clusters_in_l1() does not support
    subclusters
  qcow2: Add subcluster support to qcow2_measure()
  iotests: Add tests for qcow2 images with extended L2 entries

 docs/interop/qcow2.txt           |  68 ++-
 docs/qcow2-cache.txt             |  19 +-
 qapi/block-core.json             |   7 +
 block/qcow2.h                    | 204 ++++++-
 include/block/block_int.h        |   1 +
 block/qcow2-cluster.c            | 892 ++++++++++++++++++++-----------
 block/qcow2-refcount.c           |  38 +-
 block/qcow2.c                    | 283 ++++++----
 block/trace-events               |   2 +-
 tests/qemu-iotests/031.out       |   8 +-
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 ++--
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061           |   6 +
 tests/qemu-iotests/061.out       |  25 +-
 tests/qemu-iotests/065           |  18 +-
 tests/qemu-iotests/082.out       |  48 +-
 tests/qemu-iotests/085.out       |  38 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/198.out       |   2 +
 tests/qemu-iotests/206.out       |   4 +
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/271           | 664 +++++++++++++++++++++++
 tests/qemu-iotests/271.out       | 519 ++++++++++++++++++
 tests/qemu-iotests/274.out       |  49 +-
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/group         |   1 +
 31 files changed, 2459 insertions(+), 574 deletions(-)
 create mode 100755 tests/qemu-iotests/271
 create mode 100644 tests/qemu-iotests/271.out

-- 
2.20.1


