Received: from eggs.gnu.org ([2001:4830:134:3::10]:58086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfnt-0003Ct-LG
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfno-0000GO-0M
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:35:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:30 -0300
Message-Id: <20181025133301.16578-13-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 12/43] hw/sparc64/niagara: Model the I/O
 Bridge with the 'unimplemented_device'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Since the I/O Bridge device is not implemented,  Use the
TYPE_UNIMPLEMENTED_DEVICE which suits better: if the user
asks for 'unimp' warnings via the -d option then all accesses
will generate logging.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20181002212522.23303-10-f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 default-configs/sparc64-softmmu.mak | 1 -
 hw/sparc64/niagara.c                | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc6=
4-softmmu.mak
index 52edafe547..ce63d47046 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -16,5 +16,4 @@ CONFIG_SIMBA=3Dy
 CONFIG_SUNHME=3Dy
 CONFIG_MC146818RTC=3Dy
 CONFIG_ISA_TESTDEV=3Dy
-CONFIG_EMPTY_SLOT=3Dy
 CONFIG_SUN4V_RTC=3Dy
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 4fa8cb2904..f8a856f611 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -29,7 +29,7 @@
 #include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/char/serial.h"
-#include "hw/empty_slot.h"
+#include "hw/misc/unimp.h"
 #include "hw/loader.h"
 #include "hw/sparc/sparc64.h"
 #include "hw/timer/sun4v-rtc.h"
@@ -161,7 +161,7 @@ static void niagara_init(MachineState *machine)
         serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
                        serial_hd(0), DEVICE_BIG_ENDIAN);
     }
-    empty_slot_init(NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
+    create_unimplemented_device("sun4v-iob", NIAGARA_IOBBASE, NIAGARA_IO=
BSIZE);
     sun4v_rtc_init(NIAGARA_RTC_BASE);
 }
=20
--=20
2.18.0.rc1.1.g3f1ff2140
