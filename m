Received: from eggs.gnu.org ([2001:4830:134:3::10]:49635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gH77b-0008BU-5v
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gH77W-0001Ic-Ax
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gH77W-0001Dp-1w
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:58:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40A8330A47F4
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:58:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Oct 2018 16:57:28 +0400
Message-Id: <20181029125733.14597-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181029125733.14597-1-marcandre.lureau@redhat.com>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/6] monitor: inline ambiguous helper
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
---
 monitor.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/monitor.c b/monitor.c
index 823b5a1099..07712d89f9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4448,16 +4448,6 @@ static void sortcmdlist(void)
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
@@ -4545,7 +4535,7 @@ static void monitor_qmp_setup_handlers_bh(void *opa=
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
@@ -4597,7 +4587,7 @@ void monitor_init(Chardev *chr, int flags)
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
2.19.0.271.gfe8321ec05
