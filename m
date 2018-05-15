Received: from eggs.gnu.org ([2001:4830:134:3::10]:58533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjZE-0003d9-TQ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjZC-00023x-DU
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56530 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjZC-00023h-8b
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA94D40201A1
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:41:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:40:17 +0200
Message-Id: <20180515234017.2277-41-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/40] Migration+TLS: Fix crash due to double
 cleanup
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

During a TLS connect we see:
  migration_channel_connect calls
  migration_tls_channel_connect
  (calls after TLS setup)
  migration_channel_connect

My previous error handling fix made migration_channel_connect
call migrate_fd_connect in all cases; unfortunately the above
means it gets called twice and crashes doing double cleanup.

Fixes: 688a3dcba98

Reported-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180430185943.35714-1-dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/channel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/channel.c b/migration/channel.c
index 716192bf75..33e0e9b82f 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -71,6 +71,15 @@ void migration_channel_connect(MigrationState *s,
             !object_dynamic_cast(OBJECT(ioc),
                                  TYPE_QIO_CHANNEL_TLS)) {
             migration_tls_channel_connect(s, ioc, hostname, &error);
+
+            if (!error) {
+                /* tls_channel_connect will call back to this
+                 * function after the TLS handshake,
+                 * so we mustn't call migrate_fd_connect until then
+                 */
+
+                return;
+            }
         } else {
             QEMUFile *f =3D qemu_fopen_channel_output(ioc);
=20
--=20
2.17.0
