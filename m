Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018A4C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819C42065D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9WT9mfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819C42065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMOe-0001t5-Lr
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMHw-00015Q-OW
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMHu-0004UY-BS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601649837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ALB/FaNk12kyGw2O7Nm1BIYejy+pp+h9g1HM6AxLjHY=;
 b=O9WT9mfrjeM/Op268CfYa4h6G0e126w9MLfmGF7w1jfeuvR5XnIMg01FbUJyE6jWA+L0bu
 ocWasMN95aJFTA3ybaH1ngTLfko5kPuJKhNpLCHmWrIqY8WFwgsarXTxMifDVF1D0nvyUx
 qtM3xIZAfe7u00c62VH4Q9bugSPgSdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-W7B2WxsjNyOMJ2J1slQk6g-1; Fri, 02 Oct 2020 10:43:52 -0400
X-MC-Unique: W7B2WxsjNyOMJ2J1slQk6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 295D8192AB80;
 Fri,  2 Oct 2020 14:43:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-139.ams2.redhat.com
 [10.36.112.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1ED665D9D3;
 Fri,  2 Oct 2020 14:43:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/37] Block layer patches
Date: Fri,  2 Oct 2020 16:43:08 +0200
Message-Id: <20201002144345.253865-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 0d2a4545bf7e763984d3ee3e802617544cb7fc7a:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-python-021020-1' into staging (2020-10-02 13:39:20 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to c508c73dca636cc0fc7413d1e4a43fcfe4a5698c:

  qcow2: Use L1E_SIZE in qcow2_write_l1_entry() (2020-10-02 15:46:40 +0200)

----------------------------------------------------------------
Block layer patches:

- Add block export infrastructure
- iotests improvements
- Document the throttle block filter
- Misc code cleanups

----------------------------------------------------------------
Alberto Garcia (2):
      docs: Document the throttle block filter
      qcow2: Use L1E_SIZE in qcow2_write_l1_entry()

Dr. David Alan Gilbert (1):
      qemu-io-cmds: Simplify help_oneline

Kevin Wolf (32):
      nbd: Remove unused nbd_export_get_blockdev()
      qapi: Create block-export module
      qapi: Rename BlockExport to BlockExportOptions
      block/export: Add BlockExport infrastructure and block-export-add
      qemu-storage-daemon: Use qmp_block_export_add()
      qemu-nbd: Use raw block driver for --offset
      block/export: Remove magic from block-export-add
      nbd: Add max-connections to nbd-server-start
      nbd: Add writethrough to block-export-add
      nbd: Remove NBDExport.close callback
      qemu-nbd: Use blk_exp_add() to create the export
      nbd/server: Simplify export shutdown
      block/export: Move refcount from NBDExport to BlockExport
      block/export: Move AioContext from NBDExport to BlockExport
      block/export: Add node-name to BlockExportOptions
      block/export: Allocate BlockExport in blk_exp_add()
      block/export: Add blk_exp_close_all(_type)
      block/export: Add 'id' option to block-export-add
      block/export: Move strong user reference to block_exports
      block/export: Add block-export-del
      block/export: Add BLOCK_EXPORT_DELETED event
      block/export: Move blk to BlockExport
      block/export: Create BlockBackend in blk_exp_add()
      block/export: Add query-block-exports
      block/export: Move writable to BlockExportOptions
      nbd: Merge nbd_export_new() and nbd_export_create()
      nbd: Deprecate nbd-server-add/remove
      iotests: Factor out qemu_tool_pipe_and_status()
      iotests: Introduce qemu_nbd_list_log()
      iotests: Allow supported and unsupported formats at the same time
      iotests: Test block-export-* QMP interface
      qemu-storage-daemon: Fix help line for --export

Philippe Mathieu-Daudé (1):
      block/sheepdog: Replace magic val by NANOSECONDS_PER_SECOND definition

Thomas Huth (1):
      tests/check-block: Do not run the iotests with old versions of bash

 qapi/block-core.json                 | 166 ------------------
 qapi/block-export.json               | 291 +++++++++++++++++++++++++++++++
 qapi/qapi-schema.json                |   1 +
 docs/system/deprecated.rst           |   6 +
 docs/throttle.txt                    | 108 +++++++++++-
 include/block/export.h               |  89 ++++++++++
 include/block/nbd.h                  |  22 +--
 block.c                              |   2 +-
 block/export/export.c                | 325 +++++++++++++++++++++++++++++++++++
 block/monitor/block-hmp-cmds.c       |  13 +-
 block/qcow2-cluster.c                |   4 +-
 block/sheepdog.c                     |   2 +-
 blockdev-nbd.c                       | 171 +++++++++---------
 nbd/server.c                         | 309 ++++++++++++++-------------------
 qemu-io-cmds.c                       |  11 +-
 qemu-nbd.c                           |  67 ++++----
 storage-daemon/qemu-storage-daemon.c |  27 +--
 tests/qemu-iotests/iotests.py        |  68 ++++----
 block/export/meson.build             |   1 +
 block/meson.build                    |   2 +
 meson.build                          |   2 +-
 qapi/meson.build                     |   4 +-
 storage-daemon/qapi/qapi-schema.json |   1 +
 tests/check-block.sh                 |   5 +
 tests/qemu-iotests/140               |   9 +-
 tests/qemu-iotests/140.out           |   2 +-
 tests/qemu-iotests/223.out           |   8 +-
 tests/qemu-iotests/307               | 132 ++++++++++++++
 tests/qemu-iotests/307.out           | 124 +++++++++++++
 tests/qemu-iotests/group             |   1 +
 30 files changed, 1428 insertions(+), 545 deletions(-)
 create mode 100644 qapi/block-export.json
 create mode 100644 include/block/export.h
 create mode 100644 block/export/export.c
 create mode 100644 block/export/meson.build
 create mode 100755 tests/qemu-iotests/307
 create mode 100644 tests/qemu-iotests/307.out


