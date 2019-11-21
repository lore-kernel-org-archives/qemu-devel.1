Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C951C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3930520679
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfUCNEAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3930520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmzt-0003Ic-7f
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iXmyI-0001r3-F1
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iXmyH-0001Dy-7P
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:58:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36320
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iXmyH-0001D7-3M
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574344687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MT2D4ZdaSLXa+DKdnKsRf43/7sz2cJdbMf5gYfQ7cUQ=;
 b=RfUCNEANtto6dyAX1SXg43JM3MpEqgGi/cx42xW17V2SwiKa/+ozwtYiJmfg3kyThYuJT6
 nNNbnrCX91bKQClAda1sTfnB3FNzHV9JH7QWZW7Lf4q8lF9g1d0GRCvRBTOllRUdpRL//i
 En7xdFLX5b0TpYeRBbmSygDkRbz50qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-DN4BGaufOIebVE3Mq7_4pg-1; Thu, 21 Nov 2019 08:58:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 254EB80268A;
 Thu, 21 Nov 2019 13:58:05 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 970296E70D;
 Thu, 21 Nov 2019 13:58:00 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/5] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup and do_blockdev_backup
Date: Thu, 21 Nov 2019 14:57:54 +0100
Message-Id: <20191121135759.101655-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DN4BGaufOIebVE3Mq7_4pg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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

Sergio Lopez (5):
  blockdev: fix coding style issues in drive_backup_prepare
  blockdev: unify qmp_drive_backup and drive-backup transaction paths
  blockdev: unify qmp_blockdev_backup and blockdev-backup transaction
    paths
  blockdev: honor bdrv_try_set_aio_context() context requirements
  iotests: fix 141 after qmp_drive_backup with transactions

 blockdev.c                 | 349 ++++++++++++++++++-------------------
 tests/qemu-iotests/141.out |   2 +
 2 files changed, 173 insertions(+), 178 deletions(-)

--=20
2.23.0


