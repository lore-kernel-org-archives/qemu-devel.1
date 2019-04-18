Received: from eggs.gnu.org ([209.51.188.92]:54678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0Z-00057h-Fv
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0U-0005Ez-Bw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0T-0005D4-OG
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE0123084247
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:14 +0200
Message-Id: <20190418205135.6686-16-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-4.1 15/36] qemu-print: New qemu_printf(),
 qemu_vprintf() etc.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

We commonly want to print to the current monitor if we have one, else
to stdout/stderr.  For stderr, have error_printf().  For stdout, all
we have is monitor_vfprintf(), which is rather unwieldy.  We often
print to stderr just because error_printf() is easier.

New qemu_printf() and qemu_vprintf() do exactly what's needed.  The
next commits will put them to use.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190417190641.26814-12-armbru@redhat.com>
---
 MAINTAINERS               |  2 ++
 include/qemu/qemu-print.h | 19 ++++++++++++++++++
 stubs/monitor.c           |  5 +++++
 tests/test-util-sockets.c |  1 +
 util/Makefile.objs        |  1 +
 util/qemu-print.c         | 42 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 70 insertions(+)
 create mode 100644 include/qemu/qemu-print.h
 create mode 100644 util/qemu-print.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac8ab..1aa19dc4ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1895,6 +1895,8 @@ F: hmp.[ch]
 F: hmp-commands*.hx
 F: include/monitor/hmp-target.h
 F: tests/test-hmp.c
+F: include/qemu/qemu-print.h
+F: util/qemu-print.c
=20
 Network device backends
 M: Jason Wang <jasowang@redhat.com>
diff --git a/include/qemu/qemu-print.h b/include/qemu/qemu-print.h
new file mode 100644
index 0000000000..8fed32bf42
--- /dev/null
+++ b/include/qemu/qemu-print.h
@@ -0,0 +1,19 @@
+/*
+ * Print to stream or current monitor
+ *
+ * Copyright (C) 2019 Red Hat Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_PRINT_H
+#define QEMU_PRINT_H
+
+int qemu_vprintf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+int qemu_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+
+#endif
diff --git a/stubs/monitor.c b/stubs/monitor.c
index b57fe6c32f..b2ea975e40 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -6,6 +6,11 @@
=20
 __thread Monitor *cur_mon;
=20
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
+{
+    abort();
+}
+
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
     error_setg(errp, "only QEMU supports file descriptor passing");
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 6195a3ac36..fd1ced058c 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -70,6 +70,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Er=
ror **errp)
  * otherwise we get duplicate syms at link time.
  */
 __thread Monitor *cur_mon;
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort()=
; }
 void monitor_init(Chardev *chr, int flags) {}
=20
=20
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 835fcd69e2..9206878dec 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -23,6 +23,7 @@ util-obj-y +=3D bitmap.o bitops.o hbitmap.o
 util-obj-y +=3D fifo8.o
 util-obj-y +=3D cacheinfo.o
 util-obj-y +=3D error.o qemu-error.o
+util-obj-y +=3D qemu-print.o
 util-obj-y +=3D id.o
 util-obj-y +=3D iov.o qemu-config.o qemu-sockets.o uri.o notify.o
 util-obj-y +=3D qemu-option.o qemu-progress.o
diff --git a/util/qemu-print.c b/util/qemu-print.c
new file mode 100644
index 0000000000..86f9417af8
--- /dev/null
+++ b/util/qemu-print.c
@@ -0,0 +1,42 @@
+/*
+ * Print to stream or current monitor
+ *
+ * Copyright (C) 2019 Red Hat Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+#include "qemu/qemu-print.h"
+
+/*
+ * Print like vprintf().
+ * Print to current monitor if we have one, else to stdout.
+ */
+int qemu_vprintf(const char *fmt, va_list ap)
+{
+    if (cur_mon) {
+        return monitor_vprintf(cur_mon, fmt, ap);
+    }
+    return vprintf(fmt, ap);
+}
+
+/*
+ * Print like printf().
+ * Print to current monitor if we have one, else to stdout.
+ */
+int qemu_printf(const char *fmt, ...)
+{
+    va_list ap;
+    int ret;
+
+    va_start(ap, fmt);
+    ret =3D qemu_vprintf(fmt, ap);
+    va_end(ap);
+    return ret;
+}
--=20
2.17.2
