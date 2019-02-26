Received: from eggs.gnu.org ([209.51.188.92]:47881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyd9S-00010j-Rb
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gyd9S-0007rG-1T
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:52:06 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 26 Feb 2019 14:50:14 +0100
Message-Id: <20190226135014.31854-19-eric.auger@redhat.com>
In-Reply-To: <20190226135014.31854-1-eric.auger@redhat.com>
References: <20190226135014.31854-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 18/18] hw/arm/virt: Allow nvdimm
 instantiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

If NVDIMM option is enabled at machine level, let's allow
NVDIMM plug.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0a04f5ca88..932361fc3f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1823,13 +1823,14 @@ static void virt_memory_pre_plug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
     const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
+    MachineState *ms =3D MACHINE(hotplug_dev);
=20
     if (dev->hotplugged) {
         error_setg(errp, "memory hotplug is not supported");
     }
=20
-    if (is_nvdimm) {
-        error_setg(errp, "nvdimm is not yet supported");
+    if (is_nvdimm && !ms->acpi_nvdimm_state.is_enabled) {
+        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M=
'");
         return;
     }
=20
--=20
2.20.1
