Received: from eggs.gnu.org ([2001:4830:134:3::10]:49849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g9rpL-0006CS-Lr
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g9rpH-0002fZ-NZ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g9rpH-0002dw-E4
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2573831B333
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 13:13:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Oct 2018 17:12:47 +0400
Message-Id: <20181009131251.721-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181009131251.721-1-marcandre.lureau@redhat.com>
References: <20181009131251.721-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/6] monitor: accept chardev input from iothread
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index ab60c9f87e..a25514490a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4297,6 +4297,13 @@ int monitor_suspend(Monitor *mon)
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
@@ -4310,13 +4317,14 @@ void monitor_resume(Monitor *mon)
              * let's kick the thread in case it's sleeping.
              */
             if (mon->use_io_thread) {
-                aio_notify(iothread_get_aio_context(mon_iothread));
+                aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iot=
hread),
+                                        monitor_accept_input, mon);
             }
         } else {
             assert(mon->rs);
             readline_show_prompt(mon->rs);
+            monitor_accept_input(mon);
         }
-        qemu_chr_fe_accept_input(&mon->chr);
     }
     trace_monitor_suspend(mon, -1);
 }
--=20
2.19.0.271.gfe8321ec05
