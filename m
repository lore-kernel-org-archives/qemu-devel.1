Received: from eggs.gnu.org ([209.51.188.92]:51372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gguGf-0002gl-KO
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gguGc-0003iC-IM
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:30:16 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gguGc-0003dj-CF
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:30:14 -0500
Received: by mail-wr1-x441.google.com with SMTP id v13so4692352wrw.5
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 08:30:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  8 Jan 2019 16:30:05 +0000
Message-Id: <20190108163008.7006-2-peter.maydell@linaro.org>
In-Reply-To: <20190108163008.7006-1-peter.maydell@linaro.org>
References: <20190108163008.7006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] hw/arm/xlx-zynqmp: Realize cluster after
 putting RPUs in it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <richard.henderson@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Emilio G . Cota" <cota@braap.org>

Currently the cluster implementation doesn't have any constraints
on the ordering of realizing the TYPE_CPU_CLUSTER and populating it
with child objects. We want to impose a constraint that realize
must happen only after all the child objects are added, so move
the realize of rpu_cluster. (The apu_cluster is already
realized after child population.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zynqmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index c67ac2e64ac..370b0e44a38 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -183,8 +183,6 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
                             &error_abort, NULL);
     qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
 
-    qdev_init_nofail(DEVICE(&s->rpu_cluster));
-
     for (i = 0; i < num_rpus; i++) {
         char *name;
 
@@ -212,6 +210,8 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
             return;
         }
     }
+
+    qdev_init_nofail(DEVICE(&s->rpu_cluster));
 }
 
 static void xlnx_zynqmp_init(Object *obj)
-- 
2.19.2
