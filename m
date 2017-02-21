Received: from eggs.gnu.org ([2001:4830:134:3::10]:55716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBDm-0000gV-Kp
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBDl-0003ne-PF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBDl-0003nL-Jd
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D070BC054C3D
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:15:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:25 +0400
Message-Id: <20170221141451.28305-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/30] timer: use an inline function for free
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
Reviewed-by: Greg Kurz <groug@kaod.org>
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
