Received: from eggs.gnu.org ([209.51.188.92]:50056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gubnt-0003Fh-Bw
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gubns-0001mn-HB
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:37:13 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gubnr-0001ks-Vv
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:37:12 -0500
Received: by mail-wm1-x341.google.com with SMTP id x10so9205598wmg.2
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:37:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Feb 2019 11:37:07 +0000
Message-Id: <20190215113707.24553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/arm/armsse: Fix memory leak in error-exit
 path
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

Coverity points out (CID 1398632, CID 1398650) that we
leak a couple of allocated strings in the error-exit
code path for setting up the MHUs in the ARMSSE.
Fix this bug by moving the allocate-and-free of each
string to be closer to the use, so we do the free before
doing the error-exit check.

Fixes: f8574705f62b38a ("hw/arm/armsse: Add unimplemented-device stubs for MHUs")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armsse.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 9a8c49547db..d0207dbabc7 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -762,26 +762,28 @@ static void armsse_realize(DeviceState *dev, Error **errp)
 
     if (info->has_mhus) {
         for (i = 0; i < ARRAY_SIZE(s->mhu); i++) {
-            char *name = g_strdup_printf("MHU%d", i);
-            char *port = g_strdup_printf("port[%d]", i + 3);
+            char *name;
+            char *port;
 
+            name = g_strdup_printf("MHU%d", i);
             qdev_prop_set_string(DEVICE(&s->mhu[i]), "name", name);
             qdev_prop_set_uint64(DEVICE(&s->mhu[i]), "size", 0x1000);
             object_property_set_bool(OBJECT(&s->mhu[i]), true,
                                      "realized", &err);
+            g_free(name);
             if (err) {
                 error_propagate(errp, err);
                 return;
             }
+            port = g_strdup_printf("port[%d]", i + 3);
             mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mhu[i]), 0);
             object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr),
                                      port, &err);
+            g_free(port);
             if (err) {
                 error_propagate(errp, err);
                 return;
             }
-            g_free(name);
-            g_free(port);
         }
     }
 
-- 
2.20.1
