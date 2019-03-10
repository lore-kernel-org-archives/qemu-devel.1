Received: from eggs.gnu.org ([209.51.188.92]:48948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2mdc-0001Mv-FR
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2mdb-0006ep-Pb
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:48:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2mdb-0006eQ-JV
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:48:23 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 10 Mar 2019 01:47:48 +0100
Message-Id: <20190310004749.27029-4-philmd@redhat.com>
In-Reply-To: <20190310004749.27029-1-philmd@redhat.com>
References: <20190310004749.27029-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/4] hw/i386: Use
 edk2_add_host_crypto_policy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Enable the EDK2 Crypto Policy features on the PC machine.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 42128183e9..00dc377df0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -38,6 +38,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/timer/hpet.h"
 #include "hw/firmware/smbios.h"
+#include "hw/firmware/uefi_edk2.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "multiboot.h"
@@ -1046,6 +1047,11 @@ static FWCfgState *bochs_bios_init(AddressSpace *a=
s, PCMachineState *pcms)
     return fw_cfg;
 }
=20
+static void pc_uefi_setup(PCMachineState *pcms)
+{
+    edk2_add_host_crypto_policy(pcms->fw_cfg);
+}
+
 static long get_file_size(FILE *f)
 {
     long where, size;
@@ -1645,6 +1651,7 @@ void pc_machine_done(Notifier *notifier, void *data=
)
     if (pcms->fw_cfg) {
         pc_build_smbios(pcms);
         pc_build_feature_control_file(pcms);
+        pc_uefi_setup(pcms);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus)=
;
     }
--=20
2.20.1
