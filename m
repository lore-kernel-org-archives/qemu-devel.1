Received: from eggs.gnu.org ([2001:4830:134:3::10]:33716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE5-00026x-GP
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE4-0002vM-Pf
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmE4-0002td-Jy
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:32 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C93D563306
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:08 +0100
Message-Id: <1485207141-1941-5-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 04/17] migration: Don't create decompression
 threads if not enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

I removed the [HACK] part because previous patch just check that
compression pages are not received.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 4ad814a..cea213e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2251,6 +2251,9 @@ void migrate_decompress_threads_create(void)
 {
     int i, thread_count;

+    if (!migrate_use_compression()) {
+        return;
+    }
     thread_count = migrate_decompress_threads();
     decompress_threads = g_new0(QemuThread, thread_count);
     decomp_param = g_new0(DecompressParam, thread_count);
@@ -2272,6 +2275,9 @@ void migrate_decompress_threads_join(void)
 {
     int i, thread_count;

+    if (!migrate_use_compression()) {
+        return;
+    }
     thread_count = migrate_decompress_threads();
     for (i = 0; i < thread_count; i++) {
         qemu_mutex_lock(&decomp_param[i].mutex);
-- 
2.9.3
