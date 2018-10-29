Received: from eggs.gnu.org ([2001:4830:134:3::10]:49667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gH77c-0008Bi-Ci
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gH77b-0001gx-Ge
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:58:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gH77b-0001cA-7S
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1249C792BC
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:58:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Oct 2018 16:57:29 +0400
Message-Id: <20181029125733.14597-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181029125733.14597-1-marcandre.lureau@redhat.com>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/6] monitor: accept chardev input from
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Chardev backends may not handle safely IO events from concurrent
threads. Better to wake up the chardev from the monitor IO thread if
it's being used as the chardev context.

Unify code paths by using a BH in all cases.

Drop the now redundant aio_notify() call.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 07712d89f9..511dd11d1c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4304,6 +4304,13 @@ int monitor_suspend(Monitor *mon)
     return 0;
 }
=20
+static void monitor_accept_input(void *opaque)
+{
+    Monitor *mon =3D opaque;
+
+    qemu_chr_fe_accept_input(&mon->chr);
+}
+
 void monitor_resume(Monitor *mon)
 {
     if (monitor_is_hmp_non_interactive(mon)) {
@@ -4311,20 +4318,24 @@ void monitor_resume(Monitor *mon)
     }
=20
     if (atomic_dec_fetch(&mon->suspend_cnt) =3D=3D 0) {
+        AioContext *ctx =3D qemu_get_aio_context();
+
         if (monitor_is_qmp(mon)) {
             /*
              * For QMP monitors that are running in the I/O thread,
              * let's kick the thread in case it's sleeping.
              */
             if (mon->use_io_thread) {
-                aio_notify(iothread_get_aio_context(mon_iothread));
+                ctx =3D iothread_get_aio_context(mon_iothread);
             }
         } else {
             assert(mon->rs);
             readline_show_prompt(mon->rs);
         }
-        qemu_chr_fe_accept_input(&mon->chr);
+
+        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
     }
+
     trace_monitor_suspend(mon, -1);
 }
=20
--=20
2.19.0.271.gfe8321ec05
