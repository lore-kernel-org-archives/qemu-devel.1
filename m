Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12409CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA8F214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z8HRbTTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA8F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUeW-0005wr-Uq
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTZx-0000Xz-4m
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZv-0005RQ-F3
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:33 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZu-0005F5-Ub; Sat, 26 Oct 2019 17:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=M1JnWBLeI/U2q/+ye9GuOt2ejRpDtekbRhZrMSseTQY=; 
 b=Z8HRbTTG3ClGlo/+TnRK3GY04AhSL7TsQtITFAM0T94lFiUXibAFdqXM7EhOaAGBi7gNMVBZFnunrYjEEKyq3dvLnxPylz7KHSyMOCSW2+3tAaVqjXxwN4pdb6xBYcVyh/slyfWKDjs40edBIjcekFArDarWymrepWOamA3ZwPky1/kaa5P3t/r4KOIrbPc2mAv9HODBxsh2/JFWTVs1r4jEXLWDCqMkEJf8fZbttLyNNG2uGHJNf5LKlG/JS9tFWCXsl8rBIZbQ7eoAUHdUXNJUZuhI5OWcNVR90yQXLOzbQWW8DofvIeyQMhyz93OGubHizOOOkkD4f3EJybowRA==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZI-00045l-Kn; Sat, 26 Oct 2019 23:25:52 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTYz-0001P0-Vm; Sun, 27 Oct 2019 00:25:33 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 00/26] Add subcluster allocation to qcow2
Date: Sun, 27 Oct 2019 00:25:02 +0300
Message-Id: <cover.1572125022.git.berto@igalia.com>
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

This version includes a few tests, but I'm planning to add more for
the next revision.

Berto

v2:
- Patch 12: Update after the changes in 88f468e546.
- Patch 21 (new): Clear the L2 bitmap when allocating a compressed
  cluster. Compressed clusters should have the bitmap all set to 0.
- Patch 24: Document the new fields in the QAPI documentation [Eric].
- Patch 25: Allow qcow2 preallocation with backing files.
- Patch 26: Add some tests for qcow2 images with extended L2 entries.

v1: https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html

Output of git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/26:[----] [-C] 'qcow2: Add calculate_l2_meta()'
002/26:[----] [--] 'qcow2: Split cluster_needs_cow() out of count_cow_clusters()'
003/26:[----] [--] 'qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in handle_copied()'
004/26:[----] [--] 'qcow2: Add get_l2_entry() and set_l2_entry()'
005/26:[----] [--] 'qcow2: Document the Extended L2 Entries feature'
006/26:[----] [--] 'qcow2: Add dummy has_subclusters() function'
007/26:[----] [--] 'qcow2: Add subcluster-related fields to BDRVQcow2State'
008/26:[----] [--] 'qcow2: Add offset_to_sc_index()'
009/26:[----] [--] 'qcow2: Add l2_entry_size()'
010/26:[----] [--] 'qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()'
011/26:[----] [--] 'qcow2: Add qcow2_get_subcluster_type()'
012/26:[0005] [FC] 'qcow2: Handle QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER'
013/26:[----] [--] 'qcow2: Add subcluster support to calculate_l2_meta()'
014/26:[----] [--] 'qcow2: Add subcluster support to qcow2_get_cluster_offset()'
015/26:[----] [--] 'qcow2: Add subcluster support to zero_in_l2_slice()'
016/26:[----] [--] 'qcow2: Add subcluster support to discard_in_l2_slice()'
017/26:[----] [--] 'qcow2: Add subcluster support to check_refcounts_l2()'
018/26:[----] [--] 'qcow2: Add subcluster support to expand_zero_clusters_in_l1()'
019/26:[----] [--] 'qcow2: Fix offset calculation in handle_dependencies()'
020/26:[----] [--] 'qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()'
021/26:[down] 'qcow2: Clear the L2 bitmap when allocating a compressed cluster'
022/26:[----] [--] 'qcow2: Add subcluster support to handle_alloc_space()'
023/26:[----] [--] 'qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only'
024/26:[0007] [FC] 'qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit'
025/26:[down] 'qcow2: Allow preallocation and backing files if extended_l2 is set'
026/26:[down] 'iotests: Add tests for qcow2 images with extended L2 entries'

Alberto Garcia (26):
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
  qcow2: Clear the L2 bitmap when allocating a compressed cluster
  qcow2: Add subcluster support to handle_alloc_space()
  qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only
  qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit
  qcow2: Allow preallocation and backing files if extended_l2 is set
  iotests: Add tests for qcow2 images with extended L2 entries

 block/qcow2-cluster.c            | 548 ++++++++++++++++++++-----------
 block/qcow2-refcount.c           |  38 ++-
 block/qcow2.c                    |  92 +++++-
 block/qcow2.h                    | 121 ++++++-
 docs/interop/qcow2.txt           |  68 +++-
 docs/qcow2-cache.txt             |  19 +-
 include/block/block_int.h        |   1 +
 qapi/block-core.json             |   6 +
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
 tests/qemu-iotests/206.out       |   6 +-
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/271           | 235 +++++++++++++
 tests/qemu-iotests/271.out       | 183 +++++++++++
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/group         |   1 +
 27 files changed, 1247 insertions(+), 340 deletions(-)
 create mode 100755 tests/qemu-iotests/271
 create mode 100644 tests/qemu-iotests/271.out

-- 
2.20.1


