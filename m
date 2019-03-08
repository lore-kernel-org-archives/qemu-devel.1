Received: from eggs.gnu.org ([209.51.188.92]:57578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24OX-0002e9-9m
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24OV-0001BC-TD
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:33:52 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 02:32:11 +0100
Message-Id: <20190308013222.12524-8-philmd@redhat.com>
In-Reply-To: <20190308013222.12524-1-philmd@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/18] hw/nvram/fw_cfg: Add
 fw_cfg_common_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

Back in abe147e0ce4 when fw_cfg_add_file() was introduced, there
was no QOM design, object where not created and released at runtime.
Later 38f3adc34d finished the QOM conversion of the fw_cfg device,
adding the fw_cfg_common_realize() method.
The time has come to add the equivalent destructor and release the
memory allocated for 'files'.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b2dc0a80cb..0fb020edce 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -959,6 +959,13 @@ static void fw_cfg_common_realize(DeviceState *dev, =
Error **errp)
     qemu_add_machine_init_done_notifier(&s->machine_ready);
 }
=20
+static void fw_cfg_common_unrealize(DeviceState *dev, Error **errp)
+{
+    FWCfgState *s =3D FW_CFG(dev);
+
+    g_free(s->files);
+}
+
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as)
 {
@@ -1127,6 +1134,7 @@ static void fw_cfg_io_class_init(ObjectClass *klass=
, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->realize =3D fw_cfg_io_realize;
+    dc->unrealize =3D fw_cfg_common_unrealize;
     dc->props =3D fw_cfg_io_properties;
 }
=20
@@ -1190,6 +1198,7 @@ static void fw_cfg_mem_class_init(ObjectClass *klas=
s, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->realize =3D fw_cfg_mem_realize;
+    dc->unrealize =3D fw_cfg_common_unrealize;
     dc->props =3D fw_cfg_mem_properties;
 }
=20
--=20
2.20.1
