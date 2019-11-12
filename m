Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6EFC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C5421783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrtMJqEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C5421783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUR4-0008VN-3f
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iUUOU-0006ap-2N
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iUUOP-00011l-3i
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:31:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55906
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iUUOO-00011U-HK
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573558288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WS4ETSX8n0TQtCfiyCbJ2txZS+WuHOA2YHie7F8NtiI=;
 b=PrtMJqEPVg3irKwqalAd2GFZnhzqW1FlVt1CJWmpKz5CUQ52MhLveHeCgEXy0UO/2fG3/F
 XiozJg9oaUEeu9uzt6N5Gna3pEGYvnwqhWb/i6TWEn+tRFN8ojwfGQUZpQCMILsCSB9/Qz
 2XGwHVRs6ruzc4z8BVRz+fC2gYgfbOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-trixlZVFNQu1zRw1fufNEg-1; Tue, 12 Nov 2019 06:30:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63BFE800C72;
 Tue, 12 Nov 2019 11:30:17 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3552C6091D;
 Tue, 12 Nov 2019 11:30:13 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/8] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup and do_blockdev_backup
Date: Tue, 12 Nov 2019 12:30:04 +0100
Message-Id: <20191112113012.71136-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: trixlZVFNQu1zRw1fufNEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
  blockdev: merge drive_backup_prepare with do_drive_backup
  blockdev: fix coding style issues in drive_backup_prepare
  blockdev: place drive_backup_prepare with the other related
    transaction functions
  blockdev: change qmp_drive_backup to make use of transactions
  blockdev: merge blockdev_backup_prepare with do_blockdev_backup
  blockdev: place blockdev_backup_prepare with the other related
    transaction helpers
  blockdev: change qmp_blockdev_backup to make use of transactions
  blockdev: honor bdrv_try_set_aio_context() context requirements

 blockdev.c | 349 ++++++++++++++++++++++++++---------------------------
 1 file changed, 171 insertions(+), 178 deletions(-)

--=20
2.23.0


