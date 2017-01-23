Received: from eggs.gnu.org ([2001:4830:134:3::10]:33884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEM-0002Nu-23
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEL-0003Ce-4M
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmEK-0003CV-VB
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:49 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29D3B4E326
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:19 +0100
Message-Id: <1485207141-1941-16-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 15/17] migration: Test new fd infrastructure
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

We just send the address through the alternate channels and test that it
is ok.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 4e530ea..95af694 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -432,8 +432,22 @@ static void *multifd_send_thread(void *opaque)
     qemu_mutex_lock(&params->mutex);
     while (!params->quit){
         if (params->pages.num) {
+            int i;
+            int num;
+
+            num = params->pages.num;
             params->pages.num = 0;
             qemu_mutex_unlock(&params->mutex);
+
+            for(i=0; i < num; i++) {
+                if (qio_channel_write(params->c,
+                                      (const char *)&params->pages.address[i],
+                                      sizeof(uint8_t *), &error_abort)
+                    != sizeof(uint8_t*)) {
+                    /* Shuoudn't ever happen */
+                    exit(-1);
+                }
+            }
             qemu_mutex_lock(&multifd_send_mutex);
             params->done = true;
             qemu_cond_signal(&multifd_send_cond);
@@ -594,6 +608,7 @@ QemuCond  multifd_recv_cond;
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *params = opaque;
+    uint8_t *recv_address;
     char start;

     qio_channel_read(params->c, &start, 1, &error_abort);
@@ -605,8 +620,29 @@ static void *multifd_recv_thread(void *opaque)
     qemu_mutex_lock(&params->mutex);
     while (!params->quit){
         if (params->pages.num) {
+            int i;
+            int num;
+
+            num = params->pages.num;
             params->pages.num = 0;
             qemu_mutex_unlock(&params->mutex);
+
+            for(i = 0; i < num; i++) {
+                if (qio_channel_read(params->c,
+                                     (char *)&recv_address,
+                                     sizeof(uint8_t*), &error_abort)
+                    != sizeof(uint8_t *)) {
+                    /* shouldn't ever happen */
+                    exit(-1);
+                }
+                if (recv_address != params->pages.address[i]) {
+                    printf("We received %p what we were expecting %p (%d)\n",
+                           recv_address,
+                           params->pages.address[i], i);
+                    exit(-1);
+                }
+            }
+
             qemu_mutex_lock(&multifd_recv_mutex);
             params->done = true;
             qemu_cond_signal(&multifd_recv_cond);
-- 
2.9.3
