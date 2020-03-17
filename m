Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962D4C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AAC205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HZNnyV1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AAC205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Ac-0002Pj-Gw
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95j-00013j-V2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95h-0002lH-L5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:55 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41927 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95h-0001uK-6s; Tue, 17 Mar 2020 06:04:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKw4v3Gz9sSt; Tue, 17 Mar 2020 21:04:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439476;
 bh=ahf6kPUdTFlVRzytiUCLwUm2hqrLDJD3Di+JZ1vbp30=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HZNnyV1hmaH/QbFp9bsKZ311WiT5hxSo64ZaLebi1GN6l/LfRWjPT1Y85N7bvDdJO
 /ndfFNtKYTma9/azWRt802tssBmRs7TG8qP65clcGeFZkC8qxrt3YNp/wldCN0zhrm
 M+1hHy0tNRLoXF02R1+Fp6S+nVY9q1CabquRba4I=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 17/45] spapr: Don't use weird units for MIN_RMA_SLOF
Date: Tue, 17 Mar 2020 21:03:55 +1100
Message-Id: <20200317100423.622643-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIN_RMA_SLOF records the minimum about of RMA that the SLOF firmware
requires.  It lets us give a meaningful error if the RMA ends up too smal=
l,
rather than just letting SLOF crash.

It's currently stored as a number of megabytes, which is strange for glob=
al
constants.  Move that megabyte scaling into the definition of the constan=
t
like most other things use.

Change from M to MiB in the associated message while we're at it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/spapr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cc10798be4..510494ad87 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -103,7 +103,7 @@
 #define FW_OVERHEAD             0x2800000
 #define KERNEL_LOAD_ADDR        FW_MAX_SIZE
=20
-#define MIN_RMA_SLOF            128UL
+#define MIN_RMA_SLOF            (128 * MiB)
=20
 #define PHANDLE_INTC            0x00001111
=20
@@ -2956,10 +2956,10 @@ static void spapr_machine_init(MachineState *mach=
ine)
         }
     }
=20
-    if (spapr->rma_size < (MIN_RMA_SLOF * MiB)) {
+    if (spapr->rma_size < MIN_RMA_SLOF) {
         error_report(
-            "pSeries SLOF firmware requires >=3D %ldM guest RMA (Real Mo=
de Area memory)",
-            MIN_RMA_SLOF);
+            "pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real =
Mode Area memory)",
+            MIN_RMA_SLOF / MiB);
         exit(1);
     }
=20
--=20
2.24.1


