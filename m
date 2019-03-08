Received: from eggs.gnu.org ([209.51.188.92]:49063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h2I26-00063U-H5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h2I25-0007P7-Sp
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:07:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1h2I25-0007OL-MH
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:07:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 886B7F3FAD
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 16:07:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Mar 2019 17:07:31 +0100
Message-Id: <20190308160731.23312-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration: fix small leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Spotted by ASAN, during make check.

Fixes: 9aca82ba3108d15529a2e0f5b0996cac309a7216 ("migration: Create
socket-address parameter")
Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/migration.h | 2 +-
 migration/migration.c | 2 +-
 migration/socket.c    | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 99e99e56bd..1b10b19a67 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -308,7 +308,7 @@ void migrate_send_rp_resume_ack(MigrationIncomingStat=
e *mis, uint32_t value);
=20
 void dirty_bitmap_mig_before_vm_start(void);
 void init_dirty_bitmap_incoming_migration(void);
-void migrate_add_address(SocketAddress *address);
+void migrate_add_address(const SocketAddress *address);
=20
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
=20
diff --git a/migration/migration.c b/migration/migration.c
index df6fd8e0e5..9cc2036796 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -335,7 +335,7 @@ void migration_incoming_enable_colo(void)
     migration_colo_enabled =3D true;
 }
=20
-void migrate_add_address(SocketAddress *address)
+void migrate_add_address(const SocketAddress *address)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
     SocketAddressList *addrs;
diff --git a/migration/socket.c b/migration/socket.c
index 239527fb1f..49bacf78fd 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -199,6 +199,7 @@ static void socket_start_incoming_migration(SocketAdd=
ress *saddr,
             return;
         }
         migrate_add_address(address);
+        qapi_free_SocketAddress(address);
     }
 }
=20
--=20
2.21.0.4.g36eb1cb9cf
