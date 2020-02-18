Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83943C3403B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520C02176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0zibW98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520C02176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42GD-00011H-Ds
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42DQ-0003vE-Jb
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42DO-00011b-T5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24006
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42DO-000117-Nw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8WNff+5jxSVVPmfqG2CrWat+bu9LgTzJCpFYAi9NZII=;
 b=F0zibW98aY2FoT+iTtXedhIJARnx1WbPQup6NVR4RN8yP1gR4RFk4KZa30WtbrP+cR8td1
 g+vowMz4LYQYUgKc72T+aCSFov2KuKHBCivVjj6xHjhLvYeHCjp/8zA7oeSc1UkDtwprb0
 v22ZINYTKPt9EPKkPy6f7v+mzAK55BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-SjGQWEjfMiy7Q32EfKxH1A-1; Tue, 18 Feb 2020 07:42:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A0F618A5500;
 Tue, 18 Feb 2020 12:42:46 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 884C6384;
 Tue, 18 Feb 2020 12:42:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 00/33] block: Introduce real BdrvChildRole
Date: Tue, 18 Feb 2020 13:42:09 +0100
Message-Id: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SjGQWEjfMiy7Q32EfKxH1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Based-on: <20200218103454.296704-1-mreitz@redhat.com>
(=E2=80=9Cblock: Fix check_to_replace_node()=E2=80=9D)

Branch: https://github.com/XanClic/qemu.git child-role-v2
Branch: https://git.xanclic.moe/XanClic/qemu.git child-role-v2

v1: https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00908.html
v2: https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00108.html


Hi,

For the =E2=80=9Cwhy=E2=80=9D and =E2=80=9Cwhat=E2=80=9D regarding this ser=
ies, see the cover letter of
v1 (linked above).


In v3, I tried to address Eric=E2=80=99s comments:
- Added some commit messages where there was nothing before

- Patch 3: Renamed BdrvChildRole to BdrvChildRoleBits, and made
  BdrvChildRole a plain type alias of an unsigned int with a comment
  that explains it is only to hold BdrvChildRoleBits masks
  - Also patch 3: Expanded comments on BDRV_CHILD_FILTERED and
    BDRV_CHILD_COW (as requested by Eric and Berto)

- Patch 29: Kept comment describing bdrv_filter_default_perms() (with a
  slight modification, because no filter is going to use this as its
  .bdrv_child_perm() implementation anymore)

- Patches 4 and 20: Rebase conflict with v4 of the prerequisite series
  =E2=80=9Cblock: Fix check_to_replace_node()=E2=80=9D (Quorum=E2=80=99s ch=
ildren array
  continues to store BdrvChild pointers instead of structured objects)


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/33:[----] [--] 'block: Add BlockDriver.is_format'
002/33:[----] [--] 'block: Rename BdrvChildRole to BdrvChildClass'
003/33:[0019] [FC] 'block: Add BdrvChildRole'
004/33:[0004] [FC] 'block: Add BdrvChildRole to BdrvChild'
005/33:[----] [--] 'block: Pass BdrvChildRole to bdrv_child_perm()'
006/33:[----] [-C] 'block: Pass BdrvChildRole to .inherit_options()'
007/33:[----] [-C] 'block: Pass parent_is_format to .inherit_options()'
008/33:[----] [--] 'block: Rename bdrv_inherited_options()'
009/33:[----] [--] 'block: Add generic bdrv_inherited_options()'
010/33:[----] [--] 'block: Use bdrv_inherited_options()'
011/33:[----] [--] 'block: Unify bdrv_child_cb_attach()'
012/33:[----] [--] 'block: Unify bdrv_child_cb_detach()'
013/33:[----] [--] 'block: Add child_of_bds'
014/33:[----] [--] 'block: Distinguish paths in *_format_default_perms'
015/33:[----] [--] 'block: Pull out bdrv_default_perms_for_backing()'
016/33:[----] [--] 'block: Pull out bdrv_default_perms_for_storage()'
017/33:[----] [--] 'block: Split bdrv_default_perms_for_storage()'
018/33:[----] [--] 'block: Add bdrv_default_perms()'
019/33:[----] [--] 'raw-format: Split raw_read_options()'
020/33:[0007] [FC] 'block: Switch child_format users to child_of_bds'
021/33:[----] [--] 'block: Drop child_format'
022/33:[----] [--] 'block: Make backing files child_of_bds children'
023/33:[----] [--] 'block: Drop child_backing'
024/33:[----] [--] 'block: Make format drivers use child_of_bds'
025/33:[----] [--] 'block: Make filter drivers use child_of_bds'
026/33:[----] [-C] 'block: Use child_of_bds in remaining places'
027/33:[----] [--] 'tests: Use child_of_bds instead of child_file'
028/33:[----] [--] 'block: Use bdrv_default_perms()'
029/33:[0005] [FC] 'block: Make bdrv_filter_default_perms() static'
030/33:[----] [--] 'block: Drop bdrv_format_default_perms()'
031/33:[----] [--] 'block: Drop child_file'
032/33:[----] [--] 'block: Pass BdrvChildRole in remaining cases'
033/33:[----] [-C] 'block: Drop @child_class from bdrv_child_perm()'


Max Reitz (33):
  block: Add BlockDriver.is_format
  block: Rename BdrvChildRole to BdrvChildClass
  block: Add BdrvChildRole and BdrvChildRoleBits
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

 block.c                     | 526 ++++++++++++++++++++++--------------
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
 block/quorum.c              |   8 +-
 block/raw-format.c          | 128 +++++----
 block/replication.c         |   5 +-
 block/throttle.c            |   7 +-
 block/vdi.c                 |   7 +-
 block/vhdx.c                |   7 +-
 block/vmdk.c                |  23 +-
 block/vpc.c                 |   7 +-
 block/vvfat.c               |  11 +-
 blockjob.c                  |   7 +-
 include/block/block.h       |  46 +++-
 include/block/block_int.h   |  57 ++--
 tests/test-bdrv-drain.c     |  72 +++--
 tests/test-bdrv-graph-mod.c |  10 +-
 tests/test-block-iothread.c |  17 +-
 35 files changed, 688 insertions(+), 434 deletions(-)

--=20
2.24.1


