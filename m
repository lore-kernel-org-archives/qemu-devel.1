Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723C1C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EE120449
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EE120449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0Kn-0006k2-2j
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:17:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hR0J1-0005hM-VL
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hR0Iw-0007aC-7a
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hR0Iu-0007XU-0b; Wed, 15 May 2019 16:15:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3732308FC4B;
	Wed, 15 May 2019 20:15:05 +0000 (UTC)
Received: from localhost (unknown [10.40.205.95])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0517B60BE5;
	Wed, 15 May 2019 20:15:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 15 May 2019 22:14:59 +0200
Message-Id: <20190515201503.19069-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 15 May 2019 20:15:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] iotests: Make 245 faster and more reliable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

245 is a bit flakey for me, because it uses block jobs that copy 1 MB of
data but have a buffer size of 512 kB, so they may be done before the
test gets to do the things it wants to do while the check is running.
(Rate limiting doesn=E2=80=99t change this.)

The boring way to fix this would be to increase the amount of data.

The interesting way to fix this is to make use of auto_finalize=3Dfalse
and thus keep the jobs around until the test is done with them.
However, this has one problem: In one case, 245 tries to make the target
node of a stream job read-only.  If the job is still copying data, doing
so will fail because the target node is in COR mode.  Otherwise, we get
a cryptic =E2=80=9CBlock node is read-only=E2=80=9D message.

What the message means is =E2=80=9CAfter reopening, the node will be read=
-only,
and that won=E2=80=99t work, because there is a writer on it.=E2=80=9D  I=
t doesn=E2=80=99t say
that, though, but it should.  So patch 1 makes it say something to that
effect (=E2=80=9CCannot make block node read-only, there is a writer on i=
t=E2=80=9D).

245 doesn=E2=80=99t care about the actual error message, both reflect tha=
t qemu
correctly detects that this node cannot be made read-only at this time.
So the other thing we have to do is let assert_qmp() accept an array of
valid error messages and choose the one that matches (if any).  Then we
can just pass both error messages to it and everything works.


Nice side effect: For me, the test duration goes down from about 12 s to
about 6 s.
(That=E2=80=99s because the test forgot to disable rate limiting on the j=
obs
before waiting for their completion.)


Max Reitz (4):
  block: Improve "Block node is read-only" message
  iotests.py: Let assert_qmp() accept an array
  iotests.py: Fix VM.run_job
  iotests: Make 245 faster and more reliable

 block.c                       | 17 ++++++++++++++++-
 tests/qemu-iotests/245        | 22 ++++++++++++++--------
 tests/qemu-iotests/245.out    | 12 ++++++++++++
 tests/qemu-iotests/iotests.py | 20 +++++++++++++++++---
 4 files changed, 59 insertions(+), 12 deletions(-)

--=20
2.21.0


