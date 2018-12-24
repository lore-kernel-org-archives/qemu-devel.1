Received: from eggs.gnu.org ([208.118.235.92]:45910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gbOms-0002xw-Ua
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 06:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gbOmn-0001VC-O7
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 06:52:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gbOmn-0001TX-GN
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 06:52:41 -0500
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Date: Mon, 24 Dec 2018 06:52:35 -0500
Message-Id: <20181224115235.16881-2-wainersm@redhat.com>
In-Reply-To: <20181224115235.16881-1-wainersm@redhat.com>
References: <20181224115235.16881-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 1/1] hw/core: add qom getter for
 kernel-irqchip property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, peterx@redhat.com

Allows to access the kernel-irqchip property of a Machine
Class object via QOM get method.

Before this patch the property cannot be read although it is
listed by qom-list:

qemu-system-x86_64 -M q35,accel=3Dkvm,kernel-irqchip=3Dsplit (...)
-> {"execute": "qom-list", "arguments": {"path": "/machine"}}
<- {"return": [{"name": "type", "type": "string"}, (...) , {"name": "kern=
el-irqchip", "type": "on|off|split"} (...)}
-> {"execute": "qom-get", "arguments": {"path": "/machine", "property": "=
kernel-irqchip"}}
<- {"error": {"class": "GenericError", "desc": "Insufficient permission t=
o perform this operation"}}

It is implemented the machine_get_kernel_irqchip() method,
which evaluates the kernel_irqchip_allowed, *_required, and
*_split fields to determine the value of kernel-irqchip. Note: we
assume there is not inconsistency on the value of those fields.

Then with this change in place, it works as expected:

qemu-system-x86_64 -M q35,accel=3Dkvm,kernel-irqchip=3Dsplit (...)
-> {"execute": "qom-get", "arguments": {"path": "/machine", "property": "=
kernel-irqchip"}}
<- {"return": "split"}

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 hw/core/machine.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c51423b647..f61003f8f2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,6 +37,21 @@ static void machine_set_accel(Object *obj, const char =
*value, Error **errp)
     ms->accel =3D g_strdup(value);
 }
=20
+static void machine_get_kernel_irqchip(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+    OnOffSplit mode;
+
+    if (ms->kernel_irqchip_split) {
+        mode =3D ON_OFF_SPLIT_SPLIT;
+    } else {
+        mode =3D (ms->kernel_irqchip_allowed && ms->kernel_irqchip_requi=
red) ?
+                ON_OFF_SPLIT_ON : ON_OFF_SPLIT_OFF;
+    }
+    visit_type_OnOffSplit(v, name, &mode, errp);
+}
 static void machine_set_kernel_irqchip(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
@@ -540,7 +555,7 @@ static void machine_class_init(ObjectClass *oc, void =
*data)
         "Accelerator list", &error_abort);
=20
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-        NULL, machine_set_kernel_irqchip,
+        machine_get_kernel_irqchip, machine_set_kernel_irqchip,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure KVM in-kernel irqchip", &error_abort);
--=20
2.19.2
