Received: from eggs.gnu.org ([2001:4830:134:3::10]:40906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqihK-0007k7-Jj
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqihG-0004tw-Bg
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:38:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fqihG-0004sT-3N
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0E5A819703D
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 17:38:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Aug 2018 19:37:52 +0200
Message-Id: <20180817173752.19136-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] monitor: accept input on resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

A chardev may stop trying to write if the associated can_read()
callback returned 0. This happens when the monitor is suspended.
The frontend is supposed to call qemu_chr_fe_accept_input() when it is
ready to accept data again.

An issue was observed with a spice port: pending commands may be
delayed, as the chardev is not flushed. Most chardev don't use the
accept_input() callback, and instead check regularly if they can
write. The ones that do use it are braille, mux, msmouse,
spice (abstract), spicevmc, spiceport, wctablet.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor.c b/monitor.c
index a1999e396c..33823b035a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4407,6 +4407,7 @@ void monitor_resume(Monitor *mon)
             assert(mon->rs);
             readline_show_prompt(mon->rs);
         }
+        qemu_chr_fe_accept_input(&mon->chr);
     }
     trace_monitor_suspend(mon, -1);
 }
--=20
2.18.0.547.g1d89318c48
