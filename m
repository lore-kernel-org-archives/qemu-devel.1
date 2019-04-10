Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819CEC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFF8204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFF8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37805 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEKJK-0001au-AR
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 16:59:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHb-0000Zj-V3
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHa-00085s-Ou
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEKHY-00083X-1n; Wed, 10 Apr 2019 16:57:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EE79308968D;
	Wed, 10 Apr 2019 20:57:18 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D423E61995;
	Wed, 10 Apr 2019 20:57:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 10 Apr 2019 22:57:09 +0200
Message-Id: <20190410205715.2209-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 10 Apr 2019 20:57:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/6] qemu-img: Add salvaging mode to convert
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	"Denis V . Lunev" <den@openvz.org>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410205709.TUfYDFYrLn-G_vvXA5Bopbyx0eD0tzdt7O7Gxb4nKy4@z>

Hi,

This series adds a --salvage option to qemu-img convert.  With this,
qemu-img will not abort when it encounters an I/O error.  Instead, it
tries to narrow it down and will treat the affected sectors as being
completely 0 (and print a warning).

Testing this is not so easy, because while real I/O errors during read
operations should be treated as described above, errors encountered
during bdrv_block_status() should just be ignored and the affected
sectors should be considered allocated.  But blkdebug does not yet have
a way to intercept this, and:

(1) Just adding a new block-status event would be silly, because I don't
    want an event, I want it to fail on a certain kind of operation, on
    a certain sector range, independently of any events, so why can't we
    just do that?  See patch 4.

(2) If we just make blkdebug intercept .bdrv_co_block_status() like all
    other kinds of operations, at least iotest 041 fails, which does
    exactly that silly thing: It uses the read_aio event to wait for any
    read.  But it turns out that there may be a bdrv_*block_status()
    call in between, so suddenly the wrong operation yields an error.
    As I said, the real fault here is that it does not really make sense
    to pray that the operation you want to fail is the one that is
    immediately executed after some event that you hope will trigger
    that operation.
    See patch 3.

So patch 3 allows blkdebug users to select which kind of I/O operation
they actually want to make fail, and patch 4 allows them to not use any
event, but to have a rule active all the time.

Together, we can then enable error injection for block-status in patch 5
and make use of event=3Dnone iotype=3Dblock-status in patch 6.


v2:
- Patch 2:
  - 2058c2ad261de7f58fae01d63d3d0efa484caf2a has added an error message
    when message when *block_status() fails.  Continue using this
    message (with the problematic offset instead of the sector index),
    and adjust my new messages to fit its style.
  - Context conflict due to c075a0af22442e88226a6cef22da3fafccfb5d7e
- Patch 3: %s/4\.0/4.1/
- Patch 4: %s/4\.0/4.1/
- Patch 6: Amendments necessitated by the changes to the warnings added
           in patch 2


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/6:[----] [--] 'qemu-img: Move quiet into ImgConvertState'
002/6:[0017] [FC] 'qemu-img: Add salvaging mode to convert'
003/6:[0004] [FC] 'blkdebug: Add @iotype error option'
004/6:[0002] [FC] 'blkdebug: Add "none" event'
005/6:[----] [-C] 'blkdebug: Inject errors on .bdrv_co_block_status()'
006/6:[0035] [FC] 'iotests: Test qemu-img convert --salvage'


Max Reitz (6):
  qemu-img: Move quiet into ImgConvertState
  qemu-img: Add salvaging mode to convert
  blkdebug: Add @iotype error option
  blkdebug: Add "none" event
  blkdebug: Inject errors on .bdrv_co_block_status()
  iotests: Test qemu-img convert --salvage

 qapi/block-core.json       |  33 +++++++-
 block/blkdebug.c           |  60 ++++++++++++--
 qemu-img.c                 |  98 ++++++++++++++++------
 qemu-img-cmds.hx           |   4 +-
 qemu-img.texi              |   5 ++
 tests/qemu-iotests/249     | 163 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out |  43 ++++++++++
 tests/qemu-iotests/group   |   1 +
 8 files changed, 368 insertions(+), 39 deletions(-)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

--=20
2.20.1


