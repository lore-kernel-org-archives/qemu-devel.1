Received: from eggs.gnu.org ([2001:4830:134:3::10]:42359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cP8aQ-0002vk-OO
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cP8aN-00060T-Ka
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:00:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cP8aN-0005yx-F7
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:00:07 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 709D78050B
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 14:00:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jan 2017 14:59:57 +0100
Message-Id: <20170105135957.12003-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] error: report hints on stderr when no monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Report the error hint when running from the command line and reaching an
error, ex:

$ qemu-system-x86_64 -m 1Z
qemu-system-x86_64: -m 1Z: Parameter 'size' expects a size
You may use k, M, G or T suffixes for kilobytes, megabytes, gigabytes and=
 terabytes.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/monitor.c b/monitor.c
index a82f547488..e5cc11b5a5 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3973,6 +3973,8 @@ void error_vprintf_unless_qmp(const char *fmt, va_l=
ist ap)
 {
     if (cur_mon && !monitor_cur_is_qmp()) {
         monitor_vprintf(cur_mon, fmt, ap);
+    } else if (!cur_mon) {
+        vfprintf(stderr, fmt, ap);
     }
 }
=20
--=20
2.11.0
