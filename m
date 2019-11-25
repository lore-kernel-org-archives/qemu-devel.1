Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC6C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60640207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="KRVQGv/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60640207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEaP-0000nU-Cv
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1iZEXt-00084h-0L
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1iZEXq-0006uQ-0R
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:36:50 -0500
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:33210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1iZEXp-0006tG-E9
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:36:49 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id EB5672E0DE7;
 Mon, 25 Nov 2019 16:36:43 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net
 (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 PU0MfHJQtw-ahTu8wpR; Mon, 25 Nov 2019 16:36:43 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1574689003; bh=aoBtHArJpFwmHCpsXY9yY1bxvicpSwutbokjRF5oxLw=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=KRVQGv/Edd2sRax95/v6riJp/7YwQDnER6tADXujT+TsL+fe9jl+amEuJ6zWuutV3
 SeWADCSirNWs8mCiflKpQ71c1zKOnjeltAtEuutO7IwZfm/3bvjuISfybHDGv+YkVo
 6d12aWiFomAeggB/gea0qQMcaTKcQafD/IbPZz1A=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:bc57:f91d:ee50:9634])
 by vla1-5826f599457c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 V5h9BV3y9q-ahWa8dRZ; Mon, 25 Nov 2019 16:36:43 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2] migration/ram: Yield periodically to the main loop
Date: Mon, 25 Nov 2019 16:36:32 +0300
Message-Id: <20191125133632.21387-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yc-core@yandex-team.ru,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Usually, incoming migration coroutine yields to the main loop
while its IO-channel is waiting for data to receive. But there is a case
when RAM migration and data receive have the same speed: VM with huge
zeroed RAM. In this case, IO-channel won't read and thus the main loop
is stuck and for instance, it doesn't respond to QMP commands.

For this case, yield periodically, but not too often, so as not to
affect the speed of migration.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/ram.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5078f94490..9694ee7a0b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4227,7 +4227,7 @@ static void colo_flush_ram_cache(void)
  */
 static int ram_load_precopy(QEMUFile *f)
 {
-    int flags =3D 0, ret =3D 0, invalid_flags =3D 0, len =3D 0;
+    int flags =3D 0, ret =3D 0, invalid_flags =3D 0, len =3D 0, i =3D 0;
     /* ADVISE is earlier, it shows the source has the postcopy capabilit=
y on */
     bool postcopy_advised =3D postcopy_is_advised();
     if (!migrate_use_compression()) {
@@ -4239,6 +4239,17 @@ static int ram_load_precopy(QEMUFile *f)
         void *host =3D NULL;
         uint8_t ch;
=20
+        /*
+         * Yield periodically to let main loop run, but an iteration of
+         * the main loop is expensive, so do it each some iterations
+         */
+        if ((i & 32767) =3D=3D 0 && qemu_in_coroutine()) {
+            aio_co_schedule(qemu_get_current_aio_context(),
+                            qemu_coroutine_self());
+            qemu_coroutine_yield();
+        }
+        i++;
+
         addr =3D qemu_get_be64(f);
         flags =3D addr & ~TARGET_PAGE_MASK;
         addr &=3D TARGET_PAGE_MASK;
--=20
2.24.0


