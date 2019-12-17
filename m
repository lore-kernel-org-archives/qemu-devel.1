Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8912C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C7820733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hJ9N7d1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C7820733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih52s-0002zv-4c
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jB-0001Nk-KN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jA-0006o4-Eo
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:57 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38365 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jA-0006G0-4I; Mon, 16 Dec 2019 23:44:56 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWZ0qFjz9sT3; Tue, 17 Dec 2019 15:43:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557818;
 bh=hd3b5kZWmqs5s5i8WFPHWqDD8/H2XVn5MIFF9ib4lpM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hJ9N7d1E8F4ddkP5mCdjTNaUgunRwvueDPtvCmQDq8xm7yMWzOCUFqdzfjU21y+fr
 +19YVLB7G72Ip3kB9b7dO5lFu5rOUNIa7hoFsoqdTMoJFNJaHN9QYXmIKiU065R/iZ
 Qh9IcZKZfGpuYMn81vV/zARI7lL2BuB/L725etvA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 42/88] spapr/xive: Configure number of servers in KVM
Date: Tue, 17 Dec 2019 15:42:36 +1100
Message-Id: <20191217044322.351838-43-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The XIVE KVM devices now has an attribute to configure the number of
interrupt servers. This allows to greatly optimize the usage of the VP
space in the XIVE HW, and thus to start a lot more VMs.

Only set this attribute if available in order to support older POWER9
KVM.

The XIVE KVM device now reports the exhaustion of VPs upon the
connection of the first VCPU. Check that in order to have a chance
to provide a hint to the user.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157478679392.67101.7843580591407950866.stgit@bahia.tlslab.ib=
m.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 46c7609bd8..32b2809210 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -152,7 +152,8 @@ void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx=
, Error **errp)
=20
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
 {
-    SpaprXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    SpaprXive *xive =3D SPAPR_MACHINE(ms)->xive;
     unsigned long vcpu_id;
     int ret;
=20
@@ -171,8 +172,16 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error *=
*errp)
     ret =3D kvm_vcpu_enable_cap(tctx->cs, KVM_CAP_PPC_IRQ_XIVE, 0, xive-=
>fd,
                               vcpu_id, 0);
     if (ret < 0) {
-        error_setg(errp, "XIVE: unable to connect CPU%ld to KVM device: =
%s",
+        Error *local_err =3D NULL;
+
+        error_setg(&local_err,
+                   "XIVE: unable to connect CPU%ld to KVM device: %s",
                    vcpu_id, strerror(errno));
+        if (errno =3D=3D ENOSPC) {
+            error_append_hint(&local_err, "Try -smp maxcpus=3DN with N <=
 %u\n",
+                              ms->smp.max_cpus);
+        }
+        error_propagate(errp, local_err);
         return;
     }
=20
@@ -758,6 +767,16 @@ int kvmppc_xive_connect(SpaprInterruptController *in=
tc, uint32_t nr_servers,
         return -1;
     }
=20
+    /* Tell KVM about the # of VCPUs we may have */
+    if (kvm_device_check_attr(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
+                              KVM_DEV_XIVE_NR_SERVERS)) {
+        if (kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
+                              KVM_DEV_XIVE_NR_SERVERS, &nr_servers, true=
,
+                              &local_err)) {
+            goto fail;
+        }
+    }
+
     /*
      * 1. Source ESB pages - KVM mapping
      */
--=20
2.23.0


