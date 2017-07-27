Received: from eggs.gnu.org ([2001:4830:134:3::10]:58927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal44-0008GW-CV
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal41-0006Xq-7p
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dal40-0006Ww-VW
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:01 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:41:21 +0200
Message-Id: <20170727154126.11339-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170727154126.11339-1-marcandre.lureau@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/26] build-sys: make qemu qapi objects
 per-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

The qapi schema has per-target definitions. Move qapi objects in the
per-target build, so they can be configured at compile time.

Keep qapi-types.o qapi-visit.o in util-obj as they are necessary for
common code, but they will be overwritten during the target link. Add
some stubs for block events, in code shared by tools & qemu.

The following patch will configure the schema to conditionally remove
per-target disabled features.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 stubs/qapi-event.c                 | 74 ++++++++++++++++++++++++++++++++=
++++++
 tests/test-qobject-input-visitor.c |  1 -
 Makefile.objs                      |  9 +----
 Makefile.target                    |  4 +++
 stubs/Makefile.objs                |  1 +
 trace/Makefile.objs                |  2 +-
 6 files changed, 81 insertions(+), 10 deletions(-)
 create mode 100644 stubs/qapi-event.c

diff --git a/stubs/qapi-event.c b/stubs/qapi-event.c
new file mode 100644
index 0000000000..9415299f3a
--- /dev/null
+++ b/stubs/qapi-event.c
@@ -0,0 +1,74 @@
+#include "qemu/osdep.h"
+#include "qapi-event.h"
+
+void qapi_event_send_device_tray_moved(const char *device, const char *i=
d,
+                                       bool tray_open, Error **errp)
+{
+}
+
+void qapi_event_send_quorum_report_bad(QuorumOpType type, bool has_error=
,
+                                       const char *error, const char *no=
de_name,
+                                       int64_t sector_num,
+                                       int64_t sectors_count, Error **er=
rp)
+{
+}
+
+void qapi_event_send_quorum_failure(const char *reference, int64_t secto=
r_num,
+                                    int64_t sectors_count, Error **errp)
+{
+}
+
+void qapi_event_send_block_job_cancelled(BlockJobType type, const char *=
device,
+                                         int64_t len, int64_t offset,
+                                         int64_t speed, Error **errp)
+{
+}
+
+void qapi_event_send_block_job_completed(BlockJobType type, const char *=
device,
+                                         int64_t len, int64_t offset,
+                                         int64_t speed, bool has_error,
+                                         const char *error, Error **errp=
)
+{
+}
+
+void qapi_event_send_block_job_error(const char *device,
+                                     IoOperationType operation,
+                                     BlockErrorAction action, Error **er=
rp)
+{
+}
+
+void qapi_event_send_block_job_ready(BlockJobType type, const char *devi=
ce,
+                                     int64_t len, int64_t offset, int64_=
t speed,
+                                     Error **errp)
+{
+}
+
+void qapi_event_send_block_io_error(const char *device, const char *node=
_name,
+                                    IoOperationType operation,
+                                    BlockErrorAction action, bool has_no=
space,
+                                    bool nospace, const char *reason,
+                                    Error **errp)
+{
+}
+
+void qapi_event_send_block_image_corrupted(const char *device,
+                                           bool has_node_name,
+                                           const char *node_name,
+                                           const char *msg, bool has_off=
set,
+                                           int64_t offset, bool has_size=
,
+                                           int64_t size, bool fatal,
+                                           Error **errp)
+{
+}
+
+void qapi_event_send_block_write_threshold(const char *node_name,
+                                           uint64_t amount_exceeded,
+                                           uint64_t write_threshold,
+                                           Error **errp)
+{
+}
+
+void qapi_event_send_device_deleted(bool has_device, const char *device,
+                                    const char *path, Error **errp)
+{
+}
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 4da5d02c35..0a9352c5c1 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -1266,7 +1266,6 @@ static void test_visitor_in_qmp_introspect(TestInpu=
tVisitorData *data,
                                            const void *unused)
 {
     do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
-    do_test_visitor_in_qmp_introspect(data, &qmp_schema_qlit);
 }
=20
 int main(int argc, char **argv)
diff --git a/Makefile.objs b/Makefile.objs
index 24a4ea08b8..2664720f9b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -2,7 +2,7 @@
 # Common libraries for tools and emulators
 stub-obj-y =3D stubs/ crypto/
 util-obj-y =3D util/ qobject/ qapi/
-util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
+util-obj-y +=3D qapi-types.o qapi-visit.o
=20
 chardev-obj-y =3D chardev/
=20
@@ -72,13 +72,6 @@ common-obj-y +=3D chardev/
 common-obj-$(CONFIG_SECCOMP) +=3D qemu-seccomp.o
=20
 common-obj-$(CONFIG_FDT) +=3D device_tree.o
-
-######################################################################
-# qapi
-
-common-obj-y +=3D qmp-marshal.o
-common-obj-y +=3D qmp-introspect.o
-common-obj-y +=3D qmp.o hmp.o
 endif
=20
 #######################################################################
diff --git a/Makefile.target b/Makefile.target
index 2baec9252f..a97dd056ad 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -154,6 +154,10 @@ endif
=20
 GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
=20
+obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
+obj-y +=3D qmp-marshal.o qmp-introspect.o
+obj-y +=3D qmp.o hmp.o
+
 endif # CONFIG_SOFTMMU
=20
 # Workaround for http://gcc.gnu.org/PR55489, see configure.
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f5b47bfd74..1b2bef99c9 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -21,6 +21,7 @@ stub-obj-y +=3D machine-init-done.o
 stub-obj-y +=3D migr-blocker.o
 stub-obj-y +=3D monitor.o
 stub-obj-y +=3D notify-event.o
+stub-obj-y +=3D qapi-event.o
 stub-obj-y +=3D qtest.o
 stub-obj-y +=3D replay.o
 stub-obj-y +=3D runstate-check.o
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index afd571c3ec..6447729d60 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -56,4 +56,4 @@ util-obj-$(CONFIG_TRACE_SIMPLE) +=3D simple.o
 util-obj-$(CONFIG_TRACE_FTRACE) +=3D ftrace.o
 util-obj-y +=3D control.o
 target-obj-y +=3D control-target.o
-util-obj-y +=3D qmp.o
+target-obj-y +=3D qmp.o
--=20
2.14.0.rc0.1.g40ca67566
