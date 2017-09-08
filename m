Received: from eggs.gnu.org ([2001:4830:134:3::10]:58834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeD-0002FG-M5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe5-0003KX-7s
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:47 +1000
Message-Id: <20170908103558.31632-30-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 29/40] hw/nvram/spapr_nvram: Device can not be
 created by the users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

Trying to add a spapr-nvram device currently aborts QEMU like this:

$ ppc64-softmmu/qemu-system-ppc64  -device spapr-nvram
qemu-system-ppc64: hw/ppc/spapr_rtas.c:407: spapr_rtas_register:
 Assertion `!rtas_table[token].name' failed.
Aborted (core dumped)

This NVRAM device registers RTAS calls during its realize function
and thus can only be used once - and that's internally from spapr.c.
So let's mark the device with user_creatable = false to avoid that
the users can crash their QEMU this way.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/nvram/spapr_nvram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index bc355a4348..4a0aec8e1d 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -264,6 +264,8 @@ static void spapr_nvram_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->props = spapr_nvram_properties;
     dc->vmsd = &vmstate_spapr_nvram;
+    /* Reason: Internal device only, uses spapr_rtas_register() in realize() */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo spapr_nvram_type_info = {
-- 
2.13.5
