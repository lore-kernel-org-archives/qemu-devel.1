Received: from eggs.gnu.org ([2001:4830:134:3::10]:49269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcO-0007Uo-SK
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcN-0004zR-Ob
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcN-0004z4-EX
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 103914072CF5
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 14:30:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:11 -0500
Message-Id: <20180327143014.1767669-12-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/14] monitor: new parameter "x-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Peter Xu <peterx@redhat.com>

Add new parameter to optionally enable Out-Of-Band for a QMP server.

An example command line:

  ./qemu-system-x86_64 -chardev stdio,id=3Dchar0 \
                       -mon chardev=3Dchar0,mode=3Dcontrol,x-oob=3Don

By default, Out-Of-Band is off.

It is not allowed if either MUX or non-QMP is detected, since
Out-Of-Band is currently only for QMP, and non-MUX chardev backends.

Note that the client STILL has to request 'oob' during qmp_capabilities;
in part because the x-oob command line option may disappear in the
future if we decide the capabilities negotiation is sufficient.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180326063901.27425-4-peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[eblake: enhance commit message]
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/monitor/monitor.h |  1 +
 vl.c                      |  5 +++++
 monitor.c                 | 22 ++++++++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 0cb0538a315..d6ab70cae23 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -13,6 +13,7 @@ extern Monitor *cur_mon;
 #define MONITOR_USE_READLINE  0x02
 #define MONITOR_USE_CONTROL   0x04
 #define MONITOR_USE_PRETTY    0x08
+#define MONITOR_USE_OOB       0x10

 bool monitor_cur_is_qmp(void);

diff --git a/vl.c b/vl.c
index c81cc866079..5fd01bd5f69 100644
--- a/vl.c
+++ b/vl.c
@@ -2404,6 +2404,11 @@ static int mon_init_func(void *opaque, QemuOpts *o=
pts, Error **errp)
     if (qemu_opt_get_bool(opts, "pretty", 0))
         flags |=3D MONITOR_USE_PRETTY;

+    /* OOB is off by default */
+    if (qemu_opt_get_bool(opts, "x-oob", 0)) {
+        flags |=3D MONITOR_USE_OOB;
+    }
+
     chardev =3D qemu_opt_get(opts, "chardev");
     chr =3D qemu_chr_find(chardev);
     if (chr =3D=3D NULL) {
diff --git a/monitor.c b/monitor.c
index 32d6114ac3a..51f4cf480f8 100644
--- a/monitor.c
+++ b/monitor.c
@@ -36,6 +36,7 @@
 #include "net/slirp.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-io.h"
+#include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
@@ -4562,12 +4563,26 @@ static void monitor_qmp_setup_handlers_bh(void *o=
paque)
 void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon =3D g_malloc(sizeof(*mon));
+    bool use_readline =3D flags & MONITOR_USE_READLINE;
+    bool use_oob =3D flags & MONITOR_USE_OOB;

-    monitor_data_init(mon, false, false);
+    if (use_oob) {
+        if (CHARDEV_IS_MUX(chr)) {
+            error_report("Monitor Out-Of-Band is not supported with "
+                         "MUX typed chardev backend");
+            exit(1);
+        }
+        if (use_readline) {
+            error_report("Monitor Out-Of-band is only supported by QMP")=
;
+            exit(1);
+        }
+    }
+
+    monitor_data_init(mon, false, use_oob);

     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags =3D flags;
-    if (flags & MONITOR_USE_READLINE) {
+    if (use_readline) {
         mon->rs =3D readline_init(monitor_readline_printf,
                                 monitor_readline_flush,
                                 mon,
@@ -4663,6 +4678,9 @@ QemuOptsList qemu_mon_opts =3D {
         },{
             .name =3D "pretty",
             .type =3D QEMU_OPT_BOOL,
+        },{
+            .name =3D "x-oob",
+            .type =3D QEMU_OPT_BOOL,
         },
         { /* end of list */ }
     },
--=20
2.14.3
