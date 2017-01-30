Received: from eggs.gnu.org ([2001:4830:134:3::10]:39011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCEt-0007eA-9f
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCEq-0007m7-5A
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:43:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCEp-0007lj-U2
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:43:20 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 108BC80F63
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:43:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:54 +0400
Message-Id: <20170130133954.31353-42-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 41/41] char: headers clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Those could probably be squashed with earlier patches, however I
couldn't easily identify them, test them or check if there are still
necessary on various platforms.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/char.h   |  5 -----
 chardev/char.c          | 40 +---------------------------------------
 hmp.c                   |  1 +
 monitor.c               |  1 +
 qmp.c                   |  1 +
 tests/vhost-user-test.c |  1 +
 6 files changed, 5 insertions(+), 44 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index b256e79c31..450881d42c 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -2,12 +2,7 @@
 #define QEMU_CHAR_H
=20
 #include "qemu-common.h"
-#include "qemu/queue.h"
 #include "qemu/option.h"
-#include "qemu/config-file.h"
-#include "block/aio.h"
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qstring.h"
 #include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
 #include "qom/object.h"
diff --git a/chardev/char.c b/chardev/char.c
index a9daf9956c..abd525f75e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -26,54 +26,16 @@
 #include "qemu/cutils.h"
 #include "monitor/monitor.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/block-backend.h"
+#include "qemu/config-file.h"
 #include "qemu/error-report.h"
-#include "qemu/timer.h"
 #include "sysemu/char.h"
-#include "hw/usb.h"
 #include "qmp-commands.h"
-#include "qapi/clone-visitor.h"
 #include "qapi-visit.h"
-#include "qemu/base64.h"
-#include "io/channel-socket.h"
-#include "io/channel-tls.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
=20
-#include <zlib.h>
-
-#ifndef _WIN32
-#include <sys/times.h>
-#include <sys/wait.h>
-#include <sys/ioctl.h>
-#include <sys/resource.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <net/if.h>
-#include <arpa/inet.h>
-#include <netdb.h>
-#include <sys/select.h>
-#ifdef __sun__
-#include <sys/ethernet.h>
-#include <sys/sockio.h>
-#include <netinet/arp.h>
-#include <netinet/in.h>
-#include <netinet/in_systm.h>
-#include <netinet/ip.h>
-#include <netinet/ip_icmp.h> // must come after ip.h
-#include <netinet/udp.h>
-#include <netinet/tcp.h>
-#endif
-#endif
-
-#include "qemu/sockets.h"
-#include "ui/qemu-spice.h"
-
 #include "char-mux.h"
 #include "char-io.h"
-#ifdef _WIN32
-#include "char-win.h"
-#endif
 #include "char-parallel.h"
 #include "char-serial.h"
=20
diff --git a/hmp.c b/hmp.c
index 8522efea26..2bc4f062bb 100644
--- a/hmp.c
+++ b/hmp.c
@@ -19,6 +19,7 @@
 #include "net/eth.h"
 #include "sysemu/char.h"
 #include "sysemu/block-backend.h"
+#include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
 #include "qmp-commands.h"
diff --git a/monitor.c b/monitor.c
index 25a480a95e..b0181cb0e6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -40,6 +40,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
+#include "qemu/config-file.h"
 #include "qemu/readline.h"
 #include "ui/console.h"
 #include "ui/input.h"
diff --git a/qmp.c b/qmp.c
index 2834f02b69..dfaabac1a6 100644
--- a/qmp.c
+++ b/qmp.c
@@ -18,6 +18,7 @@
 #include "qemu/cutils.h"
 #include "monitor/monitor.h"
 #include "sysemu/sysemu.h"
+#include "qemu/config-file.h"
 #include "qemu/uuid.h"
 #include "qmp-commands.h"
 #include "sysemu/char.h"
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index f3ac6ea21a..2c45c7b29f 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -12,6 +12,7 @@
=20
 #include "libqtest.h"
 #include "qapi/error.h"
+#include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
--=20
2.11.0.295.gd7dffce1c.dirty
