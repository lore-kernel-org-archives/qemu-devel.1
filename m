Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FCDC54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898E320724
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKskPDhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898E320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR0MO-000723-KA
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 17:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0Jp-0005Bh-85
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0Jl-0004W8-7l
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:20:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jR0Jj-0004Q2-6f
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587504028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SNoubmq6zkWNrtgGq9h1cqhTiYO0TqjlC7DDr6vP8XE=;
 b=gKskPDhwRU+7aDLZvyV+yayqW5D9SzewoPuQ6boh+bzWJip0beqY/RuAquMQ5BSTKXK1jq
 XUWVOkSRc1g656ZuXBCpCcq8VQrxew8V8T7MSXf7TSf5XpJF/cQSF79wSQXxr9r6ftJfc8
 elvxWgGHwlDXg5KOf20CjsJ8abtIaFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-0Nd8vDjINKatpeahBSsgwg-1; Tue, 21 Apr 2020 17:20:21 -0400
X-MC-Unique: 0Nd8vDjINKatpeahBSsgwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2C5E1007268;
 Tue, 21 Apr 2020 21:20:20 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6667A18BC;
 Tue, 21 Apr 2020 21:20:19 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] qemu-img: Add convert --bitmaps
Date: Tue, 21 Apr 2020 16:20:13 -0500
Message-Id: <20200421212019.170707-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 17:20:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: nsoffer@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without this series, the process for copying one qcow2 image to
another including all of its bitmaps involves running qemu and doing
the copying by hand with a series of QMP commands.  This makes the
process a bit more convenient.

Series can also be downloaded at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qemu-img-bitmaps-v2

Since v1:
- patches 1, 3 are new
- patch 2 (old 1/3) moves more operations into new file
- patch 4 no longer a separate thread (was at v2 in isolation)
- patches 4, 6 rebased to take advantage of 3
- patch 5, 6 (old 2-3/3) have other minor tweaks

Eric Blake (6):
  docs: Sort sections on qemu-img subcommand parameters
  blockdev: Split off basic bitmap operations for qemu-img
  qemu-img: Add bitmap sub-command
  qcow2: Expose bitmaps' size during measure
  qemu-img: Add convert --bitmaps option
  iotests: Add test 291 to for qemu-img bitmap coverage

 docs/tools/qemu-img.rst    |  78 ++++++---
 Makefile.objs              |   2 +-
 qapi/block-core.json       |  15 +-
 include/sysemu/blockdev.h  |  14 ++
 block/crypto.c             |   2 +-
 block/qcow2.c              |  29 +++-
 block/raw-format.c         |   2 +-
 blockbitmaps.c             | 324 +++++++++++++++++++++++++++++++++++++
 blockdev.c                 | 293 ---------------------------------
 qemu-img.c                 | 281 +++++++++++++++++++++++++++++++-
 MAINTAINERS                |   1 +
 qemu-img-cmds.hx           |  11 +-
 tests/qemu-iotests/190     |  15 +-
 tests/qemu-iotests/190.out |  13 +-
 tests/qemu-iotests/291     | 103 ++++++++++++
 tests/qemu-iotests/291.out |  78 +++++++++
 tests/qemu-iotests/group   |   1 +
 17 files changed, 927 insertions(+), 335 deletions(-)
 create mode 100644 blockbitmaps.c
 create mode 100755 tests/qemu-iotests/291
 create mode 100644 tests/qemu-iotests/291.out

--=20
2.26.2


