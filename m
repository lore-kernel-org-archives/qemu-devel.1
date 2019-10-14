Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E725C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C352067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C352067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2Sn-0006wu-En
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iK2Rk-0005o4-0g
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iK2Ri-00049b-PC
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:39:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iK2Rf-00046W-5Z; Mon, 14 Oct 2019 11:39:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5CEE84FCD9;
 Mon, 14 Oct 2019 15:39:37 +0000 (UTC)
Received: from localhost (ovpn-117-165.ams2.redhat.com [10.36.117.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3490A6061E;
 Mon, 14 Oct 2019 15:39:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 0/4] mirror: Do not dereference invalid pointers
Date: Mon, 14 Oct 2019 17:39:27 +0200
Message-Id: <20191014153931.20699-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 14 Oct 2019 15:39:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

v2=E2=80=99s cover letter should explain everything:

https://lists.nongnu.org/archive/html/qemu-block/2019-09/msg01079.html


v3:
- Patch 2: Use input visitor as proposed by Vladimir

git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/4:[----] [--] 'mirror: Do not dereference invalid pointers'
002/4:[0041] [FC] 'blkdebug: Allow taking/unsharing permissions'
003/4:[----] [--] 'iotests: Add @error to wait_until_completed'
004/4:[----] [--] 'iotests: Add test for failing mirror complete'


Max Reitz (4):
  mirror: Do not dereference invalid pointers
  blkdebug: Allow taking/unsharing permissions
  iotests: Add @error to wait_until_completed
  iotests: Add test for failing mirror complete

 qapi/block-core.json          | 14 +++++-
 block/blkdebug.c              | 91 ++++++++++++++++++++++++++++++++++-
 block/mirror.c                | 13 +++--
 tests/qemu-iotests/041        | 44 +++++++++++++++++
 tests/qemu-iotests/041.out    |  4 +-
 tests/qemu-iotests/iotests.py | 18 ++++---
 6 files changed, 170 insertions(+), 14 deletions(-)

--=20
2.21.0


