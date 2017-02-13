Received: from eggs.gnu.org ([2001:4830:134:3::10]:38611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdHsw-0007Kn-Vy
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdHss-000245-Rl
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:45:46 -0500
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:52923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cdHss-00023g-Kx
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:45:42 -0500
Received: from player772.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 116964A927
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 15:45:41 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 13 Feb 2017 15:44:21 +0100
Message-Id: <1486997062-23227-2-git-send-email-clg@kaod.org>
In-Reply-To: <1486997062-23227-1-git-send-email-clg@kaod.org>
References: <1486997062-23227-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] aspeed/smc: add a 'sdram_base' property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The setting of the DRAM address of the DMA transaction depends on the
DRAM base address of the SoC. Let's add a property to give this
information to the SMC controller model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/arm/aspeed_soc.c         | 5 ++++-
 hw/ssi/aspeed_smc.c         | 1 +
 include/hw/ssi/aspeed_smc.h | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 571e4f097b02..6df76382f007 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -258,7 +258,10 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
                        qdev_get_gpio_in(DEVICE(&s->vic), 12));
=20
     /* FMC, The number of CS is set at the board level */
-    object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
+    object_property_set_int(OBJECT(&s->fmc), sc->info->sdram_base, "sdra=
m-base",
+                            &err);
+    object_property_set_bool(OBJECT(&s->fmc), true, "realized", &local_e=
rr);
+    error_propagate(&err, local_err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index cb515730c5ad..f6ecdc014436 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -798,6 +798,7 @@ static const VMStateDescription vmstate_aspeed_smc =3D=
 {
 };
=20
 static Property aspeed_smc_properties[] =3D {
+    DEFINE_PROP_UINT64("sdram-base", AspeedSMCState, sdram_base, 0),
     DEFINE_PROP_UINT32("num-cs", AspeedSMCState, num_cs, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 1f557313fa93..2c375af7bcbb 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -97,6 +97,9 @@ typedef struct AspeedSMCState {
     uint8_t r_timings;
     uint8_t conf_enable_w0;
=20
+    /* for DMA support */
+    uint64_t sdram_base;
+
     AspeedSMCFlash *flashes;
 } AspeedSMCState;
=20
--=20
2.7.4
