Received: from eggs.gnu.org ([209.51.188.92]:33626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleXZ-0002Rh-Ke
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:43:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleXX-0006dL-A7
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:43:21 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gleXX-0006ca-3R
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:43:19 -0500
Received: by mail-wr1-x443.google.com with SMTP id t6so24531371wrr.12
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:43:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:43:14 +0000
Message-Id: <20190121184314.14311-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] xlnx-zynqmp: Don't create rpu-cluster if there
 are no RPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Luc Michel <luc.michel@greensocs.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

If we aren't going to create any RPUs, then don't create the
rpu-cluster unit. This allows us to add an assertion to the
cluster object that it contains at least one CPU, which helps
to avoid bugs in creating clusters and putting CPUs in them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is a preparatory patch that is necessary for the series
"[PATCH v3 0/4] tcg: support heterogenous CPU clusters"
(20190121152218.9592-1-peter.maydell@linaro.org)
in order to avoid the xlnx-zcu102 board asserting if started with
fewer than 5 CPUs.

 hw/arm/xlnx-zynqmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 370b0e44a38..16cba433cb7 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -178,6 +178,11 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
     int i;
     int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
 
+    if (num_rpus == 0) {
+        /* Don't create rpu-cluster object if there's nothing to put in it */
+        return;
+    }
+
     object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
                             sizeof(s->rpu_cluster), TYPE_CPU_CLUSTER,
                             &error_abort, NULL);
-- 
2.20.1
