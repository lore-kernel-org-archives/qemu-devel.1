Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51068ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227C720820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227C720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6mF-0003Yu-Nz
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iL5ss-00024D-TM
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iL5sr-0003G8-FS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:32:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iL5sk-0003EG-HK; Thu, 17 Oct 2019 09:31:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF7B518C4287;
 Thu, 17 Oct 2019 13:31:57 +0000 (UTC)
Received: from localhost (ovpn-117-3.ams2.redhat.com [10.36.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A73519C70;
 Thu, 17 Oct 2019 13:31:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 00/23] iotests: Add and use $SOCK_DIR
Date: Thu, 17 Oct 2019 15:31:32 +0200
Message-Id: <20191017133155.5327-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 17 Oct 2019 13:31:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Perhaps the main reason we cannot run important tests such as 041 in CI
is that when they care Unix sockets in $TEST_DIR, the path may become
too long to connect to them.

To get by this problem, this series lets the check script create a new
temporary directory (mktemp -d) and then makes the iotests use it for
all Unix sockets.


v2:
- Patch 1: Use mkdir -p
- Patches 4/23: Only add the $SOCK_DIR replacement line in patch 4 and
                only drop the $TEST_DIR line in patch 23
  (Took Eric=E2=80=99s R-b on both because that=E2=80=99s how I interpret=
ed his
  comments)


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/23:[0010] [FC] 'iotests: Introduce $SOCK_DIR'
002/23:[----] [--] 'iotests.py: Store socket files in $SOCK_DIR'
003/23:[----] [--] 'iotests.py: Add @base_dir to FilePaths etc.'
004/23:[0002] [FC] 'iotests: Filter $SOCK_DIR'
005/23:[----] [--] 'iotests: Let common.nbd create socket in $SOCK_DIR'
006/23:[----] [--] 'iotests/083: Create socket in $SOCK_DIR'
007/23:[----] [--] 'iotests/140: Create socket in $SOCK_DIR'
008/23:[----] [--] 'iotests/143: Create socket in $SOCK_DIR'
009/23:[----] [--] 'iotests/147: Create socket in $SOCK_DIR'
010/23:[----] [--] 'iotests/181: Create socket in $SOCK_DIR'
011/23:[----] [--] 'iotests/182: Create socket in $SOCK_DIR'
012/23:[----] [--] 'iotests/183: Create socket in $SOCK_DIR'
013/23:[----] [--] 'iotests/192: Create socket in $SOCK_DIR'
014/23:[----] [--] 'iotests/194: Create sockets in $SOCK_DIR'
015/23:[----] [--] 'iotests/201: Create socket in $SOCK_DIR'
016/23:[----] [--] 'iotests/205: Create socket in $SOCK_DIR'
017/23:[----] [--] 'iotests/208: Create socket in $SOCK_DIR'
018/23:[----] [--] 'iotests/209: Create socket in $SOCK_DIR'
019/23:[----] [--] 'iotests/222: Create socket in $SOCK_DIR'
020/23:[----] [--] 'iotests/223: Create socket in $SOCK_DIR'
021/23:[----] [--] 'iotests/240: Create socket in $SOCK_DIR'
022/23:[----] [--] 'iotests/267: Create socket in $SOCK_DIR'
023/23:[0002] [FC] 'iotests: Drop TEST_DIR filter from _filter_nbd'


Max Reitz (23):
  iotests: Introduce $SOCK_DIR
  iotests.py: Store socket files in $SOCK_DIR
  iotests.py: Add @base_dir to FilePaths etc.
  iotests: Filter $SOCK_DIR
  iotests: Let common.nbd create socket in $SOCK_DIR
  iotests/083: Create socket in $SOCK_DIR
  iotests/140: Create socket in $SOCK_DIR
  iotests/143: Create socket in $SOCK_DIR
  iotests/147: Create socket in $SOCK_DIR
  iotests/181: Create socket in $SOCK_DIR
  iotests/182: Create socket in $SOCK_DIR
  iotests/183: Create socket in $SOCK_DIR
  iotests/192: Create socket in $SOCK_DIR
  iotests/194: Create sockets in $SOCK_DIR
  iotests/201: Create socket in $SOCK_DIR
  iotests/205: Create socket in $SOCK_DIR
  iotests/208: Create socket in $SOCK_DIR
  iotests/209: Create socket in $SOCK_DIR
  iotests/222: Create socket in $SOCK_DIR
  iotests/223: Create socket in $SOCK_DIR
  iotests/240: Create socket in $SOCK_DIR
  iotests/267: Create socket in $SOCK_DIR
  iotests: Drop TEST_DIR filter from _filter_nbd

 python/qemu/machine.py           | 15 +++++++++++---
 python/qemu/qtest.py             |  9 ++++++---
 tests/qemu-iotests/083           |  6 +++---
 tests/qemu-iotests/083.out       | 34 ++++++++++++++++----------------
 tests/qemu-iotests/140           |  8 ++++----
 tests/qemu-iotests/140.out       |  2 +-
 tests/qemu-iotests/143           |  6 +++---
 tests/qemu-iotests/143.out       |  2 +-
 tests/qemu-iotests/147           |  2 +-
 tests/qemu-iotests/181           |  2 +-
 tests/qemu-iotests/182           |  4 ++--
 tests/qemu-iotests/183           |  2 +-
 tests/qemu-iotests/192           |  4 ++--
 tests/qemu-iotests/192.out       |  2 +-
 tests/qemu-iotests/194           |  4 ++--
 tests/qemu-iotests/201           |  2 +-
 tests/qemu-iotests/205           |  2 +-
 tests/qemu-iotests/208           |  2 +-
 tests/qemu-iotests/209           |  3 ++-
 tests/qemu-iotests/222           |  2 +-
 tests/qemu-iotests/223           | 14 ++++++-------
 tests/qemu-iotests/240           |  4 ++--
 tests/qemu-iotests/241           |  2 --
 tests/qemu-iotests/267           |  4 ++--
 tests/qemu-iotests/267.out       |  2 +-
 tests/qemu-iotests/check         | 15 ++++++++++++--
 tests/qemu-iotests/common.filter |  7 +++++--
 tests/qemu-iotests/common.nbd    |  2 +-
 tests/qemu-iotests/iotests.py    | 16 ++++++++-------
 29 files changed, 103 insertions(+), 76 deletions(-)

--=20
2.21.0


