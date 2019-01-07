Received: from eggs.gnu.org ([209.51.188.92]:43830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZpd-0002z2-Nu
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZpb-0003K4-Le
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:41:01 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:42047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ggZpb-0003HW-F0
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:59 -0500
Received: from player687.ha.ovh.net (unknown [10.109.146.137])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id E47CBD93CE
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 19:40:57 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  7 Jan 2019 19:39:41 +0100
Message-Id: <20190107183946.7230-9-clg@kaod.org>
In-Reply-To: <20190107183946.7230-1-clg@kaod.org>
References: <20190107183946.7230-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/13] spapr/rtas: modify spapr_rtas_register()
 to remove RTAS handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Removing RTAS handlers will become necessary when the new pseries
machine supporting multiple interrupt mode is introduced.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h | 4 ++++
 hw/ppc/spapr_rtas.c    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9e01a5a12e4a..9a6d015b9cf5 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -657,6 +657,10 @@ typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, sPAPR=
MachineState *sm,
                               uint32_t nargs, target_ulong args,
                               uint32_t nret, target_ulong rets);
 void spapr_rtas_register(int token, const char *name, spapr_rtas_fn fn);
+static inline void spapr_rtas_unregister(int token)
+{
+    spapr_rtas_register(token, NULL, NULL);
+}
 target_ulong spapr_rtas_call(PowerPCCPU *cpu, sPAPRMachineState *sm,
                              uint32_t token, uint32_t nargs, target_ulon=
g args,
                              uint32_t nret, target_ulong rets);
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index d6a0952154ac..e005d5d08151 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -404,7 +404,7 @@ void spapr_rtas_register(int token, const char *name,=
 spapr_rtas_fn fn)
=20
     token -=3D RTAS_TOKEN_BASE;
=20
-    assert(!rtas_table[token].name);
+    assert(!name || !rtas_table[token].name);
=20
     rtas_table[token].name =3D name;
     rtas_table[token].fn =3D fn;
--=20
2.20.1
