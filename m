Received: from eggs.gnu.org ([2001:4830:134:3::10]:36405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dOOEY-0003TA-Ey
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dOOEU-0001lM-G7
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:46 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dOOEU-0001lB-6Z
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:42 -0400
Received: by mail-wr0-f179.google.com with SMTP id k67so64663478wrc.2
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:02:42 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri, 23 Jun 2017 15:02:35 +0200
Message-Id: <7e2e1329dbe5a6d93c3d58eb2251b8862e2d1340.1498222907.git.tgolembi@redhat.com>
In-Reply-To: <cover.1498222907.git.tgolembi@redhat.com>
References: <cover.1498222907.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 1/3] qemu-ga: add support for events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Events can play an integral role when monitoring internal state of the
guest OS. This patch adds the core functionality for adding events to
QEMU Guest Agent.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 Makefile               |  7 +++++-
 qga/Makefile.objs      |  2 +-
 qga/channel-posix.c    |  8 +++++++
 qga/channel-win32.c    |  6 +++++
 qga/channel.h          |  1 +
 qga/guest-agent-core.h |  1 +
 qga/main.c             | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-event.json    |  2 ++
 qga/qapi-schema.json   |  2 ++
 9 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 qga/qapi-event.json

diff --git a/Makefile b/Makefile
index c830d7a46c..03e2174a18 100644
--- a/Makefile
+++ b/Makefile
@@ -408,6 +408,11 @@ $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
 		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$@")
+qga/qapi-generated/qga-qapi-event.c qga/qapi-generated/qga-qapi-event.h :\
+$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
+		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
+		"GEN","$@")
 
 qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
@@ -441,7 +446,7 @@ $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
 		$(gen-out-type) -o "." $<, \
 		"GEN","$@")
 
-QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qmp-commands.h)
+QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qmp-commands.h qga-qapi-event.h)
 $(qga-obj-y) qemu-ga.o: $(QGALIB_GEN)
 
 qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index 1c5986c0bb..24399b6325 100644
--- a/qga/Makefile.objs
+++ b/qga/Makefile.objs
@@ -3,6 +3,6 @@ qga-obj-$(CONFIG_POSIX) += commands-posix.o channel-posix.o
 qga-obj-$(CONFIG_WIN32) += commands-win32.o channel-win32.o service-win32.o
 qga-obj-$(CONFIG_WIN32) += vss-win32.o
 qga-obj-y += qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-visit.o
-qga-obj-y += qapi-generated/qga-qmp-marshal.o
+qga-obj-y += qapi-generated/qga-qmp-marshal.o qapi-generated/qga-qapi-event.o
 
 qga-vss-dll-obj-$(CONFIG_QGA_VSS) += vss-win32/
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 3f34465159..22e440724c 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -118,6 +118,14 @@ static int ga_channel_client_add(GAChannel *c, int fd)
     return 0;
 }
 
+gboolean ga_channel_client_attached(GAChannel *c)
+{
+    g_assert(c);
+    /* TODO: make this work with all methods. following works only with
+     * unix-listen */
+    return c->client_channel != NULL;
+}
+
 static gboolean ga_channel_open(GAChannel *c, const gchar *path,
                                 GAChannelMethod method, int fd)
 {
diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 7e6dc4d26f..b62a6a3859 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -315,6 +315,12 @@ static gboolean ga_channel_open(GAChannel *c, GAChannelMethod method,
     return true;
 }
 
+gboolean ga_channel_client_attached(GAChannel *c)
+{
+    /* TODO: make this work with all methods */
+    return true;
+}
+
 GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
                           int listen_fd, GAChannelCallback cb, gpointer opaque)
 {
diff --git a/qga/channel.h b/qga/channel.h
index 1778416115..030ec9e551 100644
--- a/qga/channel.h
+++ b/qga/channel.h
@@ -30,5 +30,6 @@ GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
 void ga_channel_free(GAChannel *c);
 GIOStatus ga_channel_read(GAChannel *c, gchar *buf, gsize size, gsize *count);
 GIOStatus ga_channel_write_all(GAChannel *c, const gchar *buf, gsize size);
+gboolean ga_channel_client_attached(GAChannel *c);
 
 #endif
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index 3e8a4acff2..47d6c73458 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -13,6 +13,7 @@
 #include "qapi/qmp/dispatch.h"
 #include "qemu-common.h"
 #include "qga-qmp-commands.h"
+#include "qga-qapi-event.h"
 
 #define QGA_READ_COUNT_DEFAULT 4096
 
diff --git a/qga/main.c b/qga/main.c
index cc58d2b53d..f16abb5cbb 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -23,6 +23,8 @@
 #include "qapi/qmp/qjson.h"
 #include "qga/guest-agent-core.h"
 #include "qemu/module.h"
+#include "qapi/qmp-event.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/dispatch.h"
 #include "qga/channel.h"
@@ -674,6 +676,59 @@ static gboolean channel_event_cb(GIOCondition condition, gpointer data)
     return true;
 }
 
+/* TODO: HACK HACK HACK... can't we get a GAstate somehow? */
+QDict *queued_event;
+static void ga_event_emit(qga_QAPIEvent event, QDict *qdict, Error **errp)
+{
+    if (queued_event) {
+        error_setg(errp, "unsent event already waiting");
+    } else {
+        QINCREF(qdict);
+        queued_event = qdict;
+    }
+}
+/* HACK HACK HACK!!! */
+
+static gboolean monitoring_cb(gpointer data)
+{
+    Error *err = NULL;
+    GAState *s = (GAState *)data;
+
+    g_assert(s->channel);
+    g_warning("monitoring!");
+
+    if (!ga_channel_client_attached(s->channel)) {
+        goto ok;
+    }
+
+    /* TODO: call something */
+    goto ok;
+
+/*fail:*/
+    g_assert(err);
+    g_warning("%s", error_get_pretty(err));
+    error_free(err);
+
+ok:
+    /* Always return true. False would remove this callback. */
+    return true;
+}
+
+static gboolean monitoring_init(GAState *s)
+{
+    if (g_timeout_add_seconds(5, monitoring_cb, (gpointer)s) <= 0) {
+        g_error("failed to create monitoring timer");
+        goto fail;
+    }
+    g_debug("monitoring timer created");
+
+    qmp_event_set_func_emit(ga_event_emit);
+    return true;
+
+fail:
+    return false;
+}
+
 static gboolean channel_init(GAState *s, const gchar *method, const gchar *path,
                              int listen_fd)
 {
@@ -1330,6 +1385,10 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
         g_critical("failed to initialize guest agent channel");
         return EXIT_FAILURE;
     }
+
+    /* TODO: error handling? */
+    monitoring_init(ga_state);
+
 #ifndef _WIN32
     g_main_loop_run(ga_state->main_loop);
 #else
diff --git a/qga/qapi-event.json b/qga/qapi-event.json
new file mode 100644
index 0000000000..9c14e4609e
--- /dev/null
+++ b/qga/qapi-event.json
@@ -0,0 +1,2 @@
+# *-*- Mode: Python -*-*
+
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 03743ab905..f30ba183bb 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1,5 +1,7 @@
 # *-*- Mode: Python -*-*
 
+{ 'include': 'qapi-event.json' }
+
 ##
 #
 # General note concerning the use of guest agent interfaces:
-- 
2.13.1
