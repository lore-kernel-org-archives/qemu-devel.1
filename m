Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979C1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0072620732
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+K34pX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0072620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLlp-0006nj-05
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLks-0004tV-Ay
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLkk-0004RF-CU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599502828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CU9lugc1k/bVfer+aY5ls8wAJiBCFEk0+My6vYaPL9c=;
 b=I+K34pX13kBeikd0BhXTqtRIoVyzcXKFzfBqEUCL3E433L0fBjufFOqGLzYixskKCF/AP+
 TC2TxlJsGRXdfTHlS0tf5PbpPBx5VMzQe9sL5tHvwkrbDpZ52cfA0mjazP0sHwMli1x06/
 l+0ZaxttGqRZd1ZrGErsIbM4JtvZc6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-KFr-mF-rNhiPGnSCh6GgqA-1; Mon, 07 Sep 2020 14:20:25 -0400
X-MC-Unique: KFr-mF-rNhiPGnSCh6GgqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 436BF801FDC;
 Mon,  7 Sep 2020 18:20:24 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2957D60BF3;
 Mon,  7 Sep 2020 18:20:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 00/29] block/export: Add infrastructure and QAPI for block
 exports
Date: Mon,  7 Sep 2020 20:19:42 +0200
Message-Id: <20200907182011.521007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 14:12:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are planning to add more block export types than just NBD in the near
future (e.g. vhost-user-blk and FUSE). This series lays the ground for
this with some generic block export infrastructure and QAPI interfaces
that will allow managing all of them (for now add/remove/query).

As a side effect, qemu-storage-daemon can now map --export directly to
the block-export-add QMP command, similar to other command line options.
The built-in NBD servers also gains new options that bring it at least a
little closer to feature parity with qemu-nbd.

Kevin Wolf (29):
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
  iotests: Test block-export-* QMP interface

 qapi/block-core.json                 | 166 --------------
 qapi/block-export.json               | 291 ++++++++++++++++++++++++
 qapi/qapi-schema.json                |   1 +
 docs/system/deprecated.rst           |   8 +
 include/block/export.h               |  89 ++++++++
 include/block/nbd.h                  |  22 +-
 block.c                              |   2 +-
 block/export/export.c                | 318 +++++++++++++++++++++++++++
 block/monitor/block-hmp-cmds.c       |  13 +-
 blockdev-nbd.c                       | 171 +++++++-------
 nbd/server.c                         | 309 +++++++++++---------------
 qemu-nbd.c                           |  67 +++---
 storage-daemon/qemu-storage-daemon.c |  27 +--
 tests/qemu-iotests/iotests.py        |  59 ++---
 block/export/meson.build             |   1 +
 block/meson.build                    |   2 +
 meson.build                          |   2 +-
 qapi/meson.build                     |   4 +-
 storage-daemon/qapi/qapi-schema.json |   1 +
 tests/qemu-iotests/140.out           |   1 +
 tests/qemu-iotests/223.out           |   8 +-
 tests/qemu-iotests/307               | 117 ++++++++++
 tests/qemu-iotests/307.out           | 111 ++++++++++
 tests/qemu-iotests/group             |   1 +
 24 files changed, 1267 insertions(+), 524 deletions(-)
 create mode 100644 qapi/block-export.json
 create mode 100644 include/block/export.h
 create mode 100644 block/export/export.c
 create mode 100644 block/export/meson.build
 create mode 100755 tests/qemu-iotests/307
 create mode 100644 tests/qemu-iotests/307.out

-- 
2.25.4


