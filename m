Received: from eggs.gnu.org ([2001:4830:134:3::10]:50801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3u7-0003Su-FX
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3u6-0000jo-19
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fw3u5-0000jM-Qm
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7906E5C97
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 11:17:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sat,  1 Sep 2018 13:17:12 +0200
Message-Id: <20180901111716.1675-3-armbru@redhat.com>
In-Reply-To: <20180901111716.1675-1-armbru@redhat.com>
References: <20180901111716.1675-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] monitor: accept input on resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
Message-Id: <20180817173752.19136-1-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor.c b/monitor.c
index c049776603..c1add2ce09 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4411,6 +4411,7 @@ void monitor_resume(Monitor *mon)
             assert(mon->rs);
             readline_show_prompt(mon->rs);
         }
+        qemu_chr_fe_accept_input(&mon->chr);
     }
     trace_monitor_suspend(mon, -1);
 }
--=20
2.17.1
