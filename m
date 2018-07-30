Received: from eggs.gnu.org ([2001:4830:134:3::10]:38151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adam@l4re.org>) id 1fkC8q-0006OO-5K
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adam@l4re.org>) id 1fkC8m-0002wJ-LR
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:39:32 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:50662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <adam@l4re.org>) id 1fkC8m-0002uQ-Dj
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:39:28 -0400
Received: from erwin.inf.tu-dresden.de ([141.76.48.80]
	helo=os.inf.tu-dresden.de) by os.inf.tu-dresden.de with esmtps
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91)
	id 1fkC6d-0004Bz-Hg
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:37:15 +0200
Date: Mon, 30 Jul 2018 19:37:12 +0200
From: Adam Lackorzynski <adam@l4re.org>
Message-ID: <20180730173712.GG4987@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] arm: Fix return code of arm_load_elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use an int64_t as a return type to restore
the negative check for arm_load_as.

Signed-off-by: Adam Lackorzynski <adam@l4re.org>
---
 hw/arm/boot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e09201cc97..ca9467e583 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -818,9 +818,9 @@ static int do_arm_linux_init(Object *obj, void *opaque)
     return 0;
 }
 
-static uint64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
-                             uint64_t *lowaddr, uint64_t *highaddr,
-                             int elf_machine, AddressSpace *as)
+static int64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
+                            uint64_t *lowaddr, uint64_t *highaddr,
+                            int elf_machine, AddressSpace *as)
 {
     bool elf_is64;
     union {
@@ -829,7 +829,7 @@ static uint64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
     } elf_header;
     int data_swab = 0;
     bool big_endian;
-    uint64_t ret = -1;
+    int64_t ret = -1;
     Error *err = NULL;
 
 
-- 
2.18.0
