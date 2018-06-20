Received: from eggs.gnu.org ([2001:4830:134:3::10]:48411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVmXB-0001ao-W5
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVmXB-0007ED-5n
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:29:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fVmXB-0007Dx-1a
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A30374022909
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:29:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 21 Jun 2018 01:28:44 +0200
Message-Id: <20180620232851.7152-6-quintela@redhat.com>
In-Reply-To: <20180620232851.7152-1-quintela@redhat.com>
References: <20180620232851.7152-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v15 05/12] migration: Multifd channels always
 wait on the sem
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

Either for quit, sync or packet, we first wake them.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d7f8b0d989..617da76a2e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -875,6 +875,7 @@ static void *multifd_send_thread(void *opaque)
     p->num_packets = 1;
 
     while (true) {
+        qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
         multifd_send_fill_packet(p);
         if (p->quit) {
@@ -882,7 +883,9 @@ static void *multifd_send_thread(void *opaque)
             break;
         }
         qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem);
+        /* this is impossible */
+        error_setg(&local_err, "multifd_send_thread: Unknown command");
+        break;
     }
 
 out:
@@ -1033,6 +1036,7 @@ static void *multifd_recv_thread(void *opaque)
     trace_multifd_recv_thread_start(p->id);
 
     while (true) {
+        qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
         if (false)  {
             /* ToDo: Packet reception goes here */
@@ -1047,9 +1051,14 @@ static void *multifd_recv_thread(void *opaque)
             break;
         }
         qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem);
+        /* this is impossible */
+        error_setg(&local_err, "multifd_recv_thread: Unknown command");
+        break;
     }
 
+    if (local_err) {
+        multifd_recv_terminate_threads(local_err);
+    }
     qemu_mutex_lock(&p->mutex);
     p->running = false;
     qemu_mutex_unlock(&p->mutex);
-- 
2.17.1
