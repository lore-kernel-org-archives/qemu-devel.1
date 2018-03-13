Received: from eggs.gnu.org ([2001:4830:134:3::10]:47124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxV-0005bc-3L
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxS-0005zw-QU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:25 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 15:34:53 +0000
Message-Id: <20180313153458.26822-5-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-1-peter.maydell@linaro.org>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 4/9] hw/arm/bcm2386: Fix parent type of bcm2386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Pekka Enberg <penberg@iki.fi>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

The TypeInfo and state struct for bcm2386 disagree about what the
parent class is -- the TypeInfo says it's TYPE_SYS_BUS_DEVICE,
but the BCM2386State struct only defines the parent_obj field
as DeviceState. This would have caused problems if anything
actually tried to treat the object as a TYPE_SYS_BUS_DEVICE.
Fix the TypeInfo to use TYPE_DEVICE as the parent, since we don't
need any of the additional functionality TYPE_SYS_BUS_DEVICE
provides.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I noticed this when I tried to make the type into one which
has its own class struct, because we hit the assert that the
child's class struct had better be bigger than the parent's.
---
 hw/arm/bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 40e8b25a46..9266f27c14 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -165,7 +165,7 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo bcm2836_type_info = {
     .name = TYPE_BCM2836,
-    .parent = TYPE_SYS_BUS_DEVICE,
+    .parent = TYPE_DEVICE,
     .instance_size = sizeof(BCM2836State),
     .instance_init = bcm2836_init,
     .class_init = bcm2836_class_init,
-- 
2.16.2
