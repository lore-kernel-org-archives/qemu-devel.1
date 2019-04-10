Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B68C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456C92082E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456C92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJjw-0007t2-3R
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 16:22:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiF-0006q4-Sc
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJi8-0004FR-Ba
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:20:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEJi1-0004Cz-G9; Wed, 10 Apr 2019 16:20:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D65CF30C16B6;
	Wed, 10 Apr 2019 20:20:35 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B7705D71E;
	Wed, 10 Apr 2019 20:20:34 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 10 Apr 2019 22:20:22 +0200
Message-Id: <20190410202033.28617-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 10 Apr 2019 20:20:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 00/11] block: Deal with filters
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410202022.unH37BGNRJtDIDGDkByvmixKywyR4hhuWlbHk7YXMN8@z>

Note: This is technically the first part of my active mirror followup.
But just very technically.  I noticed that that followup started to
consist of two parts, namely (A) fix filtery things in the block layer,
and (B) fix active mirror.  So I decided to split it.  This is part A.
Part B is =E2=80=9Cmirror: Mainly coroutine refinements=E2=80=9D.


When we introduced filters, we did it a bit casually.  Sure, we talked a
lot about them before, but that was mostly discussion about where
implicit filters should be added to the graph (note that we currently
only have two implicit filters, those being mirror and commit).  But in
the end, we really just designated some drivers filters (Quorum,
blkdebug, etc.) and added some specifically (throttle, COR), without
really looking through the block layer to see where issues might occur.

It turns out vast areas of the block layer just don=E2=80=99t know about =
filters
and cannot really handle them.  Many cases will work in practice, in
others, well, too bad, you cannot use some feature because some part
deep inside the block layer looks at your filters and thinks they are
format nodes.

This series sets out to correct a bit of that.  I lost my head many
times and I=E2=80=99m sure this series is incomplete in many ways, but it=
 really
doesn=E2=80=99t do any good if it sits on my disk any longer, it needs to=
 go out
now.

The most important patches of this series are patches 2 and 3.  These
introduce functions to encapsulate bs->backing and bs->file accesses.
Because sometimes, bs->backing means COW, sometimes it means filtered
node.  And sometimes, bs->file means metadata storage, and sometimes it
means filtered node.  With this functions, it=E2=80=99s always clear what=
 the
caller wants, and it will always get what it wants.

Besides that, patch 2 introduces functions to skip filters which may be
used by parts of the block layer that just don=E2=80=99t care about them.


Secondly, the restraints put on mirror=E2=80=99s @replaces parameter are
revisited and fixed.


Thirdly, BDS.backing_file is changed to be constant.  I don=E2=80=99t qui=
te know
why we modify it whenever we change a BDS=E2=80=99s backing file, but tha=
t=E2=80=99s
definitely not quite right.  This fixes things like being able to
perform a commit on a file (using relative filenames) in a directory
that=E2=80=99s not qemu=E2=80=99s CWD.


Finally, a number of tests are added.


There are probably many things that are worthy of discussion, of which
only some come to my head, e.g.:

- In which cases do we want to skip filters, in which cases do we want
  to skip implicit filters?
  My approach was to basically never skip explicitly added filters,
  except when it=E2=80=99s about finding a file in some tree (e.g. in a b=
acking
  chain).  Maybe there are cases where you think we should skip even
  explicitly added filters.

- I made interesting decisions like =E2=80=9CWhen you mirror from a node,=
 we
  should indeed mirror from that node, but when replacing it, we should
  skip leave all implicit filters on top intact.=E2=80=9D  You may disagr=
ee with
  that.
  (My reasoning here is that users aren=E2=80=99t supposed to know about
  implicit filters, and therefore, they should not intend to remove
  them.  Also, mirror accepts only root nodes as the source, so you
  cannot really specify the node below the implicit filters.  But you
  can use @replaces to drop the implicit filters, if you know they are
  there.)

- bdrv_query_bds_stats() is changed: =E2=80=9Cparent=E2=80=9D now means s=
torage,
  =E2=80=9Cbacking=E2=80=9D means COW.  This is what makes sense, althoug=
h it breaks
  compatibility; but only for filters that use bs->backing for the
  filtered child (i.e. mirror top and commit top).  The alternatives
  would be:
  - Leave everything as it is.  But this means that whenever you add
    another filter (throttle or COR), the backing chain is still broken
    because they use bs->file for their filtered child.  So this is not
    really an option.
  - Present all filtered children under =E2=80=9Cbacking=E2=80=9D.  We wo=
