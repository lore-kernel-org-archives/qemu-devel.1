Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9C8C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 04:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D9C208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 04:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iFd7Ow6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D9C208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9iAm-0006Cm-Jz
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 23:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j9i9O-0004xZ-7h
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 23:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j9i9M-0003gp-Ks
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 23:30:21 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41203 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j9i9L-0003dT-NF; Wed, 04 Mar 2020 23:30:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48XyTb2z1Fz9sQx; Thu,  5 Mar 2020 15:30:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583382611;
 bh=T/rehY0EMWJvQInxawyP6AROrA+skyuozSpPmM2NzLg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iFd7Ow6S3ofudvQ7TqM6HeMPDKOw9EgsBEmrWjhpjenF1x5ly0zgxk1nMEri1UlO3
 f+bbT0VvsVyNRCQdpHW6Q8p1PBVQFQcDexaYRp5558v/pdfroB4rw5R8bD1uSDKqwC
 im8lvJpVsM2VWwffYpTMNzhL2pYOXz7bm3nkDQjs=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	pair@us.ibm.com,
	qemu-devel@nongnu.org,
	clg@kaod.org
Subject: [PATCH v3 2/2] spapr: Enable virtio iommu_platform=on by default
Date: Thu,  5 Mar 2020 15:30:09 +1100
Message-Id: <20200305043009.611636-3-david@gibson.dropbear.id.au>
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

Traditionally, virtio devices don't do DMA by the usual path on the
guest platform.  In particular they usually bypass any virtual IOMMU
the guest has, using hypervisor magic to access untranslated guest
physical addresses.

There's now the optional iommu_platform flag which can tell virtio
devices to use the platform's normal DMA path, including any IOMMUs.
That flag was motiviated for the case of hardware virtio
implementations, but there are other reasons to want it.

Specifically, the fact that the virtio device doesn't use vIOMMU
translation means that virtio devices are unsafe to pass to nested
guests, or to use with VFIO userspace drivers inside the guest.  This
is particularly noticeable on the pseries platform which *always* has
a guest-visible vIOMMU.

Not using the normal DMA path also causes difficulties for the guest
side driver when using the upcoming POWER Secure VMs (a.k.a. PEF).
While it's theoretically possible to handle this on the guest side,
it's really fiddly.  Given the other problems with the non-translated
virtio device, let's just enable vIOMMU translation for virtio devices
by default in the pseries-5.0 (and later) machine types.

This does mean the new machine type will no longer support guest
kernels older than 4.8, unless they have support for the virtio
IOMMU_PLATFORM flag backported (which some distro kernels like RHEL7
do).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3cfc98ac61..5ef099536e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4575,6 +4575,7 @@ static void spapr_machine_latest_class_options(Mach=
ineClass *mc)
      */
     static GlobalProperty compat[] =3D {
         { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
+        { TYPE_VIRTIO_DEVICE, "iommu_platform", "on", },
     };
=20
     mc->alias =3D "pseries";
@@ -4622,6 +4623,7 @@ static void spapr_machine_4_2_class_options(Machine=
Class *mc)
     SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
         { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
+        { TYPE_VIRTIO_DEVICE, "iommu_platform", "off", },
     };
=20
     spapr_machine_5_0_class_options(mc);
--=20
2.24.1


