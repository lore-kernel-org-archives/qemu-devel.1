Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4785EC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 19:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2B620674
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 19:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2B620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4s7M-0005uu-0G
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 15:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i4s4x-000445-9N
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 15:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i4s4w-0006uv-2y
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 15:33:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i4s4s-0006rJ-7Q; Mon, 02 Sep 2019 15:33:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3EA8C057F31;
 Mon,  2 Sep 2019 19:33:24 +0000 (UTC)
Received: from localhost (ovpn-204-221.brq.redhat.com [10.40.204.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD0235D9CC;
 Mon,  2 Sep 2019 19:33:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  2 Sep 2019 21:33:15 +0200
Message-Id: <20190902193320.32233-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 02 Sep 2019 19:33:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/5] vpc: Return 0 from vpc_co_create() on
 success
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(v2 for =E2=80=9Cblock: Let blockdev-create return 0 on success=E2=80=9D)

Jobs are expected to return 0 on success, so this extends to
.bdrv_co_create().  After some inspection, it turns out that vpc is the
only block driver that may return a positive value instead (to indicate
success).  Fix that.

Without this patch, blockdev-create is likely to fail for VPC images.
Hence patch 5.

John indicated his preference for me to use iotests.script_main().  I
did that; but I still wanted to retain some form of verify_protocol().
Patch 2 adds @supported_protocols to execute_test() (and thus to
iotests.script_main() and iotests.main()).  Then I noticed we should
probably make all Python tests (that use either script_main() or main())
pass something for that parameter, because it=E2=80=99s a bit silly to ru=
n all
Python tests for raw when you just want to run the nbd tests (which are
five or so).  Enter patches 3 and 4.

(There are two Python tests (093 and 136) which I didn=E2=80=99t change t=
o pass
supported_protocols, because they use null-{co,aio} as their protocol.
As these are not actually testee protocols for the iotests, I decided to
just keep running these tests for any protocol.)


For completeness=E2=80=99 sake[1]:

git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/5:[down] 'vpc: Return 0 from vpc_co_create() on success'
002/5:[down] 'iotests: Add supported protocols to execute_test()'
003/5:[down] 'iotests: Restrict file Python tests to file'
004/5:[down] 'iotests: Restrict nbd Python tests to nbd'
005/5:[0204] [FC] 'iotests: Test blockdev-create for vpc'


[1]
Please vote on the correct spelling:
(A) =E2=80=9CFor completeness sake=E2=80=9D
(B) =E2=80=9CFor completeness=E2=80=99 sake=E2=80=9D
(C) =E2=80=9CFor completeness=E2=80=99s sake=E2=80=9D

By participating, you become eligible to receive mention in the git log.

To give you mention, we need your full name and email address.
Therefore, please cast your vote by replying to this mail as follows:
> I vote for ${letter}${reason:=3D.}
>
> Reviewed-by: $name <$email_address>

(Set the =E2=80=9Cletter=E2=80=9D variable to be any of A, B, or C; =E2=80=
=9Creason=E2=80=9D to be a
justification (optional; should be prefixed by =E2=80=9C, because =E2=80=9D=
 and end with
a full stop); =E2=80=9Cname=E2=80=9D to be your name; and =E2=80=9Cemail_=
address=E2=80=9D to be your
email address.)

Thank you for doing your part in saving democracy!


Max Reitz (5):
  vpc: Return 0 from vpc_co_create() on success
  iotests: Add supported protocols to execute_test()
  iotests: Restrict file Python tests to file
  iotests: Restrict nbd Python tests to nbd
  iotests: Test blockdev-create for vpc

 block/vpc.c                   |   3 +-
 tests/qemu-iotests/030        |   3 +-
 tests/qemu-iotests/040        |   3 +-
 tests/qemu-iotests/041        |   3 +-
 tests/qemu-iotests/044        |   3 +-
 tests/qemu-iotests/045        |   3 +-
 tests/qemu-iotests/055        |   3 +-
 tests/qemu-iotests/056        |   3 +-
 tests/qemu-iotests/057        |   3 +-
 tests/qemu-iotests/065        |   3 +-
 tests/qemu-iotests/096        |   3 +-
 tests/qemu-iotests/118        |   3 +-
 tests/qemu-iotests/124        |   3 +-
 tests/qemu-iotests/129        |   3 +-
 tests/qemu-iotests/132        |   3 +-
 tests/qemu-iotests/139        |   3 +-
 tests/qemu-iotests/147        |   5 +-
 tests/qemu-iotests/148        |   3 +-
 tests/qemu-iotests/151        |   3 +-
 tests/qemu-iotests/152        |   3 +-
 tests/qemu-iotests/155        |   3 +-
 tests/qemu-iotests/163        |   3 +-
 tests/qemu-iotests/165        |   3 +-
 tests/qemu-iotests/169        |   3 +-
 tests/qemu-iotests/196        |   3 +-
 tests/qemu-iotests/199        |   3 +-
 tests/qemu-iotests/205        |   3 +-
 tests/qemu-iotests/245        |   3 +-
 tests/qemu-iotests/257        |   3 +-
 tests/qemu-iotests/266        | 153 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/266.out    | 137 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   4 +-
 33 files changed, 352 insertions(+), 32 deletions(-)
 create mode 100755 tests/qemu-iotests/266
 create mode 100644 tests/qemu-iotests/266.out

--=20
2.21.0


