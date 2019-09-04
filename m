Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81387C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 23:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5362B2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 23:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5362B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5efE-0005t2-BT
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 19:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i5ee5-0005MQ-UD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 19:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i5ee3-0006pm-BI
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 19:25:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1i5ee3-0006mS-2t
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 19:24:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C20B33090FD1;
 Wed,  4 Sep 2019 23:24:56 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-203.bos.redhat.com [10.18.17.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3E475D70D;
 Wed,  4 Sep 2019 23:24:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 19:24:51 -0400
Message-Id: <20190904232451.26466-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 04 Sep 2019 23:24:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests/docker: Use --userns=keep-id for podman
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
Cc: Fam Zheng <fam@euphon.net>, mlureau@redhat.com,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The workaround that attempts to accomplish the same result as --userns=3D=
keep-id
does not appear to work well with UIDs much above 1000 (like mine, which =
is
above 20000.)

Since we have official support for this "trick" now, use the supported me=
thod.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/docker.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index ac5baab4ca..fe17d5f709 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -368,9 +368,7 @@ class RunCommand(SubCommand):
             argv =3D [ "-u", str(uid) ] + argv
             docker =3D Docker()
             if docker._command[0] =3D=3D "podman":
-                argv =3D [ "--uidmap", "%d:0:1" % uid,
-                         "--uidmap", "0:1:%d" % uid,
-                         "--uidmap", "%d:%d:64536" % (uid + 1, uid + 1)]=
 + argv
+                argv.insert(0, '--userns=3Dkeep-id')
         return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
=20
=20
--=20
2.21.0


