Received: from eggs.gnu.org ([209.51.188.92]:39113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4l-0003Vp-53
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4j-0000rz-3j
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEb4i-0000nL-Pe
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BC2880E4B
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 14:53:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 11 Apr 2019 16:52:55 +0200
Message-Id: <20190411145256.8614-15-armbru@redhat.com>
In-Reply-To: <20190411145256.8614-1-armbru@redhat.com>
References: <20190411145256.8614-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/15] char: Make -chardev help print to
 stdout
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

Command line help explicitly requested by the user should be printed
to stdout, not stderr.  We do elsewhere.  Adjust -chardev to match:
use qemu_printf() instead of error_printf().  Plain printf() would be
wrong because we need to print to the current monitor for "chardev-add
help".

Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 514cd6b0c3..54724a56b1 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "chardev/char.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
@@ -651,7 +652,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMain=
Context *context,
=20
         chardev_name_foreach(help_string_append, str);
=20
-        error_printf("Available chardev backend types: %s\n", str->str);
+        qemu_printf("Available chardev backend types: %s\n", str->str);
         g_string_free(str, true);
         return NULL;
     }
--=20
2.17.2
