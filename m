Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1ADC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4277F214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4277F214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwH9-0006Hc-0B
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iIwG2-0004us-Lh
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iIwG0-0007D2-UP
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iIwFw-0007AC-6Z; Fri, 11 Oct 2019 10:51:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD7893058359;
 Fri, 11 Oct 2019 14:50:58 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 898286017E;
 Fri, 11 Oct 2019 14:50:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH 0/5] Enable more iotests during "make check-block"
Date: Fri, 11 Oct 2019 16:50:42 +0200
Message-Id: <20191011145047.19051-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 11 Oct 2019 14:50:58 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As discussed here:

 https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg00697.html

and here:

 https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01388.html

it would be good to have some more valuable iotests enabled in the
"auto" group to get better iotest coverage during "make check".

And once Max' "iotests: Add and use $SOCK_DIR" patch series has been
merged, we can indeed enable these Python-based tests, too.

There is just one small downside: Since these tests require a QEMU
that features a 'virtio-blk' device, we cannot run the iotests
with binaries like qemu-system-tricore anymore. But since the iotests
were not very useful with such binaries anyway, I think it's ok now
if we skip them there.

Based-on: 20191010152457.17713-1-mreitz@redhat.com

John Snow (1):
  iotests: remove 'linux' from default supported platforms

Thomas Huth (4):
  iotests: Test 041 does not work on macOS
  iotests: Test 183 does not work on macOS and OpenBSD
  iotests: Skip "make check-block" if QEMU does not support virtio-blk
  iotests: Enable more tests in the 'auto' group to improve test
    coverage

 tests/check-block.sh          | 16 +++++++++++++++-
 tests/qemu-iotests/041        |  3 ++-
 tests/qemu-iotests/183        |  1 +
 tests/qemu-iotests/group      | 18 +++++++++---------
 tests/qemu-iotests/iotests.py | 16 +++++++++++-----
 5 files changed, 38 insertions(+), 16 deletions(-)

-- 
2.18.1


