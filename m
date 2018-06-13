Received: from eggs.gnu.org ([2001:4830:134:3::10]:50761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fT10p-0002RP-QO
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fT10o-0004Sl-U7
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:15 -0400
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:46767)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1fT10o-0004Qy-Ks
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:14 -0400
From: Dima Stepanov <dimastep@yandex-team.ru>
Date: Wed, 13 Jun 2018 11:19:55 +0300
Message-Id: <1528877995-5043-3-git-send-email-dimastep@yandex-team.ru>
In-Reply-To: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
References: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
Subject: [Qemu-devel] [PATCH v2 2/2] memory: fix possible NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru

In the memory_region_do_invalidate_mmio_ptr() routine the section
variable is intialized by the memory_region_find() call. The section.mr
field can be set to NULL.

Add the check for NULL before trying to drop a section.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index 3212acc..bb45248 100644
--- a/memory.c
+++ b/memory.c
@@ -2712,7 +2712,7 @@ static void memory_region_do_invalidate_mmio_ptr(CPUState *cpu,
     /* Reset dirty so this doesn't happen later. */
     cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
 
-    if (section.mr != mr) {
+    if (section.mr && (section.mr != mr)) {
         /* memory_region_find add a ref on section.mr */
         memory_region_unref(section.mr);
         if (MMIO_INTERFACE(section.mr->owner)) {
-- 
2.7.4
