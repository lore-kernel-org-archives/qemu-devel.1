Received: from eggs.gnu.org ([2001:4830:134:3::10]:43350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFpu-0004eT-IG
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFpr-000658-4y
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gFFpq-00063g-TX
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:19 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 24 Oct 2018 10:52:04 +0100
Message-Id: <1540374728-27579-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1540374728-27579-1-git-send-email-thuth@redhat.com>
References: <1540374728-27579-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] hw/core: Move null-machine into the
 common-obj list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

The null-machine code used to be target specific since it used the
target-specific cpu_init() function in the past. But in the recent
commit 2278b93941d42c30e2950 ("Use cpu_create(type) instead of
cpu_init(cpu_model)") this has been change, so that the code now
uses the common cpu_create() function instead. Thus we can put
the null-machine into the common-obj list so that it is compiled
only once for all targets, to save some compilation time.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/Makefile.objs  | 3 +--
 hw/core/null-machine.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index b736ce2..a799c83 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -21,5 +21,4 @@ common-obj-$(CONFIG_SOFTMMU) +=3D or-irq.o
 common-obj-$(CONFIG_SOFTMMU) +=3D split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
 common-obj-$(CONFIG_SOFTMMU) +=3D generic-loader.o
-
-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
+common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index cde4d3e..76d3f8e 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -18,7 +18,7 @@
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
+#include "qom/cpu.h"
=20
 static void machine_none_init(MachineState *mch)
 {
--=20
1.8.3.1
