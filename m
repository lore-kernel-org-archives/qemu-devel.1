Received: from eggs.gnu.org ([209.51.188.92]:46471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h1VA4-0000ak-AI
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h1V9u-0006Dv-FK
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:56:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h1V9m-00067O-Dj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:56:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39C0330718CD
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 11:56:16 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  6 Mar 2019 19:55:32 +0800
Message-Id: <20190306115532.23025-6-peterx@redhat.com>
In-Reply-To: <20190306115532.23025-1-peterx@redhat.com>
References: <20190306115532.23025-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] iothread: document about why we need
 explicit aio_poll()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

After consulting Paolo I know why we'd better keep the explicit
aio_poll() in iothread_run().  Document it directly into the code so
that future readers will know the answer from day one.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 iothread.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/iothread.c b/iothread.c
index 045825a348..14e9f3779e 100644
--- a/iothread.c
+++ b/iothread.c
@@ -64,6 +64,15 @@ static void *iothread_run(void *opaque)
     qemu_sem_post(&iothread->init_done_sem);
 
     while (iothread->running) {
+        /*
+         * Note: from functional-wise the g_main_loop_run() below can
+         * already cover the aio_poll() events, but we can't run the
+         * main loop unconditionally because explicit aio_poll() here
+         * is faster than g_main_loop_run() when we do not need the
+         * gcontext at all (e.g., pure block layer iothreads).  In
+         * other words, when we want to run the gcontext with the
+         * iothread we need to pay some performance for functionality.
+         */
         aio_poll(iothread->ctx, true);
 
         /*
-- 
2.17.1
