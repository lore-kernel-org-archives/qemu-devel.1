Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73C9C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72385206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibHm4GXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72385206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxFa-00061r-Ds
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBL-0003pp-BP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBJ-00062o-Ud
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32489
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBF-0005wc-RX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SUeCEDAbhEVK+v8dIf4m6KSljmEiBXyCmoColr0TikQ=;
 b=ibHm4GXJwMwIl0RcrAldEtSEYlrtQJD4h2SCqXO9jPHkjCiVRSHl3ovbHH6GYzTDCSs8YV
 rWG9vr5UrguI8zGRyGVKrJZdgi6pEh9XyCsvuwuNXA+lQUE79vIn9bnAqKDT3fuL+qIhTE
 EHNSoGsw5ehaoPPfCGyC4E9Y32N+tXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-LHKDf9LXOlehFa5aBsRiFQ-1; Wed, 27 Nov 2019 08:16:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAF9AA3FA9;
 Wed, 27 Nov 2019 13:16:26 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F10A5D6A7;
 Wed, 27 Nov 2019 13:16:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 00/31] block: Introduce real BdrvChildRole
Date: Wed, 27 Nov 2019 14:15:53 +0100
Message-Id: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: LHKDf9LXOlehFa5aBsRiFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20191111160216.197086-1-mreitz@redhat.com>
(=E2=80=9Cblock: Fix check_to_replace_node()=E2=80=9D)

This is preliminary work for v7 of =E2=80=9CDeal with filters=E2=80=9D.  As=
 Kevin has
noted, there may be e.g. multiple storage children, and there should
probably be some way for drivers to signal what they use each child for.

Before this series, this is done in a way with the child_* BdrvChildRole
objects (i.e., child_file, child_format, child_backing).  However, they
don=E2=80=99t really suit that task, for multiple reasons:
(1) They don=E2=80=99t formally mean anything.
(2) Drivers may or may not use them.  We have tests that just copy
    child_backing and overwrite a single callback to suit their need.
(3) You can=E2=80=99t combine them (e.g. for children that store both data =
and
    metadata).

The current BdrvChildRole structure is really just a way to contact the
parent about any changes regarding the child, so it doesn=E2=80=99t describ=
e a
role but a class.  Hence this series renames it to BdrvChildClass.

Then we can introduce a real BdrvChildRole, which is an enum that
captures the roles a child can have in a bit field, so they can be
combined.

It turns out that we can use this role to unify child_file,
child_format, and child_backing into a generic child_of_bds class that
can decide what to do for each child (e.g. when it comes to flag
inheritance) based on the BdrvChildRole.

This also applies to bdrv_format_default_perms() and
bdrv_filter_default_perms(): We can unify them in a generic
bdrv_filter_perms() that has different paths for filtered, backing,
metadata, and pure-data children.


Max Reitz (31):
  block: Rename BdrvChildRole to BdrvChildClass
  block: Add BdrvChildRole
  block: Add BdrvChildRole to BdrvChild
  block: Pass BdrvChildRole to bdrv_child_perm()
  block: Drop BdrvChildClass.stay_at_node
  block: Keep BDRV_O_NO_IO in *inherited_fmt_options
  block: Pass BdrvChildRole to .inherit_options()
  block: Unify bdrv_*inherited_options()
  block: Unify bdrv_child_cb_attach()
  block: Unify bdrv_child_cb_detach()
  block: Add child_of_bds
  block: Distinguish paths in *_format_default_perms
  block: Pull out bdrv_default_perms_for_backing()
  block: Pull out bdrv_default_perms_for_storage()
  block: Split bdrv_default_perms_for_storage()
  block: Add bdrv_default_perms()
  raw-format: Split raw_read_options()
  block: Switch child_format users to child_of_bds
  block: Drop child_format
  block: Make backing files child_of_bds children
  block: Drop child_backing
  block: Make format drivers use child_of_bds
  block: Make filter drivers use child_of_bds
  block: Use child_of_bds in remaining places
  tests: Use child_of_bds instead of child_file
  block: Use bdrv_default_perms()
  block: Make bdrv_filter_default_perms() static
  block: Drop bdrv_format_default_perms()
  block: Drop child_file
  block: Pass BdrvChildRole in remaining cases
  block: Drop @child_class from bdrv_child_perm()

 block.c                     | 477 +++++++++++++++++++++---------------
 block/backup-top.c          |  11 +-
 block/blkdebug.c            |  10 +-
 block/blklogwrites.c        |  17 +-
 block/blkreplay.c           |   7 +-
 block/blkverify.c           |  12 +-
 block/block-backend.c       |  20 +-
 block/bochs.c               |   6 +-
 block/cloop.c               |   6 +-
 block/commit.c              |   2 +-
 block/copy-on-read.c        |   7 +-
 block/crypto.c              |   6 +-
 block/dmg.c                 |   6 +-
 block/io.c                  |  22 +-
 block/mirror.c              |   2 +-
 block/parallels.c           |   6 +-
 block/qcow.c                |   6 +-
 block/qcow2.c               |  20 +-
 block/qed.c                 |   6 +-
 block/quorum.c              |  11 +-
 block/raw-format.c          | 128 ++++++----
 block/replication.c         |   5 +-
 block/throttle.c            |   7 +-
 block/vdi.c                 |   6 +-
 block/vhdx.c                |   6 +-
 block/vmdk.c                |  22 +-
 block/vpc.c                 |   6 +-
 block/vvfat.c               |  11 +-
 blockjob.c                  |   8 +-
 include/block/block.h       |  46 +++-
 include/block/block_int.h   |  54 ++--
 tests/test-bdrv-drain.c     |  72 +++---
 tests/test-bdrv-graph-mod.c |  10 +-
 tests/test-block-iothread.c |  17 +-
 34 files changed, 625 insertions(+), 433 deletions(-)

--=20
2.23.0


