Received: from eggs.gnu.org ([209.51.188.92]:58730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbLR-0007e2-DY
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbLJ-0003GT-KR
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:03 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:33841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbLJ-0003Fy-54
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:01 -0500
Received: by mail-wm1-x32e.google.com with SMTP id y185so4878125wmd.1
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.06.58
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:06:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:09 +0000
Message-Id: <20190201160653.13829-4-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/47] armv7m: Make cpu object a child of the
 armv7m container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rather than just creating the CPUs with object_new, make them child
objects of the armv7m container. This will allow the cluster code to
find the CPUs if an armv7m object is made a child of a cluster object.
object_new_with_props() will do the parenting for us.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190121185118.18550-3-peter.maydell@linaro.org
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
