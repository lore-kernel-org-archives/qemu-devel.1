Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C0C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 22:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED20218B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 22:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED20218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr95x-0007Bl-Kc
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 18:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54857)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hr95m-0006nc-PR
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 18:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hr95V-0000mA-TE
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 18:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hr95D-0000PX-0X; Fri, 26 Jul 2019 18:53:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC8C5308338F;
 Fri, 26 Jul 2019 22:52:04 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-211.bos.redhat.com [10.18.17.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC5CA6012D;
 Fri, 26 Jul 2019 22:52:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 26 Jul 2019 18:51:59 -0400
Message-Id: <20190726225201.10561-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 26 Jul 2019 22:52:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] iotests: use python logging
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

Based-on: https://github.com/jnsnow/qemu/tree/bitmaps

This is a quick hack-em-up of what it might look like to use python
logging to enable output conditionally on iotests.log(). We unify an
initialization call (which also enables debugging output for those tests
with -d) and then make the switch inside of iotests.

It might help with needing to add logged/unlogged versions.

Depends on my bitmaps branch, because of the iotests refactoring I have
done there.

John Snow (2):
  iotests: add script_initialize
  iotests: use python logging for iotests.log()

 tests/qemu-iotests/030        |  4 +--
 tests/qemu-iotests/149        |  3 +-
 tests/qemu-iotests/194        |  3 +-
 tests/qemu-iotests/202        |  3 +-
 tests/qemu-iotests/203        |  3 +-
 tests/qemu-iotests/206        |  2 +-
 tests/qemu-iotests/208        |  2 +-
 tests/qemu-iotests/216        |  3 +-
 tests/qemu-iotests/218        |  2 +-
 tests/qemu-iotests/219        |  2 +-
 tests/qemu-iotests/222        |  5 ++-
 tests/qemu-iotests/224        |  3 +-
 tests/qemu-iotests/228        |  3 +-
 tests/qemu-iotests/234        |  3 +-
 tests/qemu-iotests/235        |  4 +--
 tests/qemu-iotests/236        |  2 +-
 tests/qemu-iotests/238        |  2 ++
 tests/qemu-iotests/242        |  2 +-
 tests/qemu-iotests/245        |  1 +
 tests/qemu-iotests/245.out    | 24 ++++++-------
 tests/qemu-iotests/246        |  2 +-
 tests/qemu-iotests/248        |  2 +-
 tests/qemu-iotests/254        |  2 +-
 tests/qemu-iotests/255        |  2 +-
 tests/qemu-iotests/256        |  2 +-
 tests/qemu-iotests/iotests.py | 67 ++++++++++++++++++++++-------------
 26 files changed, 83 insertions(+), 70 deletions(-)

--=20
2.21.0


