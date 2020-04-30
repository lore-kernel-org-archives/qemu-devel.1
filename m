Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F037C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF1D20775
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQCDMzTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF1D20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBZX-0002oZ-3W
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 11:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBWg-0007jk-UP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBUS-00033p-3g
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:55:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUBUR-00033L-KD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588261962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3RM4S9v0NGz3bYz9QOLVgcmqJDPE2f+owMiDCW4ofTY=;
 b=QQCDMzThu+F5V9Yha8saWK6+zVHhPqzIGa4SzF6L4XQJpv/1lj1hw1afqmhXRBBZETBkvI
 WZ9DH6PVJSU6Ya9KzPPOdXGjsvN2sLR8fqVYO6Z7aoySQ4gxp+msNWq3bLw/4seLrc86SM
 8b/FzSF5M4hhGq964o2IuI6nArVFlWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-DqVbmJ4sMWGhf-pzymZNGw-1; Thu, 30 Apr 2020 11:52:40 -0400
X-MC-Unique: DqVbmJ4sMWGhf-pzymZNGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8DDB835B52;
 Thu, 30 Apr 2020 15:52:39 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F34E389D3E;
 Thu, 30 Apr 2020 15:52:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/15] Block layer patches
Date: Thu, 30 Apr 2020 17:52:16 +0200
Message-Id: <20200430155231.473156-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 16aaacb307ed607b9780c12702c44f0fe52edc7e=
:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200430' into st=
aging (2020-04-30 14:00:36 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to eaae29ef89d498d0eac553c77b554f310a47f809:

  qemu-storage-daemon: Fix non-string --object properties (2020-04-30 17:51=
:07 +0200)

----------------------------------------------------------------
Block layer patches:

- Fix resize (extending) of short overlays
- nvme: introduce PMR support from NVMe 1.4 spec
- qemu-storage-daemon: Fix non-string --object properties

----------------------------------------------------------------
Alberto Garcia (1):
      qcow2: Add incompatibility note between backing files and raw externa=
l data files

Andrzej Jakowski (1):
      nvme: introduce PMR support from NVMe 1.4 spec

Kevin Wolf (12):
      block: Add flags to BlockDriver.bdrv_co_truncate()
      block: Add flags to bdrv(_co)_truncate()
      block-backend: Add flags to blk_truncate()
      qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
      raw-format: Support BDRV_REQ_ZERO_WRITE for truncate
      file-posix: Support BDRV_REQ_ZERO_WRITE for truncate
      block: truncate: Don't make backing file data visible
      iotests: Filter testfiles out in filter_img_info()
      iotests: Test committing to short backing file
      qcow2: Forward ZERO_WRITE flag for full preallocation
      qom: Factor out user_creatable_add_dict()
      qemu-storage-daemon: Fix non-string --object properties

Paolo Bonzini (1):
      qemu-iotests: allow qcow2 external discarded clusters to contain stal=
e data

 docs/interop/qcow2.txt          |   3 +
 hw/block/nvme.h                 |   2 +
 include/block/block.h           |   5 +-
 include/block/block_int.h       |  10 +-
 include/block/nvme.h            | 172 ++++++++++++++++++++++++++
 include/qom/object_interfaces.h |  16 +++
 include/sysemu/block-backend.h  |   2 +-
 block.c                         |   3 +-
 block/block-backend.c           |   4 +-
 block/commit.c                  |   4 +-
 block/crypto.c                  |   7 +-
 block/file-posix.c              |   6 +-
 block/file-win32.c              |   2 +-
 block/gluster.c                 |   1 +
 block/io.c                      |  43 ++++++-
 block/iscsi.c                   |   2 +-
 block/mirror.c                  |   2 +-
 block/nfs.c                     |   3 +-
 block/parallels.c               |   6 +-
 block/qcow.c                    |   4 +-
 block/qcow2-cluster.c           |   2 +-
 block/qcow2-refcount.c          |   2 +-
 block/qcow2.c                   |  73 +++++++++--
 block/qed.c                     |   3 +-
 block/raw-format.c              |   6 +-
 block/rbd.c                     |   1 +
 block/sheepdog.c                |   4 +-
 block/ssh.c                     |   2 +-
 block/vdi.c                     |   2 +-
 block/vhdx-log.c                |   2 +-
 block/vhdx.c                    |   6 +-
 block/vmdk.c                    |   8 +-
 block/vpc.c                     |   2 +-
 blockdev.c                      |   2 +-
 hw/block/nvme.c                 | 109 ++++++++++++++++
 qemu-img.c                      |   2 +-
 qemu-io-cmds.c                  |   2 +-
 qemu-storage-daemon.c           |   4 +-
 qom/object_interfaces.c         |  31 +++++
 qom/qom-qmp-cmds.c              |  24 +---
 tests/test-block-iothread.c     |   9 +-
 tests/qemu-iotests/iotests.py   |   5 +-
 hw/block/Makefile.objs          |   2 +-
 hw/block/trace-events           |   4 +
 tests/qemu-iotests/244          |  10 +-
 tests/qemu-iotests/244.out      |   9 +-
 tests/qemu-iotests/274          | 155 +++++++++++++++++++++++
 tests/qemu-iotests/274.out      | 268 ++++++++++++++++++++++++++++++++++++=
++++
 tests/qemu-iotests/group        |   1 +
 49 files changed, 951 insertions(+), 96 deletions(-)
 create mode 100755 tests/qemu-iotests/274
 create mode 100644 tests/qemu-iotests/274.out


