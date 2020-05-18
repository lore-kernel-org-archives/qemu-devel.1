Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79BAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EAB20756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkKZA7Jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EAB20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamna-0000eR-Oz
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jammr-000822-DY
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:55:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jammq-0006aa-Cc
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589835299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JMIuzWciFuFmNiOuFjTdbWm+Jdi+MNf8Cnl7j/DFSqg=;
 b=UkKZA7JmQHIs76JG2A+tbIfrouxRh4axLOF5QhKMJvg8cfUFk1GRHAyV+MxeLZ5M3MebU6
 GW5HHGIZW0NUKgSkqz/rZpFI2RJZRvgfqGwEsWGQh8YNMMQJD0jxaW0WrYcSdL9YtB50Gu
 euF4cc18/pzRQrYLKQWGdfi0XSOvO7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-mHbZmqG2MhKoExCvuW7KTA-1; Mon, 18 May 2020 16:54:52 -0400
X-MC-Unique: mHbZmqG2MhKoExCvuW7KTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53E80107ACF6
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 20:54:51 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23A02797F7
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 20:54:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] bitmaps patches for 2020-05-18
Date: Mon, 18 May 2020 15:54:41 -0500
Message-Id: <20200518205448.690566-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 16:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a28c9c8c9fc42484efe1bf5a77affe842e54e38b:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200518-pull-request' into staging (2020-05-18 16:37:09 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-05-18

for you to fetch changes up to 6660c3a69c668ff98e2a86bca0b1301648ff4b02:

  qemu-img: Add bitmap sub-command (2020-05-18 15:32:56 -0500)

----------------------------------------------------------------
bitmaps patches for 2020-05-18

- update bitmaps maintainers
- add 'qemu-img bitmap' subcommand

----------------------------------------------------------------
Eric Blake (7):
      bitmaps: Update maintainer
      docs: Sort sections on qemu-img subcommand parameters
      qemu-img: Fix stale comments on doc location
      block: Make it easier to learn which BDS support bitmaps
      blockdev: Promote several bitmap functions to non-static
      blockdev: Split off basic bitmap operations for qemu-img
      qemu-img: Add bitmap sub-command

 docs/tools/qemu-img.rst         |  72 ++++++---
 Makefile.objs                   |   3 +-
 block/qcow2.h                   |   1 +
 include/block/block_int.h       |  13 ++
 include/block/dirty-bitmap.h    |   1 +
 block/dirty-bitmap.c            |   9 ++
 block/monitor/bitmap-qmp-cmds.c | 321 ++++++++++++++++++++++++++++++++++++++++
 block/qcow2-bitmap.c            |   7 +
 block/qcow2.c                   |   2 +
 blockdev.c                      | 303 +------------------------------------
 qemu-img.c                      | 251 ++++++++++++++++++++++++++++++-
 MAINTAINERS                     |   8 +-
 block/monitor/Makefile.objs     |   1 +
 qemu-img-cmds.hx                |   9 +-
 14 files changed, 672 insertions(+), 329 deletions(-)
 create mode 100644 block/monitor/bitmap-qmp-cmds.c

-- 
2.26.2


