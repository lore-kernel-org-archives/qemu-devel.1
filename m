Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E4C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60709206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB8GrB7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60709206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHus-0005nb-Dq
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCh-0006AP-BY
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCf-00054R-Oy
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59249
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCf-00051e-IV
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bqxe3/LncuS1EZbtoURcBkIZeQhXsx9IG0m/GfFxDT8=;
 b=PB8GrB7hqkIBFdzMqIUzR3M/h41sRFGV8VQ2ZnF2PYFyetp7CdjAKI6JR973ERbjz8q1Dx
 E+H3pgore4iQQt8O/ieM4vy3GnkOEl9eP9++1Xt+EuRfrTdwbl7PtblCS5CbYmeKt5oOqN
 jlZqrJ5lQ/6UdbDZ6mKFvgwg2R5gVkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-aYGrW5XXPM2alDrmosd2Sg-1; Tue, 31 Dec 2019 08:04:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D157918031CD
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:50 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 597D8620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 76/86] post conversion default_ram_id cleanup
Date: Tue, 31 Dec 2019 14:04:00 +0100
Message-Id: <1577797450-88458-77-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: aYGrW5XXPM2alDrmosd2Sg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With default_ram_id is always defined, simplify
'if' conditions in vl.c and numa.c

while at it set
  MachineClass::default_ram_id =3D "ram"
and clean up several boards that use "ram" id

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/alpha/dp264.c       | 1 -
 hw/arm/aspeed.c        | 1 -
 hw/arm/digic_boards.c  | 1 -
 hw/arm/raspi.c         | 2 --
 hw/core/machine.c      | 1 +
 hw/core/null-machine.c | 1 -
 hw/core/numa.c         | 2 +-
 hw/hppa/machine.c      | 1 -
 hw/ppc/virtex_ml507.c  | 1 -
 vl.c                   | 1 -
 10 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 29439c7..f6b9e50 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -183,7 +183,6 @@ static void clipper_machine_init(MachineClass *mc)
     mc->max_cpus =3D 4;
     mc->is_default =3D 1;
     mc->default_cpu_type =3D ALPHA_CPU_TYPE_NAME("ev67");
-    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("clipper", clipper_machine_init)
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 330254b..188d42f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -391,7 +391,6 @@ static void aspeed_machine_class_init(ObjectClass *oc, =
void *data)
     mc->no_floppy =3D 1;
     mc->no_cdrom =3D 1;
     mc->no_parallel =3D 1;
-    mc->default_ram_id =3D "ram";
 }
=20
 static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data=
)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index c3bc5cb..c3cffb3 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -149,7 +149,6 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->init =3D &canon_a1100_init;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_ram_size =3D 64 * MiB;
-    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 33ace66..3d49dcc 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -223,7 +223,6 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->min_cpus =3D BCM283X_NCPUS;
     mc->default_cpus =3D BCM283X_NCPUS;
     mc->default_ram_size =3D 1 * GiB;
-    mc->default_ram_id =3D "ram";
     mc->ignore_memory_transaction_failures =3D true;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
@@ -246,7 +245,6 @@ static void raspi3_machine_init(MachineClass *mc)
     mc->min_cpus =3D BCM283X_NCPUS;
     mc->default_cpus =3D BCM283X_NCPUS;
     mc->default_ram_size =3D 1 * GiB;
-    mc->default_ram_id =3D "ram";
 }
 DEFINE_MACHINE("raspi3", raspi3_machine_init)
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 080ce57..a938052 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -711,6 +711,7 @@ static void machine_class_init(ObjectClass *oc, void *d=
ata)
=20
     /* Default 128 MB as guest ram size */
     mc->default_ram_size =3D 128 * MiB;
+    mc->default_ram_id =3D "ram";
     mc->rom_file_has_mr =3D true;
     mc->smp_parse =3D smp_parse;
=20
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index cb47d9d..08c6109 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -49,7 +49,6 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->init =3D machine_none_init;
     mc->max_cpus =3D 1;
     mc->default_ram_size =3D 0;
-    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 623b307..6a1711d 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -459,7 +459,7 @@ void numa_complete_configuration(MachineState *ms)
             exit(1);
         }
=20
-        if (!numa_uses_legacy_mem() && mc->default_ram_id) {
+        if (!numa_uses_legacy_mem()) {
             ms->ram =3D g_new(MemoryRegion, 1);
             memory_region_init(ms->ram, OBJECT(ms), mc->default_ram_id,
                                ram_size);
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index b2f7bc5..ebbf44f 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -279,7 +279,6 @@ static void machine_hppa_machine_init(MachineClass *mc)
     mc->is_default =3D 1;
     mc->default_ram_size =3D 512 * MiB;
     mc->default_boot_order =3D "cd";
-    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("hppa", machine_hppa_machine_init)
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index b74a269..b31f1cf 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -299,7 +299,6 @@ static void virtex_machine_init(MachineClass *mc)
     mc->desc =3D "Xilinx Virtex ML507 reference design";
     mc->init =3D virtex_init;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("440-xilinx");
-    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
diff --git a/vl.c b/vl.c
index b89e76c..60dffb4 100644
--- a/vl.c
+++ b/vl.c
@@ -4296,7 +4296,6 @@ int main(int argc, char **argv, char **envp)
=20
     if (numa_uses_legacy_mem() &&
         machine_class->default_ram_size &&
-        machine_class->default_ram_id &&
         !current_machine->ram_memdev) {
         create_default_memdev(current_machine, mem_path, mem_prealloc);
     }
--=20
2.7.4


