Received: from eggs.gnu.org ([2001:4830:134:3::10]:43720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejHIN-0000Jr-J3
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 23:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejHIM-0003HM-GQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 23:25:19 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue,  6 Feb 2018 20:24:31 -0800
Message-Id: <20180207042438.15422-8-andrew.smirnov@gmail.com>
In-Reply-To: <20180207042438.15422-1-andrew.smirnov@gmail.com>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 07/14] i.MX: Add i.MX7 GPT variant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

Add minimal code needed to allow upstream Linux guest to boot.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/timer/imx_gpt.c         | 25 +++++++++++++++++++++++++
 include/hw/timer/imx_gpt.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 4b9b54bf2e..65e4ee6bcf 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -113,6 +113,17 @@ static const IMXClk imx6_gpt_clocks[] = {
     CLK_HIGH,      /* 111 reference clock */
 };
 
+static const IMXClk imx7_gpt_clocks[] = {
+    CLK_NONE,      /* 000 No clock source */
+    CLK_IPG,       /* 001 ipg_clk, 532MHz*/
+    CLK_IPG_HIGH,  /* 010 ipg_clk_highfreq */
+    CLK_EXT,       /* 011 External clock */
+    CLK_32k,       /* 100 ipg_clk_32k */
+    CLK_HIGH,      /* 101 reference clock */
+    CLK_NONE,      /* 110 not defined */
+    CLK_NONE,      /* 111 not defined */
+};
+
 static void imx_gpt_set_freq(IMXGPTState *s)
 {
     uint32_t clksrc = extract32(s->cr, GPT_CR_CLKSRC_SHIFT, 3);
@@ -512,6 +523,13 @@ static void imx6_gpt_init(Object *obj)
     s->clocks = imx6_gpt_clocks;
 }
 
+static void imx7_gpt_init(Object *obj)
+{
+    IMXGPTState *s = IMX_GPT(obj);
+
+    s->clocks = imx7_gpt_clocks;
+}
+
 static const TypeInfo imx25_gpt_info = {
     .name = TYPE_IMX25_GPT,
     .parent = TYPE_SYS_BUS_DEVICE,
@@ -532,11 +550,18 @@ static const TypeInfo imx6_gpt_info = {
     .instance_init = imx6_gpt_init,
 };
 
+static const TypeInfo imx7_gpt_info = {
+    .name = TYPE_IMX7_GPT,
+    .parent = TYPE_IMX25_GPT,
+    .instance_init = imx7_gpt_init,
+};
+
 static void imx_gpt_register_types(void)
 {
     type_register_static(&imx25_gpt_info);
     type_register_static(&imx31_gpt_info);
     type_register_static(&imx6_gpt_info);
+    type_register_static(&imx7_gpt_info);
 }
 
 type_init(imx_gpt_register_types)
diff --git a/include/hw/timer/imx_gpt.h b/include/hw/timer/imx_gpt.h
index eac59b2a70..20ccb327c4 100644
--- a/include/hw/timer/imx_gpt.h
+++ b/include/hw/timer/imx_gpt.h
@@ -77,6 +77,7 @@
 #define TYPE_IMX25_GPT "imx25.gpt"
 #define TYPE_IMX31_GPT "imx31.gpt"
 #define TYPE_IMX6_GPT "imx6.gpt"
+#define TYPE_IMX7_GPT "imx7.gpt"
 
 #define TYPE_IMX_GPT TYPE_IMX25_GPT
 
-- 
2.14.3
