Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1EAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34C920709
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnDF+GFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34C920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajFY-0008IC-Rw
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jajEb-0006yC-3O
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:07:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31686
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jajEZ-000505-24
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589821641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=It0ZhduZoPtSdcdOH/6UlKXCUevXPqmMS35xKqPtpao=;
 b=MnDF+GFe3DaI9cOXyewWA/MV833vQ1tp1el9VmfL3qGinEVanty2oejB1EMVvvgmd1M1e8
 BaX01hrn3DOytqd+dbxj/A6rhwXY7enEkQh0uhs3p4SBHfTVhlRrH5EusnwgkNMicw1nrd
 AJgYzq2AQ5L0gDs05QmhPaqsYvfyao8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-_-5NvtTSMzSoOUiwdBp7bQ-1; Mon, 18 May 2020 13:07:20 -0400
X-MC-Unique: _-5NvtTSMzSoOUiwdBp7bQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06A7A80B71E;
 Mon, 18 May 2020 17:07:19 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-96.ams2.redhat.com [10.36.112.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C049100239B;
 Mon, 18 May 2020 17:07:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL v2 00/52] Block layer patches
Date: Mon, 18 May 2020 19:06:59 +0200
Message-Id: <20200518170659.36547-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit debe78ce14bf8f8940c2bdf3ef387505e9e035a9:

  Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20200515' into staging (2020-05-15 19:51:16 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 4cdd0a774dc35b2ffe6ddb634e0c431f17dfe07e:

  hw: Use QEMU_IS_ALIGNED() on parallel flash block size (2020-05-18 19:05:25 +0200)

----------------------------------------------------------------
Block layer patches:

- Introduce real BdrvChildRole
- blk/bdrv_make_empty() functions instead of calling callbacks directly
- mirror: Make sure that source and target size match
- block-copy: Fix uninitialized variable
- block/replication: Avoid cancelling the job twice
- ahci: Log lost IRQs
- iotests: Run pylint and mypy in a testcase
- iotests: log messages from notrun()

----------------------------------------------------------------
John Snow (1):
      iotests: log messages from notrun()

Kevin Wolf (8):
      iotests/109: Don't mirror with mismatched size
      iotests/229: Use blkdebug to inject an error
      mirror: Make sure that source and target size match
      iotests: Mirror with different source/target size
      iotests: Fix incomplete type declarations
      iotests: Run pylint and mypy in a testcase
      replication: Avoid blk_make_empty() on read-only child
      iotests/030: Reduce run time by unthrottling job earlier

Lukas Straub (1):
      block/replication.c: Avoid cancelling the job twice

Max Reitz (38):
      block: Add bdrv_make_empty()
      block: Add blk_make_empty()
      block: Use blk_make_empty() after commits
      block: Use bdrv_make_empty() where possible
      block: Mark commit, mirror, blkreplay as filters
      block: Add BlockDriver.is_format
      block: Rename BdrvChildRole to BdrvChildClass
      block: Add BdrvChildRole and BdrvChildRoleBits
      block: Add BdrvChildRole to BdrvChild
      block: Pass BdrvChildRole to bdrv_child_perm()
      block: Pass BdrvChildRole to .inherit_options()
      block: Pass parent_is_format to .inherit_options()
      block: Rename bdrv_inherited_options()
      block: Add generic bdrv_inherited_options()
      block: Use bdrv_inherited_options()
      block: Unify bdrv_child_cb_attach()
      block: Unify bdrv_child_cb_detach()
      block: Add child_of_bds
      block: Distinguish paths in *_format_default_perms
      block: Pull out bdrv_default_perms_for_cow()
      block: Pull out bdrv_default_perms_for_storage()
      block: Relax *perms_for_storage for data children
      block: Add bdrv_default_perms()
      raw-format: Split raw_read_options()
      block: Switch child_format users to child_of_bds
      block: Drop child_format
      block: Make backing files child_of_bds children
      block: Drop child_backing
      block: Make format drivers use child_of_bds
      block: Make filter drivers use child_of_bds
      block: Use child_of_bds in remaining places
      tests: Use child_of_bds instead of child_file
      block: Use bdrv_default_perms()
      block: Make bdrv_filter_default_perms() static
      block: Drop bdrv_format_default_perms()
      block: Drop child_file
      block: Pass BdrvChildRole in remaining cases
      block: Drop @child_class from bdrv_child_perm()

Philippe Mathieu-Daudé (4):
      block/block-copy: Fix uninitialized variable in block_copy_task_entry
      block/block-copy: Simplify block_copy_do_copy()
      hw/ide/ahci: Log lost IRQs
      hw: Use QEMU_IS_ALIGNED() on parallel flash block size

 include/block/block.h            |  65 ++++-
 include/block/block_int.h        |  57 ++--
 include/sysemu/block-backend.h   |   2 +
 block.c                          | 601 ++++++++++++++++++++++++---------------
 block/backup-top.c               |  11 +-
 block/blkdebug.c                 |  10 +-
 block/blklogwrites.c             |  16 +-
 block/blkreplay.c                |   8 +-
 block/blkverify.c                |  10 +-
 block/block-backend.c            |  30 +-
 block/block-copy.c               |  14 +-
 block/bochs.c                    |   7 +-
 block/cloop.c                    |   7 +-
 block/commit.c                   |  20 +-
 block/copy-on-read.c             |   7 +-
 block/crypto.c                   |   8 +-
 block/dmg.c                      |   7 +-
 block/filter-compress.c          |   7 +-
 block/io.c                       |  22 +-
 block/mirror.c                   |  25 +-
 block/parallels.c                |   7 +-
 block/qcow.c                     |   7 +-
 block/qcow2.c                    |  20 +-
 block/qed.c                      |   7 +-
 block/quorum.c                   |   8 +-
 block/raw-format.c               | 128 +++++----
 block/replication.c              |  23 +-
 block/throttle.c                 |   7 +-
 block/vdi.c                      |   7 +-
 block/vhdx.c                     |   7 +-
 block/vmdk.c                     |  23 +-
 block/vpc.c                      |   7 +-
 block/vvfat.c                    |  17 +-
 blockjob.c                       |   7 +-
 hw/arm/sbsa-ref.c                |   2 +-
 hw/arm/virt.c                    |   2 +-
 hw/block/pflash_cfi01.c          |   2 +-
 hw/block/pflash_cfi02.c          |   2 +-
 hw/i386/pc_sysfw.c               |   2 +-
 hw/ide/ahci.c                    |   1 +
 hw/riscv/virt.c                  |   2 +-
 qemu-img.c                       |  19 +-
 tests/test-bdrv-drain.c          |  72 +++--
 tests/test-bdrv-graph-mod.c      |  10 +-
 tests/test-block-iothread.c      |  17 +-
 tests/qemu-iotests/iotests.py    |  19 +-
 tests/qemu-iotests/030           |   6 +-
 tests/qemu-iotests/041           |  45 +++
 tests/qemu-iotests/041.out       |   4 +-
 tests/qemu-iotests/098.out       |   8 +-
 tests/qemu-iotests/109           |  10 +-
 tests/qemu-iotests/109.out       |  74 ++---
 tests/qemu-iotests/229           |  18 +-
 tests/qemu-iotests/229.out       |   6 +-
 tests/qemu-iotests/297           |  44 +++
 tests/qemu-iotests/297.out       |   3 +
 tests/qemu-iotests/common.filter |   5 +
 tests/qemu-iotests/group         |   1 +
 58 files changed, 1003 insertions(+), 580 deletions(-)
 create mode 100755 tests/qemu-iotests/297
 create mode 100644 tests/qemu-iotests/297.out


