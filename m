Received: from eggs.gnu.org ([2001:4830:134:3::10]:42758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehr9e-0001An-4T
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 01:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehr9c-0004yD-6p
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 01:18:26 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat,  3 Feb 2018 07:16:20 +0100
Message-Id: <20180203061621.7033-3-stefanha@redhat.com>
In-Reply-To: <20180203061621.7033-1-stefanha@redhat.com>
References: <20180203061621.7033-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] block/iscsi: take iscsilun->mutex in
 iscsi_timed_check_events()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Commit d045c466d9e62b4321fadf586d024d54ddfd8bd4 ("iscsi: do not use
aio_context_acquire/release") introduced iscsilun->mutex but appears to
have overlooked iscsi_timed_check_events() when introducing the mutex.

iscsi_service() and iscsi_set_events() must be called with
iscsilun->mutex held.

iscsi_timed_check_events() is invoked from the AioContext and does not
take the mutex.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/iscsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index cd0738942c..1cfe1c647c 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -339,6 +339,8 @@ static void iscsi_timed_check_events(void *opaque)
 {
     IscsiLun *iscsilun = opaque;
 
+    qemu_mutex_lock(&iscsilun->mutex);
+
     /* check for timed out requests */
     iscsi_service(iscsilun->iscsi, 0);
 
@@ -351,6 +353,8 @@ static void iscsi_timed_check_events(void *opaque)
      * to return to service once this situation changes. */
     iscsi_set_events(iscsilun);
 
+    qemu_mutex_unlock(&iscsilun->mutex);
+
     timer_mod(iscsilun->event_timer,
               qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + EVENT_INTERVAL);
 }
-- 
2.14.3
