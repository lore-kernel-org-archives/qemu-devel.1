Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808D1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B7320870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="LAARk3nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B7320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5C9H-0008J4-C4
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i5BaD-0007S9-Ui
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i5BaA-00039j-VZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:03 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:42924)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i5BaA-00037g-DS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:02 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id C593F2E1A63;
 Tue,  3 Sep 2019 19:22:57 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 cGNnAwq6R9-MvvqSHIW; Tue, 03 Sep 2019 19:22:57 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1567527777; bh=KCUeoaNqnQu/WiD9KqkTvm8fZPyB8ZNH0dHpI5COUjs=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=LAARk3ncrGRyjRY1ldszKxusHbESjVoSOIqXteIiwZGEjK2j0jB8Y9Wx3LPkWPi2d
 xIo1wZb3K+HUwLjhtsTybYTDiLruIBEXOa1o8dpYeHi0xBR8S3yiNueDX3VUYOQvmY
 52nlBs1UKopRQ1NsBgZhAFJHQWBoz06N0lUDY9p0=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:c43c:5d37:585c:b5d6])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 YFfYaDvJaP-MufacASv; Tue, 03 Sep 2019 19:22:56 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Date: Tue,  3 Sep 2019 19:22:43 +0300
Message-Id: <20190903162246.18524-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
Subject: [Qemu-devel] [PATCH v2 0/3] UUID validation during migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

V2:
* Remove x- prefix from capability name
* Fix expected status checking
* Fix description of capability

This series adds an UUID validation at the start of the migration
on the target side. The idea is to identify the source of migration.

Possible case of problem:
1. There are 3 servers: A, B and C
2. Server A has a VM 1, server B has a VM 2
3. VM 1 and VM 2 want to migrate to the server C
4. Target of VM 1 starts on the server C and dies too quickly for some re=
ason
5. Target of VM 2 starts just after that and listen the same tcp port X, =
which
   the target of VM 1 wanted to use
6. Source of VM 1 connects to the tcp port X, and migrates to VM 2 source
7. It's possible that migration might be successful (e.g., devices are th=
e same)
8. So, the target of VM 2 is in undefined state

The series adds a capability to prevent successful (by mistake) migration=
.

The new capability validate-uuid only affects the source so that it sends
its UUID to the target. The target will validate the received UUID and st=
op
the migration if UUIDs are not equal.

Regards,
Yury

Yury Kotov (3):
  migration: Add validate-uuid capability
  tests/libqtest: Allow setting expected exit status
  tests/migration: Add a test for validate-uuid capability

 migration/migration.c  |   9 +++
 migration/migration.h  |   1 +
 migration/savevm.c     |  45 +++++++++++++
 qapi/migration.json    |   5 +-
 tests/libqtest.c       |  36 ++++++-----
 tests/libqtest.h       |   9 +++
 tests/migration-test.c | 140 ++++++++++++++++++++++++++++++++---------
 7 files changed, 199 insertions(+), 46 deletions(-)

--=20
2.17.1


