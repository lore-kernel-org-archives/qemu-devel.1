Received: from eggs.gnu.org ([2001:4830:134:3::10]:54440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgMCC-0001dv-Kf
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 23:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgMC9-0008IG-GQ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 23:35:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgMC9-0008I4-Av
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 23:35:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A256C40711BE
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 03:35:04 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Jul 2018 11:34:51 +0800
Message-Id: <20180720033451.32710-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.0 v5] monitor: Fix unsafe sharing of
 @cur_mon among threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

@cur_mon is null unless the main thread is running monitor code, either
HMP code within monitor_read(), or QMP code within
monitor_qmp_dispatch().

Use of @cur_mon outside the main thread is therefore unsafe.

Most of its uses are in monitor command handlers.  These run in the main
thread.

However, there are also uses hiding elsewhere, such as in
error_vprintf(), and thus error_report(), making these functions unsafe
outside the main thread.  No such unsafe uses are known at this time.
Regardless, this is an unnecessary trap.  It's an ancient trap, though.

More recently, commit cf869d53172 "qmp: support out-of-band (oob)
execution" spiced things up: the monitor I/O thread assigns to @cur_mon
when executing commands out-of-band.  Having two threads save, set and
restore @cur_mon without synchronization is definitely unsafe.  We can
end up with @cur_mon null while the main thread runs monitor code, or
non-null while it runs non-monitor code.

We could fix this by making the I/O thread not mess with @cur_mon, but
that would leave the trap armed and ready.

Instead, make @cur_mon thread-local.  It's now reliably null unless the
thread is running monitor code.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
[peterx: update subject and commit message written by Markus]
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v5:
- Update the subject and commit message from Markus, pick r-b.  Subject
  was: "monitor: let cur_mon be per-thread"
v4:
- touch up the commit message since now we have OOB command already
v3:
- fix code style warning from patchew
v2:
- drop qemu-thread changes
---
 include/monitor/monitor.h | 2 +-
 monitor.c                 | 2 +-
 stubs/monitor.c           | 2 +-
 tests/test-util-sockets.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index d6ab70cae2..2ef5e04b37 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -6,7 +6,7 @@
 #include "qapi/qapi-types-misc.h"
 #include "qemu/readline.h"
=20
-extern Monitor *cur_mon;
+extern __thread Monitor *cur_mon;
=20
 /* flags for monitor_init */
 /* 0x01 unused */
diff --git a/monitor.c b/monitor.c
index be29634a00..f75027b09e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -290,7 +290,7 @@ static mon_cmd_t info_cmds[];
=20
 QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
=20
-Monitor *cur_mon;
+__thread Monitor *cur_mon;
=20
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque);
diff --git a/stubs/monitor.c b/stubs/monitor.c
index e018c8f594..3890771bb5 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -3,7 +3,7 @@
 #include "qemu-common.h"
 #include "monitor/monitor.h"
=20
-Monitor *cur_mon =3D NULL;
+__thread Monitor *cur_mon;
=20
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index acadd85e8f..6195a3ac36 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -69,7 +69,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Er=
ror **errp)
  * stubs/monitor.c is defined, to make sure monitor.o is discarded
  * otherwise we get duplicate syms at link time.
  */
-Monitor *cur_mon;
+__thread Monitor *cur_mon;
 void monitor_init(Chardev *chr, int flags) {}
=20
=20
--=20
2.17.1
