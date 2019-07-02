Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E534BC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B321A20881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Jv9cphML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B321A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCTl-0006gX-1W
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58819)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzK-0005Nf-Eu
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzI-0003G7-K3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47233 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBzG-0002yx-AD; Tue, 02 Jul 2019 02:09:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMl2fwrz9sQm; Tue,  2 Jul 2019 16:09:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047747;
 bh=aCPek2AYuldWB9s1DOJowKsZqT1D6uezI0A6JQoAHY8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jv9cphMLIvVUbRknZTDxekQg18i12riIgOshw0zVAkqP3uxIpZMWC7eyHB7kjBQCR
 VsM9Ge5M0QB/pi5e5L0afBk8bVuGukipGjxPnCaP2/wD8mvaUt0ocynCghtRrUVRHD
 IGakAYOXjGGAYM8uw8nHrZ61Piu8AU79JP01QfGc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:32 +1000
Message-Id: <20190702060857.3926-25-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 24/49] xics/kvm: Always use local_err in
 xics_kvm_init()
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Passing both errp and &local_err to functions is a recipe for messing
things up.

Since we must use &local_err for icp_kvm_realize(), use &local_err
everywhere where rollback must happen and have a single call to
error_propagate() them all. While here, add errno to the error
message.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156077921212.433243.11716701611944816815.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 377ff88701..c9e25fb051 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -353,32 +353,36 @@ int xics_kvm_connect(SpaprMachineState *spapr, Erro=
r **errp)
=20
     rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_SET_XIVE, "ibm,set-x=
ive");
     if (rc < 0) {
-        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,set-xive"=
);
+        error_setg_errno(&local_err, -rc,
+                         "kvmppc_define_rtas_kernel_token: ibm,set-xive"=
);
         goto fail;
     }
=20
     rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_GET_XIVE, "ibm,get-x=
ive");
     if (rc < 0) {
-        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,get-xive"=
);
+        error_setg_errno(&local_err, -rc,
+                         "kvmppc_define_rtas_kernel_token: ibm,get-xive"=
);
         goto fail;
     }
=20
     rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_INT_ON, "ibm,int-on"=
);
     if (rc < 0) {
-        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,int-on");
+        error_setg_errno(&local_err, -rc,
+                         "kvmppc_define_rtas_kernel_token: ibm,int-on");
         goto fail;
     }
=20
     rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_INT_OFF, "ibm,int-of=
f");
     if (rc < 0) {
-        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,int-off")=
;
+        error_setg_errno(&local_err, -rc,
+                         "kvmppc_define_rtas_kernel_token: ibm,int-off")=
;
         goto fail;
     }
=20
     /* Create the KVM XICS device */
     rc =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
     if (rc < 0) {
-        error_setg_errno(errp, -rc, "Error on KVM_CREATE_DEVICE for XICS=
");
+        error_setg_errno(&local_err, -rc, "Error on KVM_CREATE_DEVICE fo=
r XICS");
         goto fail;
     }
=20
@@ -393,7 +397,6 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error =
**errp)
=20
         icp_kvm_realize(DEVICE(spapr_cpu_state(cpu)->icp), &local_err);
         if (local_err) {
-            error_propagate(errp, local_err);
             goto fail;
         }
     }
@@ -410,6 +413,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error =
**errp)
     return 0;
=20
 fail:
+    error_propagate(errp, local_err);
     kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
     kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
     kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
--=20
2.21.0


