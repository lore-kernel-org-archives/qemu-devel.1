Received: from eggs.gnu.org ([2001:4830:134:3::10]:34035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaD-0002h4-1Y
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaC-0004nw-86
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fBIaC-0004n9-4V
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B51C0402290A
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:27:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Apr 2018 13:27:06 +0200
Message-Id: <20180425112723.1111-5-quintela@redhat.com>
In-Reply-To: <20180425112723.1111-1-quintela@redhat.com>
References: <20180425112723.1111-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 04/21] migration: Be sure all recv channels
 are created
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

We need them before we start migration.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 migration/migration.c |  6 +++++-
 migration/ram.c       | 11 +++++++++++
 migration/ram.h       |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 604722cec9..98f85e982c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -479,7 +479,11 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
  */
 bool migration_has_all_channels(void)
 {
-    return true;
+    bool all_channels;
+
+    all_channels =3D multifd_recv_all_channels_created();
+
+    return all_channels;
 }
=20
 /*
diff --git a/migration/ram.c b/migration/ram.c
index c0ad6d8e9f..3a01472835 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -636,6 +636,17 @@ int multifd_load_setup(void)
     return 0;
 }
=20
+bool multifd_recv_all_channels_created(void)
+{
+    int thread_count =3D migrate_multifd_channels();
+
+    if (!migrate_use_multifd()) {
+        return true;
+    }
+
+    return thread_count =3D=3D atomic_read(&multifd_recv_state->count);
+}
+
 void multifd_recv_new_channel(QIOChannel *ioc)
 {
     /* nothing to do yet */
diff --git a/migration/ram.h b/migration/ram.h
index 06dbddc2a2..3f4b7daee8 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -45,6 +45,7 @@ int multifd_save_setup(void);
 int multifd_save_cleanup(Error **errp);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
+bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc);
=20
 uint64_t ram_pagesize_summary(void);
--=20
2.17.0
