Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F825C2D0FD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED3E20740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDXdpEAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED3E20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpGW-0006u1-7Z
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDO-0001Qg-QE
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60228
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDM-0003P7-A1
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589367975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wsrohe8ACmPGCMy/RrK2jlJdTiNurOIriiV2U6VdfXo=;
 b=VDXdpEAYqX8naP8RbCCZ5lUhLBwbwX7T+7U2r3gVd9QAqrDl6MqqNVC9vT6SvdvTyi8e0C
 /UJbtkcllnAHih0U0r/ZJdoD/CTivrHmTRmZ4DXwndNn4tEhW2Qa4Y2K4RZBmKAjEZhsh+
 npZP3wpqs/JYDhXcqZg4WmNAWWlXdf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-F5jhHV5SNTC_eKjSPDBzKg-1; Wed, 13 May 2020 07:05:47 -0400
X-MC-Unique: F5jhHV5SNTC_eKjSPDBzKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B208801504;
 Wed, 13 May 2020 11:05:46 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1A6C5C1C3;
 Wed, 13 May 2020 11:05:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 00/34] block: Introduce real BdrvChildRole
Date: Wed, 13 May 2020 13:05:10 +0200
Message-Id: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200429141126.85159-1-mreitz@redhat.com>
(“block: Do not call BlockDriver.bdrv_make_empty() directly”)

Branch: https://github.com/XanClic/qemu.git child-role-v4
Branch: https://git.xanclic.moe/XanClic/qemu.git child-role-v4

v1: https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00908.html
v2: https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00108.html
v3: https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00737.html


Hi,

For the “why” and “what” regarding this series, see the cover letter of
v1 (linked above).


In v4, I mostly addressed Kevin’s comments (and one permission bug for
pure data children in patch 18):
- Patch 1: Pulled in from the “Deal with filters” series (and added
           blkreplay to the mix)

- Patch 4: More comments, and added consistent notes on how many
           children may get a certain role

- Patch 10:
  - Move the function down below child_backing, so that we get less
    forward declarations of static functions, and they’ll all be
    temporary
  - Split the (role & (DATA | METADATA | FILTERED)) == DATA condition
    into (role & DATA) && !(role & (METADATA | FILTERED))
  - Fixed up the comment on how backing files are opened RO only by
    default
  - Unconditionally let @unmap default to true for children

- Patch 11: Fallout from having moved bdrv_inherited_options() down: We
            need a forward declaration of bdrv_open_inherit()

- Patch 12: Move bdrv_child_cb_attach() down to
            bdrv_inherited_options(), and add a (temporary) forward
            declaration for it

- Patch 13: Same as patch 12, but for bdrv_child_detach() now

- Patch 14: Drop (now unnecessary) forward declaration of
            bdrv_backing_update_filename()

- Patch 16: Renamed s/for_backing/for_cow/

- Patch 18: Swapped the existing patch that split
            bdrv_default_perms_for_storage() function into for_data()
            and for_metadata() for this one, which handles both cases in
            the existing function, but just relaxes the restrictions for
            pure data children
  - Also, some permissions fixed: When WRITE_UNCHANGED was taken on the
    parent, it may need WRITE on the the data child; and if it needs
    WRITE, it may also need RESIZE.

- Patch 19:
  - Fallout from bdrv_default_perms_for_storage() still being a single
    function
  - Assertions that FILTERED, COW, and DATA | METADATA are mutually
    exclusive

- Patch 23: Use bdrv_backing_role() instead of a fixed BDRV_CHILD_COW in
            bdrv_open_backing_file()

- Patch 24: Fallout from bdrv_default_perms_for_storage() still being a
            single function

- Patch 26: blkreplay is a filter now, too

- Patch 27: Drop blkreplay (it’s now a filter, so handled in patch 26)

- Patch 31: Fallout from bdrv_default_perms_for_storage() still being a
            single function

- Patch 32:
  - Fallout from bdrv_default_perms_for_storage() still being a single
    function
  - Remove the temporary forward declarations added in patches 11
    through 13

- Patch 33: Pass DATA | METADATA instead of just DATA for vvfat’s qcow
            child

