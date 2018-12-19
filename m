Received: from eggs.gnu.org ([2001:4830:134:3::10]:55645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZddY-00060L-AZ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZddW-00048W-Hl
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:19:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZddW-000489-Bm
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:19:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A63F96CE
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:19:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Dec 2018 16:18:55 +0100
Message-Id: <20181219151917.3874-14-pbonzini@redhat.com>
In-Reply-To: <20181219151917.3874-1-pbonzini@redhat.com>
References: <20181219151917.3874-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/35] block/iscsi: take iscsilun->mutex in
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
index a4e3730a82..1924a2b58e 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -344,6 +344,8 @@ static void iscsi_timed_check_events(void *opaque)
 {
     IscsiLun *iscsilun =3D opaque;
=20
+    qemu_mutex_lock(&iscsilun->mutex);
+
     /* check for timed out requests */
     iscsi_service(iscsilun->iscsi, 0);
=20
@@ -356,6 +358,8 @@ static void iscsi_timed_check_events(void *opaque)
      * to return to service once this situation changes. */
     iscsi_set_events(iscsilun);
=20
+    qemu_mutex_unlock(&iscsilun->mutex);
+
     timer_mod(iscsilun->event_timer,
               qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + EVENT_INTERVAL);
 }
--=20
2.20.1
