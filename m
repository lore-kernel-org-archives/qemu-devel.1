Received: from eggs.gnu.org ([209.51.188.92]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Ili-0003wG-JM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Ilh-0006Q1-S4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  8 Mar 2019 16:53:44 +0000
Message-Id: <20190308165344.10685-8-stefanha@redhat.com>
In-Reply-To: <20190308165344.10685-1-stefanha@redhat.com>
References: <20190308165344.10685-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/7] iothread: document about why we need
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Peter Xu <peterx@redhat.com>

After consulting Paolo I know why we'd better keep the explicit
aio_poll() in iothread_run().  Document it directly into the code so
that future readers will know the answer from day one.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20190306115532.23025-6-peterx@redhat.com
Message-Id: <20190306115532.23025-6-peterx@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 iothread.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/iothread.c b/iothread.c
index ad64c757ac..7130be58e3 100644
--- a/iothread.c
+++ b/iothread.c
@@ -63,6 +63,15 @@ static void *iothread_run(void *opaque)
     qemu_sem_post(&iothread->init_done_sem);
=20
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
=20
         /*
--=20
2.20.1
