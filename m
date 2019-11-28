Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5561C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4EA21775
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9bOyDdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4EA21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaHIn-0005Eo-N7
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 05:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iaHF3-0003P8-QE
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iaHF1-0006Iy-8F
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iaHEz-000663-Tg
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574937697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YE1wgm36UjBnc7W+itfuj7auVKN4+i+4B6cDxiZh+us=;
 b=b9bOyDdHhuCnSl9etDpagVqFoUO6MqhQvleYndyK8MO3NfLaL6pAWIdUsMllIaNULonR2P
 3OQ4n63agybjEfMNUz2skx5gtmt23Xml8kBZqvI6kCGXAu9TZXdCUyEaFedbujKegy8gWA
 yjskhDh47SVKL9+82xUL1WCUJbd0HKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-HgH-4zEwMuGcSy8J6JGeMA-1; Thu, 28 Nov 2019 05:41:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 203DE1883521;
 Thu, 28 Nov 2019 10:41:35 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB33610013A7;
 Thu, 28 Nov 2019 10:41:30 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/4] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup and do_blockdev_backup
Date: Thu, 28 Nov 2019 11:41:25 +0100
Message-Id: <20191128104129.250206-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: HgH-4zEwMuGcSy8J6JGeMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

do_drive_backup() acquires the AioContext lock of the corresponding
BlockDriverState. This is not a problem when it's called from
qmp_drive_backup(), but drive_backup_prepare() also acquires the lock
before calling it. The same things happens with do_blockdev_backup()
and blockdev_backup_prepare().

This patch series merges do_drive_backup() with drive_backup_prepare()
and do_blockdev_backup() with blockdev_backup_prepare(), and ensures
they're only getting called from a transaction context. This way,
there's a single code path for both transaction requests and qmp
commands, as suggested by Kevin Wolf.

We also take this opportunity to ensure we're honoring the context
acquisition semantics required by bdrv_try_set_aio_context, as
suggested by Max Reitz.

---
Changelog:

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

Sergio Lopez (4):
  blockdev: fix coding style issues in drive_backup_prepare
  blockdev: unify qmp_drive_backup and drive-backup transaction paths
  blockdev: unify qmp_blockdev_backup and blockdev-backup transaction
    paths
  blockdev: honor bdrv_try_set_aio_context() context requirements

 blockdev.c                 | 354 ++++++++++++++++++-------------------
 tests/qemu-iotests/141.out |   2 +
 tests/qemu-iotests/185.out |   2 +
 tests/qemu-iotests/219     |   7 +-
 tests/qemu-iotests/219.out |   8 +
 5 files changed, 192 insertions(+), 181 deletions(-)

--=20
2.23.0


