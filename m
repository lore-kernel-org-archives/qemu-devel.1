Received: from eggs.gnu.org ([209.51.188.92]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxApC-0000qd-Uw
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAfR-0005iQ-7Q
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:15:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34826
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAfQ-0004xO-T8
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:15:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDBkJf076273
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:14:25 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qtefst41y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:14:11 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:37 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:17 +0100
In-Reply-To: <20190222131322.26079-1-clg@kaod.org>
References: <20190222131322.26079-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-9-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/13] spapr/rtas: modify
 spapr_rtas_register() to remove RTAS handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Removing RTAS handlers will become necessary when the new pseries
machine supporting multiple interrupt mode is introduced.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h | 4 ++++
 hw/ppc/spapr_rtas.c    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 59073a757900..dd346d921428 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -660,6 +660,10 @@ typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, sPAPR=
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
index 7a2cb786a36a..d09c5f463d22 100644
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
