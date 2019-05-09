Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF1DC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BF42085A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BF42085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnFT-0003ih-G5
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:54:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOnDn-0002iP-C1
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOnDm-0006BI-Dn
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:52:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOnDk-00068y-3w; Thu, 09 May 2019 13:52:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AAA1300414C;
	Thu,  9 May 2019 17:52:39 +0000 (UTC)
Received: from localhost (ovpn-204-168.brq.redhat.com [10.40.204.168])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E3CD227BC4;
	Thu,  9 May 2019 17:52:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu,  9 May 2019 19:52:34 +0200
Message-Id: <20190509175237.19363-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 09 May 2019 17:52:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/3] qemu-img: Allow rebase with no input
 base
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
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series allows using qemu-img rebase (without -u) on images that do
not have a backing file.  Right now, this fails with the rather cryptic
error message:

$ qemu-img rebase -b base.qcow2 foo.qcow2
qemu-img: Could not open old backing file '': The 'file' block driver req=
uires a file name

Yeah, well, OK.

With how rebase currently works, this would lead to the overlay being
filled with zeroes, however.  This is where patch 2 comes in and instead
makes rebase use blk_pwrite_zeroes() whenever it handles an area past
the input=E2=80=99s backing file=E2=80=99s EOF.

(Note that additionally we could try to punch holes in the overlay
whenever it matches the new backing file, but that=E2=80=99s something I=E2=
=80=99ll put
off for later.  (We don=E2=80=99t even have a reliable method for punchin=
g holes
into an overlay yet, although I would like to have such because it could
make active commit more efficient.))


And patch 3 adds the usual test.


v3:
- Patch 3: Move test to own file so it doesn=E2=80=99t run for qed or qco=
w2 v2
  (because it can=E2=80=99t, it requires zero clusters)

git backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/3:[----] [--] 'qemu-img: Allow rebase with no input base'
002/3:[----] [--] 'qemu-img: Use zero writes after source backing EOF'
003/3:[0059] [FC] 'iotests: Add test for rebase without input base'


v2:
- Patch 1: Added example to the commit message, and made a note that
           this is about rebase without -u [Eric]

git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/3:[----] [--] 'qemu-img: Allow rebase with no input base'
002/3:[----] [--] 'qemu-img: Use zero writes after source backing EOF'
003/3:[----] [--] 'iotests: Add test for rebase without input base'


Max Reitz (3):
  qemu-img: Allow rebase with no input base
  qemu-img: Use zero writes after source backing EOF
  iotests: Add test for rebase without input base

 qemu-img.c                 |  72 ++++++++++++---------
 tests/qemu-iotests/252     | 124 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/252.out |  39 ++++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 207 insertions(+), 29 deletions(-)
 create mode 100755 tests/qemu-iotests/252
 create mode 100644 tests/qemu-iotests/252.out

--=20
2.21.0


