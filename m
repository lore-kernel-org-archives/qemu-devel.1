Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAF9C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EE9206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mq7fyE0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EE9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnZm-0001UK-Kb
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTnRV-00057M-EH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTnRU-00047s-OO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:12:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTnRU-00047Z-8c
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588169523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4vLLDsAJT0h2+7WzHjMUIrR2cKsbzq1AMQTHBPGcQi8=;
 b=Mq7fyE0MSaiP2WPmyo0xKhdmqnL8ekyR998n0gcH/Au6Vh4isV5KRqpdufeIcaKoxOCHVx
 nkimJdw5m3pJxKWpPvzYeno/3yGB3twRwDs1/UvEK4kv24FdILK6B/YsImA4pGPsosuBWK
 vblFOztNSMSt03ZcLGPRbSCAafiTUs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-us5LKEfFNnCBrbWXhFoONQ-1; Wed, 29 Apr 2020 10:11:37 -0400
X-MC-Unique: us5LKEfFNnCBrbWXhFoONQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1A18AB428;
 Wed, 29 Apr 2020 14:11:28 +0000 (UTC)
Received: from localhost (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E287A5D9C9;
 Wed, 29 Apr 2020 14:11:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
Date: Wed, 29 Apr 2020 16:11:22 +0200
Message-Id: <20200429141126.85159-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1: https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg01245.html

Branch: https://github.com/XanClic/qemu.git fix-bdrv_make_empty-v2
Branch: https://git.xanclic.moe/XanClic/qemu.git fix-bdrv_make_empty-v2

Based-on: <20200428192648.749066-1-eblake@redhat.com>
          (=E2=80=9Cqcow2: Allow resize of images with internal snapshots=
=E2=80=9D)

Hi,

As described in v1=E2=80=99s cover letter (linked above), this series ensur=
es
that all calls to BlockDriver.bdrv_make_empty() go through a wrapper
bdrv_make_empty() function that ensures the caller does have the
necessary permissions.


Changes in v2 (thanks for the quick reviews, I didn=E2=80=99t expect this s=
eries
to get attention so quickly :)):
- Added Based-on here in the cover letter [Eric]
- Patch 1: WRITE_UNCHANGED is sufficient [Kevin]
- Patch 3: Check whether blk->root is actually present with
           blk_is_available() [Kevin]
- Patch 4: Let bdrv_commit() only take the WRITE_UNCHANGED permission,
           and take it from the moment the @src BB is created and @bs is
           inserted [Kevin];
           then drop the drv->bdrv_make_empty check, just call
           blk_make_empty() and ignore -ENOTSUP [Eric]


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/4:[0002] [FC] 'block: Add bdrv_make_empty()'
002/4:[----] [--] 'block: Use bdrv_make_empty() where possible'
003/4:[0005] [FC] 'block: Add blk_make_empty()'
004/4:[0020] [FC] 'block: Use blk_make_empty() after commits'


Max Reitz (4):
  block: Add bdrv_make_empty()
  block: Use bdrv_make_empty() where possible
  block: Add blk_make_empty()
  block: Use blk_make_empty() after commits

 include/block/block.h          |  1 +
 include/sysemu/block-backend.h |  2 ++
 block.c                        | 23 +++++++++++++++++++++++
 block/block-backend.c          | 10 ++++++++++
 block/commit.c                 | 16 +++++++++-------
 block/replication.c            |  6 ++----
 block/vvfat.c                  |  4 +---
 qemu-img.c                     | 19 ++++++++++++++-----
 8 files changed, 62 insertions(+), 19 deletions(-)

--=20
2.25.4


