Received: from eggs.gnu.org ([2001:4830:134:3::10]:35093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds3dk-0003Bq-H8
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds3dg-0000R6-Kn
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:07:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Sep 2017 11:07:17 +0200
Message-Id: <1505293637-10450-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/isa/pc87312: Mark the device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-trivial@nongnu.org

QEMU currently aborts if you try to use the device at the command
line:

$ ppc64-softmmu/qemu-system-ppc64 -S -machine prep -device pc87312
Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
qemu-system-ppc64: -device pc87312: Device 'parallel0' is in use
Aborted (core dumped)

It uses parallel_hds in its realize function, so I can not be
instantiated by the user again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/isa/pc87312.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 5ce9f0a..48b29e3 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -386,6 +386,8 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
     dc->reset = pc87312_reset;
     dc->vmsd = &vmstate_pc87312;
     dc->props = pc87312_properties;
+    /* Reason: Uses parallel_hds[0] in realize(), so it can't be used twice */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo pc87312_type_info = {
-- 
1.8.3.1
