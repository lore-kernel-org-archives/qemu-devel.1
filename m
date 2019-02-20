Received: from eggs.gnu.org ([209.51.188.92]:41736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwUP3-0002rC-8W
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwUP0-0005YI-8U
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:07:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwUOz-0005Jy-Sc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:07:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45E311214C
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 16:06:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 17:06:27 +0100
Message-Id: <20190220160628.6555-4-marcandre.lureau@redhat.com>
In-Reply-To: <20190220160628.6555-1-marcandre.lureau@redhat.com>
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] monitor: set the chardev context from the
 main context/thread
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

With the previous changes to qemu_chr_fe_set_handlers(), it is no
longer necessary to call qemu_chr_fe_set_handlers() from the target
context.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 39 ++++++---------------------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/monitor.c b/monitor.c
index 33ccbf3957..2312573300 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4513,19 +4513,6 @@ static void monitor_list_append(Monitor *mon)
     }
 }
=20
-static void monitor_qmp_setup_handlers_bh(void *opaque)
-{
-    Monitor *mon =3D opaque;
-    GMainContext *context;
-
-    assert(mon->use_io_thread);
-    context =3D iothread_get_g_main_context(mon_iothread);
-    assert(context);
-    qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_re=
ad,
-                             monitor_qmp_event, NULL, mon, context, true=
);
-    monitor_list_append(mon);
-}
-
 void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon =3D g_malloc(sizeof(*mon));
@@ -4548,29 +4535,15 @@ void monitor_init(Chardev *chr, int flags)
     }
=20
     if (monitor_is_qmp(mon)) {
+        GMainContext *ctxt =3D mon->use_io_thread ?
+            iothread_get_g_main_context(mon_iothread) : NULL;
+
         qemu_chr_fe_set_echo(&mon->chr, true);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
                                  mon, NULL);
-        if (mon->use_io_thread) {
-            /*
-             * Make sure the old iowatch is gone.  It's possible when
-             * e.g. the chardev is in client mode, with wait=3Don.
-             */
-            remove_fd_in_watch(chr);
-            /*
-             * We can't call qemu_chr_fe_set_handlers() directly here
-             * since chardev might be running in the monitor I/O
-             * thread.  Schedule a bottom half.
-             */
-            aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothrea=
d),
-                                    monitor_qmp_setup_handlers_bh, mon);
-            /* The bottom half will add @mon to @mon_list */
-            return;
-        } else {
-            qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
-                                     monitor_qmp_read, monitor_qmp_event=
,
-                                     NULL, mon, NULL, true);
-        }
+        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
+                                 monitor_qmp_read, monitor_qmp_event,
+                                 NULL, mon, ctxt, true);
     } else {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_re=
ad,
                                  monitor_event, NULL, mon, NULL, true);
--=20
2.21.0.rc1
