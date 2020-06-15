Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96537C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6FA2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7lo/mOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6FA2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkw8Q-00009G-Fz
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 16:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvuF-0002ua-FO
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvuB-0000XE-QL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VBjlJPvV3hPd138FX8e4juWsuXpfOwT0PkBigNWG35U=;
 b=Y7lo/mOs3azQvVILUWwhDeuRnhDbRqoyM3ecpt1c8VloSN/wgS1us6XGJ/wJkl2ZHAF532
 DJDADhE0oPgS3ac1hLvHXGnUptCzQZhWWxubG68eLxfwhUR8p9qh2unwyUOVO3bj5pa0it
 ABQi5BunNjSg4PKVeUETX0ET+dzUJXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-IAKguHWYPQyoWtibZmhVXQ-1; Mon, 15 Jun 2020 16:40:27 -0400
X-MC-Unique: IAKguHWYPQyoWtibZmhVXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B22B0803303;
 Mon, 15 Jun 2020 20:40:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AE585D9CD;
 Mon, 15 Jun 2020 20:40:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6565811358DE; Mon, 15 Jun 2020 22:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/84] riscv: Fix to put "riscv.hart_array" devices on sysbus
Date: Mon, 15 Jun 2020 22:39:05 +0200
Message-Id: <20200615204008.3069956-22-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

riscv_sifive_e_soc_init(), riscv_sifive_u_soc_init(),
spike_board_init(), spike_v1_10_0_board_init(),
spike_v1_09_1_board_init(), and riscv_virt_board_init() create
"riscv-hart_array" sysbus devices in a way that leaves them unplugged.

Create them the common way that puts them into the main system bus.
Affects machines sifive_e, sifive_u, spike, spike_v1.10, spike_v1.9.1,
and virt.  Visible in "info qtree", here's the change for sifive_e:

     bus: main-system-bus
       type System
    +  dev: riscv.hart_array, id ""
    +    num-harts = 1 (0x1)
    +    hartid-base = 0 (0x0)
    +    cpu-type = "sifive-e31-riscv-cpu"
       dev: sifive_soc.gpio, id ""

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-riscv@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200609122339.937862-20-armbru@redhat.com>
---
 hw/riscv/opentitan.c |  5 ++---
 hw/riscv/sifive_e.c  |  5 ++---
 hw/riscv/sifive_u.c  | 14 ++++++--------
 hw/riscv/spike.c     |  4 ++--
 hw/riscv/virt.c      |  4 ++--
 5 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index b4fb836466..29887fe363 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -94,9 +94,8 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
 {
     LowRISCIbexSoCState *s = RISCV_IBEX_SOC(obj);
 
-    object_initialize_child(obj, "cpus", &s->cpus,
-                            sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
-                            &error_abort, NULL);
+    sysbus_init_child_obj(obj, "cpus", &s->cpus,
+                          sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
 }
 
 static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 472a98970b..d2e2350a4d 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -149,9 +149,8 @@ static void riscv_sifive_e_soc_init(Object *obj)
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveESoCState *s = RISCV_E_SOC(obj);
 
-    object_initialize_child(obj, "cpus", &s->cpus,
-                            sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
-                            &error_abort, NULL);
+    sysbus_init_child_obj(obj, "cpus", &s->cpus,
+                          sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
     object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
                             &error_abort);
     sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0",
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f9fef2be91..d6c6364596 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -491,10 +491,9 @@ static void sifive_u_soc_instance_init(Object *obj)
                             &error_abort, NULL);
     qdev_prop_set_uint32(DEVICE(&s->e_cluster), "cluster-id", 0);
 
-    object_initialize_child(OBJECT(&s->e_cluster), "e-cpus",
-                            &s->e_cpus, sizeof(s->e_cpus),
-                            TYPE_RISCV_HART_ARRAY, &error_abort,
-                            NULL);
+    sysbus_init_child_obj(OBJECT(&s->e_cluster), "e-cpus",
+                          &s->e_cpus, sizeof(s->e_cpus),
+                          TYPE_RISCV_HART_ARRAY);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
@@ -504,10 +503,9 @@ static void sifive_u_soc_instance_init(Object *obj)
                             &error_abort, NULL);
     qdev_prop_set_uint32(DEVICE(&s->u_cluster), "cluster-id", 1);
 
-    object_initialize_child(OBJECT(&s->u_cluster), "u-cpus",
-                            &s->u_cpus, sizeof(s->u_cpus),
-                            TYPE_RISCV_HART_ARRAY, &error_abort,
-                            NULL);
+    sysbus_init_child_obj(OBJECT(&s->u_cluster), "u-cpus",
+                          &s->u_cpus, sizeof(s->u_cpus),
+                          TYPE_RISCV_HART_ARRAY);
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
     qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", SIFIVE_U_CPU);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 7bbbdb5036..7d1119dcb6 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -169,8 +169,8 @@ static void spike_board_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
 
     /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
+    sysbus_init_child_obj(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+                          TYPE_RISCV_HART_ARRAY);
     object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4e4c494a70..d569b38d1b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -485,8 +485,8 @@ static void virt_machine_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
 
     /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
+    sysbus_init_child_obj(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+                          TYPE_RISCV_HART_ARRAY);
     object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-- 
2.26.2


