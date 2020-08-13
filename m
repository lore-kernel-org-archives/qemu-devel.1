Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F261C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BA0206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNuf9nMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BA0206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6G8W-0003VV-GX
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G70-0001c9-2y
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:29:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G6x-0001Bh-To
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=P68AJAu4CMfCYBpYbSte2R6/0q49diNnuJVuLfU6zes=;
 b=ZNuf9nMb1zpgi3xVFIrEhLGund0e/b2uePO1fybxIJwp95JnUrj09ZPEH1HTAPMaTyIG46
 /peVu+TarG9eM9ofP/+DlqIBkVlnwi9rJIaxzSa/8by03e8J1lqDny019zKdSx+N0gdMo9
 LTTt4qp4yWMT+DT7y+kfyTXnyn7gM+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-L96L4fuqMEu7lQu-cVi54w-1; Thu, 13 Aug 2020 12:29:47 -0400
X-MC-Unique: L96L4fuqMEu7lQu-cVi54w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B67E71015DBF;
 Thu, 13 Aug 2020 16:29:46 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9400F5C1A3;
 Thu, 13 Aug 2020 16:29:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 00/22] block/export: Add infrastructure and QAPI for block
 exports
Date: Thu, 13 Aug 2020 18:29:13 +0200
Message-Id: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 12:29:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

This series is still RFC because the patches aren't very polished
(though they also shouldn't be too bad), it's not completely clear if
more features should be moved from NBD to the BlockExport layer in this
series (or maybe even less, and the rest dealt with in a separate
series) and qemu-iotests cases for the new interfaces are still missing.

Kevin Wolf (22):
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
  block/export: Move device to BlockExportOptions
  block/export: Allocate BlockExport in blk_exp_add()
  block/export: Add blk_exp_close_all(_type)
  block/export: Add 'id' option to block-export-add
  block/export: Move strong user reference to block_exports
  block/export: Add block-export-del
  block/export: Move blk to BlockExport
  block/export: Add query-block-exports

 qapi/block-core.json                 | 166 ---------------
 qapi/block-export.json               | 261 +++++++++++++++++++++++
 qapi/qapi-schema.json                |   1 +
 include/block/export.h               |  73 +++++++
 include/block/nbd.h                  |  25 +--
 block.c                              |   2 +-
 block/export/export.c                | 297 +++++++++++++++++++++++++++
 block/monitor/block-hmp-cmds.c       |  11 +-
 blockdev-nbd.c                       | 124 +++++------
 nbd/server.c                         | 243 +++++++++-------------
 qemu-nbd.c                           |  67 +++---
 qemu-storage-daemon.c                |  25 +--
 Makefile.objs                        |   6 +-
 block/Makefile.objs                  |   2 +
 block/export/Makefile.objs           |   1 +
 qapi/Makefile.objs                   |   5 +-
 storage-daemon/qapi/qapi-schema.json |   1 +
 17 files changed, 857 insertions(+), 453 deletions(-)
 create mode 100644 qapi/block-export.json
 create mode 100644 include/block/export.h
 create mode 100644 block/export/export.c
 create mode 100644 block/export/Makefile.objs

-- 
2.25.4


