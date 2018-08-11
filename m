Received: from eggs.gnu.org ([2001:4830:134:3::10]:55091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtD-0005uA-Kh
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtC-0001KP-V5
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:08:51 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Sat, 11 Aug 2018 11:08:34 +0200
Message-Id: <20180811090836.4024-6-contrib@steffen-goertz.de>
In-Reply-To: <20180811090836.4024-1-contrib@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/7] arm: Improve error propagation in nRF51 SOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

This patch takes care that errors that occur during
instantiation of the cortex-m0 cpu are properly propagated.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/nrf51_soc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 2265d30352..88a848de8b 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -66,8 +66,17 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Er=
ror **errp)
     }
=20
     object_property_set_link(OBJECT(&s->cpu), OBJECT(&s->container), "me=
mory",
-            &err);
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+                            &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized",
+                             &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
=20
     memory_region_add_subregion_overlap(&s->container, 0, s->board_memor=
y, -1);
=20
--=20
2.18.0
