Received: from eggs.gnu.org ([209.51.188.92]:41510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45E-00021U-LK
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB456-0003mG-JZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33810
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB456-0003fo-CV
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1r0j095832
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:50 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegycx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:49 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:49 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:42 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-69-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 68/97] i2c: Add a length check to the SMBus
 write handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Corey Minyard <cminyard@mvista.com>, Peter Maydell <peter.maydell@linaro.org>

From: Corey Minyard <cminyard@mvista.com>

Avoid an overflow.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: QEMU Stable <qemu-stable@nongnu.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 629457a13080052c575779e1fd9f5eb5ee6b8ad9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i2c/smbus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 587ce1ab7f..639ff90b65 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -193,7 +193,11 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
     switch (dev->mode) {
     case SMBUS_WRITE_DATA:
         DPRINTF("Write data %02x\n", data);
-        dev->data_buf[dev->data_len++] =3D data;
+        if (dev->data_len >=3D sizeof(dev->data_buf)) {
+            BADF("Too many bytes sent\n");
+        } else {
+            dev->data_buf[dev->data_len++] =3D data;
+        }
         break;
     default:
         BADF("Unexpected write in state %d\n", dev->mode);
--=20
2.17.1
