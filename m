Received: from eggs.gnu.org ([2001:4830:134:3::10]:59724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoL-0004zD-8K
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoI-0006F7-8A
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44632 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoI-0006Em-3r
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DC72404084A
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 12:00:00 +0100
Message-Id: <20180307110010.2205-15-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 14/24] migration: Be sure all recv channels
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
---
 migration/migration.c |  6 +++++-
 migration/ram.c       | 11 +++++++++++
 migration/ram.h       |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 919343232e..c06c34ca0f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -461,7 +461,11 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
  */
 bool migration_has_all_channels(void)
 {
-    return true;
+    bool all_channels;
+
+    all_channels = multifd_recv_all_channels_created();
+
+    return all_channels;
 }
 
 /*
diff --git a/migration/ram.c b/migration/ram.c
index f48c74585f..e502be5dda 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -625,6 +625,17 @@ int multifd_load_setup(void)
     return 0;
 }
 
+bool multifd_recv_all_channels_created(void)
+{
+    int thread_count = migrate_multifd_channels();
+
+    if (!migrate_use_multifd()) {
+        return true;
+    }
+
+    return thread_count == atomic_read(&multifd_recv_state->count);
+}
+
 void multifd_recv_new_channel(QIOChannel *ioc)
 {
     /* nothing to do yet */
diff --git a/migration/ram.h b/migration/ram.h
index a2031acf59..3daf074bcc 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -45,6 +45,7 @@ int multifd_save_setup(void);
 int multifd_save_cleanup(Error **errp);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
+bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc);
 
 uint64_t ram_pagesize_summary(void);
-- 
2.14.3
