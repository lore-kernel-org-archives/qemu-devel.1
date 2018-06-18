Received: from eggs.gnu.org ([2001:4830:134:3::10]:49886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEc-0005Q2-Vd
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEb-000447-3u
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:14 +1000
Message-Id: <20180618035324.19907-19-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/28] pnv: Fix some error handling cpu realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

In pnv_core_realize() we call two functions with an Error * parameter in
succession, which will go badly if they both cause errors.  In fact, a
failure in either of them indicates a qemu internal error, so we can just
use &error_abort in both cases.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 13ad7d9e04..01f47c8037 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -172,12 +172,9 @@ static void pnv_core_realize(DeviceState *dev, Error=
 **errp)
         object_initialize(obj, size, typename);
=20
         snprintf(name, sizeof(name), "thread[%d]", i);
-        object_property_add_child(OBJECT(pc), name, obj, &local_err);
+        object_property_add_child(OBJECT(pc), name, obj, &error_abort);
         object_property_add_alias(obj, "core-pir", OBJECT(pc),
-                                  "pir", &local_err);
-        if (local_err) {
-            goto err;
-        }
+                                  "pir", &error_abort);
         object_unref(obj);
     }
=20
--=20
2.17.1
