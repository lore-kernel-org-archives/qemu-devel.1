Received: from eggs.gnu.org ([2001:4830:134:3::10]:40495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9M-0004KH-Vd
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9I-0005YU-Ub
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9I-0005XW-N6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:45:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0haV2144782
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:55 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3cbn4y8w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:55 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 20:45:54 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:18 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170920004521.9417-10-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/12] mps2-an511: Fix wiring of UART overflow
 interrupt lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Fix an error that meant we were wiring every UART's overflow
interrupts into the same inputs 0 and 1 of the OR gate,
rather than giving each its own input.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 1505232834-20890-1-git-send-email-peter.maydell@linaro.org
(cherry picked from commit ce3bc112cdb1d462e2d52eaa17a7314e7f3af504)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/arm/mps2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index abb0ab6d71..769cff872c 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -287,8 +287,8 @@ static void mps2_common_init(MachineState *machine)
             cmsdk_apb_uart_create(uartbase[i],
                                   qdev_get_gpio_in(txrx_orgate_dev, 0),
                                   qdev_get_gpio_in(txrx_orgate_dev, 1),
-                                  qdev_get_gpio_in(orgate_dev, 0),
-                                  qdev_get_gpio_in(orgate_dev, 1),
+                                  qdev_get_gpio_in(orgate_dev, i * 2),
+                                  qdev_get_gpio_in(orgate_dev, i * 2 + 1=
),
                                   NULL,
                                   uartchr, SYSCLK_FRQ);
         }
--=20
2.11.0
