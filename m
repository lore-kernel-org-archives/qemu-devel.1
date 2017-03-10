Received: from eggs.gnu.org ([2001:4830:134:3::10]:46386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cmQnk-00088Z-F0
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cmQnj-0002Ro-Gi
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:06:12 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 10 Mar 2017 22:05:50 +0200
Message-Id: <20170310200550.13313-3-krzk@kernel.org>
In-Reply-To: <20170310200550.13313-1-krzk@kernel.org>
References: <20170310200550.13313-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v2 2/2] qdev: Constify local variable returned
 by blk_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Krzysztof Kozlowski <krzk@kernel.org>

Inside qdev_prop_set_drive() the value returned by blk_bs() is passed
only as pointer to const to bdrv_get_node_name() and pointed values is
not modified in other places so this can be made const for code
safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/core/qdev-properties-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index c34be1c1bace..0d40ce682d05 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -405,7 +405,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
     if (value) {
         ref = blk_name(value);
         if (!*ref) {
-            BlockDriverState *bs = blk_bs(value);
+            const BlockDriverState *bs = blk_bs(value);
             if (bs) {
                 ref = bdrv_get_node_name(bs);
             }
-- 
2.9.3
