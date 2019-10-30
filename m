Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6F5CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1C1208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NXBg3gor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1C1208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPqvV-0002Y7-4b
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 12:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iPquA-0001h2-0h
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iPqu8-0007y0-LN
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:33:05 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52785 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iPqu7-0007Z6-HR; Wed, 30 Oct 2019 12:33:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 473DX64fdDz9sPd; Thu, 31 Oct 2019 03:32:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572453174;
 bh=2Ut/jU05PVrItKTeJQ9DougQ62vrTiFKSOQcEp5RSiQ=;
 h=From:To:Cc:Subject:Date:From;
 b=NXBg3gorz0c0fLwr/RktbGlbPnY1V4iIF9dLv0fbL6XIVAnTNCnAkUhVPLtaCZjHi
 uduGDivtSA+k2QLMKvGvO8ykjT3YDNVwijMO0Qi+R6DyAE7EobFrqKAG3Ue7AsffyG
 20/7QeNtnqYzgqXcZfV/MxFV71TSYC/mMsodBJhQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: jdenemar@redhat.com,
	david@redhat.com
Subject: [PATCH] spapr/kvm: Set default cpu model for all machine classes
Date: Wed, 30 Oct 2019 17:32:43 +0100
Message-Id: <20191030163243.10644-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
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
Cc: qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have to set the default model of all machine classes, not just for the
active one. Otherwise, "query-machines" will indicate the wrong CPU model
("qemu-s390x-cpu" instead of "host-s390x-cpu") as "default-cpu-type".

s390x already fixed this in de60a92e "s390x/kvm: Set default cpu model fo=
r
all machine classes".  This patch applies a similar fix for the pseries-*
machine types on ppc64.

Doing a
    {"execute":"query-machines"}
under KVM now results in
    {
      "hotpluggable-cpus": true,
      "name": "pseries-4.2",
      "numa-mem-supported": true,
      "default-cpu-type": "host-powerpc64-cpu",
      "is-default": true,
      "cpu-max": 1024,
      "deprecated": false,
      "alias": "pseries"
    },
    {
      "hotpluggable-cpus": true,
      "name": "pseries-4.1",
      "numa-mem-supported": true,
      "default-cpu-type": "host-powerpc64-cpu",
      "cpu-max": 1024,
      "deprecated": false
    },
    ...

Libvirt probes all machines via "-machine none,accel=3Dkvm:tcg" and will
currently see the wrong CPU model under KVM.

Reported-by: Ji=C5=99i Denemark <jdenemar@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 target/ppc/kvm.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7d2e8969ac..c77f9848ec 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -100,7 +100,7 @@ static bool kvmppc_is_pr(KVMState *ks)
     return kvm_vm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) !=3D 0;
 }
=20
-static int kvm_ppc_register_host_cpu_type(MachineState *ms);
+static int kvm_ppc_register_host_cpu_type(void);
 static void kvmppc_get_cpu_characteristics(KVMState *s);
 static int kvmppc_get_dec_bits(void);
=20
@@ -147,7 +147,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         exit(1);
     }
=20
-    kvm_ppc_register_host_cpu_type(ms);
+    kvm_ppc_register_host_cpu_type();
=20
     return 0;
 }
@@ -2534,13 +2534,19 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
     return pvr_pcc;
 }
=20
-static int kvm_ppc_register_host_cpu_type(MachineState *ms)
+static void pseries_machine_class_fixup(ObjectClass *oc, void *opaque)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
+    mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
+}
+
+static int kvm_ppc_register_host_cpu_type(void)
 {
     TypeInfo type_info =3D {
         .name =3D TYPE_HOST_POWERPC_CPU,
         .class_init =3D kvmppc_host_cpu_class_init,
     };
-    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
     PowerPCCPUClass *pvr_pcc;
     ObjectClass *oc;
     DeviceClass *dc;
@@ -2552,10 +2558,9 @@ static int kvm_ppc_register_host_cpu_type(MachineS=
tate *ms)
     }
     type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
     type_register(&type_info);
-    if (object_dynamic_cast(OBJECT(ms), TYPE_SPAPR_MACHINE)) {
-        /* override TCG default cpu type with 'host' cpu model */
-        mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
-    }
+    /* override TCG default cpu type with 'host' cpu model */
+    object_class_foreach(pseries_machine_class_fixup, TYPE_SPAPR_MACHINE=
,
+                         false, NULL);
=20
     oc =3D object_class_by_name(type_info.name);
     g_assert(oc);
--=20
2.21.0


