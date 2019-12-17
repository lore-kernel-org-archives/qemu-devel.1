Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7914BC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A722072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IC/xXLhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A722072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih554-0006h0-Ms
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ic-0000QM-SQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ib-0005yk-PE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:22 -0500
Received: from ozlabs.org ([203.11.71.1]:44833)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ib-0005wL-Du; Mon, 16 Dec 2019 23:44:21 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWX5Dxkz9sT2; Tue, 17 Dec 2019 15:43:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557816;
 bh=eHt+im12o+kyfnKW0xo3miFJfZBW7JfBFQ7bKqjoviY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IC/xXLhhQENWfgyZGtUi4SpU1hg+F0WJpr/jg8RA3HqBsys3A/RA9/asRUaaXiecN
 ti6agTuYOfUSignAiIkgPyCm65H9bT6DnjXiY6GaY969y5Byi6lUP5tXO9cQk7I4u0
 cOELX4BMGQgSl5ENs1UaR+iTFI6WQtGnKEgMpenw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 41/88] spapr/xics: Configure number of servers in KVM
Date: Tue, 17 Dec 2019 15:42:35 +1100
Message-Id: <20191217044322.351838-42-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The XICS-on-XIVE KVM devices now has an attribute to configure the number
of interrupt servers. This allows to greatly optimize the usage of the VP
space in the XIVE HW, and thus to start a lot more VMs.

Only set this attribute if available in order to support older POWER9 KVM
and pre-POWER9 XICS KVM devices.

The XICS-on-XIVE KVM device now reports the exhaustion of VPs upon the
connection of the first VCPU. Check that in order to have a chance to
provide a hint to the user.
`
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157478678846.67101.9660531022460517710.stgit@bahia.tlslab.ib=
m.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index a1f1b7b0d3..8d6156578f 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -165,8 +165,15 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
=20
     ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,=
 vcpu_id);
     if (ret < 0) {
-        error_setg(errp, "Unable to connect CPU%ld to kernel XICS: %s", =
vcpu_id,
-                   strerror(errno));
+        Error *local_err =3D NULL;
+
+        error_setg(&local_err, "Unable to connect CPU%ld to kernel XICS:=
 %s",
+                   vcpu_id, strerror(errno));
+        if (errno =3D=3D ENOSPC) {
+            error_append_hint(&local_err, "Try -smp maxcpus=3DN with N <=
 %u\n",
+                              MACHINE(qdev_get_machine())->smp.max_cpus)=
;
+        }
+        error_propagate(errp, local_err);
         return;
     }
     enabled_icp =3D g_malloc(sizeof(*enabled_icp));
@@ -399,6 +406,16 @@ int xics_kvm_connect(SpaprInterruptController *intc,=
 uint32_t nr_servers,
         goto fail;
     }
=20
+    /* Tell KVM about the # of VCPUs we may have (POWER9 and newer only)=
 */
+    if (kvm_device_check_attr(rc, KVM_DEV_XICS_GRP_CTRL,
+                              KVM_DEV_XICS_NR_SERVERS)) {
+        if (kvm_device_access(rc, KVM_DEV_XICS_GRP_CTRL,
+                              KVM_DEV_XICS_NR_SERVERS, &nr_servers, true=
,
+                              &local_err)) {
+            goto fail;
+        }
+    }
+
     kernel_xics_fd =3D rc;
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
--=20
2.23.0


