Received: from eggs.gnu.org ([2001:4830:134:3::10]:58461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNCy-0004NN-9F
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNCv-0000n1-Fi
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37844 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNCv-0000m6-BO
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00DBF40200A0
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:31 +0200
Message-Id: <20180509112406.6183-7-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/41] migration: Introduce
 multifd_recv_new_channel()
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
---
 migration/migration.c | 3 ++-
 migration/ram.c       | 6 ++++++
 migration/ram.h       | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 35f2781b03..4a7959c111 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -449,8 +449,9 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
     if (!mis->from_src_file) {
         QEMUFile *f =3D qemu_fopen_channel_input(ioc);
         migration_fd_process_incoming(f);
+        return;
     }
-    /* We still only have a single channel.  Nothing to do here yet */
+    multifd_recv_new_channel(ioc);
 }
=20
 /**
diff --git a/migration/ram.c b/migration/ram.c
index 4d8be30676..826172c342 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -36,6 +36,7 @@
 #include "xbzrle.h"
 #include "ram.h"
 #include "migration.h"
+#include "socket.h"
 #include "migration/register.h"
 #include "migration/misc.h"
 #include "qemu-file.h"
@@ -654,6 +655,11 @@ int multifd_load_setup(void)
     return 0;
 }
=20
+void multifd_recv_new_channel(QIOChannel *ioc)
+{
+    /* nothing to do yet */
+}
+
 /**
  * save_page_header: write page header to wire
  *
diff --git a/migration/ram.h b/migration/ram.h
index 5030be110a..06dbddc2a2 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -32,6 +32,7 @@
 #include "qemu-common.h"
 #include "qapi/qapi-types-migration.h"
 #include "exec/cpu-common.h"
+#include "io/channel.h"
=20
 extern MigrationStats ram_counters;
 extern XBZRLECacheStats xbzrle_counters;
@@ -44,6 +45,7 @@ int multifd_save_setup(void);
 int multifd_save_cleanup(Error **errp);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
+void multifd_recv_new_channel(QIOChannel *ioc);
=20
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_=
t len);
--=20
2.17.0
