Received: from eggs.gnu.org ([2001:4830:134:3::10]:60513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYso-0007nb-LU
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYsn-0008EN-Sy
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dpYsn-0008Do-Jv
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A720C047B62
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 11:52:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  6 Sep 2017 13:51:40 +0200
Message-Id: <20170906115143.27451-20-quintela@redhat.com>
In-Reply-To: <20170906115143.27451-1-quintela@redhat.com>
References: <20170906115143.27451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v7 19/22] migration: Test new fd infrastructure
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

We just send the address through the alternate channels and test that it
is ok.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index b897d490f2..348ce1141a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -496,8 +496,24 @@ static void *multifd_send_thread(void *opaque)
             break;
         }
         if (p->pages.num) {
+            Error *local_err = NULL;
+            size_t ret;
+            int i;
+            int num;
+
+            num = p->pages.num;
             p->pages.num = 0;
             qemu_mutex_unlock(&p->mutex);
+
+            for (i = 0; i < num; i++) {
+                ret = qio_channel_write(p->c,
+                                        (const char *)&p->pages.iov[i].iov_base,
+                                        sizeof(uint8_t *), &local_err);
+                if (ret != sizeof(uint8_t *)) {
+                    terminate_multifd_send_threads(local_err);
+                    return NULL;
+                }
+            }
             qemu_mutex_lock(&multifd_send_state->mutex);
             p->done = true;
             qemu_mutex_unlock(&multifd_send_state->mutex);
@@ -669,6 +685,7 @@ int multifd_load_cleanup(Error **errp)
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
+    uint8_t *recv_address;
 
     qemu_sem_post(&p->ready);
     while (true) {
@@ -678,7 +695,29 @@ static void *multifd_recv_thread(void *opaque)
             break;
         }
         if (p->pages.num) {
+            Error *local_err = NULL;
+            size_t ret;
+            int i;
+            int num;
+
+            num = p->pages.num;
             p->pages.num = 0;
+
+            for (i = 0; i < num; i++) {
+                ret = qio_channel_read(p->c, (char *)&recv_address,
+                                       sizeof(uint8_t *), &local_err);
+                if (ret != sizeof(uint8_t *)) {
+                    terminate_multifd_recv_threads(local_err);
+                    return NULL;
+                }
+                if (recv_address != p->pages.iov[i].iov_base) {
+                    error_setg(&local_err, "received %p and expecting %p (%d)\n",
+                               recv_address, p->pages.iov[i].iov_base, i);
+                    terminate_multifd_recv_threads(local_err);
+                    return NULL;
+                }
+            }
+
             p->done = true;
             qemu_mutex_unlock(&p->mutex);
             qemu_sem_post(&p->ready);
-- 
2.13.5
