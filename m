Received: from eggs.gnu.org ([2001:4830:134:3::10]:46673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99UU-0004dO-4t
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99UQ-0006LJ-VB
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:20:46 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Apr 2018 15:20:23 +0200
Message-Id: <20180419132026.5494-2-kraxel@redhat.com>
In-Reply-To: <20180419132026.5494-1-kraxel@redhat.com>
References: <20180419132026.5494-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] ui: add qapi parser for -display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Add parse_display_qapi() function which parses the -display command line
using a qapi visitor for DisplayOptions.  Wire up as default catch in
parse_display().

Improves the error message for unknown display types.

Also enables json as -display argument, i.e. -display "{ 'type': 'gtk' }"

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index fce1fd12d8..784c3fb795 100644
--- a/vl.c
+++ b/vl.c
@@ -126,6 +126,7 @@ int main(int argc, char **argv)
 #include "sysemu/replay.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-visit-ui.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-run-state.h"
@@ -2090,6 +2091,31 @@ static void select_vgahw(const char *p)
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
+    visit_free(v);
+
+    /*
+     * We don't have any dynamically allocated stuff inside
+     * DisplayOptions, so we can simply copy the struct content and
+     * free opts without ending up with pointers pointing into
+     * nowhere.
+     */
+    dpy = *opts;
+    qapi_free_DisplayOptions(opts);
+}
+
 static void parse_display(const char *p)
 {
     const char *opts;
@@ -2201,8 +2227,7 @@ static void parse_display(const char *p)
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
