Received: from eggs.gnu.org ([2001:4830:134:3::10]:47464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H8B-0002PM-Ve
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H8A-0004mC-T1
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d1H8A-0004lz-Jy
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:38 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Apr 2017 15:47:05 -0300
Message-Id: <20170420184705.25018-16-ehabkost@redhat.com>
In-Reply-To: <20170420184705.25018-1-ehabkost@redhat.com>
References: <20170420184705.25018-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 15/15] qdev: Constify local variable returned by
 blk_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>

From: Krzysztof Kozlowski <krzk@kernel.org>

Inside qdev_prop_set_drive() the value returned by blk_bs() is passed
only as pointer to const to bdrv_get_node_name() and pointed values is
not modified in other places so this can be made const for code
safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Message-Id: <20170310200550.13313-3-krzk@kernel.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev-properties-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index e885e650fb..79c2014135 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -409,7 +409,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
     if (value) {
         ref = blk_name(value);
         if (!*ref) {
-            BlockDriverState *bs = blk_bs(value);
+            const BlockDriverState *bs = blk_bs(value);
             if (bs) {
                 ref = bdrv_get_node_name(bs);
             }
-- 
2.11.0.259.g40922b1
