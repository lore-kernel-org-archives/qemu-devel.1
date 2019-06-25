Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78E4C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0532085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0532085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfsuJ-0001To-BP
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 17:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfsrZ-0008Mh-85
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfsrP-00047u-Vl
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:20:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfsrM-0003w5-Hf; Tue, 25 Jun 2019 17:20:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2A22356D3;
 Tue, 25 Jun 2019 21:20:01 +0000 (UTC)
Received: from localhost (ovpn-204-63.brq.redhat.com [10.40.204.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7356B1972B;
 Tue, 25 Jun 2019 21:19:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 25 Jun 2019 23:19:50 +0200
Message-Id: <20190625211955.15664-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 25 Jun 2019 21:20:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/5] iotests: Selfish patches
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

Hi,

These are some rather selfish iotests patches.  The first patch helps me
personally because I tend to run the tests over SSH and forget to set
$DISPLAY.  That makes test 139 skip the tests annotated with
skip_if_unsupprted(), because iotests.py can no longer determine the
list of whitelisted formats.

Patches 2 through 5 are specifically for RHEL.  We have not whitelisted
null-aio, so it would be nice if tests didn=E2=80=99t require it.  Sorry,=
 I
don=E2=80=99t have a better reason to give.
In all seriousness, null-co is used widely in many tests, it basically
is our standard null driver.  Tests should prefer it over null-aio, just
for consistency alone.  It is not completely unreasonable to treat
null-aio as optional.  I guess.


v2:
- Allow tests to use the unittest module=E2=80=99s skipTest() so it is po=
ssible
  to skip a test case in the setUp() method (new patch 3).  Then use
  this in patches 4 and 5 to skip all null-aio cases instead of falling
  back to null-co and thus running tests twice.

- Patch 1 needed to be rebased on
  4a715461c8eab628e79b1e6889d650455e043b88
  (=E2=80=9Ctests/qemu-iotests/check: Pick a default machine if necessary=
=E2=80=9D)


git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/5:[0008] [FC] 'iotests: Add -display none to the qemu options'
002/5:[----] [--] 'iotests: Prefer null-co over null-aio'
003/5:[down] 'iotests: Allow skipping test cases'
004/5:[0007] [FC] 'iotests: Test driver whitelisting in 093'
005/5:[0007] [FC] 'iotests: Test driver whitelisting in 136'


Max Reitz (5):
  iotests: Add -display none to the qemu options
  iotests: Prefer null-co over null-aio
  iotests: Allow skipping test cases
  iotests: Test driver whitelisting in 093
  iotests: Test driver whitelisting in 136

 tests/qemu-iotests/093        | 21 ++++++++++++++-------
 tests/qemu-iotests/136        | 16 ++++++++++++----
 tests/qemu-iotests/245        |  2 +-
 tests/qemu-iotests/check      |  6 +++---
 tests/qemu-iotests/iotests.py | 20 ++++++++++++++++++--
 5 files changed, 48 insertions(+), 17 deletions(-)

--=20
2.21.0


