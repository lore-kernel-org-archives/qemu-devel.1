Received: from eggs.gnu.org ([2001:4830:134:3::10]:33251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJLV2-0002Oa-8f
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJLV1-00012B-5M
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:06:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Jun 2017 12:06:21 -0300
Message-Id: <20170609150622.4720-2-f4bug@amsat.org>
In-Reply-To: <20170609150622.4720-1-f4bug@amsat.org>
References: <20170609150622.4720-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] hw/pci: define msi_nonbroken in pci-stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The kludged field 'msi_nonbroken' is declared in "hw/pci/msi.h" and defined in
hw/pci/msi.c.
When using an ARM config with CONFIG_PCI disabled, hw/pci/msi.c is not included.
Without being PCI-related, the files hw/intc/arm_gicv[23*].c do access this
field (to enable the kludge if PCI is enabled).
The final link fails since hw/pci/msi.c is not included.
Defining this field in pci-stub is safe enough for configs without CONFIG_PCI.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

v2: Addressed review feedback from Thomas Huth

Error reported:

$ ../configure --target-list=armeb-softmmu && make
[...]
  LINK    armeb-softmmu/qemu-system-armeb
../hw/intc/arm_gicv2m.o: In function `gicv2m_realize':
qemu/hw/intc/arm_gicv2m.c:154: undefined reference to `msi_nonbroken'
../hw/intc/arm_gicv3_its_common.o: In function `gicv3_its_init_mmio':
qemu/hw/intc/arm_gicv3_its_common.c:110: undefined reference to `msi_nonbroken'
collect2: error: ld returned 1 exit status
Makefile:201: recipe for target 'qemu-system-armeb' failed
make[1]: *** [qemu-system-armeb] Error 1
Makefile:327: recipe for target 'subdir-armeb-softmmu' failed
make: *** [subdir-armeb-softmmu] Error 2

branch used (wip):

https://github.com/qemu/qemu/compare/master...philmd:armeb_wip

with following config:

$ cat default-configs/armeb-softmmu.mak
# Default configuration for armeb-softmmu
CONFIG_ECC=y
CONFIG_SERIAL=y
CONFIG_PTIMER=y
CONFIG_SD=y
CONFIG_SSI=y
#CONFIG_USB=y
CONFIG_PLATFORM_BUS=y
CONFIG_ARM_V7M=y
CONFIG_ARM_GIC=y
CONFIG_ARM_TIMER=y
CONFIG_PL011=y
CONFIG_PL022=y
CONFIG_PL031=y
CONFIG_PL041=y
CONFIG_PL050=y
CONFIG_PL061=y
CONFIG_PL080=y
CONFIG_PL181=y
CONFIG_PL190=y
CONFIG_PL310=y
CONFIG_PL330=y
CONFIG_BITBANG_I2C=y
CONFIG_GPIO_KEY=y
CONFIG_HERCULES=y

 hw/pci/pci-stub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index 36d2c430c5..ecad664946 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -24,6 +24,9 @@
 #include "qapi/qmp/qerror.h"
 #include "hw/pci/pci.h"
 #include "qmp-commands.h"
+#include "hw/pci/msi.h"
+
+bool msi_nonbroken;
 
 PciInfoList *qmp_query_pci(Error **errp)
 {
-- 
2.11.0
