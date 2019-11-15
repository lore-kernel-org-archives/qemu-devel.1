Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1A4C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77002072A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2XfVglS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77002072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVkH8-0002GV-TT
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 17:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iVk9x-0003zM-AW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iVk9w-0000vX-6M
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24525
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iVk9v-0000v3-EY
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573857223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZhkqmiZ0I2Ks/BCR+8j353XbItxBsaSyT+JsObDfGQ=;
 b=f2XfVglS4PzBbpgK0fYqVUeW6eId9O1ATehv09HnqeKTe8n7vLWEwTg052IJtEqnPDxhFW
 VBZl/P1Qls8hKZgKOmFsmAYeVhvg8pza2N48roBXelP/eqieTvR4k4fnT02MLgGA5o41CV
 M5UCDiHCP3Hl6pa+ugMhzikIckTMJ+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-SrXyzJQ0MMisYm11oUzKrA-1; Fri, 15 Nov 2019 17:33:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9D74477;
 Fri, 15 Nov 2019 22:33:28 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-194.ams2.redhat.com
 [10.36.116.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA9A175E39;
 Fri, 15 Nov 2019 22:33:23 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] spapr/kvm: Set default cpu model for all machine classes
Date: Fri, 15 Nov 2019 23:33:11 +0100
Message-Id: <20191115223312.204979-6-lvivier@redhat.com>
In-Reply-To: <20191115223312.204979-1-lvivier@redhat.com>
References: <20191115223312.204979-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: SrXyzJQ0MMisYm11oUzKrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Ji=C5=99i=20Denemark?= <jdenemar@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Gibson <david@gibson.dropbear.id.au>

We have to set the default model of all machine classes, not just for
the active one. Otherwise, "query-machines" will indicate the wrong
CPU model (e.g. "power9_v2.0-powerpc64-cpu" instead of
"host-powerpc64-cpu") as "default-cpu-type".

s390x already fixed this in de60a92e "s390x/kvm: Set default cpu model for
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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
---
 target/ppc/kvm.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7d2e8969ac5f..c77f9848ec38 100644
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
@@ -2552,10 +2558,9 @@ static int kvm_ppc_register_host_cpu_type(MachineSta=
te *ms)
     }
     type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
     type_register(&type_info);
-    if (object_dynamic_cast(OBJECT(ms), TYPE_SPAPR_MACHINE)) {
-        /* override TCG default cpu type with 'host' cpu model */
-        mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
-    }
+    /* override TCG default cpu type with 'host' cpu model */
+    object_class_foreach(pseries_machine_class_fixup, TYPE_SPAPR_MACHINE,
+                         false, NULL);
=20
     oc =3D object_class_by_name(type_info.name);
     g_assert(oc);
--=20
2.23.0


