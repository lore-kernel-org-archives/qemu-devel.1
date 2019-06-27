Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106CAC4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 22:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EE32063F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 22:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EE32063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgd0G-0003bO-61
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 18:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44227)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hgcxR-0000N8-Ex
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hgcxO-0004Ex-3C
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:33:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hgcxH-0003lH-CZ; Thu, 27 Jun 2019 18:33:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2250987630;
 Thu, 27 Jun 2019 22:33:02 +0000 (UTC)
Received: from localhost (ovpn-204-47.brq.redhat.com [10.40.204.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 422C15C237;
 Thu, 27 Jun 2019 22:32:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 28 Jun 2019 00:32:50 +0200
Message-Id: <20190627223255.3789-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 27 Jun 2019 22:33:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/5] block: Add BDS.never_freeze
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As it is, this series depends on my block branch, most importantly
Andrey=E2=80=99s series =E2=80=9Cblock/stream: get rid of the base=E2=80=9D=
.

Depends-on: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuoz=
zo.com>

This series made the problem apparent to me, but it existed before:
Namely, the commit and mirror block jobs create filter nodes which they
just try to drop with an &error_fatal.  If any of its parent links is
frozen, that will abort qemu.  Patch 1 fixes this by adding a
BDS.never_freeze flag, which prevents bdrv_freeze_backing_chain() from
freezing any links to a BDS that has this flag set.

Now, after Andrey=E2=80=99s series, you can reproduce this problem by fir=
st
launching a commit job and then launching a stream job from the commit=E2=
=80=99s
top node.  This is actually something that iotest 030 tests, but I
didn=E2=80=99t notice the problem because 030 has two problems of itself:
(1) It fails to do proper throttling, so usually, the commit job is
    already gone by the time the stream job starts.  (Fixed by patch 2.)
(2) It doesn=E2=80=99t check the error message, but just the error class.=
  If it
    had checked the error message, we would have seen that it just says
    that the stream=E2=80=99s base node cannot be found, and thus would h=
ave
    fixed problem #1 earlier.  (Fixed by patch 3.)

If you apply patches 2 and 3 to my block branch, you=E2=80=99ll see that =
both
jobs can be created.  If you remove the check that creating the stream
job should fail and replace the self.wait_until_completed() by a
self.vm.run_job('drive0'), you will see that qemu aborts.

So that appears to be a new problem introduced by Andrey=E2=80=99s series=
,
right?  But it actually isn=E2=80=99t new.  Patch 5 adds a test for a
pre-existing case:

If on master you launch a commit job and then a stream job from the
commit=E2=80=99s filter node, qemu will abort (if the commit job complete=
s
before the stream job, at least).  So the problem existed well before
Andrey=E2=80=99s series, it just moved it down one node.
(You can test that by applying patches 2 through 5 on master.  You will
get a failure in test_overlapping_4, and a qemu abort in
test_overlapping_5.)

In turn, thanks to said series, this test case now fully works.  (So you
can stream from a commit=E2=80=99s filter node.)


So either way, the problem addressed by patch 1 is visible both on
master and on my block branch.  It just appears in different places,
hence the dependency.


Max Reitz (5):
  block: Add BDS.never_freeze
  iotests: Fix throttling in 030
  iotests: Compare error messages in 030
  iotests: Add @use_log to VM.run_job()
  iotests: Add new case to 030

 include/block/block_int.h     |   3 +
 block.c                       |   8 +++
 block/commit.c                |   4 ++
 block/mirror.c                |   4 ++
 tests/qemu-iotests/030        | 121 ++++++++++++++++++++++++++--------
 tests/qemu-iotests/030.out    |   4 +-
 tests/qemu-iotests/iotests.py |  18 +++--
 7 files changed, 127 insertions(+), 35 deletions(-)

--=20
2.21.0


