Received: from eggs.gnu.org ([2001:4830:134:3::10]:42123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dk8ay-0001Us-Vd
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dk8ay-0002hh-AI
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:47:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 22 Aug 2017 14:47:39 +0200
Message-Id: <1503406059-7280-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm/aspeed_soc: Mark devices as
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Jeremy Kerr <jk@ozlabs.org>, qemu-devel@nongnu.org

QEMU currently aborts if the user is accidentially trying to
do something like this:

$ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
QEMU 2.9.93 monitor - type 'help' for more information
(qemu) device_add ast2400
Unexpected error in error_set_from_qdev_prop_error()
 at hw/core/qdev-properties.c:1032:
Aborted (core dumped)

The ast2400 SoC devices are clearly not creatable by the user since
they are using the serial_hds and nd_table arrays directly in their
realize function, so mark them with user_creatable = false.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/aspeed_soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5529024..7f1be04 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -338,6 +338,8 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 
     sc->info = (AspeedSoCInfo *) data;
     dc->realize = aspeed_soc_realize;
+    /* Reason: Uses serial_hds and nd_table in realize() directly */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo aspeed_soc_type_info = {
-- 
1.8.3.1
