Received: from eggs.gnu.org ([2001:4830:134:3::10]:43771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ie-0005A1-2S
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iZ-0007sK-PM
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59874
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iZ-0007rq-Kj
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:47 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEMcP056550
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:46 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fygjbwcdn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:45 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:44 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:38 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180206191515.25830-18-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/54] hw/sd/ssi-sd: Reset SD card on
 controller reset
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

Since ssi-sd is still using the legacy SD card API, the SD
card created by sd_init() is not plugged into any bus. This
means that the controller has to reset it manually.

Failing to do this mostly didn't affect the guest since the
guest typically does a programmed SD card reset as part of
its SD controller driver initialization, but meant that
migration failed because it's only in sd_reset() that we
set up the wpgrps_size field.

In the case of sd-ssi, we have to implement an entire
reset function since there wasn't one previously, and
that requires a QOM cast macro that got omitted when this
device was QOMified.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 1515506513-31961-4-git-send-email-peter.maydell@linaro.org
(cherry picked from commit 8046d44f3c9f67828d3368797d4d314433ee75e9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/sd/ssi-sd.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 24001dc3e6..f88f509e0a 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -50,6 +50,9 @@ typedef struct {
     SDState *sd;
 } ssi_sd_state;
=20
+#define TYPE_SSI_SD "ssi-sd"
+#define SSI_SD(obj) OBJECT_CHECK(ssi_sd_state, (obj), TYPE_SSI_SD)
+
 /* State word bits.  */
 #define SSI_SDR_LOCKED          0x0001
 #define SSI_SDR_WP_ERASE        0x0002
@@ -241,7 +244,6 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     ssi_sd_state *s =3D FROM_SSI_SLAVE(ssi_sd_state, d);
     DriveInfo *dinfo;
=20
-    s->mode =3D SSI_SD_CMD;
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo =3D drive_get_next(IF_SD);
     s->sd =3D sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, true);
@@ -251,6 +253,24 @@ static void ssi_sd_realize(SSISlave *d, Error **errp=
)
     }
 }
=20
+static void ssi_sd_reset(DeviceState *dev)
+{
+    ssi_sd_state *s =3D SSI_SD(dev);
+
+    s->mode =3D SSI_SD_CMD;
+    s->cmd =3D 0;
+    memset(s->cmdarg, 0, sizeof(s->cmdarg));
+    memset(s->response, 0, sizeof(s->response));
+    s->arglen =3D 0;
+    s->response_pos =3D 0;
+    s->stopping =3D 0;
+
+    /* Since we're still using the legacy SD API the card is not plugged
+     * into any bus, and we must reset it manually.
+     */
+    device_reset(DEVICE(s->sd));
+}
+
 static void ssi_sd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -260,10 +280,11 @@ static void ssi_sd_class_init(ObjectClass *klass, v=
oid *data)
     k->transfer =3D ssi_sd_transfer;
     k->cs_polarity =3D SSI_CS_LOW;
     dc->vmsd =3D &vmstate_ssi_sd;
+    dc->reset =3D ssi_sd_reset;
 }
=20
 static const TypeInfo ssi_sd_info =3D {
-    .name          =3D "ssi-sd",
+    .name          =3D TYPE_SSI_SD,
     .parent        =3D TYPE_SSI_SLAVE,
     .instance_size =3D sizeof(ssi_sd_state),
     .class_init    =3D ssi_sd_class_init,
--=20
2.11.0
