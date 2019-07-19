Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFBAC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192F62084D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192F62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPAE-0002wI-63
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37585)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hoP9r-0001ts-O6
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hoP9q-0005pE-NK
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hoP9o-0005jC-5I; Fri, 19 Jul 2019 05:26:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9E9CB2CD;
 Fri, 19 Jul 2019 09:26:23 +0000 (UTC)
Received: from localhost (unknown [10.40.205.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E875B1001B14;
 Fri, 19 Jul 2019 09:26:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 11:26:08 +0200
Message-Id: <20190719092618.24891-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 19 Jul 2019 09:26:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 00/10] block: Delay poll when ending drained
 sections
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
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series:

(1) Keeps patch 1, as the previous series, and

(2) Decides whether all *drained_end* functions should poll or not; as
    proposed by Kevin, all that should not poll now get a
    @drained_end_counter pointer, whose pointee they have to increment
    once for every background operation scheduled, and that background
    operation will decrement it once it settles.
    This allows functions that should poll to do so until the counter
    reaches 0, so they don=E2=80=99t have to poll after scheduling every =
single
    operation but can do so once in a place where it=E2=80=99s safe.

v3:
- Change the design as described above (drained_end_counter instead of a
  list of BdrvCoDrainData objects to poll)
- Added a test to test-bdrv-drain


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/10:[----] [--] 'block: Introduce BdrvChild.parent_quiesce_counter'
002/10:[down] 'tests: Add job commit by drained_end test'
003/10:[down] 'block: Add @drained_end_counter to bdrv_drain_invoke()'
004/10:[down] 'block: Make bdrv_parent_drained_[^_]*() static'
005/10:[down] 'tests: Lock AioContexts in test-block-iothread'
006/10:[down] 'block: Only poll once in bdrv_drained_end()'
007/10:[down] 'tests: Extend commit by drained_end test'
008/10:[down] 'block: Loop unsafely in bdrv*drained_end()'
009/10:[----] [--] 'iotests: Add @has_quit to vm.shutdown()'
010/10:[----] [--] 'iotests: Test commit with a filter on the chain'


Max Reitz (10):
  block: Introduce BdrvChild.parent_quiesce_counter
  tests: Add job commit by drained_end test
  block: Add @drained_end_counter
  block: Make bdrv_parent_drained_[^_]*() static
  tests: Lock AioContexts in test-block-iothread
  block: Do not poll in bdrv_do_drained_end()
  tests: Extend commit by drained_end test
  block: Loop unsafely in bdrv*drained_end()
  iotests: Add @has_quit to vm.shutdown()
  iotests: Test commit with a filter on the chain

 include/block/block.h       |  42 +++++++----
 include/block/block_int.h   |  15 +++-
 block.c                     |  52 ++++++++-----
 block/block-backend.c       |   6 +-
 block/io.c                  | 134 +++++++++++++++++++++++---------
 blockjob.c                  |   2 +-
 tests/test-bdrv-drain.c     | 147 ++++++++++++++++++++++++++++++++++++
 tests/test-block-iothread.c |  40 ++++++----
 python/qemu/machine.py      |   5 +-
 tests/qemu-iotests/040      |  40 +++++++++-
 tests/qemu-iotests/040.out  |   4 +-
 tests/qemu-iotests/255      |   2 +-
 12 files changed, 397 insertions(+), 92 deletions(-)

--=20
2.21.0


