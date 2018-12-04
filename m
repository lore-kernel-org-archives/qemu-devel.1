Received: from eggs.gnu.org ([2001:4830:134:3::10]:54423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUAb1-0004hA-7a
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUAax-0001lu-FO
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:18:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUAav-0001fr-Nv
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:18:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D80C0308624A
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 13:18:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 17:17:58 +0400
Message-Id: <20181204131802.16885-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181204131802.16885-1-marcandre.lureau@redhat.com>
References: <20181204131802.16885-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/6] monitor: accept chardev input from
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
threads (they are not thread-safe in general, only the write path is
since commit > 9005b2a7589540a3733b3abdcfbccfe7746cd1a1). Better to
wake up the chardev from the monitor IO thread if it's being used as
the chardev context.

Unify code paths by using a BH in all cases.

Drop the now redundant aio_notify() call.

Simplify the condition, based on mon->use_io_thread (only QMP so far).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/monitor.c b/monitor.c
index d531e8ccc9..79afe99079 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4297,7 +4297,7 @@ int monitor_suspend(Monitor *mon)
=20
     atomic_inc(&mon->suspend_cnt);
=20
-    if (monitor_is_qmp(mon) && mon->use_io_thread) {
+    if (mon->use_io_thread) {
         /*
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
@@ -4309,6 +4309,13 @@ int monitor_suspend(Monitor *mon)
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
@@ -4316,20 +4323,22 @@ void monitor_resume(Monitor *mon)
     }
=20
     if (atomic_dec_fetch(&mon->suspend_cnt) =3D=3D 0) {
-        if (monitor_is_qmp(mon)) {
-            /*
-             * For QMP monitors that are running in the I/O thread,
-             * let's kick the thread in case it's sleeping.
-             */
-            if (mon->use_io_thread) {
-                aio_notify(iothread_get_aio_context(mon_iothread));
-            }
+        AioContext *ctx;
+
+        if (mon->use_io_thread) {
+            ctx =3D iothread_get_aio_context(mon_iothread);
         } else {
+            ctx =3D qemu_get_aio_context();
+        }
+
+        if (!monitor_is_qmp(mon)) {
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
2.20.0.rc1
