Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC54C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42468204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42468204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZrg-0001tr-Aa
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:13:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRZn1-0005sr-W2
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRZbg-0005wr-Kz
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:56:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hRZbf-0005b0-8F; Fri, 17 May 2019 05:56:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4372030C1AF9;
	Fri, 17 May 2019 09:56:32 +0000 (UTC)
Received: from localhost (unknown [10.40.205.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B78761001DE1;
	Fri, 17 May 2019 09:56:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 11:56:24 +0200
Message-Id: <20190517095628.10119-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 17 May 2019 09:56:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] iotests: Selfish patches
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

Hi,

These are some rather selfish iotests patches.  The first patch helps me
personally because I tend to run the tests over SSH and forget to set
$DISPLAY.  That makes test 139 skip the tests annotated with
skip_if_unsupprted(), because iotests.py can no longer determine the
list of whitelisted formats.

Patch 2 through 4 are specifically for RHEL.  We have not whitelisted
null-aio, so it would be nice if tests didn=E2=80=99t require it.  Sorry,=
 I
don=E2=80=99t have a better reason to give.
In all seriousness, null-co is used widely in many tests, it basically
is our standard null driver.  Tests should prefer it over null-aio, just
for consistency alone.  It is not completely unreasonable to treat
null-aio as optional.  I guess.

Final note: The best thing would probably to skip the null-aio tests in
093/136 if there is no null-aio support.  However, I didn=E2=80=99t get a=
nything
to work: Annotating with @iotests.skip_if_unsupported() didn=E2=80=99t wo=
rk
because the format name is a class instance attribute; and just
iotests.skipTest() didn=E2=80=99t work because that would print 's' chara=
cters
instead of '.' in the output (and emit the number of skipped tests), so
the comparison against the reference output fails...  Which is why I
decided to just run the test with null-co then.  That means that some
tests run twice with null-co (if there is no null-aio support), but
that=E2=80=99s not too bad.  Just ugly.


Max Reitz (4):
  iotests: Add -display none to the qemu options
  iotests: Prefer null-co over null-aio
  iotests: Test driver whitelisting in 093
  iotests: Test driver whitelisting in 136

 tests/qemu-iotests/093   | 22 +++++++++++++++-------
 tests/qemu-iotests/136   | 17 +++++++++++++----
 tests/qemu-iotests/245   |  2 +-
 tests/qemu-iotests/check |  2 +-
 4 files changed, 30 insertions(+), 13 deletions(-)

--=20
2.21.0


