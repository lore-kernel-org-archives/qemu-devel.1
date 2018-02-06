Received: from eggs.gnu.org ([2001:4830:134:3::10]:43784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ie-0005Aa-I9
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ia-0007t8-Jy
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iZ-0007ro-Uj
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:48 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JFBeN064873
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:47 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyhx2hbav-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:45 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:44 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:37 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180206191515.25830-17-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/54] hw/sd/milkymist-memcard: Reset SD card
 on controller reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Since milkymist-memcard is still using the legacy SD card API,
the SD card created by sd_init() is not plugged into any bus.
This means that the controller has to reset it manually.

Failing to do this mostly didn't affect the guest since the
guest typically does a programmed SD card reset as part of
its SD controller driver initialization, but meant that
migration failed because it's only in sd_reset() that we
set up the wpgrps_size field.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 1515506513-31961-3-git-send-email-peter.maydell@linaro.org
(cherry picked from commit 16bf0e0e7aaa8efc0b8ee7e2aecb2fa235f82d38)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/sd/milkymist-memcard.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 4008c81002..341da88552 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -248,6 +248,10 @@ static void milkymist_memcard_reset(DeviceState *d)
     for (i =3D 0; i < R_MAX; i++) {
         s->regs[i] =3D 0;
     }
+    /* Since we're still using the legacy SD API the card is not plugged
+     * into any bus, and we must reset it manually.
+     */
+    device_reset(DEVICE(s->card));
 }
=20
 static int milkymist_memcard_init(SysBusDevice *dev)
--=20
2.11.0
