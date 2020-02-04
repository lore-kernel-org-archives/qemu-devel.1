Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7324AC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCED2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZTmneKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCED2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1mE-0003Nj-DK
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hP-0002te-6s
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hN-0002LX-Kr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20154
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hN-0002Ja-Fh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=84x6O/n9nrOqCN0puRgshxlhGVXK2uf1E4Xb9Zdypbo=;
 b=EZTmneKUuzGhw1Uj3Rap6fuo2HYnb7rRPKaSMUl86+5bqw2c0Ij270bkNSxDI2+2MuuubC
 Smybqc1K7hNtD5gfg8KIrAOzHAlLdudSLH5fvz0BOCuUcXaqPnexzDnAnKODtwCwq/Nw5I
 8j/ibWizgO9CnoQsG5+firM0j3bInyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-XJPOqvavNmidYR2oqWHhwQ-1; Tue, 04 Feb 2020 12:08:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 824B91882CD4;
 Tue,  4 Feb 2020 17:08:51 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE833857A1;
 Tue,  4 Feb 2020 17:08:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 00/33] block: Introduce real BdrvChildRole
Date: Tue,  4 Feb 2020 18:08:15 +0100
Message-Id: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: XJPOqvavNmidYR2oqWHhwQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200130214431.333510-1-mreitz@redhat.com>
(=E2=80=9Cblock: Fix check_to_replace_node()=E2=80=9D)

Branch: https://github.com/XanClic/qemu.git child-role-v2
Branch: https://git.xanclic.moe/XanClic/qemu.git child-role-v2

v1: https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00908.html


Hi,

For the =E2=80=9Cwhy=E2=80=9D and =E2=80=9Cwhat=E2=80=9D regarding this ser=
ies, see the cover letter of
v1 (linked above).


v2:
- Dropped BDRV_CHILD_STAY_AT_NODE from BdrvChildRole

- Dropped BDRV_CHILD_PROTOCOL and BDRV_CHILD_FORMAT from BdrvChildRole;
  this necessitates a BlockDriver.is_format flag that
  BdrvChildClass.inherit_options() receives and from which (and the
  BdrvChildRole) it can figure out whether to set, clear, or bequeath
  BDRV_O_PROTOCOL.

- Document that BDRV_CHILD_PRIMARY must be set for at most one child at
  a time.

- Rebasing conflicts with the compress filter

- Split =E2=80=9Cblock: Unify bdrv_*inherited_options()=E2=80=9D into three=
 patches (8
  through 10)

- Dropped the old patch 6 (=E2=80=9CKeep BDRV_O_NO_IO...=E2=80=9D) because =
it
  effectively didn=E2=80=99t do anything (child_file.inherit_options() stil=
l
  cleared BDRV_O_NO_IO).  Implicitly do the change in patch 10 instead
  and explain it in the commit message.


git-backport-diff against 1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/33:[down] 'block: Add BlockDriver.is_format'
002/33:[----] [--] 'block: Rename BdrvChildRole to BdrvChildClass'
003/33:[0025] [FC] 'block: Add BdrvChildRole'
004/33:[0002] [FC] 'block: Add BdrvChildRole to BdrvChild'
005/33:[----] [--] 'block: Pass BdrvChildRole to bdrv_child_perm()'
006/33:[----] [-C] 'block: Pass BdrvChildRole to .inherit_options()'
007/33:[down] 'block: Pass parent_is_format to .inherit_options()'
008/33:[down] 'block: Rename bdrv_inherited_options()'
009/33:[down] 'block: Add generic bdrv_inherited_options()'
010/33:[down] 'block: Use bdrv_inherited_options()'
011/33:[----] [--] 'block: Unify bdrv_child_cb_attach()'
012/33:[----] [--] 'block: Unify bdrv_child_cb_detach()'
013/33:[----] [-C] 'block: Add child_of_bds'
014/33:[----] [--] 'block: Distinguish paths in *_format_default_perms'
015/33:[----] [--] 'block: Pull out bdrv_default_perms_for_backing()'
016/33:[----] [--] 'block: Pull out bdrv_default_perms_for_storage()'
017/33:[----] [--] 'block: Split bdrv_default_perms_for_storage()'
018/33:[----] [-C] 'block: Add bdrv_default_perms()'
019/33:[----] [--] 'raw-format: Split raw_read_options()'
020/33:[0009] [FC] 'block: Switch child_format users to child_of_bds'
021/33:[0003] [FC] 'block: Drop child_format'
022/33:[----] [--] 'block: Make backing files child_of_bds children'
023/33:[0004] [FC] 'block: Drop child_backing'
024/33:[0009] [FC] 'block: Make format drivers use child_of_bds'
025/33:[0008] [FC] 'block: Make filter drivers use child_of_bds'
026/33:[0008] [FC] 'block: Use child_of_bds in remaining places'
027/33:[----] [--] 'tests: Use child_of_bds instead of child_file'
028/33:[0002] [FC] 'block: Use bdrv_default_perms()'
029/33:[----] [--] 'block: Make bdrv_filter_default_perms() static'
030/33:[----] [--] 'block: Drop bdrv_format_default_perms()'
031/33:[0010] [FC] 'block: Drop child_file'
032/33:[----] [--] 'block: Pass BdrvChildRole in remaining cases'
033/33:[----] [-C] 'block: Drop @child_class from bdrv_child_perm()'


Max Reitz (33):
  block: Add BlockDriver.is_format
  block: Rename BdrvChildRole to BdrvChildClass
  block: Add BdrvChildRole
  block: Add BdrvChildRole to BdrvChild
  block: Pass BdrvChildRole to bdrv_child_perm()
  block: Pass BdrvChildRole to .inherit_options()
  block: Pass parent_is_format to .inherit_options()
  block: Rename bdrv_inherited_options()
  block: Add generic bdrv_inherited_options()
  block: Use bdrv_inherited_options()
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

 block.c                     | 521 ++++++++++++++++++++++--------------
 block/backup-top.c          |  11 +-
 block/blkdebug.c            |  10 +-
 block/blklogwrites.c        |  16 +-
 block/blkreplay.c           |   7 +-
 block/blkverify.c           |  10 +-
 block/block-backend.c       |  20 +-
 block/bochs.c               |   7 +-
 block/cloop.c               |   7 +-
 block/commit.c              |   2 +-
 block/copy-on-read.c        |   7 +-
 block/crypto.c              |   8 +-
 block/dmg.c                 |   7 +-
 block/filter-compress.c     |   7 +-
 block/io.c                  |  22 +-
 block/mirror.c              |   2 +-
 block/parallels.c           |   7 +-
 block/qcow.c                |   7 +-
 block/qcow2.c               |  20 +-
 block/qed.c                 |   7 +-
 block/quorum.c              |   9 +-
 block/raw-format.c          | 128 +++++----
 block/replication.c         |   5 +-
 block/throttle.c            |   7 +-
 block/vdi.c                 |   7 +-
 block/vhdx.c                |   7 +-
 block/vmdk.c                |  23 +-
 block/vpc.c                 |   7 +-
 block/vvfat.c               |  11 +-
 blockjob.c                  |   7 +-
 include/block/block.h       |  35 ++-
 include/block/block_int.h   |  57 ++--
 tests/test-bdrv-drain.c     |  72 +++--
 tests/test-bdrv-graph-mod.c |  10 +-
 tests/test-block-iothread.c |  17 +-
 35 files changed, 672 insertions(+), 435 deletions(-)

--=20
2.24.1


