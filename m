Received: from eggs.gnu.org ([209.51.188.92]:35730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefN-0000oe-Em
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefM-0002X5-Nh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:25 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefL-0002Uu-U8
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:24 -0500
Received: by mail-wr1-x441.google.com with SMTP id t6so24556097wrr.12
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:50:57 +0000
Message-Id: <20190121185118.18550-3-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/23] armv7m: Make cpu object a child of the
 armv7m container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Rather than just creating the CPUs with object_new, make them child
objects of the armv7m container. This will allow the cluster code to
find the CPUs if an armv7m object is made a child of a cluster object.
object_new_with_props() will do the parenting for us.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armv7m.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index f9aa83d20ef..0f2c8e066cf 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -158,7 +158,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
 
-    s->cpu = ARM_CPU(object_new(s->cpu_type));
+    s->cpu = ARM_CPU(object_new_with_props(s->cpu_type, OBJECT(s), "cpu",
+                                           &err, NULL));
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
 
     object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
                              &error_abort);
-- 
2.20.1
