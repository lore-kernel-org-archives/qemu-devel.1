Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BCCC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E6A20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GopygTPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E6A20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCOt-0002Ms-Nj
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ipCNG-0000gK-J8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ipCND-0005mp-SP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:31:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47906
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ipCND-0005lo-JH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578493910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=td51EbT10t8qfQHipJ1YcGJ0G1BPMU7zxXdbWGzaro8=;
 b=GopygTPzG0udU6tttcDxBWWdegixI3vzAGsHfO2lTft2QSMyPMHNNGq7fYJQHJqnWFRKxq
 6+6lru3f5j5xpcSCxs8R0D42WoiHpHhx22TIWUUOYuyMsh04nQ6dXtGkdFuWq9BPMtK2ow
 dhBxC740lOw1oSjXWm5aMgxzgV3GYQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-koQhmKbaMpKpOZz9ssKpwQ-1; Wed, 08 Jan 2020 09:31:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366D41800D4E;
 Wed,  8 Jan 2020 14:31:46 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5286E60BE2;
 Wed,  8 Jan 2020 14:31:39 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/8] blockdev: Fix AioContext handling for various blockdev
 actions
Date: Wed,  8 Jan 2020 15:31:30 +0100
Message-Id: <20200108143138.129909-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: koQhmKbaMpKpOZz9ssKpwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series includes fixes for various issues related to
AioContext mismanagement for various blockdev-initiated actions.

It also adds tests for those actions when executed on drives running
on an IOThread AioContext.

---
Changelog:

v6:
 - Rename the patch series.
 - Add "block/backup-top: Don't acquire context while dropping top"
 - Add "blockdev: Acquire AioContext on dirty bitmap functions"
 - Add "blockdev: Return bs to the proper context on snapshot abort"
 - Add "iotests: Test handling of AioContexts with some blockdev
   actions" (thanks Kevin Wolf)
 - Fix context release on error. (thanks Kevin Wolf)

v5:
 - Include fix for iotest 141 in patch 2. (thanks Max Reitz)
 - Also fix iotest 185 and 219 in patch 2. (thanks Max Reitz)
 - Move error block after context acquisition/release, to we can use
   goto to bail out and release resources. (thanks Max Reitz)
 - Properly release old_context in qmp_blockdev_mirror. (thanks Max
   Reitz)

v4:
 - Unify patches 1-4 and 5-7 to avoid producing broken interim
   states. (thanks Max Reitz)
 - Include a fix for iotest 141. (thanks Kevin Wolf)

v3:
 - Rework the whole patch series to fix the issue by consolidating all
   operations in the transaction model. (thanks Kevin Wolf)

v2:
 - Honor bdrv_try_set_aio_context() context acquisition requirements
   (thanks Max Reitz).
 - Release the context at drive_backup_prepare() instead of avoiding
   re-acquiring it at do_drive_baclup(). (thanks Max Reitz)
 - Convert a single patch into a two-patch series.
---

Sergio Lopez (8):
  blockdev: fix coding style issues in drive_backup_prepare
  blockdev: unify qmp_drive_backup and drive-backup transaction paths
  blockdev: unify qmp_blockdev_backup and blockdev-backup transaction
    paths
  blockdev: honor bdrv_try_set_aio_context() context requirements
  block/backup-top: Don't acquire context while dropping top
  blockdev: Acquire AioContext on dirty bitmap functions
  blockdev: Return bs to the proper context on snapshot abort
  iotests: Test handling of AioContexts with some blockdev actions

 block/backup-top.c         |   5 -
 block/backup.c             |   3 +
 blockdev.c                 | 391 ++++++++++++++++++++-----------------
 tests/qemu-iotests/141.out |   2 +
 tests/qemu-iotests/185.out |   2 +
 tests/qemu-iotests/219     |   7 +-
 tests/qemu-iotests/219.out |   8 +
 tests/qemu-iotests/281     | 247 +++++++++++++++++++++++
 tests/qemu-iotests/281.out |   5 +
 tests/qemu-iotests/group   |   1 +
 10 files changed, 484 insertions(+), 187 deletions(-)
 create mode 100755 tests/qemu-iotests/281
 create mode 100644 tests/qemu-iotests/281.out

--=20
2.23.0


