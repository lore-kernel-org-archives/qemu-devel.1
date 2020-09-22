Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD0EC4742A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623F42399A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R31RuPJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623F42399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfy9-0008Ko-9J
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfs7-0000Md-6S
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfs3-0000U5-EW
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2aCNWRG2L47AEtyb+XYywRJUQcl5CJofgX6m9l39ZyU=;
 b=R31RuPJe7lTKS27DnBrv7c1Oam/RXA3dDRbTW2CUg/i5j0ZoCqTyMJzaFu6UkvZxFNuXcQ
 aoK8+GUq/ZkIeASWmx2biebn+8fWZEnhmxL+aY/nBm6o/Dbav4dDvG82t+0hE8HkryON6v
 dJXCYFXzUH41+rf2e3s62Vnx7U2FGGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-TeuX3X0DPoCPlmU48cRjzw-1; Tue, 22 Sep 2020 06:49:38 -0400
X-MC-Unique: TeuX3X0DPoCPlmU48cRjzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66846808245;
 Tue, 22 Sep 2020 10:49:37 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA1F7881A;
 Tue, 22 Sep 2020 10:49:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 00/20] block/export: Allow exporting BDSs via FUSE
Date: Tue, 22 Sep 2020 12:49:12 +0200
Message-Id: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200907182011.521007-1-kwolf@redhat.com>
          (“block/export: Add infrastructure and QAPI for block exports”)

(Though its patch 16 needs a s/= \&blk_exp_nbd/= drv/ on top.)

v1: https://lists.nongnu.org/archive/html/qemu-block/2019-12/msg00451.html

Branch: https://github.com/XanClic/qemu.git fuse-exports-v2
Branch: https://git.xanclic.moe/XanClic/qemu.git fuse-exports-v2


Hi,

Ever since I found out that you can mount FUSE filesystems on regular
files (not just directories), I had the idea of adding FUSE block
exports to qemu where you can export block nodes as raw images.  The
best thing is that you’d be able to mount an image on itself, so
whatever format it may be in, qemu lets it appear as a raw image (and
you can then use regular tools like dd on it).

The performance is quite bad so far, but we can always try to improve it
if the need arises.  For now I consider it mostly a cute feature to get
easy access to the raw contents of image files in any format (without
requiring root rights).

In this version (as opposed to v1 linked above), I integrated the FUSE
export code into Kevin’s proposed common infrastructure for block
exports.


This series does the following:

First, add the FUSE export module (block/export/fuse.c) that implements
the basic file access functions.  (Note that you need libfuse 3.8.0 or
later for SEEK_HOLE/SEEK_DATA.)

Second, it allows using FUSE exports as a protocol in the iotests and
makes many iotests work with it.  (The file node is exported by a
background qemu instance to $SOCK_DIR.)

This gives us a lot of coverage for, well, not free (it does take twelve
patches), but for cheap; but there are still some more specialized
things we want to test, so third and last, this series adds an iotest
dedicated to FUSE exports.


(Note that as opposed to v1, I did run the iotests this time.)


Some notable changes from v1:
- Integrated everything into Kevin’s block-export infrastructure
- Use the storage daemon instead of full QEMU to provide FUSE exports
  when running the iotests with -fuse
- meson rebase
- Some other rebase conflicts


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/20:[0007] [FC] 'configure: Detect libfuse'
002/20:[0255] [FC] 'fuse: Allow exporting BDSs via FUSE'
003/20:[0062] [FC] 'fuse: Implement standard FUSE operations'
004/20:[0018] [FC] 'fuse: Allow growable exports'
005/20:[0016] [FC] 'fuse: (Partially) implement fallocate()'
006/20:[0008] [FC] 'fuse: Implement hole detection through lseek'
007/20:[0036] [FC] 'iotests: Do not needlessly filter _make_test_img'
008/20:[----] [--] 'iotests: Do not pipe _make_test_img'
009/20:[0012] [FC] 'iotests: Use convert -n in some cases'
010/20:[0006] [FC] 'iotests: Avoid renaming images'
011/20:[0008] [FC] 'iotests: Derive image names from $TEST_IMG'
012/20:[----] [--] 'iotests/091: Use _cleanup_qemu instad of "wait"'
013/20:[0008] [FC] 'iotests: Restrict some Python tests to file'
014/20:[0010] [FC] 'iotests: Let _make_test_img guess $TEST_IMG_FILE'
015/20:[down] 'iotests/287: Clean up subshell test image'
016/20:[down] 'storage-daemon: Call bdrv_close_all() on exit'
017/20:[down] 'iotests: Give access to the qemu-storage-daemon'
018/20:[0042] [FC] 'iotests: Allow testing FUSE exports'
019/20:[0026] [FC] 'iotests: Enable fuse for many tests'
020/20:[0104] [FC] 'iotests/281: Add test for FUSE exports'


