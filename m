Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56117C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19BA2064A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19BA2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49380 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHjp-0006bp-Pp
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48883)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hZGi5-0005V2-78
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hZGi4-0006ZC-1o
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:23:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52647)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hZGi3-0006Xx-Se
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:23:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D4F822386B;
 Fri,  7 Jun 2019 15:23:02 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-62.rdu2.redhat.com
 [10.10.122.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2110E842B8;
 Fri,  7 Jun 2019 15:23:00 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 11:22:23 -0400
Message-Id: <20190607152223.9467-9-crosa@redhat.com>
In-Reply-To: <20190607152223.9467-1-crosa@redhat.com>
References: <20190607152223.9467-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 15:23:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 8/8] Migration acceptance test: reduce the
 possibility of port collisions
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The avocado.utils.network.find_free_port() will by default attempt
to return the first port given in the range, if it seems to be
available.

Let's reduce the probability of collisions by picking a random port
by default.

As a side note, this behavior has changed in a recent Avocado version,
and the default use will then be equivalent to this proposed change.

Reference: https://avocado-framework.readthedocs.io/en/68.0/api/utils/avo=
cado.utils.html#avocado.utils.network.find_free_port
Reference: https://github.com/avocado-framework/avocado/commit/f232e4505f=
7cfefc513449e0b97790b517275da7
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/migration.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
index a44c1ae58f..b2a5767348 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -25,7 +25,7 @@ class Migration(Test):
         return vm.command('query-migrate')['status'] in ('completed', 'f=
ailed')
=20
     def _get_free_port(self):
-        port =3D network.find_free_port()
+        port =3D network.find_free_port(sequent=3DFalse)
         if port is None:
             self.cancel('Failed to find a free port')
         return port
--=20
2.21.0


