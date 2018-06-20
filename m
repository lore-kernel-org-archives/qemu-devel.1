Received: from eggs.gnu.org ([2001:4830:134:3::10]:47389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVXGQ-0000UH-Dw
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVXGO-0002mq-V2
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:10:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fVXGO-0002mm-Pp
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:10:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 773958790A
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:10:44 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 20 Jun 2018 15:10:40 +0800
Message-Id: <20180620071040.28729-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

After the Out-Of-Band work, the monitor iothread may be accessing the
cur_mon as well (via monitor_qmp_dispatch_one()).  Let's convert the
cur_mon variable to be a per-thread variable to make sure there won't be
a race between threads when accessing the variable.

Note that thread variables are not initialized to a valid value when new
thread is created.  However for our case we don't need to set it up,
since the cur_mon variable is only used in such a pattern:

  old_mon =3D cur_mon;
  cur_mon =3D xxx;
  (do something, read cur_mon if necessary in the stack)
  cur_mon =3D old_mon;

It plays a role as stack variable, so no need to be initialized at all.
We only need to make sure the variable won't be changed unexpectedly by
other threads.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
[peterx: touch up commit message a bit]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
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
index 885e000f9b..94365a8ae6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -282,7 +282,7 @@ static mon_cmd_t info_cmds[];
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
