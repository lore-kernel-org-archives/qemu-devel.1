Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9EFC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 09:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01E4217D6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 09:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="VCbfWikv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01E4217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56367 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE9WO-0000EE-JL
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 05:27:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hE9VZ-0008Kv-6X
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hE9VY-00014A-5q
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:27:05 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:38784)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hE9VX-0000xk-G2
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:27:04 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 441122E1512;
	Wed, 10 Apr 2019 12:26:59 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net
	[2a02:6b8:0:1a2d::30])
	by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	2yLQePubGh-QwMqtOd1; Wed, 10 Apr 2019 12:26:59 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1554888419; bh=qzVUe+kFoue1PLwKTfFPiIOFXUwUUgzArHlxHpLVHgc=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=VCbfWikvBVL0wXcHp5Jm9saEbV74OQsrZdVFhsmQuXKJfRvY7gGENyZv/vuu5VADM
	gJLXSJZuprOs900ZwmHrscKpFDYnUnwIyyAoPI2LC0MCkHevMjouYtOiHcIaFiqEMp
	265tSwqkxvZrwfdxgYP/tQa4Cn8sTxh+z/23G1/U=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:1c6a:cfcd:3ad6:4876])
	by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	4IllViJHpG-QwYeQP9I; Wed, 10 Apr 2019 12:26:58 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Apr 2019 12:26:52 +0300
Message-Id: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a02:6b8:0:1619::183
Subject: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410092652.4nFQyo97XngUWfuefOdbsr5Y_9vtQGy_EIWBdAUvV8c@z>

Currently such case is possible for incoming:
QMP: add-fd (fdset =3D 0, fd of some file):
    adds fd to fdset 0 and returns QEMU's fd (e.g. 33)
QMP: migrate-incoming (uri =3D "fd:33"): fd is stored in QIOChannel *ioc
...
Incoming migration completes and unrefs ioc -> close(33)
QMP: remove-fd (fdset =3D 0, fd =3D 33):
    removes fd from fdset 0 and qemu_close() -> close(33) =3D> double clo=
se

For outgoing migration the case is the same but getfd instead of add-fd.
Fix it by duping client's fd.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/fd.c         | 39 +++++++++++++++++++++++++++++++--------
 migration/trace-events |  4 ++--
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index a7c13df4ad..c9ff07ac41 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -15,6 +15,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "channel.h"
 #include "fd.h"
 #include "migration.h"
@@ -26,15 +27,27 @@
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, =
Error **errp)
 {
     QIOChannel *ioc;
-    int fd =3D monitor_get_fd(cur_mon, fdname, errp);
+    int fd, dup_fd;
+
+    fd =3D monitor_get_fd(cur_mon, fdname, errp);
     if (fd =3D=3D -1) {
         return;
     }
=20
-    trace_migration_fd_outgoing(fd);
-    ioc =3D qio_channel_new_fd(fd, errp);
+    /* fd is previously created by qmp command 'getfd',
+     * so client is responsible to close it. Dup it to save original val=
ue from
+     * QIOChannel's destructor */
+    dup_fd =3D qemu_dup(fd);
+    if (dup_fd =3D=3D -1) {
+        error_setg(errp, "Cannot dup fd %s: %s (%d)", fdname, strerror(e=
rrno),
+                   errno);
+        return;
+    }
+
+    trace_migration_fd_outgoing(fd, dup_fd);
+    ioc =3D qio_channel_new_fd(dup_fd, errp);
     if (!ioc) {
-        close(fd);
+        close(dup_fd);
         return;
     }
=20
@@ -55,14 +68,24 @@ static gboolean fd_accept_incoming_migration(QIOChann=
el *ioc,
 void fd_start_incoming_migration(const char *infd, Error **errp)
 {
     QIOChannel *ioc;
-    int fd;
+    int fd, dup_fd;
=20
     fd =3D strtol(infd, NULL, 0);
-    trace_migration_fd_incoming(fd);
=20
-    ioc =3D qio_channel_new_fd(fd, errp);
+    /* fd is previously created by qmp command 'add-fd' or something els=
e,
+     * so client is responsible to close it. Dup it to save original val=
ue from
+     * QIOChannel's destructor */
+    dup_fd =3D qemu_dup(fd);
+    if (dup_fd =3D=3D -1) {
+        error_setg(errp, "Cannot dup fd %d: %s (%d)", fd, strerror(errno=
),
+                   errno);
+        return;
+    }
+
+    trace_migration_fd_incoming(fd, dup_fd);
+    ioc =3D qio_channel_new_fd(dup_fd, errp);
     if (!ioc) {
-        close(fd);
+        close(dup_fd);
         return;
     }
=20
diff --git a/migration/trace-events b/migration/trace-events
index de2e136e57..d2d30a6b3c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -258,8 +258,8 @@ migration_exec_outgoing(const char *cmd) "cmd=3D%s"
 migration_exec_incoming(const char *cmd) "cmd=3D%s"
=20
 # fd.c
-migration_fd_outgoing(int fd) "fd=3D%d"
-migration_fd_incoming(int fd) "fd=3D%d"
+migration_fd_outgoing(int fd, int dup_fd) "fd=3D%d dup_fd=3D%d"
+migration_fd_incoming(int fd, int dup_fd) "fd=3D%d dup_fd=3D%d"
=20
 # socket.c
 migration_socket_incoming_accepted(void) ""
--=20
2.21.0