uld need to
    present them under =E2=80=9Cparent=E2=80=9D as well, though, if they =
are referenced
    as bs->file, otherwise this too would break compatibility and would
    not be any better.
    This seems rather broken because we may present the same node twice
    (once as =E2=80=9Cparent=E2=80=9D, once as =E2=80=9Cbacking=E2=80=9D)=
.
    Well, or we decide to break compatibility here, too, but to me it
    seems wrong to present filtered nodes under =E2=80=9Cbacking=E2=80=9D=
 but not under
    =E2=80=9Cparent=E2=80=9D.

  So I went for the solution that makes the most sense to me.


v4:
- Dropped patch 2 because it=E2=80=99s in master
- (New) patch 2:
  - Fixed the description of BDS.is_filter (requested by Kevin); I
    didn=E2=80=99t do that before patch 1 because the description is kind=
 of
    wrong today already (Quorum does not have a bs->file but has been
    marked a filter from the start).  It was only kind of wrong
    because the description just claims that some callbacks get
    automatically passed to bs->file, not that the filter must have
    bs->file present.  But then patch 1 is correct without adjusting the
    description, and we only need to do so here, in patch 2.  (Because
    now the callbacks may be passed to bs->backing, too.)
  - Rebase conflicts, mostly due to *backing_chain_frozen() and reopen
    stuff in general (we usually still want to access bs->backing
    instead of using the new functions because this is specifically
    about bs->backing, not about the COW child).
Patch 7: Keep iotest 245 passing


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/11:[----] [--] 'block: Mark commit and mirror as filter drivers'
002/11:[0034] [FC] 'block: Filtered children access functions'
003/11:[----] [--] 'block: Storage child access function'
004/11:[----] [-C] 'block: Inline bdrv_co_block_status_from_*()'
005/11:[----] [--] 'block: Fix check_to_replace_node()'
006/11:[----] [--] 'iotests: Add tests for mirror @replaces loops'
007/11:[0004] [FC] 'block: Leave BDS.backing_file constant'
008/11:[----] [--] 'iotests: Add filter commit test cases'
009/11:[----] [--] 'iotests: Add filter mirror test cases'
010/11:[----] [--] 'iotests: Add test for commit in sub directory'
011/11:[----] [--] 'iotests: Test committing to overridden backing'


Max Reitz (11):
  block: Mark commit and mirror as filter drivers
  block: Filtered children access functions
  block: Storage child access function
  block: Inline bdrv_co_block_status_from_*()
  block: Fix check_to_replace_node()
  iotests: Add tests for mirror @replaces loops
  block: Leave BDS.backing_file constant
  iotests: Add filter commit test cases
  iotests: Add filter mirror test cases
  iotests: Add test for commit in sub directory
  iotests: Test committing to overridden backing

 qapi/block-core.json           |   4 +
 include/block/block.h          |   2 +
 include/block/block_int.h      |  87 +++++---
 block.c                        | 381 +++++++++++++++++++++++++++------
 block/backup.c                 |   8 +-
 block/blkdebug.c               |   7 +-
 block/blklogwrites.c           |   1 -
 block/block-backend.c          |  16 +-
 block/commit.c                 |  36 ++--
 block/copy-on-read.c           |   2 -
 block/io.c                     | 102 ++++-----
 block/mirror.c                 |  24 ++-
 block/qapi.c                   |  42 ++--
 block/snapshot.c               |  40 ++--
 block/stream.c                 |  13 +-
 block/throttle.c               |   1 -
 blockdev.c                     | 122 +++++++++--
 migration/block-dirty-bitmap.c |   4 +-
 nbd/server.c                   |   6 +-
 qemu-img.c                     |  41 ++--
 tests/qemu-iotests/020         |  36 ++++
 tests/qemu-iotests/020.out     |  10 +
 tests/qemu-iotests/040         | 191 +++++++++++++++++
 tests/qemu-iotests/040.out     |   4 +-
 tests/qemu-iotests/041         | 270 ++++++++++++++++++++++-
 tests/qemu-iotests/041.out     |   4 +-
 tests/qemu-iotests/184.out     |   7 +-
 tests/qemu-iotests/191.out     |   1 -
 tests/qemu-iotests/204.out     |   1 +
 tests/qemu-iotests/228         |   6 +-
 tests/qemu-iotests/228.out     |   6 +-
 tests/qemu-iotests/245         |   4 +-
 32 files changed, 1194 insertions(+), 285 deletions(-)

--=20
2.20.1


