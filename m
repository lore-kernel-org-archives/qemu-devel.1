Received: from eggs.gnu.org ([2001:4830:134:3::10]:55090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCc-0004yx-BT
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCb-000306-Hm
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzhCb-0002z4-9S
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 414D7C058EAA
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:46:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:46:32 +0200
Message-Id: <20171004104636.7963-9-quintela@redhat.com>
In-Reply-To: <20171004104636.7963-1-quintela@redhat.com>
References: <20171004104636.7963-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v9 08/12] migration: Test new fd infrastructure
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

--

Use qio_channel_*all functions
---
 migration/ram.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 745da2971d..4c16d0775b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -492,8 +492,24 @@ static void *multifd_send_thread(void *opaque)
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
+                ret = qio_channel_write_all(p->c,
+                         (const char *)&p->pages.iov[i].iov_base,
+                         sizeof(uint8_t *), &local_err);
+                if (ret != 0) {
+                    terminate_multifd_send_threads(local_err);
+                    return NULL;
+                }
+            }
             qemu_mutex_lock(&multifd_send_state->mutex);
             p->done = true;
             qemu_mutex_unlock(&multifd_send_state->mutex);
@@ -675,6 +691,7 @@ int multifd_load_cleanup(Error **errp)
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
+    uint8_t *recv_address;
 
     qemu_sem_post(&p->ready);
     while (true) {
@@ -684,7 +701,29 @@ static void *multifd_recv_thread(void *opaque)
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
+                ret = qio_channel_read_all(p->c, (char *)&recv_address,
+                                           sizeof(uint8_t *), &local_err);
+                if (ret != 0) {
+                    terminate_multifd_recv_threads(local_err);
+                    return NULL;
+                }
+                if (recv_address != p->pages.iov[i].iov_base) {
+                    error_setg(&local_err, "received %p and expecting %p (%d)",
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
