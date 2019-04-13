Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED627C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0884218D2
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0884218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFLwO-0008Ie-SB
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 12:55:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLuZ-000737-4X
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLuY-0002ep-1r
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hFLuV-0002ax-FT; Sat, 13 Apr 2019 12:53:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0129581E04;
	Sat, 13 Apr 2019 16:53:46 +0000 (UTC)
Received: from localhost (ovpn-204-66.brq.redhat.com [10.40.204.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EB1B960852;
	Sat, 13 Apr 2019 16:53:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Sat, 13 Apr 2019 18:53:36 +0200
Message-Id: <20190413165343.9018-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Sat, 13 Apr 2019 16:53:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/7] qemu-img: Add salvaging mode to convert
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
Message-ID: <20190413165336.XtOLm8aLeS3EhSa-ZtDtP8u-B1koCAg0LaHyS5fB6CI@z>

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


v3:
- Patch 2: Forbid combination of -C and --salvage instead of noting that
           it does nothing [Vladimir]
  (Also, a rebase conflict)
- Patch 7 (new): Test that


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/7:[----] [--] 'qemu-img: Move quiet into ImgConvertState'
002/7:[0012] [FC] 'qemu-img: Add salvaging mode to convert'
003/7:[----] [--] 'blkdebug: Add @iotype error option'
004/7:[----] [--] 'blkdebug: Add "none" event'
005/7:[----] [--] 'blkdebug: Inject errors on .bdrv_co_block_status()'
006/7:[----] [--] 'iotests: Test qemu-img convert --salvage'
007/7:[down] 'iotests: Test qemu-img convert -C --salvage'


Max Reitz (7):
  qemu-img: Move quiet into ImgConvertState
  qemu-img: Add salvaging mode to convert
  blkdebug: Add @iotype error option
  blkdebug: Add "none" event
  blkdebug: Inject errors on .bdrv_co_block_status()
  iotests: Test qemu-img convert --salvage
  iotests: Test qemu-img convert -C --salvage

 qapi/block-core.json       |  33 +++++++-
 block/blkdebug.c           |  60 ++++++++++++--
 qemu-img.c                 | 103 +++++++++++++++++------
 qemu-img-cmds.hx           |   4 +-
 qemu-img.texi              |   4 +
 tests/qemu-iotests/082     |   1 +
 tests/qemu-iotests/082.out |   3 +
 tests/qemu-iotests/249     | 163 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out |  43 ++++++++++
 tests/qemu-iotests/group   |   1 +
 10 files changed, 376 insertions(+), 39 deletions(-)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

--=20
2.20.1


