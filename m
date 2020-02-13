Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA2BC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BFB20714
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dtHtnI9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BFB20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j22rC-0007HQ-Sb
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 19:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j22qE-0005dB-4R
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j22qC-0002ai-Lg
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:58:53 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53101 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j22qC-0002YO-7w; Wed, 12 Feb 2020 19:58:52 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48HynM4RDdz9sPK; Thu, 13 Feb 2020 11:58:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581555527;
 bh=t0k99hTNO/99CbhZA6anYL5OlCfBcZGL05yN+aGdY6c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dtHtnI9GmkX/XvFfCgyRzjdIOKEPTOpxgJEoIguACCutOALelULZ+YFk/L+r1kvPS
 P+aTx0J93QzPTgKPptDIJErR/eTzX0depcQ4pdBbYigkMzkAiZnU24Dfc41UVHYPZB
 2lOFgTw+RwYFKLG5qPRPNxN3HZKtn4mmRrzp0/MY=
From: David Gibson <david@gibson.dropbear.id.au>
To: pair@us.ibm.com,
	qemu-devel@nongnu.org,
	groug@kaod.org,
	clg@kaod.org
Subject: [PATCH v2 1/2] spapr: Disable legacy virtio devices for pseries-5.0
 and later
Date: Thu, 13 Feb 2020 11:58:36 +1100
Message-Id: <20200213005837.131791-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213005837.131791-1-david@gibson.dropbear.id.au>
References: <20200213005837.131791-1-david@gibson.dropbear.id.au>
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
Cc: mst@redhat.com, aik@ozlabs.ru, paulus@samba.org, mdroth@us.ibm.com,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PAPR specifies a kind of odd, paravirtualized PCI bus, which looks to
the guess mostly like classic PCI, even if some of the individual
devices on the bus are PCI Express.  One consequence of that is that
virtio-pci devices still default to being in transitional mode, though
legacy mode is now disabled by default on current q35 x86 machine
types.

Legacy mode virtio devices aren't really necessary any more, and are
causing some problems for future changes.  Therefore, for the
pseries-5.0 machine type (and onwards), switch to modern-only
virtio-pci devices by default.

This does mean we no longer support guest kernels prior to 4.0, unless
they have modern virtio support backported (which some distro kernels
like that in RHEL7 do).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cb220fde45..6e1e467cc6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -65,6 +65,7 @@
=20
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost-scsi-common.h"
=20
@@ -4567,7 +4568,14 @@ static void spapr_machine_latest_class_options(Mac=
hineClass *mc)
  */
 static void spapr_machine_5_0_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class *=
/
+    /* Most defaults for the latest behaviour are inherited from the
+     * base class, but we need to override the (non ppc specific)
+     * default behaviour for virtio */
+    static GlobalProperty compat[] =3D {
+        { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
+    };
+
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
=20
 DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
@@ -4578,12 +4586,16 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
 static void spapr_machine_4_2_class_options(MachineClass *mc)
 {
     SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    static GlobalProperty compat[] =3D {
+        { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
+    };
=20
     spapr_machine_5_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
     mc->nvdimm_supported =3D false;
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
=20
 DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
--=20
2.24.1


