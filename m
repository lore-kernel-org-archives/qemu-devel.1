Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BB0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBF820707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRyB1HtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBF820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqEN-000277-Gt
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAqD8-0008U4-8z
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 03:51:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35067
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAqD2-0002bl-Jb
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 03:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598428262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AshblrPjJMR2R4JuxoIZkuv1ONPwaNrQpTgPZ8PtiD8=;
 b=IRyB1HtGo44QJD3SO7i3Vsbvse5/JLbrEi8SCnFjeoLbR2BKG/BFeXKXXE4LcmdiOOv4SN
 i6D9XdFPwmRAQrdN4d6OdKVl8iaaW11UdFBRqWP3B/lfZJVh1oPPRzSKvo8gq+/3MbtDEf
 3TLQAp3JGUBHodZB/vhol6FTeIUtlm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-2WfjWYtCMrmrTLZ5FwhuWg-1; Wed, 26 Aug 2020 03:50:59 -0400
X-MC-Unique: 2WfjWYtCMrmrTLZ5FwhuWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3E3D10066FB;
 Wed, 26 Aug 2020 07:50:57 +0000 (UTC)
Received: from localhost (ovpn-112-172.ams2.redhat.com [10.36.112.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4601B708FF;
 Wed, 26 Aug 2020 07:50:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL v2 00/34] Block patches
Date: Wed, 26 Aug 2020 09:50:55 +0200
Message-Id: <20200826075055.779372-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:47:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 30aa19446d82358a30eac3b556b4d6641e00b7c1:

  Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20200812' into staging (2020-08-24 16:39:53 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-08-26

for you to fetch changes up to a5d3cfa2dc775e5d99f013703b8508f1d989d588:

  iotests: Add tests for qcow2 images with extended L2 entries (2020-08-26 08:49:51 +0200)

----------------------------------------------------------------
Block patches:
- qcow2 subclusters (extended L2 entries)

----------------------------------------------------------------
v2:
- Fixed the shebang line in iotest 271

----------------------------------------------------------------
Alberto Garcia (34):
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
  qcow2: Add prealloc field to QCowL2Meta
  qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit
  qcow2: Allow preallocation and backing files if extended_l2 is set
  qcow2: Assert that expand_zero_clusters_in_l1() does not support
    subclusters
  iotests: Add tests for qcow2 images with extended L2 entries

 docs/interop/qcow2.txt           |  68 ++-
 docs/qcow2-cache.txt             |  19 +-
 qapi/block-core.json             |   7 +
 block/qcow2.h                    | 211 ++++++-
 include/block/block_int.h        |   1 +
 block/qcow2-cluster.c            | 906 +++++++++++++++++++++----------
 block/qcow2-refcount.c           |  47 +-
 block/qcow2.c                    | 302 +++++++----
 block/trace-events               |   2 +-
 tests/qemu-iotests/031.out       |   8 +-
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 ++--
 tests/qemu-iotests/060.out       |   3 +-
 tests/qemu-iotests/061           |   6 +
 tests/qemu-iotests/061.out       |  25 +-
 tests/qemu-iotests/065           |  12 +-
 tests/qemu-iotests/082.out       |  39 +-
 tests/qemu-iotests/085.out       |  38 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/198           |   2 +
 tests/qemu-iotests/206.out       |   6 +-
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/271           | 901 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/271.out       | 726 +++++++++++++++++++++++++
 tests/qemu-iotests/274.out       |  49 +-
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/291.out       |   2 +
 tests/qemu-iotests/302.out       |   1 +
 tests/qemu-iotests/303.out       |   4 +-
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/group         |   1 +
 34 files changed, 2952 insertions(+), 570 deletions(-)
 create mode 100755 tests/qemu-iotests/271
 create mode 100644 tests/qemu-iotests/271.out

-- 
2.26.2


