Received: from eggs.gnu.org ([2001:4830:134:3::10]:48532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6u-0004E0-9b
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6r-0001UJ-5C
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:08 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 15 May 2018 11:18:56 +0200
Message-Id: <20180515091901.27774-6-kraxel@redhat.com>
In-Reply-To: <20180515091901.27774-1-kraxel@redhat.com>
References: <20180515091901.27774-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 05/10] ui: add qapi parser for -display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Add parse_display_qapi() function which parses the -display command line
using a qapi visitor for DisplayOptions.  Wire up as default catch in
parse_display().

Improves the error message for unknown display types.

Also enables json as -display argument, i.e. -display "{ 'type': 'gtk' }"

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180507095539.19584-2-kraxel@redhat.com
---
 vl.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index b9f6b42779..c56f7f8046 100644
--- a/vl.c
+++ b/vl.c
@@ -120,12 +120,14 @@ int main(int argc, char **argv)
 #include "ui/qemu-spice.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/opts-visitor.h"
+#include "qapi/clone-visitor.h"
 #include "qom/object_interfaces.h"
 #include "exec/semihost.h"
 #include "crypto/init.h"
 #include "sysemu/replay.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-visit-ui.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-run-state.h"
@@ -2088,6 +2090,25 @@ static void select_vgahw(const char *p)
     }
 }
 
+static void parse_display_qapi(const char *optarg)
+{
+    Error *err = NULL;
+    DisplayOptions *opts;
+    Visitor *v;
+
+    v = qobject_input_visitor_new_str(optarg, "type", &err);
+    if (!v) {
+        error_report_err(err);
+        exit(1);
+    }
+
+    visit_type_DisplayOptions(v, NULL, &opts, &error_fatal);
+    QAPI_CLONE_MEMBERS(DisplayOptions, &dpy, opts);
+
+    qapi_free_DisplayOptions(opts);
+    visit_free(v);
+}
+
 static void parse_display(const char *p)
 {
     const char *opts;
@@ -2203,8 +2224,7 @@ static void parse_display(const char *p)
     } else if (strstart(p, "none", &opts)) {
         dpy.type = DISPLAY_TYPE_NONE;
     } else {
-        error_report("unknown display type");
-        exit(1);
+        parse_display_qapi(p);
     }
 }
 
-- 
2.9.3
