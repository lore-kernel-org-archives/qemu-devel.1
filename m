Received: from eggs.gnu.org ([209.51.188.92]:41097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNU-00031O-EA
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNQ-0000Pq-5v
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNJ-0000Ez-94
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:15 -0500
Received: by mail-wr1-x444.google.com with SMTP id t27so19148906wra.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.10 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:38 +0000
Message-Id: <20190128181047.20781-18-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/26] xlnx-zynqmp: Don't create rpu-cluster if
 there are no RPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If we aren't going to create any RPUs, then don't create the
rpu-cluster unit. This allows us to add an assertion to the
cluster object that it contains at least one CPU, which helps
to avoid bugs in creating clusters and putting CPUs in them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190121184314.14311-1-peter.maydell@linaro.org
---
 hw/arm/xlnx-zynqmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index c67ac2e64ac..70cbe6bd475 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -178,6 +178,11 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
     int i;
     int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
 
+    if (num_rpus <= 0) {
+        /* Don't create rpu-cluster object if there's nothing to put in it */
+        return;
+    }
+
     object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
                             sizeof(s->rpu_cluster), TYPE_CPU_CLUSTER,
                             &error_abort, NULL);
-- 
2.20.1
