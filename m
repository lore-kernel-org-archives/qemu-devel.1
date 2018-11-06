Received: from eggs.gnu.org ([2001:4830:134:3::10]:39244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJykL-0005Rx-Sf
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJyWQ-0005H4-Gy
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:23:48 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Nov 2018 11:23:35 +0100
Message-Id: <20181106102335.20027-7-kraxel@redhat.com>
In-Reply-To: <20181106102335.20027-1-kraxel@redhat.com>
References: <20181106102335.20027-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] add UsageHints to QemuSupportState
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

So we can add device usage recommendations to devices,
independant from support state.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/support-state.h |  1 +
 qapi/common.json             | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/qemu/support-state.h b/include/qemu/support-state.h
index 6567d8702b..6ea0d03bd5 100644
--- a/include/qemu/support-state.h
+++ b/include/qemu/support-state.h
@@ -5,6 +5,7 @@
 
 typedef struct QemuSupportState {
     SupportState state;
+    UsageHints   hints;
     const char   *help;
 } QemuSupportState;
 
diff --git a/qapi/common.json b/qapi/common.json
index 00374127b8..6952ea2074 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -183,3 +183,32 @@
             'unsupported',
             'obsolete',
             'deprecated' ] }
+
+##
+# @UsageHints:
+#
+# Usage recommendations.
+#
+# @unspecified: not specified (zero-initialized).
+#
+# @green: Best choice.  Typically paravirtual devices go into this
+#         category.
+#         Example (nic): virtio-net.
+#         Example (usb); xhci.
+#
+# @yellow: Reasonable choice.  Typically emulated devices with
+#          good performance go into this category.
+#          Example (nic): e1000, e1000e
+#
+# @red: Bad choice.  Avoid this unless you run an old guest which
+#       lacks support for something better.
+#       Example (nic): rtl8139, pcnet, ne2k, ...
+#       Example (usb): ehci, uhci, ohci
+#
+# Since: 3.2
+##
+{ 'enum': 'UsageHints',
+  'data': [ 'unspecified',
+            'green',
+            'yellow',
+            'red' ] }
-- 
2.9.3
