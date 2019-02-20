Received: from eggs.gnu.org ([209.51.188.92]:41411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwUOY-0002Vc-QU
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwUOL-0005JF-Mk
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:06:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwUOL-0005FY-C2
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:06:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC8D113B24A
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 16:06:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 17:06:25 +0100
Message-Id: <20190220160628.6555-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190220160628.6555-1-marcandre.lureau@redhat.com>
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] iothread: wait until the glib context is
 acquired
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Another thread may acquire the glib context (temporarily) before
g_main_context_push_thread_default().

This can happen with the following qemu_chr_fe_set_handlers()
modifications.

Unfortunately, g_main_context_wait() is deprecated in glib
2.58 (apparently it was a broken interface). Use a polling loop.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 iothread.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/iothread.c b/iothread.c
index e615b7ae52..93cc3aa875 100644
--- a/iothread.c
+++ b/iothread.c
@@ -70,6 +70,11 @@ static void *iothread_run(void *opaque)
         if (iothread->running && atomic_read(&iothread->worker_context))=
 {
             GMainLoop *loop;
=20
+            /* we may race with another thread acquiring the context */
+            while (!g_main_context_acquire(iothread->worker_context)) {
+                g_usleep(10000);
+            }
+
             g_main_context_push_thread_default(iothread->worker_context)=
;
             iothread->main_loop =3D
                 g_main_loop_new(iothread->worker_context, TRUE);
@@ -80,6 +85,8 @@ static void *iothread_run(void *opaque)
             g_main_loop_unref(loop);
=20
             g_main_context_pop_thread_default(iothread->worker_context);
+
+            g_main_context_release(iothread->worker_context);
         }
     }
=20
--=20
2.21.0.rc1
