Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3143C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA1C23787
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAn0ZTpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA1C23787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTBf-0002ch-6j
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLT9n-0000c9-Jr
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLT9j-0005Mu-Vj
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a0RyNFVCrPJ3nP7aAUui823y+9UPa+tAmFGKQ/T4d7Q=;
 b=ZAn0ZTpVXRXFBhGz6m30kwAQKV8tX1IO6Z4yXjHRaB9cYIFHq07FA0ZvxTy6/w0LorgG0J
 xdsWl3CgrJBDF034pGoDv9m/MZuhMK4QRtXg+ywsYcg/6RJBoh/NwboleFrHyf2PB6W7gs
 7oyR+/oRT/T3ugDfeE8DmPGuM7GSVog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-uCZmE5pFNbGHH3UaM29jAQ-1; Thu, 24 Sep 2020 11:27:32 -0400
X-MC-Unique: uCZmE5pFNbGHH3UaM29jAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71DD81084C9A;
 Thu, 24 Sep 2020 15:27:31 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D35060C15;
 Thu, 24 Sep 2020 15:27:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 00/31] block/export: Add infrastructure and QAPI for block
 exports
Date: Thu, 24 Sep 2020 17:26:46 +0200
Message-Id: <20200924152717.287415-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
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

v2:
- Rebased on current master
- Fixed assumption of &blk_exp_nbd instead of drv in generic code [Max]
- Documented blk_exp_request_shutdown() better [Max]
- iotests 140: Fixed race between QMP return value and event [Max]
- Improved the commit message for patch 26
- Removed copy&paste error in deprecated.rst [Max]
- iotests: Take Sequence instead of positional arguments in
  qemu_tool_pipe_and_status() [Max]
- iotests: Separate patch for qemu_nbd_list_log [Max]
- iotests 307: [Max]
  * Allow more image formats
  * Use sock_dir for the socket
  * Use f-strings instead of % operator
  * Log events after deleting an export
  * Test force removing an export

Kevin Wolf (31):
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

 qapi/block-core.json                 | 166 --------------
 qapi/block-export.json               | 291 ++++++++++++++++++++++++
 qapi/qapi-schema.json                |   1 +
 docs/system/deprecated.rst           |   6 +
 include/block/export.h               |  89 ++++++++
 include/block/nbd.h                  |  22 +-
 block.c                              |   2 +-
 block/export/export.c                | 325 +++++++++++++++++++++++++++
 block/monitor/block-hmp-cmds.c       |  13 +-
 blockdev-nbd.c                       | 171 +++++++-------
 nbd/server.c                         | 309 +++++++++++--------------
 qemu-nbd.c                           |  67 +++---
 storage-daemon/qemu-storage-daemon.c |  27 +--
 tests/qemu-iotests/iotests.py        |  68 +++---
 block/export/meson.build             |   1 +
 block/meson.build                    |   2 +
 meson.build                          |   2 +-
 qapi/meson.build                     |   4 +-
 storage-daemon/qapi/qapi-schema.json |   1 +
 tests/qemu-iotests/140               |   9 +-
 tests/qemu-iotests/140.out           |   2 +-
 tests/qemu-iotests/223.out           |   8 +-
 tests/qemu-iotests/307               | 132 +++++++++++
 tests/qemu-iotests/307.out           | 124 ++++++++++
 tests/qemu-iotests/group             |   1 +
 25 files changed, 1311 insertions(+), 532 deletions(-)
 create mode 100644 qapi/block-export.json
 create mode 100644 include/block/export.h
 create mode 100644 block/export/export.c
 create mode 100644 block/export/meson.build
 create mode 100755 tests/qemu-iotests/307
 create mode 100644 tests/qemu-iotests/307.out

-- 
2.25.4