Max Reitz (20):
  configure: Detect libfuse
  fuse: Allow exporting BDSs via FUSE
  fuse: Implement standard FUSE operations
  fuse: Allow growable exports
  fuse: (Partially) implement fallocate()
  fuse: Implement hole detection through lseek
  iotests: Do not needlessly filter _make_test_img
  iotests: Do not pipe _make_test_img
  iotests: Use convert -n in some cases
  iotests/046: Avoid renaming images
  iotests: Derive image names from $TEST_IMG
  iotests/091: Use _cleanup_qemu instad of "wait"
  iotests: Restrict some Python tests to file
  iotests: Let _make_test_img guess $TEST_IMG_FILE
  iotests/287: Clean up subshell test image
  storage-daemon: Call bdrv_close_all() on exit
  iotests: Give access to the qemu-storage-daemon
  iotests: Allow testing FUSE exports
  iotests: Enable fuse for many tests
  iotests/308: Add test for FUSE exports

 configure                            |  66 +++
 qapi/block-export.json               |  28 +-
 include/block/fuse.h                 |  30 ++
 block.c                              |   1 +
 block/export/export.c                |   4 +
 block/export/fuse.c                  | 645 +++++++++++++++++++++++++++
 storage-daemon/qemu-storage-daemon.c |   3 +
 block/export/meson.build             |   1 +
 meson.build                          |   7 +
 tests/qemu-iotests/025               |   2 +-
 tests/qemu-iotests/026               |   2 +-
 tests/qemu-iotests/028               |  16 +-
 tests/qemu-iotests/028.out           |   3 +
 tests/qemu-iotests/031               |   2 +-
 tests/qemu-iotests/034               |   2 +-
 tests/qemu-iotests/036               |   2 +-
 tests/qemu-iotests/037               |   2 +-
 tests/qemu-iotests/038               |   2 +-
 tests/qemu-iotests/039               |   2 +-
 tests/qemu-iotests/046               |   7 +-
 tests/qemu-iotests/046.out           |   2 +-
 tests/qemu-iotests/050               |   2 +-
 tests/qemu-iotests/054               |   2 +-
 tests/qemu-iotests/060               |   2 +-
 tests/qemu-iotests/071               |  21 +-
 tests/qemu-iotests/079               |   2 +-
 tests/qemu-iotests/080               |   2 +-
 tests/qemu-iotests/089               |   5 +-
 tests/qemu-iotests/089.out           |   1 +
 tests/qemu-iotests/090               |   2 +-
 tests/qemu-iotests/091               |   5 +-
 tests/qemu-iotests/095               |   2 +-
 tests/qemu-iotests/097               |   2 +-
 tests/qemu-iotests/098               |   2 +-
 tests/qemu-iotests/102               |   2 +-
 tests/qemu-iotests/103               |   2 +-
 tests/qemu-iotests/106               |   2 +-
 tests/qemu-iotests/107               |   2 +-
 tests/qemu-iotests/108               |   2 +-
 tests/qemu-iotests/111               |   2 +-
 tests/qemu-iotests/112               |   2 +-
 tests/qemu-iotests/115               |   2 +-
 tests/qemu-iotests/117               |   2 +-
 tests/qemu-iotests/120               |   2 +-
 tests/qemu-iotests/121               |   2 +-
 tests/qemu-iotests/127               |   2 +-
 tests/qemu-iotests/133               |   2 +-
 tests/qemu-iotests/137               |   2 +-
 tests/qemu-iotests/138               |   2 +-
 tests/qemu-iotests/140               |   2 +-
 tests/qemu-iotests/154               |   2 +-
 tests/qemu-iotests/161               |  14 +-
 tests/qemu-iotests/171               |   2 +-
 tests/qemu-iotests/174               |  10 +-
 tests/qemu-iotests/175               |   8 +-
 tests/qemu-iotests/176               |   2 +-
 tests/qemu-iotests/177               |   2 +-
 tests/qemu-iotests/179               |   2 +-
 tests/qemu-iotests/183               |   2 +-
 tests/qemu-iotests/186               |   2 +-
 tests/qemu-iotests/187               |   2 +-
 tests/qemu-iotests/191               |   2 +-
 tests/qemu-iotests/195               |   2 +-
 tests/qemu-iotests/200               |   5 +-
 tests/qemu-iotests/200.out           |   4 +-
 tests/qemu-iotests/204               |   2 +-
 tests/qemu-iotests/206               |   3 +-
 tests/qemu-iotests/214               |   2 +-
 tests/qemu-iotests/217               |   2 +-
 tests/qemu-iotests/220               |   2 +-
 tests/qemu-iotests/221               |   2 +-
 tests/qemu-iotests/229               |   5 +-
 tests/qemu-iotests/229.out           |   6 +-
 tests/qemu-iotests/242               |   3 +-
 tests/qemu-iotests/247               |   2 +-
 tests/qemu-iotests/249               |   8 +-
 tests/qemu-iotests/250               |   2 +-
 tests/qemu-iotests/252               |   2 +-
 tests/qemu-iotests/265               |   2 +-
 tests/qemu-iotests/268               |   2 +-
 tests/qemu-iotests/272               |   2 +-
 tests/qemu-iotests/273               |   2 +-
 tests/qemu-iotests/279               |   2 +-
 tests/qemu-iotests/286               |   2 +-
 tests/qemu-iotests/287               |   6 +-
 tests/qemu-iotests/289               |   2 +-
 tests/qemu-iotests/290               |   2 +-
 tests/qemu-iotests/291               |   2 +-
 tests/qemu-iotests/292               |   2 +-
 tests/qemu-iotests/293               |   2 +-
 tests/qemu-iotests/294               |   2 +-
 tests/qemu-iotests/305               |   2 +-
 tests/qemu-iotests/308               | 339 ++++++++++++++
 tests/qemu-iotests/308.out           |  97 ++++
 tests/qemu-iotests/check             |  17 +
 tests/qemu-iotests/common.filter     |   5 +-
 tests/qemu-iotests/common.rc         | 181 +++++++-
 tests/qemu-iotests/group             |   1 +
 98 files changed, 1559 insertions(+), 126 deletions(-)
 create mode 100644 include/block/fuse.h
 create mode 100644 block/export/fuse.c
 create mode 100755 tests/qemu-iotests/308
 create mode 100644 tests/qemu-iotests/308.out

-- 
2.26.2


