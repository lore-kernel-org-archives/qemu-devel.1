Received: from eggs.gnu.org ([2001:4830:134:3::10]:39266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJykL-0005Vt-PW
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJyWO-0005Dw-C5
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:23:48 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Nov 2018 11:23:31 +0100
Message-Id: <20181106102335.20027-3-kraxel@redhat.com>
In-Reply-To: <20181106102335.20027-1-kraxel@redhat.com>
References: <20181106102335.20027-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/6] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Indicates support state for something (device, backend, subsystem, ...)
in qemu.  Add QemuSupportState field to ObjectClass.  Add some support
code.

TODO: wire up to qom-list-types

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/support-state.h | 17 +++++++++++++++++
 include/qom/object.h         |  3 +++
 util/support-state.c         | 26 ++++++++++++++++++++++++++
 qapi/common.json             | 32 ++++++++++++++++++++++++++++++++
 util/Makefile.objs           |  1 +
 5 files changed, 79 insertions(+)
 create mode 100644 include/qemu/support-state.h
 create mode 100644 util/support-state.c

diff --git a/include/qemu/support-state.h b/include/qemu/support-state.h
new file mode 100644
index 0000000000..6567d8702b
--- /dev/null
+++ b/include/qemu/support-state.h
@@ -0,0 +1,17 @@
+#ifndef QEMU_SUPPORT_STATE_H
+#define QEMU_SUPPORT_STATE_H
+
+#include "qapi/qapi-types-common.h"
+
+typedef struct QemuSupportState {
+    SupportState state;
+    const char   *help;
+} QemuSupportState;
+
+void qemu_warn_support_state(const char *type, const char *name,
+                             ObjectClass *oc);
+
+bool qemu_is_deprecated(ObjectClass *oc);
+bool qemu_is_obsolete(ObjectClass *oc);
+
+#endif /* QEMU_SUPPORT_STATE_H */
diff --git a/include/qom/object.h b/include/qom/object.h
index 499e1fd8b7..2b5f27bf85 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -15,6 +15,7 @@
 #define QEMU_OBJECT_H
 
 #include "qapi/qapi-builtin-types.h"
+#include "qemu/support-state.h"
 #include "qemu/queue.h"
 
 struct TypeImpl;
@@ -399,6 +400,8 @@ struct ObjectClass
     ObjectUnparent *unparent;
 
     GHashTable *properties;
+
+    QemuSupportState supported;
 };
 
 /**
diff --git a/util/support-state.c b/util/support-state.c
new file mode 100644
index 0000000000..3170dbd15d
--- /dev/null
+++ b/util/support-state.c
@@ -0,0 +1,26 @@
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/support-state.h"
+#include "qom/object.h"
+
+void qemu_warn_support_state(const char *type, const char *name,
+                             ObjectClass *oc)
+{
+    const char *help = oc->supported.help;
+
+    warn_report("%s %s is %s%s%s%s", type, name,
+                SupportState_str(oc->supported.state),
+                help ? " (" : "",
+                help ? help : "",
+                help ? ")"  : "");
+}
+
+bool qemu_is_deprecated(ObjectClass *oc)
+{
+    return oc->supported.state == SUPPORT_STATE_DEPRECATED;
+}
+
+bool qemu_is_obsolete(ObjectClass *oc)
+{
+    return oc->supported.state == SUPPORT_STATE_OBSOLETE;
+}
diff --git a/qapi/common.json b/qapi/common.json
index 021174f04e..00374127b8 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -151,3 +151,35 @@
              'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
              'x86_64', 'xtensa', 'xtensaeb' ] }
+
+##
+# @SupportState:
+#
+# Indicate Support level of qemu devices, backends, subsystems, ...
+#
+# @unspecified: not specified (zero-initialized).
+#
+# @experimental: in development, can be unstable or incomplete.
+#
+# @supported: works stable and is fully supported.
+#             (supported + maintained in MAINTAINERS).
+#
+# @unsupported: should work, support is weak or not present.
+#               (odd-fixes + orphan in MAINTAINERS).
+#
+# @obsolete: is obsolete, still present for compatibility reasons,
+#            will likely be removed at some point in the future.
+#            Not deprecated (yet).
+#            (obsolete in MAINTAINERS).
+#
+# @deprecated: is deprecated, according to qemu deprecation policy.
+#
+# Since: 3.2
+##
+{ 'enum': 'SupportState',
+  'data': [ 'unspecified',
+            'experimental',
+            'supported',
+            'unsupported',
+            'obsolete',
+            'deprecated' ] }
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 0820923c18..6e5f8faf82 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -50,5 +50,6 @@ util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
 util-obj-y += iova-tree.o
+util-obj-y += support-state.o
 util-obj-$(CONFIG_LINUX) += vfio-helpers.o
 util-obj-$(CONFIG_OPENGL) += drm.o
-- 
2.9.3
