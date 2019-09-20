Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255BEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0DF320882
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DF320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBL1h-0002E5-BQ
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKpS-0000Zn-6y
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKpP-0004G4-IJ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpL-0004BG-T9; Fri, 20 Sep 2019 11:28:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4A8910CC1F9;
 Fri, 20 Sep 2019 15:28:06 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 294D519C5B;
 Fri, 20 Sep 2019 15:28:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 00/22] block: Fix check_to_replace_node()
Date: Fri, 20 Sep 2019 17:27:42 +0200
Message-Id: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 20 Sep 2019 15:28:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20190912135632.13925-1-mreitz@redhat.com>
(=E2=80=9Cmirror: Do not dereference invalid pointers=E2=80=9D)


Hi,

We have this function bdrv_is_first_non_filter(), and I don=E2=80=99t kno=
w what
we have it for exactly.  It=E2=80=99s used in three places:
1. To allow snapshots only on such nodes,
2. To allow resizing only on such nodes,
3. For check_to_replace_node().

In none of these places it=E2=80=99s clear why we=E2=80=99d want it.

For (1), snapshots should just work for every node that supports backing
nodes.  We have such checks in place, so we don=E2=80=99t need to call
bdrv_is_first_non_filter(); and it should be fine to snapshot nodes
somewhere down a backing chain, too.

For (2), bdrv_truncate() should work on any node.  There is no reason
why we=E2=80=99d prevent the user from invoking block_resize only on the =
first
non-filter in a chain.  We now have the RESIZE permission, and as long
as that can be taken, any node can be resized.

For (3), it is just wrong.  The main reason it was introduced here was
to replace broken Quorum children.  But Quorum isn=E2=80=99t actually a f=
ilter,
and that is evidenced precisely here: The user wants to replace a child
that *does not* match the overall quorum.  We need something else
entirely here, namely a special bdrv_recurse_can_replace() function.

That the current approach doesn=E2=80=99t actually work can be seen by at=
taching
some other parent to a Quorum child, and then trying to replace that
child; Quorum will happily agree, but nobody asked that other parent
what they think of suddenly changing the data on their child.

It isn=E2=80=99t wrong to let a node be replaced when there are only filt=
ers
between it and the source node (because then they must have the same
data).  What=E2=80=99s wrong is that Quorum calls itself a filter.

In the new .bdrv_recurse_can_replace(), Quorum can be more aware of all
of this.  So it verifies that there is noone else who might care about
sudden data change by unsharing CONSISTENT_READ and taking the WRITE
permission.


The second problem is that mirror never checked whether the combination
of mirror command (drive/blockdev), sync mode, and @replaces asks for a
loop.  While bdrv_replace_node() was fixed in commit
ec9f10fe064f2abb9dc60a9fa580d8d0933f2acf to never create loops, mirror
should still reject such a configuration because it will probably not
achieve what the user expects.


Other things this series does:
- Fix Quorum=E2=80=99s permissions: It cannot share WRITE or RESIZE permi=
ssions
  because that would break the Quorum
- Drop .is_filter =3D true from Quorum
- Add some tests


(In case you=E2=80=99re wondering, yes, this 22-patch series does replace=
 a
single patch from my 42-patch series =E2=80=9CDeal with filters=E2=80=9D.=
)


Max Reitz (22):
  blockdev: Allow external snapshots everywhere
  blockdev: Allow resizing everywhere
  block: Drop bdrv_is_first_non_filter()
  iotests: Let 041 use -blockdev for quorum children
  quorum: Fix child permissions
  block: Add bdrv_recurse_can_replace()
  blkverify: Implement .bdrv_recurse_can_replace()
  quorum: Store children in own structure
  quorum: Add QuorumChild.to_be_replaced
  quorum: Implement .bdrv_recurse_can_replace()
  block: Use bdrv_recurse_can_replace()
  block: Remove bdrv_recurse_is_first_non_filter()
  mirror: Double-check immediately before replacing
  quorum: Stop marking it as a filter
  mirror: Prevent loops
  iotests: Use complete_and_wait() in 155
  iotests: Add VM.assert_block_path()
  iotests: Resolve TODOs in 041
  iotests: Use self.image_len in TestRepairQuorum
  iotests: Add tests for invalid Quorum @replaces
  iotests: Check that @replaces can replace filters
  iotests: Mirror must not attempt to create loops

 include/block/block.h         |   5 -
 include/block/block_int.h     |  19 ++-
 block.c                       | 115 +++++++++------
 block/blkverify.c             |  20 +--
 block/copy-on-read.c          |   9 --
 block/mirror.c                |  31 +++-
 block/quorum.c                | 155 ++++++++++++++++----
 block/replication.c           |   7 -
 block/throttle.c              |   8 -
 blockdev.c                    |  58 ++++++--
 tests/qemu-iotests/041        | 268 +++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/041.out    |   4 +-
 tests/qemu-iotests/155        |   7 +-
 tests/qemu-iotests/iotests.py |  48 ++++++
 14 files changed, 602 insertions(+), 152 deletions(-)

--=20
2.21.0


