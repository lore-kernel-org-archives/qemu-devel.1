Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DD6C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E607206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBSF5+aC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E607206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8VX-000230-KG
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Tu-0000Co-Jj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Ts-0004Vs-82
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ez15pI8lC8jlBr9Yh/7N97pI7E08KCHPgyEk+QpVpW4=;
 b=gBSF5+aCFBQ0YBbb/hLBc3GjrCE842iRuOcy6SVwGbllxNit1J3vk+35HlB7IdsScNm7cv
 gFH1m6yiFPCdgvJCGNXNAsfJGoaIiKaUFXo+1Pl3L/xqp2oPMwuP7bnLfvTYkdfg3T2uTY
 j5wH8uh0yqYZ3zDLxbS3MMHoN78wMDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-_XVL_z-xNe6I4qeMsOVAxw-1; Tue, 15 Sep 2020 06:46:30 -0400
X-MC-Unique: _XVL_z-xNe6I4qeMsOVAxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7FB31084D62;
 Tue, 15 Sep 2020 10:46:29 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 627CA60BE2;
 Tue, 15 Sep 2020 10:46:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/22] Block patches
Date: Tue, 15 Sep 2020 12:46:05 +0200
Message-Id: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:29:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2d2c73d0e3d504a61f868e46e6abd5643f38091b:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200914-1' into staging (2020-09-14 16:03:08 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-09-15

for you to fetch changes up to 7bae7c805d82675eb3a02c744093703d84ada2d6:

  block/rbd: add 'namespace' to qemu_rbd_strong_runtime_opts[] (2020-09-15 11:31:10 +0200)

----------------------------------------------------------------
Block patches:
- Several qcow2 fixes and refactorings
- Let qemu-img convert try to stay at cluster boundaries
- Stable child names for quorum (with x-blockdev-change)
- Explicitly drop vhdx 4k sector support, as it was never actually
  working
- rbd: Mark @namespace a strong runtime option
- iotests.py improvements
- Drop unused runtime_opts objects
- Skip a test case in 030 when run through make check-block

----------------------------------------------------------------
Alberto Garcia (9):
  qcow2: Use macros for the L1, refcount and bitmap table entry sizes
  qcow2: Fix removal of list members from BDRVQcow2State.cluster_allocs
  qcow2: Don't check nb_clusters when removing l2meta from the list
  qcow2: Rewrite the documentation of qcow2_alloc_cluster_offset()
  qcow2: Handle QCowL2Meta on error in preallocate_co()
  qcow2: Make qcow2_free_any_clusters() free only one cluster
  qcow2: Return the original error code in qcow2_co_pwrite_zeroes()
  qcow2: Make preallocate_co() resize the image to the correct size
  qcow2: Convert qcow2_alloc_cluster_offset() into
    qcow2_alloc_host_offset()

John Snow (2):
  block/rbd: remove runtime_opts
  block/qcow: remove runtime opts

Lukas Straub (1):
  block/quorum.c: stable children names

Nir Soffer (5):
  qemu-iotests: Fix FilePaths cleanup
  qemu-iotests: Fix FilePaths docstring
  qemu-iotests: Support varargs syntax in FilePaths
  qemu-iotests: Merge FilePaths and FilePath
  qemu-iotests: Simplify FilePath __init__

Peter Lieven (1):
  qemu-img: avoid unaligned read requests during convert

Stefano Garzarella (1):
  block/rbd: add 'namespace' to qemu_rbd_strong_runtime_opts[]

Swapnil Ingle (1):
  block/vhdx: Support vhdx image only with 512 bytes logical sector size

Thomas Huth (1):
  iotests: Skip test_stream_parallel in test 030 when doing "make check"

Yi Li (1):
  qemu-img: Explicit number replaced by a constant

 block/qcow2.h                 |  16 +++--
 block/qcow.c                  |   9 ---
 block/qcow2-bitmap.c          |  11 ++--
 block/qcow2-cluster.c         |  69 ++++++++++++----------
 block/qcow2-refcount.c        |  97 +++++++++++++++---------------
 block/qcow2-snapshot.c        |  20 +++----
 block/qcow2.c                 | 108 ++++++++++++++--------------------
 block/quorum.c                |  20 +++++--
 block/rbd.c                   |  43 +-------------
 block/vhdx.c                  |   6 +-
 qemu-img.c                    |  32 ++++++++--
 tests/check-block.sh          |   3 +
 tests/qemu-iotests/030        |   2 +
 tests/qemu-iotests/125        |  44 ++++++++------
 tests/qemu-iotests/125.out    |  28 ++++++++-
 tests/qemu-iotests/194        |   4 +-
 tests/qemu-iotests/208        |   2 +-
 tests/qemu-iotests/222        |   2 +-
 tests/qemu-iotests/251        |   7 ++-
 tests/qemu-iotests/257        |  10 ++--
 tests/qemu-iotests/305        |  74 +++++++++++++++++++++++
 tests/qemu-iotests/305.out    |  16 +++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  53 +++++++++--------
 24 files changed, 395 insertions(+), 282 deletions(-)
 create mode 100755 tests/qemu-iotests/305
 create mode 100644 tests/qemu-iotests/305.out

-- 
2.26.2


