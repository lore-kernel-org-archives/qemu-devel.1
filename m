Received: from eggs.gnu.org ([209.51.188.92]:43139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hD41Q-0000hI-2V
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hD41O-000425-3Q
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:23:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hD41M-00041N-AM
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:23:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Sun,  7 Apr 2019 11:23:14 +0200
Message-Id: <20190407092314.11066-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

QEMU currently crashes when you try to hot-plug an "nvdimm" device
on older machine types:

$ qemu-system-x86_64 -monitor stdio -M pc-1.1
QEMU 3.1.92 monitor - type 'help' for more information
(qemu) device_add nvdimm,id=3Dnvdimmn1
qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
 Assertion `*errp =3D=3D ((void *)0)' failed.
Aborted (core dumped)

The call to hotplug_handler_pre_plug() in pc_memory_pre_plug() has been
added recently before the check whether nvdimm is enabled. It should
be done after the check. And while we're at it, also check the errp
after the hotplug_handler_pre_plug(), otherwise errors are silently
ignored here.

Fixes: 9040e6dfa8c3fed87695a3de555d2c775727bb51
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6077d27361..f2c15bf1f2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2078,6 +2078,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
     const MachineState *ms =3D MACHINE(hotplug_dev);
     const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
     const uint64_t legacy_align =3D TARGET_PAGE_SIZE;
+    Error *local_err =3D NULL;
=20
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
@@ -2090,13 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
         return;
     }
=20
-    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
-
     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M=
'");
         return;
     }
=20
+    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, =
errp);
 }
--=20
2.21.0
