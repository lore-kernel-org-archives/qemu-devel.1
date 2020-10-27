Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FD4C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41D920756
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PauLBsqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41D920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUQX-00029D-Vv
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUIf-0000ol-UL
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUIc-0001Hy-LX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k3TLBXODEcwDnm4zNOFcabdvrlkWV8I/zzBL844aYfA=;
 b=PauLBsqxMV8Tf7HoDT7D+luSos4M1r01+jUt3TD121a6mHe9fIMMQpWX4r33WJn4q9VN25
 uosLVxjnppPp/lvKvq7jvBdy1A6QUjCpfwmN8jiAnbxMe8oV+waNfGqEKKMO/DN3Khz6UQ
 xQeUSEWhNKHyw1Xf0BW64q2QI0hfZhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-jh49S98CO4CctlCWmOWuWw-1; Tue, 27 Oct 2020 15:06:07 -0400
X-MC-Unique: jh49S98CO4CctlCWmOWuWw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AC53101EBEF;
 Tue, 27 Oct 2020 19:06:06 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24ED41992F;
 Tue, 27 Oct 2020 19:06:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-6.0 v3 00/20] block/export: Allow exporting BDSs via FUSE
Date: Tue, 27 Oct 2020 20:05:40 +0100
Message-Id: <20201027190600.192171-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1: https://lists.nongnu.org/archive/html/qemu-block/2019-12/msg00451.html
v2: https://lists.nongnu.org/archive/html/qemu-block/2020-09/msg01611.html

Branch: https://github.com/XanClic/qemu.git fuse-exports-v3
Branch: https://git.xanclic.moe/XanClic/qemu.git fuse-exports-v3


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


Changes from v2:
- Let meson handle the libfuse and feature (lseek) detection
- Rebase on top of vhost-user-blk export
- Patch 2:
  - %s/5\.2/6.0/
  - Renamed init_fuse() to init_exports_table(), so I can add a
    fuse_init() without being too confusing
  - Set max read/write request sizes (using that fuse_init() function,
    and mount options that libfuse still needs for max_read)
  - Run fuse_session_receive_buf() in a loop until something other than
    EINTR is returned
  - Let setup_fuse_export() clean up
  - Unmount and destroy the FUSE session only in fuse_export_delete()
    (after all I/O has settled and thus all references have been
    dropped)
  - Add MAINTAINERS entry
- Patch 3:
  - Don't use bdrv_query_image_info() when all we want is
    bdrv_get_allocated_file_size()
  - Optionally let fuse_do_truncate() require zeroes in the added areas
    (there is one fallocate() case where we don't need zeroes there)
  - Error out if the max read/write request sizes have been exceeded
    instead of (wrongly) limiting the request size
  - Rename fuse_flush() to fuse_fsync(), and let a new fuse_flush()
    invoke fuse_fsync()
- Patch 4:
  - Keep RESIZE permission for growable exports
- Patch 5:
  - Fix two bugs where I forgot to increment the offset when iterating
    over some area
- Patch 17:
  - %s/QEMU_STGD/QSD/
- Patch 18:
  - %s/QEMU_STGD/QSD/
  - Drop superfluous -T from df invocation


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/20:[down] 'meson: Detect libfuse'
002/20:[0103] [FC] 'fuse: Allow exporting BDSs via FUSE'
003/20:[0058] [FC] 'fuse: Implement standard FUSE operations'
004/20:[0034] [FC] 'fuse: Allow growable exports'
005/20:[0011] [FC] 'fuse: (Partially) implement fallocate()'
006/20:[0063] [FC] 'fuse: Implement hole detection through lseek'
007/20:[----] [--] 'iotests: Do not needlessly filter _make_test_img'
008/20:[----] [--] 'iotests: Do not pipe _make_test_img'
009/20:[----] [--] 'iotests: Use convert -n in some cases'
010/20:[----] [--] 'iotests/046: Avoid renaming images'
011/20:[----] [--] 'iotests: Derive image names from $TEST_IMG'
012/20:[----] [--] 'iotests/091: Use _cleanup_qemu instad of "wait"'
013/20:[----] [--] 'iotests: Restrict some Python tests to file'
014/20:[----] [--] 'iotests: Let _make_test_img guess $TEST_IMG_FILE'
015/20:[----] [--] 'iotests/287: Clean up subshell test image'
016/20:[----] [--] 'storage-daemon: Call bdrv_close_all() on exit'
017/20:[0018] [FC] 'iotests: Give access to the qemu-storage-daemon'
018/20:[0004] [FC] 'iotests: Allow testing FUSE exports'
019/20:[----] [--] 'iotests: Enable fuse for many tests'
020/20:[----] [--] 'iotests/308: Add test for FUSE exports'


Max Reitz (20):
  meson: Detect libfuse
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

 configure                            |  13 +
 meson.build                          |  26 +
 qapi/block-export.json               |  27 +-
 include/block/fuse.h                 |  30 ++
 block.c                              |   1 +
 block/export/export.c                |   4 +
 block/export/fuse.c                  | 726 +++++++++++++++++++++++++++
 storage-daemon/qemu-storage-daemon.c |   3 +
 MAINTAINERS                          |   6 +
 block/export/meson.build             |   1 +
 meson_options.txt                    |   4 +
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
 tests/qemu-iotests/308               | 339 +++++++++++++
 tests/qemu-iotests/308.out           |  97 ++++
 tests/qemu-iotests/check             |  17 +
 tests/qemu-iotests/common.filter     |   5 +-
 tests/qemu-iotests/common.rc         | 181 ++++++-
 tests/qemu-iotests/group             |   1 +
 100 files changed, 1615 insertions(+), 126 deletions(-)
 create mode 100644 include/block/fuse.h
 create mode 100644 block/export/fuse.c
 create mode 100755 tests/qemu-iotests/308
 create mode 100644 tests/qemu-iotests/308.out

-- 
2.26.2


