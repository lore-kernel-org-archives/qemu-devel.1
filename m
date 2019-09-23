Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC75C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7584205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7584205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCN0C-0004VI-QT
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 07:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iCMyI-0003It-QY
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iCMyH-0006pk-Gh
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:57:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iCMyE-0006n0-Oc; Mon, 23 Sep 2019 07:57:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00E3210C092E;
 Mon, 23 Sep 2019 11:57:33 +0000 (UTC)
Received: from localhost (unknown [10.40.205.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2685E5D9CA;
 Mon, 23 Sep 2019 11:57:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/4] mirror: Do not dereference invalid pointers
Date: Mon, 23 Sep 2019 13:57:24 +0200
Message-Id: <20190923115728.28250-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 23 Sep 2019 11:57:33 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The fix (patch 1) is pretty straightforward; patch 2 (which I need for
the test) may not be.

The biggest problem with patch 2 is that you can use it to uncover where
our permission handling is broken.  For example, devising the test case
(patch 4) was very difficult because I kept running into the
&error_abort that mirror_exit_common() passes when dropping the
mirror_top_bs.

The problem is that mirror_top_bs does not take the same permissions
that its parent takes.  Ergo using &error_abort when dropping it is
wrong: The parent may require more permissions that mirror_top_bs did,
and so dropping mirror_top_bs may fail.

Now what=E2=80=99s really bad is that this cannot be fixed with our curre=
nt
permission system.  mirror_top_bs was introduced precisely so it does
not take CONSISTENT_READ, but can still allow parents to take it (for
active commits).  But what if there is actually something besides the
mirror job that unshares CONSISTENT_READ?


Imagine this:

      mirror target BB       mirror source BB
                  |             |
                  v             v
mirror_top_bs -> top -> mid -> base
                  ^
                  |
             other_parent

The source BB unshares CONSISTENT_READ on the base.  mirror_top_bs
ensures that its parents can read from top even though top itself cannot
allow CONSISTENT_READ to be taken.  So far so good.

But what if other_parent also unshares CONSISTENT_READ?  Then,
mirror_top_bs has no business allowing its parents to take it.

No idea how to fix that.  (I suppose mirror_top_bs would need some way
to verify that there is no other party that has unshared CONSISTENT_READ
but its associated source BB.  In the future, we want the source BB to
go away and instead have the source be an immediate BdrvChild of
mirror_top_bs.  Maybe we can then build something into the block layer
so that a node can only restore CONSISTENT_READ when it was that node
that broke it?)


Anyway.  You can see something arising from this problem simply by
unsharing CONSISTENT_READ on the target node.  (Just drop the src-perm
node from the test I add in patch 4.)  Replacing the source with the
target will then work fine (because mirror_top_bs doesn=E2=80=99t care ab=
out
CONSISTENT_READ being removed), but then you cannot drop mirror_top_bs =E2=
=80=93
because its parent does want CONSISTENT_READ.  Thus, the &error_abort
aborts.


While this is a more special case, I have no idea how to fix this one
either.


Soo...  This series just fixes one thing, and leaves another unfixed
because I have no idea how to fix it.  Worse, it adds parameters to
blkdebug to actually see the problem.  Do we want to let blkdebug be
able to crash qemu (because of a bug in qemu)?


v2:
- Patch 2: Dropped BlockdevPermission, we have BlockPermission already
- Patch 4:
  - Use list comprehension instead of map() + lambda
    (Though I notice that over time my aversion of list comprehensions
    only grows)

  - Use a tuple instead of a list for a collection of values that isn=E2=80=
=99t
    modified

git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/4:[----] [--] 'mirror: Do not dereference invalid pointers'
002/4:[0027] [FC] 'blkdebug: Allow taking/unsharing permissions'
003/4:[----] [--] 'iotests: Add @error to wait_until_completed'
004/4:[0004] [FC] 'iotests: Add test for failing mirror complete'


Max Reitz (4):
  mirror: Do not dereference invalid pointers
  blkdebug: Allow taking/unsharing permissions
  iotests: Add @error to wait_until_completed
  iotests: Add test for failing mirror complete

 qapi/block-core.json          |  14 ++++-
 block/blkdebug.c              | 106 +++++++++++++++++++++++++++++++++-
 block/mirror.c                |  13 +++--
 tests/qemu-iotests/041        |  44 ++++++++++++++
 tests/qemu-iotests/041.out    |   4 +-
 tests/qemu-iotests/iotests.py |  18 ++++--
 6 files changed, 185 insertions(+), 14 deletions(-)

--=20
2.21.0


