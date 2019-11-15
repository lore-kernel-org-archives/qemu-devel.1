Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA94C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44122072A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyLztV8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44122072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVkFD-0000TA-Kk
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 17:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iVk9i-0003rC-T8
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iVk9h-0000oT-GL
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iVk9h-0000oC-5h
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573857208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkBBnCuyCfKGIR9YXOw6emT9qG+af+UvXfR6hxOD64U=;
 b=QyLztV8UrWsZ5K5xuhs+YiyjXbOn9g09MkDc7lz5ItRouJw7faYonoPMXcmbJLxwMaSfHf
 T8FeJf7kR/jIGm18K6ZEqvIw1wOkKgM9UzVOhpgdQuUCOOrCnJbJAPMwX9ouAWZYznbaUt
 Wdp0O1qfuxftFejYbHIdTzwgE3TmPVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-9JRj39hDMWCp3ee13ZOcvQ-1; Fri, 15 Nov 2019 17:33:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73F92477;
 Fri, 15 Nov 2019 22:33:23 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-194.ams2.redhat.com
 [10.36.116.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64F1B66835;
 Fri, 15 Nov 2019 22:33:21 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] spapr: Add /chosen to FDT only at reset time to preserve
 kernel and initramdisk
Date: Fri, 15 Nov 2019 23:33:10 +0100
Message-Id: <20191115223312.204979-5-lvivier@redhat.com>
In-Reply-To: <20191115223312.204979-1-lvivier@redhat.com>
References: <20191115223312.204979-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 9JRj39hDMWCp3ee13ZOcvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

Since "spapr: Render full FDT on ibm,client-architecture-support" we build
the entire flatten device tree (FDT) twice - at the reset time and
when "ibm,client-architecture-support" (CAS) is called. The full FDT from
CAS is then applied on top of the SLOF internal device tree.

This is mostly ok, however there is a case when the QEMU is started with
-initrd and for some reason the guest decided to move/unpack the init RAM
disk image - the guest correctly notifies SLOF about the change but
at CAS it is overridden with the QEMU initial location addresses and
the guest may fail to boot if the original initrd memory was changed.

This fixes the problem by only adding the /chosen node at the reset time
to prevent the original QEMU's linux,initrd-start/linux,initrd-end to
override the updated addresses.

This only treats /chosen differently as we know there is a special case
already and it is unlikely anything else will need to change /chosen at CAS
we are better off not touching /chosen after we handed it over to SLOF.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20191024041308.5673-1-aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 94f9d27096af..e076f6023c73 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -917,7 +917,7 @@ static bool spapr_hotplugged_dev_before_cas(void)
     return false;
 }
=20
-static void *spapr_build_fdt(SpaprMachineState *spapr);
+static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset);
=20
 int spapr_h_cas_compose_response(SpaprMachineState *spapr,
                                  target_ulong addr, target_ulong size,
@@ -939,7 +939,7 @@ int spapr_h_cas_compose_response(SpaprMachineState *spa=
pr,
=20
     size -=3D sizeof(hdr);
=20
-    fdt =3D spapr_build_fdt(spapr);
+    fdt =3D spapr_build_fdt(spapr, false);
     _FDT((fdt_pack(fdt)));
=20
     if (fdt_totalsize(fdt) + sizeof(hdr) > size) {
@@ -1197,7 +1197,7 @@ static void spapr_dt_hypervisor(SpaprMachineState *sp=
apr, void *fdt)
     }
 }
=20
-static void *spapr_build_fdt(SpaprMachineState *spapr)
+static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset)
 {
     MachineState *machine =3D MACHINE(spapr);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
@@ -1297,7 +1297,9 @@ static void *spapr_build_fdt(SpaprMachineState *spapr=
)
     spapr_dt_rtas(spapr, fdt);
=20
     /* /chosen */
-    spapr_dt_chosen(spapr, fdt);
+    if (reset) {
+        spapr_dt_chosen(spapr, fdt);
+    }
=20
     /* /hypervisor */
     if (kvm_enabled()) {
@@ -1305,11 +1307,14 @@ static void *spapr_build_fdt(SpaprMachineState *spa=
pr)
     }
=20
     /* Build memory reserve map */
-    if (spapr->kernel_size) {
-        _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)))=
;
-    }
-    if (spapr->initrd_size) {
-        _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base, spapr->initrd_size)=
));
+    if (reset) {
+        if (spapr->kernel_size) {
+            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_siz=
e)));
+        }
+        if (spapr->initrd_size) {
+            _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
+                                  spapr->initrd_size)));
+        }
     }
=20
     /* ibm,client-architecture-support updates */
@@ -1718,7 +1723,7 @@ static void spapr_machine_reset(MachineState *machine=
)
      */
     fdt_addr =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
=20
-    fdt =3D spapr_build_fdt(spapr);
+    fdt =3D spapr_build_fdt(spapr, true);
=20
     rc =3D fdt_pack(fdt);
=20
--=20
2.23.0


