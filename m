Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F91C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 04:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E659620B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 04:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KZiB379g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E659620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7txf-00067a-G4
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 00:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i7tsV-0000Tp-N3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i7tsU-0002u5-7L
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:05:11 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56033 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i7tsS-0002oU-3w; Wed, 11 Sep 2019 00:05:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46SpFh3x6dz9sP7; Wed, 11 Sep 2019 14:04:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568174696;
 bh=ylhoDfJcjV2qvn5MxSZQG8aGRM94Y37JeaOOSb3exk8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KZiB379g12JRigBzvMLx+UvAp98Jlut87ijKuAndv6Qkt8Tz/QGaZWm+wQ/LAEZd4
 Fusm8L8eWPXI6WBqQp+x+cka+/w5yf4O6uxNo+7ipu/8cjHQfEiake5E4G4lV+xMSQ
 +eyViX8sf4tZgbHZxxsOHe/VVdJksOnFfk+3EYGw=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Date: Wed, 11 Sep 2019 14:04:49 +1000
Message-Id: <20190911040452.8341-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911040452.8341-1-david@gibson.dropbear.id.au>
References: <20190911040452.8341-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH 4/7] spapr: Skip leading zeroes from memory@ DT
 node names
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The device tree build by QEMU at the machine reset time is used by SLOF
to build its internal device tree but the node names are not preserved
exactly so when QEMU provides a device tree update in response to H_CAS,
it might become tricky to match a node from the update blob to
the actual node in SLOF.

This removed leading zeroes from "memory@" nodes and makes
the DTC checker happy.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d93dacd483..d072c2aa3d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -386,7 +386,7 @@ static int spapr_populate_memory_node(void *fdt, int =
nodeid, hwaddr start,
     mem_reg_property[0] =3D cpu_to_be64(start);
     mem_reg_property[1] =3D cpu_to_be64(size);
=20
-    sprintf(mem_name, "memory@" TARGET_FMT_lx, start);
+    sprintf(mem_name, "memory@%" HWADDR_PRIx, start);
     off =3D fdt_add_subnode(fdt, 0, mem_name);
     _FDT(off);
     _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
--=20
2.21.0


