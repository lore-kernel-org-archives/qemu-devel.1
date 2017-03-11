Received: from eggs.gnu.org ([2001:4830:134:3::10]:58911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh0B-0002aY-4O
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh08-0002ks-Ao
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmh08-0002kf-2B
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:04 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:51 +0400
Message-Id: <20170311132256.22951-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/21] qga: emit VMDUMP_INFO event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

When client connects, emit the VMDUMP_INFO.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/guest-agent-core.h |  2 ++
 qga/channel-posix.c    | 11 +++++++++++
 qga/main.c             | 13 +++++++++++++
 Makefile               |  7 ++++++-
 qga/Makefile.objs      |  1 +
 qga/qapi-schema.json   | 15 +++++++++++++++
 6 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index 3e8a4acff2..1880b0f0ac 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -46,3 +46,5 @@ int ga_parse_whence(GuestFileWhence *whence, Error **er=
rp);
 #ifndef _WIN32
 void reopen_fd_to_null(int fd);
 #endif
+
+void ga_client_added(void);
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 3f34465159..5999df0684 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -3,6 +3,7 @@
 #include "qapi/error.h"
 #include "qemu/sockets.h"
 #include "qga/channel.h"
+#include "qga/guest-agent-core.h"
=20
 #ifdef CONFIG_SOLARIS
 #include <stropts.h>
@@ -98,6 +99,13 @@ static gboolean ga_channel_client_event(GIOChannel *ch=
annel,
     return true;
 }
=20
+static gboolean client_added_idle_cb(gpointer user_data)
+{
+    ga_client_added();
+
+    return false;
+}
+
 static int ga_channel_client_add(GAChannel *c, int fd)
 {
     GIOChannel *client_channel;
@@ -115,6 +123,9 @@ static int ga_channel_client_add(GAChannel *c, int fd=
)
     g_io_add_watch(client_channel, G_IO_IN | G_IO_HUP,
                    ga_channel_client_event, c);
     c->client_channel =3D client_channel;
+
+    g_idle_add(client_added_idle_cb, NULL);
+
     return 0;
 }
=20
diff --git a/qga/main.c b/qga/main.c
index 8e852bd556..d2a874e67a 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -40,6 +40,7 @@
 #endif
 #endif
 #include "qapi/qmp-event.h"
+#include "qga-qapi-event.h"
=20
 #ifndef _WIN32
 #define QGA_VIRTIO_PATH_DEFAULT "/dev/virtio-ports/org.qemu.guest_agent.=
0"
@@ -691,6 +692,18 @@ static gboolean channel_event_cb(GIOCondition condit=
ion, gpointer data)
     return true;
 }
=20
+void ga_client_added(void)
+{
+#ifndef _WIN32
+    GAState *s =3D ga_state;
+
+    qapi_event_send_vmdump_info(s->vmdump.has_phys_base, s->vmdump.phys_=
base,
+                                s->vmdump.has_text, s->vmdump.text,
+                                s->vmdump.vmcoreinfo !=3D NULL,
+                                s->vmdump.vmcoreinfo, NULL);
+#endif
+}
+
 static gboolean channel_init(GAState *s, const gchar *method, const gcha=
r *path,
                              int listen_fd)
 {
diff --git a/Makefile b/Makefile
index 1c4c04f6f2..fc7e321041 100644
--- a/Makefile
+++ b/Makefile
@@ -404,6 +404,11 @@ $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts=
/qapi-commands.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
 		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$@")
+qga/qapi-generated/qga-qapi-event.c qga/qapi-generated/qga-qapi-event.h =
:\
+$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(=
qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
+		$(gen-out-type)  -o qga/qapi-generated -p "qga-" $<, \
+		"GEN","$@")
=20
 qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.js=
on \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.j=
son \
@@ -437,7 +442,7 @@ $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.p=
y $(qapi-py)
 		$(gen-out-type) -o "." $<, \
 		"GEN","$@")
=20
-QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qmp-commands.h)
+QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qmp-commands.h qga-qapi-event.h)
 $(qga-obj-y) qemu-ga.o: $(QGALIB_GEN)
=20
 qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index 1c5986c0bb..d22977f0e1 100644
--- a/qga/Makefile.objs
+++ b/qga/Makefile.objs
@@ -4,5 +4,6 @@ qga-obj-$(CONFIG_WIN32) +=3D commands-win32.o channel-win=
32.o service-win32.o
 qga-obj-$(CONFIG_WIN32) +=3D vss-win32.o
 qga-obj-y +=3D qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-v=
isit.o
 qga-obj-y +=3D qapi-generated/qga-qmp-marshal.o
+qga-obj-y +=3D qapi-generated/qga-qapi-event.o
=20
 qga-vss-dll-obj-$(CONFIG_QGA_VSS) +=3D vss-win32/
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index d421609dcb..2a95af3399 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -48,6 +48,21 @@
   'returns': 'int' }
=20
 ##
+# @VMDUMP_INFO:
+#
+# Provides VM dump information details to qemu.
+#
+# @phys-base: base address
+#
+# @text: "_text" location
+#
+# @vmcoreinfo: the content of /sys/kernel/vmcoreinfo on Linux
+#
+##
+{ 'event': 'VMDUMP_INFO',
+  'data': { '*phys-base': 'uint64', '*text': 'uint64', '*vmcoreinfo': 's=
tr' } }
+
+##
 # @guest-sync:
 #
 # Echo back a unique integer value
--=20
2.12.0.191.gc5d8de91d
