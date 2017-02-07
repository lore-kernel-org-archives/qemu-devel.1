Received: from eggs.gnu.org ([2001:4830:134:3::10]:60505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6C9-0007a3-0i
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6C6-0007nv-0l
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6C5-0007nZ-Qt
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:29 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD884C05AA55
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:52:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:51:47 +0400
Message-Id: <20170207135211.15870-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/28] timer: use an inline function for free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Similarly to allocation, do it from an inline function. This allows
tests to only use the headers for allocation/free of timer.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/timer.h | 5 ++++-
 qemu-timer.c         | 5 -----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9abed51ae8..26e628584c 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -610,7 +610,10 @@ void timer_deinit(QEMUTimer *ts);
  *
  * Free a timer (it must not be on the active list)
  */
-void timer_free(QEMUTimer *ts);
+static inline void timer_free(QEMUTimer *ts)
+{
+    g_free(ts);
+}
=20
 /**
  * timer_del:
diff --git a/qemu-timer.c b/qemu-timer.c
index ff620ecff7..6cf70b96f6 100644
--- a/qemu-timer.c
+++ b/qemu-timer.c
@@ -355,11 +355,6 @@ void timer_deinit(QEMUTimer *ts)
     ts->timer_list =3D NULL;
 }
=20
-void timer_free(QEMUTimer *ts)
-{
-    g_free(ts);
-}
-
 static void timer_del_locked(QEMUTimerList *timer_list, QEMUTimer *ts)
 {
     QEMUTimer **pt, *t;
--=20
2.11.0.295.gd7dffce1c.dirty
