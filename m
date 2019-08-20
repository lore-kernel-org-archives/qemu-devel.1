Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619CAC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 23:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325A3206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 23:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325A3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Dy2-00057G-LL
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 19:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i0Dvo-0002Rv-2s
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 19:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i0Dvm-00051J-MK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 19:52:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i0Dvk-0004yi-1Q; Tue, 20 Aug 2019 19:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 611F0C06511B;
 Tue, 20 Aug 2019 23:52:47 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41D2F2C8DC;
 Tue, 20 Aug 2019 23:52:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 19:52:39 -0400
Message-Id: <20190820235243.26092-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 20 Aug 2019 23:52:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/4] iotests: use python logging
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
 ehabkost@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series uses python logging to enable output conditionally on
iotests.log(). We unify an initialization call (which also enables
debugging output for those tests with -d) and then make the switch
inside of iotests.

It will help alleviate the need to create logged/unlogged versions
of all the various helpers we have made.

V3:
 - Rebased for 4.1+; now based on main branch.

V2:
 - Added all of the other python tests I missed to use script_initialize
 - Refactored the common setup as per Ehabkost's suggestion
 - Added protocol arguments to common initialization,
   but this isn't strictly required.

John Snow (4):
  iotests: add script_initialize
  iotest 258: use script_main
  iotests: add protocol support to initialization info
  iotests: use python logging for iotests.log()

 tests/qemu-iotests/030        |   4 +-
 tests/qemu-iotests/149        |   3 +-
 tests/qemu-iotests/194        |   3 +-
 tests/qemu-iotests/202        |   3 +-
 tests/qemu-iotests/203        |   3 +-
 tests/qemu-iotests/206        |   2 +-
 tests/qemu-iotests/207        |   4 +-
 tests/qemu-iotests/208        |   2 +-
 tests/qemu-iotests/209        |   2 +-
 tests/qemu-iotests/210        |   4 +-
 tests/qemu-iotests/211        |   4 +-
 tests/qemu-iotests/212        |   4 +-
 tests/qemu-iotests/213        |   4 +-
 tests/qemu-iotests/216        |   3 +-
 tests/qemu-iotests/218        |   2 +-
 tests/qemu-iotests/219        |   2 +-
 tests/qemu-iotests/222        |   5 +-
 tests/qemu-iotests/224        |   3 +-
 tests/qemu-iotests/228        |   3 +-
 tests/qemu-iotests/234        |   3 +-
 tests/qemu-iotests/235        |   4 +-
 tests/qemu-iotests/236        |   2 +-
 tests/qemu-iotests/237        |   2 +-
 tests/qemu-iotests/238        |   2 +
 tests/qemu-iotests/242        |   2 +-
 tests/qemu-iotests/245        |   1 +
 tests/qemu-iotests/245.out    |  24 ++++----
 tests/qemu-iotests/246        |   2 +-
 tests/qemu-iotests/248        |   2 +-
 tests/qemu-iotests/254        |   2 +-
 tests/qemu-iotests/255        |   2 +-
 tests/qemu-iotests/256        |   2 +-
 tests/qemu-iotests/258        |   8 +--
 tests/qemu-iotests/262        |   3 +-
 tests/qemu-iotests/iotests.py | 108 ++++++++++++++++++++++------------
 35 files changed, 124 insertions(+), 105 deletions(-)

--=20
2.21.0


