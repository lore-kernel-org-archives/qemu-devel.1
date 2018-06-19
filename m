Received: from eggs.gnu.org ([2001:4830:134:3::10]:56100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVINq-0007Zv-2K
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVINm-00019j-09
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:17:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVINl-00019Z-Qs
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:17:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7355287A4B
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 15:17:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 19 Jun 2018 16:17:19 +0100
Message-Id: <20180619151719.17002-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration: fix crash in when incoming client
 channel setup fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The way we determine if we can start the incoming migration was
changed to use migration_has_all_channels() in:

  commit 428d89084c709e568f9cd301c2f6416a54c53d6d
  Author: Juan Quintela <quintela@redhat.com>
  Date:   Mon Jul 24 13:06:25 2017 +0200

    migration: Create migration_has_all_channels

This method in turn calls multifd_recv_all_channels_created()
which is hardcoded to always return 'true' when multifd is
not in use.

This means that if channel initialization fails with normal
migration, it'll never notice and attempt to start the
incoming migration regardless.

This can be seen, for example, if a client connects to a server
requiring TLS, but has an invalid x509 certificate:

qemu-system-x86_64: The certificate hasn't got a known issuer
qemu-system-x86_64: migration/migration.c:386: process_incoming_migration=
_co: Assertion `mis->from_src_file' failed.

 #0  0x00007fffebd24f2b in raise () at /lib64/libc.so.6
 #1  0x00007fffebd0f561 in abort () at /lib64/libc.so.6
 #2  0x00007fffebd0f431 in _nl_load_domain.cold.0 () at /lib64/libc.so.6
 #3  0x00007fffebd1d692 in  () at /lib64/libc.so.6
 #4  0x0000555555ad027e in process_incoming_migration_co (opaque=3D<optim=
ized out>) at migration/migration.c:386
 #5  0x0000555555c45e8b in coroutine_trampoline (i0=3D<optimized out>, i1=
=3D<optimized out>) at util/coroutine-ucontext.c:116
 #6  0x00007fffebd3a6a0 in __start_context () at /lib64/libc.so.6
 #7  0x0000000000000000 in  ()

To handle the non-multifd case, we check whether mis->from_src_file
is non-NULL.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index e1eaa97df4..38ad818b23 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -518,11 +518,12 @@ void migration_ioc_process_incoming(QIOChannel *ioc=
)
  */
 bool migration_has_all_channels(void)
 {
+    MigrationIncomingState *mis =3D migration_incoming_get_current();
     bool all_channels;
=20
     all_channels =3D multifd_recv_all_channels_created();
=20
-    return all_channels;
+    return all_channels && mis->from_src_file !=3D NULL;
 }
=20
 /*
--=20
2.17.0
