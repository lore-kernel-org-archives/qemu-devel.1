Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94265C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632A7216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aau0jHaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632A7216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiD3C-0002Kq-IG
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC08-0006G3-CJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC07-0003gc-0p
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60955 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiC06-0003Rm-D2; Tue, 02 Jul 2019 02:10:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMp6whYz9sRG; Tue,  2 Jul 2019 16:09:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047750;
 bh=xNBAfThvMp3uPtv4D+p/AYjVG9+ShPt5zcdDQqY4iIo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aau0jHaGdgRSE7rule/dv3dPCxOZ6Ws5M5JCnDUkKjV1kl1qoNJlah2AfoHMGTmpN
 3l7NnAF+/rN7YvhBOcXhWD/RaCeB3WvRW9EwGioDGlc3KVxi0/ahG3b7EhoJ00uD9w
 jx+tcpFSmBLk/9lWLq0CUxHHuLVPMN7GnIr1Kasw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:57 +1000
Message-Id: <20190702060857.3926-50-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 49/49] spapr/xive: Add proper rollback to
 kvmppc_xive_connect()
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

Make kvmppc_xive_disconnect() able to undo the changes of a partial
execution of kvmppc_xive_connect() and use it to perform rollback.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <156198735673.293938.7313195993600841641.stgit@bahia>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 48 ++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 5559f8bce5..3bf8e7a20e 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -724,8 +724,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **err=
p)
     xsrc->esb_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, =
esb_len,
                                       &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+        goto fail;
     }
=20
     memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
@@ -743,8 +742,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **err=
p)
     xive->tm_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, =
tima_len,
                                      &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+        goto fail;
     }
     memory_region_init_ram_device_ptr(&xive->tm_mmio_kvm, OBJECT(xive),
                                       "xive.tima", tima_len, xive->tm_mm=
ap);
@@ -760,21 +758,24 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **e=
rrp)
=20
         kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, &local_err);
         if (local_err) {
-            error_propagate(errp, local_err);
-            return;
+            goto fail;
         }
     }
=20
     /* Update the KVM sources */
     kvmppc_xive_source_reset(xsrc, &local_err);
     if (local_err) {
-            error_propagate(errp, local_err);
-            return;
+        goto fail;
     }
=20
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
+    return;
+
+fail:
+    error_propagate(errp, local_err);
+    kvmppc_xive_disconnect(xive, NULL);
 }
=20
 void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
@@ -796,23 +797,29 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error =
**errp)
     xsrc =3D &xive->source;
     esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
=20
-    memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm);
-    object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
-    munmap(xsrc->esb_mmap, esb_len);
-    xsrc->esb_mmap =3D NULL;
+    if (xsrc->esb_mmap) {
+        memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm=
);
+        object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
+        munmap(xsrc->esb_mmap, esb_len);
+        xsrc->esb_mmap =3D NULL;
+    }
=20
-    memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
-    object_unparent(OBJECT(&xive->tm_mmio_kvm));
-    munmap(xive->tm_mmap, 4ull << TM_SHIFT);
-    xive->tm_mmap =3D NULL;
+    if (xive->tm_mmap) {
+        memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
+        object_unparent(OBJECT(&xive->tm_mmio_kvm));
+        munmap(xive->tm_mmap, 4ull << TM_SHIFT);
+        xive->tm_mmap =3D NULL;
+    }
=20
     /*
      * When the KVM device fd is closed, the KVM device is destroyed
      * and removed from the list of devices of the VM. The VCPU
      * presenters are also detached from the device.
      */
-    close(xive->fd);
-    xive->fd =3D -1;
+    if (xive->fd !=3D -1) {
+        close(xive->fd);
+        xive->fd =3D -1;
+    }
=20
     kvm_kernel_irqchip =3D false;
     kvm_msi_via_irqfd_allowed =3D false;
@@ -822,5 +829,8 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error **=
errp)
     kvm_cpu_disable_all();
=20
     /* VM Change state handler is not needed anymore */
-    qemu_del_vm_change_state_handler(xive->change);
+    if (xive->change) {
+        qemu_del_vm_change_state_handler(xive->change);
+        xive->change =3D NULL;
+    }
 }
--=20
2.21.0


