Received: from eggs.gnu.org ([2001:4830:134:3::10]:43460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFM-0005Hi-He
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFL-0003vh-3z
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:39 +1100
Message-Id: <20181108121646.26173-16-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/22] hw/ppc/mac_newworld: Free openpic_irqs
 array after use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Peter Maydell <peter.maydell@linaro.org>

In ppc_core99_init(), we allocate an openpic_irqs array, which
we then use to collect up the various qemu_irqs which we're
going to connect to the interrupt controller. Once we've
called sysbus_connect_irq() to connect them all up, the
array is no longer required, but we forgot to free it.

Since board init is only run once at startup, the memory
leak is not a significant one.

Spotted by Coverity: CID 1192916.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_newworld.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index a630cb81cd..14273a123e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -303,6 +303,7 @@ static void ppc_core99_init(MachineState *machine)
             sysbus_connect_irq(s, k++, openpic_irqs[i][j]);
         }
     }
+    g_free(openpic_irqs);
=20
     if (PPC_INPUT(env) =3D=3D PPC_FLAGS_INPUT_970) {
         /* 970 gets a U3 bus */
--=20
2.19.1
