Received: from eggs.gnu.org ([2001:4830:134:3::10]:57673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUE6H-0004Td-0R
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUE6E-00020F-2r
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cUE6D-0001z2-Tw
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:54:02 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E25C43D944
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:54:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 19 Jan 2017 15:53:57 +0100
Message-Id: <1484837637-16896-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1484837637-16896-1-git-send-email-armbru@redhat.com>
References: <1484837637-16896-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] error: Report certain hints on stderr when
 no monitor
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

Hints printed with error_printf_unless_qmp() are suppressed outside
monitor context.  Reproducer:

    $ qemu-system-x86_64 -m 1Z
    qemu-system-x86_64: -m 1Z: Parameter 'size' expects a size

Print to stderr instead.  The reproducer now additionally prints:

    You may use k, M, G or T suffixes for kilobytes, megabytes, gigabytes=
 and terabytes.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170105135957.12003-1-marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/monitor.c b/monitor.c
index 0841d43..90c5baf 100644
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
2.7.4
