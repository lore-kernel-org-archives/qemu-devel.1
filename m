Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F22C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 18:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CE520675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 18:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CE520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51305 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO4yO-0000yV-LT
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 14:37:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO4ws-0007O8-0n
	for qemu-devel@nongnu.org; Tue, 07 May 2019 14:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO4wr-0002Go-2H
	for qemu-devel@nongnu.org; Tue, 07 May 2019 14:36:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO4wp-0002B4-0F; Tue, 07 May 2019 14:36:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1B8B30832C5;
	Tue,  7 May 2019 18:36:12 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 65CF95EDE4;
	Tue,  7 May 2019 18:36:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 20:36:05 +0200
Message-Id: <20190507183610.9848-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 07 May 2019 18:36:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/5] iotests: Let 233 run concurrently
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


Max Reitz (5):
  qemu-nbd: Add --pid-file option
  iotests.py: Add qemu_nbd_early_pipe()
  qemu-nbd: Do not close stderr
  iotests: Use qemu-nbd's --pid-file
  iotests: Let 233 run concurrently

 qemu-nbd.c                    | 32 +++++++++++-
 qemu-nbd.texi                 |  2 +
 tests/qemu-iotests/147        |  4 +-
 tests/qemu-iotests/233        |  1 -
 tests/qemu-iotests/common.nbd | 93 ++++++++++++++++-------------------
 tests/qemu-iotests/common.rc  |  4 +-
 tests/qemu-iotests/iotests.py |  9 ++--
 7 files changed, 85 insertions(+), 60 deletions(-)

--=20
2.20.1


