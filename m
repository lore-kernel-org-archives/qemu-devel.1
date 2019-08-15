Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA721C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB1F206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB1F206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyHqS-0007Fy-Eo
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hyHoA-0004kx-3Z
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hyHo6-0000Ni-TR
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hyHnw-0000Ke-K3; Thu, 15 Aug 2019 11:36:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1652A2A09DA;
 Thu, 15 Aug 2019 15:36:43 +0000 (UTC)
Received: from localhost (ovpn-204-81.brq.redhat.com [10.40.204.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11CBD69CAC;
 Thu, 15 Aug 2019 15:36:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 15 Aug 2019 17:36:31 +0200
Message-Id: <20190815153638.4600-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 15 Aug 2019 15:36:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/7] vmdk: Misc fixes
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I made the mistake of trying to run the iotests with all non-default
subformats our vmdk driver has to offer:
- monolithicFlat
- twoGbMaxExtentSparse
- twoGbMaxExtentFlat
- streamOptimized

Many things broke, so this series fixes what I found.  It=E2=80=99s mostl=
y just
iotest fixes, but there are actually two real fixes in here.


v2:
- Patch 2: Don=E2=80=99t treat extent filenames with protocol prefixes as
  absolute filenames =E2=80=93 this may be the right thing to do, but:
  (1) path_combine() doesn=E2=80=99t (it just ignores whether the suppose=
d
      relative filename has a potential protocol prefix), so this is how
      we handled it so far,
  (2) It would break other cases (when a filename contains a colon for
      no particular reason), as seen in iotest 126.
  That means you cannot have an extent file e.g. on an http server while
  the descriptor is on a local filesystem, but I hope nobody would ever
  want to do that.

- Patch 3: Fix paste-o [John]

- Patch 7: twoGbMaxExtentSparse works now with the change to patch 2, so
  we no longer have to mark it unsupported [Thanks for the insistent
  inquiry, John :-)]


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/7:[----] [--] 'iotests: Fix _filter_img_create()'
002/7:[0002] [FC] 'vmdk: Use bdrv_dirname() for relative extent paths'
003/7:[0002] [FC] 'iotests: Keep testing broken relative extent paths'
004/7:[----] [--] 'vmdk: Reject invalid compressed writes'
005/7:[----] [--] 'iotests: Disable broken streamOptimized tests'
006/7:[----] [--] 'iotests: Disable 110 for vmdk.twoGbMaxExtentSparse'
007/7:[0006] [FC] 'iotests: Disable 126 for some vmdk subformats'


Max Reitz (7):
  iotests: Fix _filter_img_create()
  vmdk: Use bdrv_dirname() for relative extent paths
  iotests: Keep testing broken relative extent paths
  vmdk: Reject invalid compressed writes
  iotests: Disable broken streamOptimized tests
  iotests: Disable 110 for vmdk.twoGbMaxExtentSparse
  iotests: Disable 126 for flat vmdk subformats

 block/vmdk.c                     | 64 ++++++++++++++++++++++----------
 tests/qemu-iotests/002           |  1 +
 tests/qemu-iotests/003           |  1 +
 tests/qemu-iotests/005           |  3 +-
 tests/qemu-iotests/009           |  1 +
 tests/qemu-iotests/010           |  1 +
 tests/qemu-iotests/011           |  1 +
 tests/qemu-iotests/017           |  3 +-
 tests/qemu-iotests/018           |  3 +-
 tests/qemu-iotests/019           |  3 +-
 tests/qemu-iotests/020           |  3 +-
 tests/qemu-iotests/027           |  1 +
 tests/qemu-iotests/032           |  1 +
 tests/qemu-iotests/033           |  1 +
 tests/qemu-iotests/034           |  3 +-
 tests/qemu-iotests/037           |  3 +-
 tests/qemu-iotests/059           | 34 ++++++++++++++++-
 tests/qemu-iotests/059.out       | 24 +++++++-----
 tests/qemu-iotests/063           |  3 +-
 tests/qemu-iotests/072           |  1 +
 tests/qemu-iotests/105           |  3 +-
 tests/qemu-iotests/110           |  3 +-
 tests/qemu-iotests/126           |  2 +
 tests/qemu-iotests/197           |  1 +
 tests/qemu-iotests/215           |  1 +
 tests/qemu-iotests/251           |  1 +
 tests/qemu-iotests/common.filter |  4 +-
 27 files changed, 127 insertions(+), 43 deletions(-)

--=20
2.21.0


