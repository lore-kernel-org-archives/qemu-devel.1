Received: from eggs.gnu.org ([2001:4830:134:3::10]:41505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNk-0005FG-Nm
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNa-0005nT-K4
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNa-0005hD-9U
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:38 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:01 +0200
Message-Id: <20181008173125.19678-8-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/31] 9pfs: Fix CLI parsing crash on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  9p-handle.c's handle_parse_opts() does that, and then
fails without setting an error.  Wrong.  Its caller crashes when it
tries to report the error:

    $ qemu-system-x86_64 -nodefaults -fsdev id=foo,fsdriver=handle
    qemu-system-x86_64: -fsdev id=foo,fsdriver=handle: warning: handle backend is deprecated
    qemu-system-x86_64: -fsdev id=foo,fsdriver=handle: fsdev: No path specified
    Segmentation fault (core dumped)

Screwed up when commit 91cda4e8f37 (v2.12.0) converted the function to
Error.  Fix by calling error_setg() instead of error_report().

Fixes: 91cda4e8f372602795e3a2f4bd2e3adaf9f82255
Cc: Greg Kurz <groug@kaod.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/9pfs/9p-handle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index f3641dbe4a..3465b1ef30 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -19,6 +19,7 @@
 #include <grp.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include "qapi/error.h"
 #include "qemu/xattr.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
@@ -655,12 +656,13 @@ static int handle_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
     warn_report("handle backend is deprecated");
 
     if (sec_model) {
-        error_report("Invalid argument security_model specified with handle fsdriver");
+        error_setg(errp,
+                   "Invalid argument security_model specified with handle fsdriver");
         return -1;
     }
 
     if (!path) {
-        error_report("fsdev: No path specified");
+        error_setg(errp, "fsdev: No path specified");
         return -1;
     }
     fse->path = g_strdup(path);
-- 
2.17.1
