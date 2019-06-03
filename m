Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21103C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 20:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1D025687
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 20:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1D025687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40627 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXtgG-0001iO-U4
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 16:35:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hXteg-0000hP-99
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hXtTw-0004yW-NH
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:23:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hXtTv-0004v6-IZ; Mon, 03 Jun 2019 16:22:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA5A430860AE;
	Mon,  3 Jun 2019 20:22:40 +0000 (UTC)
Received: from localhost (unknown [10.40.205.221])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C598101E660;
	Mon,  3 Jun 2019 20:22:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 22:22:34 +0200
Message-Id: <20190603202236.1342-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 03 Jun 2019 20:22:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/2] blockdev: Overlays are not snapshots
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU=E2=80=99s always been confused over what a snapshot is: Is it the ov=
erlay?
Is it the backing image?

Confusion is rarely a good thing.  I can=E2=80=99t think of any objective=
 reason
why the overlay would be a snapshot.  A snapshot is something that does
not change over time; the overlay does.

(I suppose historically the reason is that =E2=80=9CTaking an overlay=E2=80=
=9D makes no
sense, so the operations are called =E2=80=9CTaking a snapshot=E2=80=9D. =
 Somehow, this
meaning carried over to the new file that is created during that
operation; if =E2=80=9CCreating a snapshot=E2=80=9D creates a file, that =
file must be
the snapshot, right?  Well, no, it isn=E2=80=99t.)

Let=E2=80=99s fix this as best as we can.  Better Nate than lever.


v2:
- Don=E2=80=99t break the iotests for a change
  (kept Eric=E2=80=99s R-b, because it felt like the right thing to do)


git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/2:[----] [--] 'qapi/block-core: Overlays are not snapshots'
002/2:[0010] [FC] 'blockdev: Overlays are not snapshots'


Max Reitz (2):
  qapi/block-core: Overlays are not snapshots
  blockdev: Overlays are not snapshots

 qapi/block-core.json       | 20 ++++++++++----------
 blockdev.c                 | 10 +++++-----
 tests/qemu-iotests/085.out | 10 +++++-----
 3 files changed, 20 insertions(+), 20 deletions(-)

--=20
2.21.0


