Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A8DC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0FD204EC
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0FD204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37139 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMYP-0005PM-Hn
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:24:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOMWb-00044j-4g
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOMWZ-00015y-8i
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:22:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOMWT-000119-JT; Wed, 08 May 2019 09:22:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3763369C4;
	Wed,  8 May 2019 13:22:11 +0000 (UTC)
Received: from localhost (ovpn-204-94.brq.redhat.com [10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B5AF10027D5;
	Wed,  8 May 2019 13:22:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  8 May 2019 15:22:04 +0200
Message-Id: <20190508132209.17707-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 08 May 2019 13:22:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/5] iotests: Let 233 run concurrently
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

Currently, 233 cannot reliably run concurrently to other NBD TCP tests.
When it starts, it looks for a free port and then attempts to use that
for the whole duration of the test run.  This is a TOCTTOU race
condition: It does not reserve that port, so another NBD TCP test that
runs in parallel can grab it.

To fix this, we must not use the same port all the time, but always
choose a new one when qemu-nbd is started.  We cannot check whether it
is free, but must let qemu-nbd do so and take it atomically.  We can
achieve this by using the existing --fork option.

There are two problems with --fork, however.  First, it does not give us
a chance to reliably get the server=E2=80=99s PID, which we need.  We can=
 change
that by letting qemu-nbd (optionally) write a PID file, though.  (Which
makes sense if we have a daemon mode.)

Second, it currently discards all output after the server has been
started.  That looks like an accident to me, because we clearly try to
restore the old stderr channel after having redirected all startup
messages to the parent process.  If it is a bug, we can fix it.


v2:
- Patch 1:
  - Use qemu_write_pidfile() [Dan]
  - %s/pid_path/pid_filename/ [Eric]
- Patch 4: Drop the now superfluous subshell [Eric]
  (Didn=E2=80=99t touch _qemu_img_wrapper, because, well, it doesn=E2=80=99=
t belong in
  this series?)
- Patch 5:
  - s/racey/racy/ [Eric]
  - Unite the =E2=80=9Crm -f=E2=80=9Ds [Eric]
  (Did not address the =E2=80=9CFIFO filling up=E2=80=9D problem, because=
 64 kB of FIFO
  space ought to be enough.  Also, cat-ing around that felt weird.)


git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/5:[0025] [FC] 'qemu-nbd: Add --pid-file option'
002/5:[----] [--] 'iotests.py: Add qemu_nbd_early_pipe()'
003/5:[----] [--] 'qemu-nbd: Do not close stderr'
004/5:[0006] [FC] 'iotests: Use qemu-nbd's --pid-file'
005/5:[0003] [FC] 'iotests: Let 233 run concurrently'


Max Reitz (5):
  qemu-nbd: Add --pid-file option
  iotests.py: Add qemu_nbd_early_pipe()
  qemu-nbd: Do not close stderr
  iotests: Use qemu-nbd's --pid-file
  iotests: Let 233 run concurrently

 qemu-nbd.c                    | 15 +++++-
 qemu-nbd.texi                 |  2 +
 tests/qemu-iotests/147        |  4 +-
 tests/qemu-iotests/233        |  1 -
 tests/qemu-iotests/common.nbd | 94 ++++++++++++++++-------------------
 tests/qemu-iotests/common.rc  |  6 +--
 tests/qemu-iotests/iotests.py |  9 ++--
 7 files changed, 68 insertions(+), 63 deletions(-)

--=20
2.20.1


