Received: from eggs.gnu.org ([209.51.188.92]:52026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXj-0008N8-3k
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXg-0007My-Eg
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:57:58 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXV-0007GN-Lz
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:57:49 -0500
Received: by mail-wr1-x433.google.com with SMTP id t18so31878773wrx.2
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:57:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.57.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:57:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:19 +0000
Message-Id: <20190221185739.25362-2-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/21] hw/arm/armsse: Fix memory leak in
 error-exit path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Coverity points out (CID 1398632, CID 1398650) that we
leak a couple of allocated strings in the error-exit
code path for setting up the MHUs in the ARMSSE.
Fix this bug by moving the allocate-and-free of each
string to be closer to the use, so we do the free before
doing the error-exit check.

Fixes: f8574705f62b38a ("hw/arm/armsse: Add unimplemented-device stubs for MHUs")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190215113707.24553-1-peter.maydell@linaro.org
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
