Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56BFC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867AE2173C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Rg2McVI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867AE2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVC38-0006Tg-HK
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 05:36:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hVC1G-0005IE-CA
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hVC1F-0004JI-5z
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:34:14 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:43838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1hVC1E-0004Ds-Rr
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:34:13 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::301])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id A60682E0D77;
	Mon, 27 May 2019 12:34:07 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net
	[2a02:6b8:0:1a2d::30])
	by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	MTcYoHEohe-Y7T4R1kD; Mon, 27 May 2019 12:34:07 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1558949647; bh=KoT/42fTCftwmyxvkchXYJktCH0HvQrO/0ta05NwHe8=;
	h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
	b=Rg2McVI4MXBCedCZ++mR5Yyt1WMPyhspxpPlZdjevkcd5K7Vyc4bovmp8WUSEMyHZ
	9AeMPNBtiPPk2pGqw3WTkVbRtLQwsWVoLp5f1M6H+eQUD5e9scy2GApeQgLcVJxJ4C
	CbJtSUv2wmL4rMsL3no5gGr9VHCPVZIGwxAMUdzE=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:c428:a8c1:9de0:d2bf])
	by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	ZkWW82ke0f-Y7lmKsvP; Mon, 27 May 2019 12:34:07 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 May 2019 12:33:49 +0300
Message-Id: <20190527093350.28567-2-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527093350.28567-1-yury-kotov@yandex-team.ru>
References: <20190527093350.28567-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a02:6b8:0:1619::183
Subject: [Qemu-devel] [PATCH 1/2] migration: Fix fd protocol for incoming
 defer
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, incoming migration through fd supports only command-line case:
E.g.
    fork();
    fd =3D open();
    exec("qemu ... -incoming fd:%d", fd);

It's possible to use add-fd commands to pass fd for migration, but it's
invalid case. add-fd works with fdset but not with particular fds.

To work with getfd in incoming defer it's enough to use monitor_fd_param
instead of strtol. monitor_fd_param supports both cases:
* fd:123
* fd:fd_name (added by getfd).

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/fd.c | 8 +++++---
 migration/fd.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index a7c13df4ad..0a29ecdebf 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -52,12 +52,14 @@ static gboolean fd_accept_incoming_migration(QIOChann=
el *ioc,
     return G_SOURCE_REMOVE;
 }
=20
-void fd_start_incoming_migration(const char *infd, Error **errp)
+void fd_start_incoming_migration(const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
-    int fd;
+    int fd =3D monitor_fd_param(cur_mon, fdname, errp);
+    if (fd =3D=3D -1) {
+        return;
+    }
=20
-    fd =3D strtol(infd, NULL, 0);
     trace_migration_fd_incoming(fd);
=20
     ioc =3D qio_channel_new_fd(fd, errp);
diff --git a/migration/fd.h b/migration/fd.h
index a14a63ce2e..b901bc014e 100644
--- a/migration/fd.h
+++ b/migration/fd.h
@@ -16,7 +16,7 @@
=20
 #ifndef QEMU_MIGRATION_FD_H
 #define QEMU_MIGRATION_FD_H
-void fd_start_incoming_migration(const char *path, Error **errp);
+void fd_start_incoming_migration(const char *fdname, Error **errp);
=20
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
                                  Error **errp);
--=20
2.21.0


