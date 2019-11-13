Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65557C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E471206CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="HUhjHgE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E471206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUwqQ-0001SV-DZ
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 12:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1iUwpo-00010u-PP
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1iUwpl-0004zW-Sz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:53:38 -0500
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:54942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1iUwpl-0004xD-Cy
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:53:37 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id DBF6A2E1332;
 Wed, 13 Nov 2019 20:53:31 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net
 (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 5LGN0FAm7r-rU48nnAI; Wed, 13 Nov 2019 20:53:31 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1573667611; bh=kiaYtEDJRHAH27d5egZ84LWQurvEf0kKTPc7W4M1eAM=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=HUhjHgE2dAdfkHTFkt/i2PIdyNJctZWLbwethLJ47roPGUmzwcmtKepLpaxvUySq1
 mhVkanN4WtDaC1CN8nknqEeqg+BCXmFbfS1PBh2EDIsoRH81JQG6AwOnwwiM+SUrfr
 YqFCSbva66WSvoToXLIIxYpp+Oyr6ntm5vDPEHQg=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:9c6c:1931:9853:bdc5])
 by vla1-5826f599457c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 nN38Y7fY7i-rUVa6qpD; Wed, 13 Nov 2019 20:53:30 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH] migration: Fix the re-run check of the migrate-incoming
 command
Date: Wed, 13 Nov 2019 20:53:25 +0300
Message-Id: <20191113175325.29765-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1619::183
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

The current check sets an error but doesn't fail the command.
This may cause a problem if new connection attempt by the same URI
affects the first connection.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index 354ad072fa..fa2005b49f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1784,6 +1784,7 @@ void qmp_migrate_incoming(const char *uri, Error **=
errp)
     }
     if (!once) {
         error_setg(errp, "The incoming migration has already been starte=
d");
+        return;
     }
=20
     qemu_start_incoming_migration(uri, &local_err);
--=20
2.24.0


