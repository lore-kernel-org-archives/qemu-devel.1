Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EC1C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7529B2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7529B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39915 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYUYM-00071l-PJ
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 07:58:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hYUUQ-0003up-Ga
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hYUUM-0002rj-Sh
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:53:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hYUUL-0002mh-4s
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:53:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A35802F8BF3;
	Wed,  5 Jun 2019 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-241.ams2.redhat.com
	[10.36.116.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C14855D6A9;
	Wed,  5 Jun 2019 11:53:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 13:53:16 +0200
Message-Id: <20190605115318.9972-4-quintela@redhat.com>
In-Reply-To: <20190605115318.9972-1-quintela@redhat.com>
References: <20190605115318.9972-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 05 Jun 2019 11:53:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/5] migration: Fix fd protocol for incoming
 defer
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	Yury Kotov <yury-kotov@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yury Kotov <yury-kotov@yandex-team.ru>

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

And also the use of monitor_fd_param improves error messages.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
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


