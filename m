Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B35C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CCC2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="G1FXis1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CCC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35541 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvCy-0007SC-U1
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:23:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAt-00067C-Ry
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAs-000716-Sz
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:55 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:38406)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAs-0006zQ-Et
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:54 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id A4EA92E1492;
	Fri, 12 Apr 2019 15:20:51 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
	[2a02:6b8:0:1472:2741:0:8b6:10])
	by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	yEKrHqEP7I-KpMSx8Gh; Fri, 12 Apr 2019 15:20:51 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555071651; bh=X5GmXqb1cHMB9+SLJFdxNHUQLC1wO/RQ408daMmcNII=;
	h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
	b=G1FXis1JNaL87fH98myOLMYLAjuGzP6L6oow0QuX98QOsX+IS//oChKacPzy2E1Om
	e6sClb7vZOMhv24lILwi0OdzcMQ8JiWygs8tR7+v73LhJvDEAKCOY1ECauBqbCeSCz
	e8ec9Gg0tbzGQ4uBvfDxwg1+38ZT7lnxBljzqbeE=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:3404:6cb5:5ab:ed68])
	by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	m4LakqlT7Q-Ko0WmlCv; Fri, 12 Apr 2019 15:20:50 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Apr 2019 15:20:26 +0300
Message-Id: <20190412122028.7067-2-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
References: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
Subject: [Qemu-devel] [PATCH 1/3] monitor: Add monitor_recv_fd function to
 work with sent fds
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
	yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122026.7msBrLhDUPU_gDNh7tHhLHg4msq4LyBm_6_oRxb2p34@z>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 include/monitor/monitor.h |  1 +
 monitor.c                 | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c1b40a9cac..9b9e593fb3 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -25,6 +25,7 @@ void monitor_cleanup(void);
 int monitor_suspend(Monitor *mon);
 void monitor_resume(Monitor *mon);
=20
+int monitor_recv_fd(Monitor *mon, Error **errp);
 int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp);
 int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
=20
diff --git a/monitor.c b/monitor.c
index 4807bbe811..3ebbc08e5c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2206,9 +2206,8 @@ void qmp_getfd(const char *fdname, Error **errp)
     mon_fd_t *monfd;
     int fd, tmp_fd;
=20
-    fd =3D qemu_chr_fe_get_msgfd(&cur_mon->chr);
+    fd =3D monitor_recv_fd(cur_mon, errp);
     if (fd =3D=3D -1) {
-        error_setg(errp, QERR_FD_NOT_SUPPLIED);
         return;
     }
=20
@@ -2266,6 +2265,15 @@ void qmp_closefd(const char *fdname, Error **errp)
     error_setg(errp, QERR_FD_NOT_FOUND, fdname);
 }
=20
+int monitor_recv_fd(Monitor *mon, Error **errp)
+{
+    int fd =3D qemu_chr_fe_get_msgfd(&cur_mon->chr);
+    if (fd =3D=3D -1) {
+        error_setg(errp, QERR_FD_NOT_SUPPLIED);
+    }
+    return fd;
+}
+
 int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
@@ -2335,9 +2343,8 @@ AddfdInfo *qmp_add_fd(bool has_fdset_id, int64_t fd=
set_id, bool has_opaque,
     Monitor *mon =3D cur_mon;
     AddfdInfo *fdinfo;
=20
-    fd =3D qemu_chr_fe_get_msgfd(&mon->chr);
+    fd =3D monitor_recv_fd(mon, errp);
     if (fd =3D=3D -1) {
-        error_setg(errp, QERR_FD_NOT_SUPPLIED);
         goto error;
     }
=20
--=20
2.21.0


