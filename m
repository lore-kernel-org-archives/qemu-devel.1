Received: from eggs.gnu.org ([2001:4830:134:3::10]:53663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHRyC-0000xt-JT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHRy9-00084z-0M
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:14:00 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 Oct 2018 12:13:45 +0100
Message-Id: <20181030111348.14713-2-kraxel@redhat.com>
In-Reply-To: <20181030111348.14713-1-kraxel@redhat.com>
References: <20181030111348.14713-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Indicates support state for somerhing (device, backend, subsystem, ...)
in qemu.  Modeled roughly after the "S:" states we have in MAINTANERS.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/support-state.h | 17 +++++++++++++++++
 util/support-state.c         | 23 +++++++++++++++++++++++
 qapi/common.json             | 16 ++++++++++++++++
 util/Makefile.objs           |  1 +
 4 files changed, 57 insertions(+)
 create mode 100644 include/qemu/support-state.h
 create mode 100644 util/support-state.c

diff --git a/include/qemu/support-state.h b/include/qemu/support-state.h
new file mode 100644
index 0000000000..5fd3c83eee
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
+    const char *reason;
+} QemuSupportState;
+
+void qemu_warn_support_state(const char *type, const char *name,
+                             QemuSupportState *state);
+
+bool qemu_is_deprecated(QemuSupportState *state);
+bool qemu_is_obsolete(QemuSupportState *state);
+
+#endif /* QEMU_SUPPORT_STATE_H */
diff --git a/util/support-state.c b/util/support-state.c
new file mode 100644
index 0000000000..7966fa0fc7
--- /dev/null
+++ b/util/support-state.c
@@ -0,0 +1,23 @@
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/support-state.h"
+
+void qemu_warn_support_state(const char *type, const char *name,
+                             QemuSupportState *state)
+{
+    warn_report("%s %s is %s%s%s%s", type, name,
+                SupportState_str(state->state),
+                state->reason ? " ("          : "",
+                state->reason ? state->reason : "",
+                state->reason ? ")"           : "");
+}
+
+bool qemu_is_deprecated(QemuSupportState *state)
+{
+    return state->state == SUPPORT_STATE_DEPRECATED;
+}
+
+bool qemu_is_obsolete(QemuSupportState *state)
+{
+    return state->state == SUPPORT_STATE_OBSOLETE;
+}
diff --git a/qapi/common.json b/qapi/common.json
index 021174f04e..78176151af 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -151,3 +151,19 @@
              'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
              'x86_64', 'xtensa', 'xtensaeb' ] }
+
+##
+# @SupportState:
+#
+# Indicate Support level of qemu devices, backends, subsystems, ...
+#
+# Since: 3.2
+##
+{ 'enum': 'SupportState',
+  'data': [ 'unknown',
+            'supported',
+            'maintained',
+            'odd-fixes',
+            'orphan',
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
