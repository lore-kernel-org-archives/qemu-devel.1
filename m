Received: from eggs.gnu.org ([2001:4830:134:3::10]:41042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLp-0005BW-ET
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLl-0004Wm-BK
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmLj-0004Ug-Cc
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:41 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:08 -0200
Message-Id: <20181211180129.7661-4-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/24] docs: Document vCPU hotplug procedure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kashyap Chamarthy <kchamart@redhat.com>

From: Kashyap Chamarthy <kchamart@redhat.com>

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Message-Id: <20181030123526.26415-4-kchamart@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/cpu-hotplug.rst | 142 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 docs/cpu-hotplug.rst

diff --git a/docs/cpu-hotplug.rst b/docs/cpu-hotplug.rst
new file mode 100644
index 0000000000..1c268e00b4
--- /dev/null
+++ b/docs/cpu-hotplug.rst
@@ -0,0 +1,142 @@
+===================
+Virtual CPU hotplug
+===================
+
+A complete example of vCPU hotplug (and hot-unplug) using QMP
+``device_add`` and ``device_del``.
+
+vCPU hotplug
+------------
+
+(1) Launch QEMU as follows (note that the "maxcpus" is mandatory to
+    allow vCPU hotplug)::
+
+      $ qemu-system-x86_64 -display none -no-user-config -m 2048 \
+          -nodefaults -monitor stdio -machine pc,accel=kvm,usb=off \
+          -smp 1,maxcpus=2 -cpu IvyBridge-IBRS \
+          -qmp unix:/tmp/qmp-sock,server,nowait
+
+(2) Run 'qmp-shell' (located in the source tree, under: "scripts/qmp/)
+    to connect to the just-launched QEMU::
+
+      $> ./qmp-shell -p -v /tmp/qmp-sock
+      [...]
+      (QEMU)
+
+(3) Find out which CPU types could be plugged, and into which sockets::
+
+      (QEMU) query-hotpluggable-cpus
+      {
+          "execute": "query-hotpluggable-cpus",
+          "arguments": {}
+      }
+      {
+          "return": [
+              {
+                  "type": "IvyBridge-IBRS-x86_64-cpu",
+                  "vcpus-count": 1,
+                  "props": {
+                      "socket-id": 1,
+                      "core-id": 0,
+                      "thread-id": 0
+                  }
+              },
+              {
+                  "qom-path": "/machine/unattached/device[0]",
+                  "type": "IvyBridge-IBRS-x86_64-cpu",
+                  "vcpus-count": 1,
+                  "props": {
+                      "socket-id": 0,
+                      "core-id": 0,
+                      "thread-id": 0
+                  }
+              }
+          ]
+      }
+      (QEMU)
+
+(4) The ``query-hotpluggable-cpus`` command returns an object for CPUs
+    that are present (containing a "qom-path" member) or which may be
+    hot-plugged (no "qom-path" member).  From its output in step (3), we
+    can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0,
+    while hot-plugging a CPU into socket 1 requires passing the listed
+    properties to QMP ``device_add``:
+
+      (QEMU) device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=1 core-id=0 thread-id=0
+      {
+          "execute": "device_add",
+          "arguments": {
+              "socket-id": 1,
+              "driver": "IvyBridge-IBRS-x86_64-cpu",
+              "id": "cpu-2",
+              "core-id": 0,
+              "thread-id": 0
+          }
+      }
+      {
+          "return": {}
+      }
+      (QEMU)
+
+(5) Optionally, run QMP `query-cpus-fast` for some details about the
+    vCPUs::
+
+      (QEMU) query-cpus-fast
+      {
+          "execute": "query-cpus-fast",
+          "arguments": {}
+      }
+      {
+          "return": [
+              {
+                  "qom-path": "/machine/unattached/device[0]",
+                  "target": "x86_64",
+                  "thread-id": 11534,
+                  "cpu-index": 0,
+                  "props": {
+                      "socket-id": 0,
+                      "core-id": 0,
+                      "thread-id": 0
+                  },
+                  "arch": "x86"
+              },
+              {
+                  "qom-path": "/machine/peripheral/cpu-2",
+                  "target": "x86_64",
+                  "thread-id": 12106,
+                  "cpu-index": 1,
+                  "props": {
+                      "socket-id": 1,
+                      "core-id": 0,
+                      "thread-id": 0
+                  },
+                  "arch": "x86"
+              }
+          ]
+      }
+      (QEMU)
+
+vCPU hot-unplug
+---------------
+
+From the 'qmp-shell', invoke the QMP ``device_del`` command::
+
+      (QEMU) device_del id=cpu-2
+      {
+          "execute": "device_del",
+          "arguments": {
+              "id": "cpu-2"
+          }
+      }
+      {
+          "return": {}
+      }
+      (QEMU)
+
+.. note::
+    vCPU hot-unplug requires guest cooperation; so the ``device_del``
+    command above does not guarantee vCPU removal -- it's a "request to
+    unplug".  At this point, the guest will get a System Control
+    Interupt (SCI) and calls the ACPI handler for the affected vCPU
+    device.  Then the guest kernel will bring the vCPU offline and tell
+    QEMU to unplug it.
-- 
2.18.0.rc1.1.g3f1ff2140
