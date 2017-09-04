Received: from eggs.gnu.org ([2001:4830:134:3::10]:52928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSi-0005EK-UQ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSV-0004zY-IE
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:44 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSV-0004yH-BZ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:31 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSU-0005dZ-Cf
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:30 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:26:04 +0100
Message-Id: <1504527967-29248-34-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/36] hw/arm/aspeed_soc: Mark devices as
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 22dcac9..13c6393 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -340,6 +340,8 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 
     sc->info = (AspeedSoCInfo *) data;
     dc->realize = aspeed_soc_realize;
+    /* Reason: Uses serial_hds and nd_table in realize() directly */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo aspeed_soc_type_info = {
-- 
2.7.4