- Patch 34:
  - Fallout from bdrv_default_perms_for_backing() being named
    bdrv_default_perms_for_cow() now
  - Fallout from bdrv_default_perms_for_storage() still being a single
    function


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/34:[down] 'block: Mark commit, mirror, blkreplay as filters'
002/34:[----] [--] 'block: Add BlockDriver.is_format'
003/34:[----] [-C] 'block: Rename BdrvChildRole to BdrvChildClass'
004/34:[0030] [FC] 'block: Add BdrvChildRole and BdrvChildRoleBits'
005/34:[----] [-C] 'block: Add BdrvChildRole to BdrvChild'
006/34:[----] [--] 'block: Pass BdrvChildRole to bdrv_child_perm()'
007/34:[----] [-C] 'block: Pass BdrvChildRole to .inherit_options()'
008/34:[----] [--] 'block: Pass parent_is_format to .inherit_options()'
009/34:[----] [--] 'block: Rename bdrv_inherited_options()'
010/34:[0021] [FC] 'block: Add generic bdrv_inherited_options()'
011/34:[0015] [FC] 'block: Use bdrv_inherited_options()'
012/34:[0025] [FC] 'block: Unify bdrv_child_cb_attach()'
013/34:[0024] [FC] 'block: Unify bdrv_child_cb_detach()'
014/34:[0003] [FC] 'block: Add child_of_bds'
015/34:[----] [--] 'block: Distinguish paths in *_format_default_perms'
016/34:[0016] [FC] 'block: Pull out bdrv_default_perms_for_cow()'
017/34:[----] [-C] 'block: Pull out bdrv_default_perms_for_storage()'
018/34:[down] 'block: Relax *perms_for_storage for data children'
019/34:[0028] [FC] 'block: Add bdrv_default_perms()'
020/34:[----] [--] 'raw-format: Split raw_read_options()'
021/34:[----] [--] 'block: Switch child_format users to child_of_bds'
022/34:[----] [--] 'block: Drop child_format'
023/34:[0002] [FC] 'block: Make backing files child_of_bds children'
024/34:[0010] [FC] 'block: Drop child_backing'
025/34:[----] [--] 'block: Make format drivers use child_of_bds'
026/34:[0005] [FC] 'block: Make filter drivers use child_of_bds'
027/34:[0005] [FC] 'block: Use child_of_bds in remaining places'
028/34:[----] [--] 'tests: Use child_of_bds instead of child_file'
029/34:[----] [-C] 'block: Use bdrv_default_perms()'
030/34:[----] [--] 'block: Make bdrv_filter_default_perms() static'
031/34:[0004] [FC] 'block: Drop bdrv_format_default_perms()'
032/34:[0013] [FC] 'block: Drop child_file'
033/34:[0004] [FC] 'block: Pass BdrvChildRole in remaining cases'
034/34:[0024] [FC] 'block: Drop @child_class from bdrv_child_perm()'


Max Reitz (34):
  block: Mark commit, mirror, blkreplay as filters
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
  block: Pull out bdrv_default_perms_for_cow()
  block: Pull out bdrv_default_perms_for_storage()
  block: Relax *perms_for_storage for data children
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

 include/block/block.h       |  64 +++-
 include/block/block_int.h   |  57 ++--
 block.c                     | 578 ++++++++++++++++++++++--------------
 block/backup-top.c          |  11 +-
 block/blkdebug.c            |  10 +-
 block/blklogwrites.c        |  16 +-
 block/blkreplay.c           |   8 +-
 block/blkverify.c           |  10 +-
 block/block-backend.c       |  20 +-
 block/bochs.c               |   7 +-
 block/cloop.c               |   7 +-
 block/commit.c              |   4 +-
 block/copy-on-read.c        |   7 +-
 block/crypto.c              |   8 +-
 block/dmg.c                 |   7 +-
 block/filter-compress.c     |   7 +-
 block/io.c                  |  22 +-
 block/mirror.c              |   4 +-
 block/parallels.c           |   7 +-
 block/qcow.c                |   7 +-
 block/qcow2.c               |  20 +-
 block/qed.c                 |   7 +-
 block/quorum.c              |   8 +-
 block/raw-format.c          | 128 +++++---
 block/replication.c         |   5 +-
 block/throttle.c            |   7 +-
 block/vdi.c                 |   7 +-
 block/vhdx.c                |   7 +-
 block/vmdk.c                |  23 +-
 block/vpc.c                 |   7 +-
 block/vvfat.c               |  13 +-
 blockjob.c                  |   7 +-
 tests/test-bdrv-drain.c     |  72 ++---
 tests/test-bdrv-graph-mod.c |  10 +-
 tests/test-block-iothread.c |  17 +-
 35 files changed, 738 insertions(+), 461 deletions(-)

-- 
2.26.2


