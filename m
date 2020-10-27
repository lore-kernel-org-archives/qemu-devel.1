Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C88C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1527620829
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEKDhOLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1527620829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXX2B-0008Lt-Ra
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 18:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXWzz-0006Pd-KT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXWzx-0000fv-Qc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603835961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zvXE/0IAfOEFLUhoqSj7W5esrRz1UV9LBocwsT3W/9c=;
 b=OEKDhOLQKNiFs9MOITHrlqjdC6ohQUSMGa83jJxTeQxPFupEkM7W6e9pfAjpLnLRJ0Emee
 wgqJF7v4TeOMhNX9vB1NB/2HKGHXdhEe840uiR5AW1hsTihxZXhM+fibmV2laA2OtyKqTh
 rQevDZ3bPiKQRg0MjFO1Bq5+MdZ7+mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-ChU3j43ONb2j5_JYsT3bYw-1; Tue, 27 Oct 2020 17:59:18 -0400
X-MC-Unique: ChU3j43ONb2j5_JYsT3bYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ADEA1009E23
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 21:59:17 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAE591002382
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 21:59:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] NBD patches for 2020-10-27 soft-freeze
Date: Tue, 27 Oct 2020 16:59:02 -0500
Message-Id: <20201027215914.619460-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 725ca3313a5b9cbef89eaa1c728567684f37990a:

  Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20201026' into staging (2020-10-27 14:29:52 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-10-27

for you to fetch changes up to a1487599cc3270ea0d435e8965ee2d6efc8f8a1a:

  nbd: Add 'qemu-nbd -A' to expose allocation depth (2020-10-27 16:46:21 -0500)

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
 block/io.c                 |  29 +++++--
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
 22 files changed, 445 insertions(+), 151 deletions(-)
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out

-- 
2.29.0


