Received: from eggs.gnu.org ([2001:4830:134:3::10]:43762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8id-00059v-PB
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ia-0007sn-0o
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43790
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iZ-0007s9-R3
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:47 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEKow078915
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:45 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyj92099x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:44 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:43 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:36 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180206191515.25830-16-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/54] hw/sd/pl181: Reset SD card on controller
 reset
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

Since pl181 is still using the legacy SD card API, the SD
card created by sd_init() is not plugged into any bus. This
means that the controller has to reset it manually.

Failing to do this mostly didn't affect the guest since the
guest typically does a programmed SD card reset as part of
its SD controller driver initialization, but meant that
migration failed because it's only in sd_reset() that we
set up the wpgrps_size field.

Cc: qemu-stable@nongnu.org
Fixes: https://bugs.launchpad.net/qemu/+bug/1739378
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 1515506513-31961-2-git-send-email-peter.maydell@linaro.org
(cherry picked from commit 0cb57cc701839e7358918d5f2922ccbc04d28d17)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/sd/pl181.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 55c8098ecd..3ba1f7dd23 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -480,6 +480,10 @@ static void pl181_reset(DeviceState *d)
=20
     /* We can assume our GPIO outputs have been wired up now */
     sd_set_cb(s->card, s->cardstatus[0], s->cardstatus[1]);
+    /* Since we're still using the legacy SD API the card is not plugged
+     * into any bus, and we must reset it manually.
+     */
+    device_reset(DEVICE(s->card));
 }
=20
 static void pl181_init(Object *obj)
--=20
2.11.0
