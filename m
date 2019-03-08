Received: from eggs.gnu.org ([209.51.188.92]:58369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24PL-0003Sy-Vj
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24PL-0002G5-1W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:34:43 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 02:32:15 +0100
Message-Id: <20190308013222.12524-12-philmd@redhat.com>
In-Reply-To: <20190308013222.12524-1-philmd@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/18] hw/nvram/fw_cfg: Add
 boot_splash.time_le16 to FWCfgState
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

Similar to the previous commit, use the FWCfgState lifetime state
to hold the 'bst_le16' variable content (renaned as time_le16).
Doing so we avoid a memory leak.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c         | 6 +++---
 include/hw/nvram/fw_cfg.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 182d27f59a..3ac6687a04 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -187,7 +187,6 @@ static void fw_cfg_bootsplash(FWCfgState *s)
     /* insert splash time if user configurated */
     if (boot_splash_time) {
         int64_t bst_val =3D qemu_opt_get_number(opts, "splash-time", -1)=
;
-        uint16_t bst_le16;
=20
         /* validate the input */
         if (bst_val < 0 || bst_val > 0xffff) {
@@ -196,9 +195,10 @@ static void fw_cfg_bootsplash(FWCfgState *s)
             exit(1);
         }
         /* use little endian format */
-        bst_le16 =3D cpu_to_le16(bst_val);
+        s->boot_splash.time_le16 =3D cpu_to_le16(bst_val);
         fw_cfg_add_file(s, "etc/boot-menu-wait",
-                        g_memdup(&bst_le16, sizeof bst_le16), sizeof bst=
_le16);
+                        &s->boot_splash.time_le16,
+                        sizeof(s->boot_splash.time_le16));
     }
=20
     /* insert splash file if user configurated */
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 99f6fafcaa..fcb771186c 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -55,6 +55,9 @@ struct FWCfgState {
     MemoryRegion dma_iomem;
=20
     uint32_t reboot_timeout;
+    struct {
+        uint16_t time_le16;
+    } boot_splash;
 };
=20
 struct FWCfgIoState {
--=20
2.20.1
