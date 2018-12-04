Received: from eggs.gnu.org ([2001:4830:134:3::10]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUAal-0004Ib-Fo
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUAak-0001LK-PZ
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:18:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUAak-0001KF-KR
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:18:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 066253082191
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 13:18:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 17:17:57 +0400
Message-Id: <20181204131802.16885-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181204131802.16885-1-marcandre.lureau@redhat.com>
References: <20181204131802.16885-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/6] monitor: inline ambiguous helper
 functions
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

The function were not named with "mon_iothread", or following the AIO
vs GMainContext distinction. Inline them instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/monitor.c b/monitor.c
index d39390c2f2..d531e8ccc9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4453,16 +4453,6 @@ static void sortcmdlist(void)
     qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
 }
=20
-static GMainContext *monitor_get_io_context(void)
-{
-    return iothread_get_g_main_context(mon_iothread);
-}
-
-static AioContext *monitor_get_aio_context(void)
-{
-    return iothread_get_aio_context(mon_iothread);
-}
-
 static void monitor_iothread_init(void)
 {
     mon_iothread =3D iothread_create("mon_iothread", &error_abort);
@@ -4549,7 +4539,7 @@ static void monitor_qmp_setup_handlers_bh(void *opa=
que)
     GMainContext *context;
=20
     assert(mon->use_io_thread);
-    context =3D monitor_get_io_context();
+    context =3D iothread_get_g_main_context(mon_iothread);
     assert(context);
     qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_re=
ad,
                              monitor_qmp_event, NULL, mon, context, true=
);
@@ -4601,7 +4591,7 @@ void monitor_init(Chardev *chr, int flags)
              * since chardev might be running in the monitor I/O
              * thread.  Schedule a bottom half.
              */
-            aio_bh_schedule_oneshot(monitor_get_aio_context(),
+            aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothrea=
d),
                                     monitor_qmp_setup_handlers_bh, mon);
             /* The bottom half will add @mon to @mon_list */
             return;
--=20
2.20.0.rc1
