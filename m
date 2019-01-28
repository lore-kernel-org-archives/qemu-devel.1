Received: from eggs.gnu.org ([209.51.188.92]:41222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNe-0003AB-Dx
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNc-0000Yy-R5
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:34 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNc-0000PS-G3
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:32 -0500
Received: by mail-wm1-x32a.google.com with SMTP id p6so14942593wmc.1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:44 +0000
Message-Id: <20190128181047.20781-24-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/26] hw/arm/xlnx-zynqmp: Realize cluster after
 putting RPUs in it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently the cluster implementation doesn't have any constraints
on the ordering of realizing the TYPE_CPU_CLUSTER and populating it
with child objects. We want to impose a constraint that realize
must happen only after all the child objects are added, so move
the realize of rpu_cluster. (The apu_cluster is already
realized after child population.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20190121152218.9592-2-peter.maydell@linaro.org
---
 hw/arm/xlnx-zynqmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 70cbe6bd475..4f8bc41d9d4 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -188,8 +188,6 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
                             &error_abort, NULL);
     qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
 
-    qdev_init_nofail(DEVICE(&s->rpu_cluster));
-
     for (i = 0; i < num_rpus; i++) {
         char *name;
 
@@ -217,6 +215,8 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
             return;
         }
     }
+
+    qdev_init_nofail(DEVICE(&s->rpu_cluster));
 }
 
 static void xlnx_zynqmp_init(Object *obj)
-- 
2.20.1
