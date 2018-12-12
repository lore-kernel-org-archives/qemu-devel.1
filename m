Received: from eggs.gnu.org ([2001:4830:134:3::10]:52311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Ma-0000r7-5K
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MY-0000G2-9x
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:33942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MX-0008U9-Qy
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:50 -0500
Received: by mail-wm1-x334.google.com with SMTP id y185so11704432wmd.1
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:34 +0100
Message-Id: <1544628195-37728-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/54] block/iscsi: take iscsilun->mutex in
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit d045c466d9e62b4321fadf586d024d54ddfd8bd4 ("iscsi: do not use
aio_context_acquire/release") introduced iscsilun->mutex but appears to
have overlooked iscsi_timed_check_events() when introducing the mutex.

iscsi_service() and iscsi_set_events() must be called with
iscsilun->mutex held.

iscsi_timed_check_events() is invoked from the AioContext and does not
take the mutex.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180203061621.7033-3-stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index a4e3730..1924a2b 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -344,6 +344,8 @@ static void iscsi_timed_check_events(void *opaque)
 {
     IscsiLun *iscsilun = opaque;
 
+    qemu_mutex_lock(&iscsilun->mutex);
+
     /* check for timed out requests */
     iscsi_service(iscsilun->iscsi, 0);
 
@@ -356,6 +358,8 @@ static void iscsi_timed_check_events(void *opaque)
      * to return to service once this situation changes. */
     iscsi_set_events(iscsilun);
 
+    qemu_mutex_unlock(&iscsilun->mutex);
+
     timer_mod(iscsilun->event_timer,
               qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + EVENT_INTERVAL);
 }
-- 
1.8.3.1
