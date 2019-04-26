Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E90C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1B2206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WG/48ccf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1B2206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40239 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuMG-0003Jq-6b
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:29:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu12-00065U-2D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu10-00059Y-3S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:19 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49939 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0y-0004aF-8W; Fri, 26 Apr 2019 02:07:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tq1bynz9sNy; Fri, 26 Apr 2019 16:06:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258799;
	bh=oH/M0pCY9v8xQ/LPkDyH0fYeWSAbMZJyivCSW4mRds0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WG/48ccfAb3ZeaRQIw+QsW6vIMSgpPJ1DqUbn25DY3K8l5B+niR58yWt3dc/kgwdV
	0Vsx+xW7OarlsPEOmkIw1oSI4uBtiCJuXkr5rfG7EsoxfiL6RHLEIYzYWLgMP3w9Ei
	F70tpx7i1MeCSLrCE4fBhZaXJRHihedF+3MLLYtU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:19 +1000
Message-Id: <20190426060627.18153-29-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 28/36] spapr_pci: Get rid of duplicate code for
 node name creation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: gkurz@kaod.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426060619.CFw4z0U-QB-7fVHt20R62xTqOWxGyuY-DlNkMLhRzKo@z>

From: Greg Kurz <groug@kaod.org>

According to the changelog of 298a971024534, SpaprPhbState::dtbusname was
introduced to "make it easier to relate the guest and qemu views of memor=
y
to each other", hence its name.

Use it when creating the PHB node to avoid code duplication.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d6d0a7115c..f005854dec 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2176,7 +2176,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint3=
2_t intc_phandle, void *fdt,
                           uint32_t nr_msis, int *node_offset)
 {
     int bus_off, i, j, ret;
-    gchar *nodename;
     uint32_t bus_range[] =3D { cpu_to_be32(0), cpu_to_be32(0xff) };
     struct {
         uint32_t hi;
@@ -2227,9 +2226,7 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint3=
2_t intc_phandle, void *fdt,
     Error *errp =3D NULL;
=20
     /* Start populating the FDT */
-    nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
-    _FDT(bus_off =3D fdt_add_subnode(fdt, 0, nodename));
-    g_free(nodename);
+    _FDT(bus_off =3D fdt_add_subnode(fdt, 0, phb->dtbusname));
     if (node_offset) {
         *node_offset =3D bus_off;
     }
--=20
2.20.1


