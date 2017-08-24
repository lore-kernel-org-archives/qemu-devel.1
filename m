Received: from eggs.gnu.org ([2001:4830:134:3::10]:52272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkmll-0001qT-77
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkmlk-0005Kv-B6
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:41:37 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 24 Aug 2017 09:41:33 +0200
Message-Id: <1503560493-5961-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] hw/nvram/spapr_nvram: Device can not
 be created by the users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org

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
---
 hw/nvram/spapr_nvram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index bc355a4..4a0aec8 100644
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
1.8.3.1
