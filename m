Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C85C2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E862072A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="m8YI2w6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E862072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ7ZZ-00076s-Ax
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ7Yb-0005xS-Ul
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ7Yb-0000Pd-1j
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:27:17 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56127)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jJ7Ya-0000Ne-NO; Mon, 30 Mar 2020 23:27:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48rvry57Swz9sP7; Tue, 31 Mar 2020 14:27:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585625234;
 bh=J3M3Ij39CttqLq1kyCpOWCIOXS/ayMDSti3LhgpqBpM=;
 h=From:To:Cc:Subject:Date:From;
 b=m8YI2w6gJEmffL3VlobB7/+nV3PG4lpq8Gnv2czpRZeOSrMwJWTTD1Xlht2a1Sl4o
 FLeYVFITOOhQ1BjPe0KH19VAraeW0TPIaz6LUNt1ZGDo6PLk23TUKjh1MpR/V86Ly8
 RzixWpTbC7G7P3wpuhEZc2/oBtjT1pjJ5FcyvuiI=
From: David Gibson <david@gibson.dropbear.id.au>
To: aik@ozlabs.ru,
	groug@kaod.org
Subject: [PATCH] spapr: Don't allow unplug of NVLink2 devices
Date: Tue, 31 Mar 2020 14:27:09 +1100
Message-Id: <20200331032709.112476-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, we can't properly handle unplug of NVLink2 devices, because we
don't have code to tear down their special memory resources.  There's not
a lot of impetus to implement that: since hardware NVLink2 devices can't
be hot unplugged, the guest side drivers don't usually support unplug
anyway.

Therefore, simply prevent unplug of NVLink2 devices.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 55ca9dee1e..61b84a392d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1665,6 +1665,10 @@ static void spapr_pci_unplug_request(HotplugHandle=
r *plug_handler,
             error_setg(errp, "PCI: Hot unplug of PCI bridges not support=
ed");
             return;
         }
+        if (object_property_get_uint(OBJECT(pdev), "nvlink2-tgt", NULL))=
 {
+            error_setg(errp, "PCI: Cannot unplug NVLink2 devices");
+            return;
+        }
=20
         /* ensure any other present functions are pending unplug */
         if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
--=20
2.25.1


