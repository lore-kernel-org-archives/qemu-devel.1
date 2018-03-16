Received: from eggs.gnu.org ([2001:4830:134:3::10]:59054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwE-0006dq-5q
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwA-0002WY-4u
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwA-0002W7-1B
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2ACEC401CC41
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:53:50 +0100
Message-Id: <20180316115403.4148-3-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 02/15] migration: In case of error just end
 the migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

--

As requested, just continue connection in case of error.
---
 migration/socket.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index 52db0c0c09..8dda1d9a98 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -140,9 +140,7 @@ static gboolean socket_accept_incoming_migration(QIOC=
hannel *ioc,
     sioc =3D qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
                                      &err);
     if (!sioc) {
-        error_report("could not accept migration connection (%s)",
-                     error_get_pretty(err));
-        goto out;
+        return G_SOURCE_CONTINUE;
     }
=20
     trace_migration_socket_incoming_accepted();
@@ -151,7 +149,6 @@ static gboolean socket_accept_incoming_migration(QIOC=
hannel *ioc,
     migration_channel_process_incoming(QIO_CHANNEL(sioc));
     object_unref(OBJECT(sioc));
=20
-out:
     if (migration_has_all_channels()) {
         /* Close listening socket as its no longer needed */
         qio_channel_close(ioc, NULL);
--=20
2.14.3
