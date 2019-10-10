Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975ABC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D7B214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D7B214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIaLf-0007rz-6V
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIaJO-0005j6-6O
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIaJM-0004GB-MW
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIaJJ-0004F5-P4; Thu, 10 Oct 2019 11:25:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC497316D8C2;
 Thu, 10 Oct 2019 15:25:00 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2520560852;
 Thu, 10 Oct 2019 15:24:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 00/23] iotests: Add and use $SOCK_DIR
Date: Thu, 10 Oct 2019 17:24:34 +0200
Message-Id: <20191010152457.17713-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 10 Oct 2019 15:25:00 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
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
 tests/qemu-iotests/check         | 17 ++++++++++++++++
 tests/qemu-iotests/common.filter |  7 +++++--
 tests/qemu-iotests/common.nbd    |  2 +-
 tests/qemu-iotests/iotests.py    | 16 ++++++++-------
 29 files changed, 107 insertions(+), 74 deletions(-)

--=20
2.21.0


