Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334DDC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 04:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF77208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 04:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kJjDeqhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF77208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9iBn-0007bE-6p
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 23:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j9i9O-0004xQ-7u
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 23:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j9i9M-0003gh-H0
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 23:30:21 -0500
Received: from ozlabs.org ([203.11.71.1]:40371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j9i9L-0003dS-Je; Wed, 04 Mar 2020 23:30:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48XyTb0bJrz9sPK; Thu,  5 Mar 2020 15:30:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583382611;
 bh=SNFwgbzOvCRy87QUp6Yhx7yIEmwyU2cBc5gclGTgUKE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kJjDeqhG+vdlKr8sDfF8X34fX1y09DnHFIzTopkOkf/1gREfMQzGGMfXKXqy7NaGL
 UYgx3UqgmU7t5Dxy6TrqmTRvUPVrwvB3fUiB0RQIw9E/Ml4qaehjzMQz0m43jRr2wv
 NI54NpI5KgYmdZaEyIfF6d5PxM546MTU1sFl2kn0=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	pair@us.ibm.com,
	qemu-devel@nongnu.org,
	clg@kaod.org
Subject: [PATCH v3 1/2] spapr: Disable legacy virtio devices for pseries-5.0
 and later
Date: Thu,  5 Mar 2020 15:30:08 +1100
Message-Id: <20200305043009.611636-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305043009.611636-1-david@gibson.dropbear.id.au>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
 hw/ppc/spapr.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2eb0d8f70d..3cfc98ac61 100644
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
@@ -4566,8 +4567,20 @@ static const TypeInfo spapr_machine_info =3D {
=20
 static void spapr_machine_latest_class_options(MachineClass *mc)
 {
+    /*
+     * Most defaults for the latest behaviour are inherited from the
+     * base class, but we need to override the (non ppc specific)
+     * default behaviour for virtio.  We can't do that from the base
+     * class since it doesn't have a compat_props.
+     */
+    static GlobalProperty compat[] =3D {
+        { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
+    };
+
     mc->alias =3D "pseries";
     mc->is_default =3D true;
+
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
=20
 #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
@@ -4607,6 +4620,9 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
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
@@ -4614,6 +4630,7 @@ static void spapr_machine_4_2_class_options(Machine=
Class *mc)
     smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
     smc->rma_limit =3D 16 * GiB;
     mc->nvdimm_supported =3D false;
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
=20
 DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
--=20
2.24.1


