Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C588C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656C921882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656C921882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijBK-0005xN-LO
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hij3u-0007fd-6Z
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hij3s-0008RO-S3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hij3p-0007oe-UZ; Wed, 03 Jul 2019 13:28:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 88DF437F43;
 Wed,  3 Jul 2019 17:28:15 +0000 (UTC)
Received: from localhost (ovpn-204-65.brq.redhat.com [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 202AE91537;
 Wed,  3 Jul 2019 17:28:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  3 Jul 2019 19:28:01 +0200
Message-Id: <20190703172813.6868-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 03 Jul 2019 17:28:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/12] block: Fixes for concurrent block jobs
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

This is a v2 to =E2=80=9Cblock: Add BDS.never_freeze=E2=80=9D.

It depends on my =E2=80=9Cblock: Delay poll when ending drained sections=E2=
=80=9D
series:

Depends-on: <20190619152603.5937-1-mreitz@redhat.com>


It turned out that if you run 030 (or just the new test_overlapping_5
case) sufficiently often, it breaks; which is why I=E2=80=99m hesitant to=
 just
merge the =E2=80=9Cadd never_freeze=E2=80=9D series as it is.

There are several reasons for why this test case breaks, I hope patches
3 to 6 fix them.  Patch 12 adds a test that is much more reliable than
test_overlapping_5 at detecting the problems fixed by at least patches 4
to 6.  (I think that 3 doesn=E2=80=99t really need a test.)

I=E2=80=99m sure there are other ways to see these problems, but well, co=
ming
from 030, concurrent commit/stream jobs are how I reproduced them.
Hence the same of this series.

Patch 2 is for something I encountered on the way.  Patch 11 tests it.


v2:
- Added a bunch of more patches.


git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/12:[----] [--] 'block: Add BDS.never_freeze'
002/12:[down] 'block/stream: Fix error path'
003/12:[down] 'block/stream: Swap backing file change order'
004/12:[down] 'block: Keep subtree drained in drop_intermediate'
005/12:[down] 'block: Reduce (un)drains when replacing a child'
006/12:[down] 'block: Deep-clear inherits_from'
007/12:[----] [--] 'iotests: Fix throttling in 030'
008/12:[----] [--] 'iotests: Compare error messages in 030'
009/12:[----] [--] 'iotests: Add @use_log to VM.run_job()'
010/12:[----] [--] 'iotests: Add new case to 030'
011/12:[down] 'iotests: Add read-only test case to 030'
012/12:[down] 'iotests: Add test for concurrent stream/commit'



Max Reitz (12):
  block: Add BDS.never_freeze
  block/stream: Fix error path
  block/stream: Swap backing file change order
  block: Keep subtree drained in drop_intermediate
  block: Reduce (un)drains when replacing a child
  block: Deep-clear inherits_from
  iotests: Fix throttling in 030
  iotests: Compare error messages in 030
  iotests: Add @use_log to VM.run_job()
  iotests: Add new case to 030
  iotests: Add read-only test case to 030
  iotests: Add test for concurrent stream/commit

 include/block/block_int.h     |   3 +
 block.c                       |  93 +++++++++++++------
 block/commit.c                |   4 +
 block/mirror.c                |   4 +
 block/stream.c                |   4 +-
 tests/qemu-iotests/030        | 150 +++++++++++++++++++++++++------
 tests/qemu-iotests/030.out    |   4 +-
 tests/qemu-iotests/258        | 163 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/258.out    |  33 +++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  18 ++--
 11 files changed, 413 insertions(+), 64 deletions(-)
 create mode 100755 tests/qemu-iotests/258
 create mode 100644 tests/qemu-iotests/258.out

--=20
2.21.0


