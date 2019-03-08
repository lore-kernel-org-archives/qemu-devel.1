Received: from eggs.gnu.org ([209.51.188.92]:58074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24P7-0003ES-5S
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24P4-0001nu-Vh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:34:29 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 02:32:14 +0100
Message-Id: <20190308013222.12524-11-philmd@redhat.com>
In-Reply-To: <20190308013222.12524-1-philmd@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/18] hw/nvram/fw_cfg: Add reboot_timeout
 to FWCfgState
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

Due to the contract interface of fw_cfg_add_file(), the
'reboot_timeout' data has to be valid for the lifetime of the
FwCfg object. For this reason it is copied on the heap with
memdup().

The object state, 'FWCfgState', is also meant to be valid during the
lifetime of the object.
Move the 'reboot_timeout' in FWCfgState to achieve the same purpose.
Doing so we avoid a memory leak.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c         | 4 +++-
 include/hw/nvram/fw_cfg.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b73a591eff..182d27f59a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -250,7 +250,9 @@ static void fw_cfg_reboot(FWCfgState *s)
         }
     }
=20
-    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_val, 4), 4);
+    s->reboot_timeout =3D rt_val;
+    fw_cfg_add_file(s, "etc/boot-fail-wait",
+                    &s->reboot_timeout, sizeof(s->reboot_timeout));
 }
=20
 static void fw_cfg_write(FWCfgState *s, uint8_t value)
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 828ad9dedc..99f6fafcaa 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -53,6 +53,8 @@ struct FWCfgState {
     dma_addr_t dma_addr;
     AddressSpace *dma_as;
     MemoryRegion dma_iomem;
+
+    uint32_t reboot_timeout;
 };
=20
 struct FWCfgIoState {
--=20
2.20.1
