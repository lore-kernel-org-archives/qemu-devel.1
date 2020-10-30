Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C51C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368142076D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vju52eRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368142076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYb69-0008Hy-0T
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYb4l-0006nd-Kt
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYb4j-0000UH-HO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604089958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fLFfMmAiHmys+Q03WCcf6/EBoOlc3H8DSL44oe4QMP8=;
 b=Vju52eRCR2d+SvxL32aWYaz9pfXh3BNWbx1CmHoy++ojmCM4Ff5QvfMAxvWPQFYtQZuwpD
 i3q8pwIccM7ZT7LvtjzjbUaHBA1wCCFivDjMVWhX08Wm/G9YQocZVd8OHgU8QF4lFM+Mg0
 4+ahzpOKvxwa4kl3STzwp1pQwuZ6m4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-RL6-xqUjMaWiC55qCmIacA-1; Fri, 30 Oct 2020 16:32:36 -0400
X-MC-Unique: RL6-xqUjMaWiC55qCmIacA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82B60802B74
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 20:32:35 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-218.phx2.redhat.com [10.3.113.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51A9419D61
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 20:32:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/12] NBD patches for 2020-10-27 soft-freeze
Date: Fri, 30 Oct 2020 15:32:19 -0500
Message-Id: <20201030203231.107486-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9a2ea4f4a7230fe224dee91d9adf2ef872c3d226:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-for-5.2-pull-request' into staging (2020-10-30 15:49:35 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-10-27-v2

for you to fetch changes up to dbc7b01492371e4a54b92d2b6d968f9b863cc794:

  nbd: Add 'qemu-nbd -A' to expose allocation depth (2020-10-30 15:22:00 -0500)

v2: Respin to fix compilation error due to semantic merge conflict
(only the changed patch is resent)

----------------------------------------------------------------
nbd patches for 2020-10-27

- Tweak the new block-export-add QMP command
- Allow multiple -B options for qemu-nbd
- Add qemu:allocation-depth metadata context as qemu-nbd -A
- Improve iotest use of NBD

----------------------------------------------------------------
Eric Blake (10):
      block: Simplify QAPI_LIST_ADD
      qapi: Add QAPI_LIST_PREPEND() macro
      nbd: Utilize QAPI_CLONE for type conversion
      nbd: Update qapi to support exporting multiple bitmaps
      nbd: Simplify qemu bitmap context name
      nbd: Refactor counting of metadata contexts
      nbd: Allow export of multiple bitmaps for one device
      block: Return depth level during bdrv_is_allocated_above
      nbd: Add new qemu:allocation-depth metadata context
      nbd: Add 'qemu-nbd -A' to expose allocation depth

Max Reitz (2):
      iotests/291: Filter irrelevant parts of img-info
      iotests/291: Stop NBD server

 docs/interop/nbd.txt       |  23 +++--
 docs/system/deprecated.rst |   3 +-
 docs/tools/qemu-nbd.rst    |   8 +-
 qapi/block-core.json       |   7 +-
 qapi/block-export.json     |  46 +++++++---
 block/coroutines.h         |   6 +-
 include/block/nbd.h        |   8 +-
 include/qapi/util.h        |  13 +++
 block/io.c                 |  31 +++++--
 block.c                    |  22 ++---
 block/commit.c             |   2 +-
 block/mirror.c             |   2 +-
 block/nbd.c                |  26 ++++--
 block/stream.c             |   2 +-
 blockdev-nbd.c             |  19 +++--
 nbd/server.c               | 208 +++++++++++++++++++++++++++++++++++----------
 qemu-nbd.c                 |  30 ++++---
 tests/qemu-iotests/291     |  22 +++--
 tests/qemu-iotests/291.out |  20 -----
 tests/qemu-iotests/309     |  77 +++++++++++++++++
 tests/qemu-iotests/309.out |  22 +++++
 tests/qemu-iotests/group   |   1 +
 22 files changed, 446 insertions(+), 152 deletions(-)
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out

-- 
2.29.2


