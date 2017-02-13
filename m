Received: from eggs.gnu.org ([2001:4830:134:3::10]:57703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIF-0007u7-AQ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKID-0004p9-Gm
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKID-0004o6-BD
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:01 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80DEEC056790
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:20:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Feb 2017 18:19:38 +0100
Message-Id: <1487006388-7966-3-git-send-email-quintela@redhat.com>
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 02/12] migration: Don't create decompression
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
---
 migration/ram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 5817f8c..4422ee8 100644
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
2.7.4
