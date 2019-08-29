Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E52C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4C22189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="E2CSvOox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4C22189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3DuF-0004xu-PC
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 02:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3DcM-0004kX-N8
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3DcL-0003u7-0i
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:09:10 -0400
Received: from ozlabs.org ([203.11.71.1]:42731)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i3DcK-0003hN-BY; Thu, 29 Aug 2019 02:09:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JscP3s7pz9sPp; Thu, 29 Aug 2019 16:08:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567058917;
 bh=RBgHbhPx26tGG/QCPvEM4i2Bd9jCromG2Hg59zfhJ84=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E2CSvOox5OLQiitL0qU+n2WtaIgX6prY94ibB1kp+zjsif6QpGiofOuo8/flu+vqj
 ygpdsKmVjodA05kd6auWsqm9WJFZz+qGPkSztBWpkdtgenYixQ4AnhnRoUvAfrVjEB
 viYkckrBsERBmoQB49BurrWGn8nioYos3dez6ETk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Thu, 29 Aug 2019 16:08:27 +1000
Message-Id: <20190829060827.25731-20-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829060827.25731-1-david@gibson.dropbear.id.au>
References: <20190829060827.25731-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 19/19] spapr: Set compat mode in
 spapr_core_plug()
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

A recent change in spapr_machine_reset() showed that resetting the compat
mode in spapr_machine_reset() for the boot vCPU and in spapr_cpu_reset()
for all other vCPUs was fragile. The fix was thus to reset the compat mod=
e
for all vCPUs in spapr_machine_reset(), but we still have to propagate
it to hot-plugged CPUs. This is still performed from spapr_cpu_reset(),
hence resulting in ppc_set_compat() being called twice for every vCPU at
machine reset. Apart from wasting cycles, which isn't really an issue
during machine reset, this seems to indicate that spapr_cpu_reset() isn't
the best place to set the compat mode.

A natural candidate for CPU-hotplug specific code is spapr_core_plug().
Also, it sits in the same file as spapr_machine_reset() : this makes
it easier for someone who wants to know when the compat PVR is set.

Call ppc_set_compat() from there. This doesn't need to be done for
initial vCPUs since the compat PVR is 0 and spapr_machine_reset() sets
the appropriate value later. No need to do this on manually added vCPUS
on the destination QEMU during migration since the compat PVR is
part of the migrated vCPU state. Both conditions can be checked with
spapr_drc_hotplugged().

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156701285312.499757.7807417667750711711.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c          | 24 ++++++++++++++++--------
 hw/ppc/spapr_cpu_core.c |  7 -------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 447fb5c4ea..ea56499b4b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1758,12 +1758,6 @@ static void spapr_machine_reset(MachineState *mach=
ine)
         spapr_ovec_cleanup(spapr->ov5_cas);
         spapr->ov5_cas =3D spapr_ovec_new();
=20
-        /*
-         * reset compat_pvr for all CPUs
-         * as qemu_devices_reset() is called before this,
-         * it can't be propagated by spapr_cpu_reset()
-         * from the first CPU to all the others
-         */
         ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
     }
=20
@@ -3841,6 +3835,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
     CPUArchId *core_slot;
     int index;
     bool hotplugged =3D spapr_drc_hotplugged(dev);
+    int i;
=20
     core_slot =3D spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id,=
 &index);
     if (!core_slot) {
@@ -3874,13 +3869,26 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
     core_slot->cpu =3D OBJECT(dev);
=20
     if (smc->pre_2_10_has_unused_icps) {
-        int i;
-
         for (i =3D 0; i < cc->nr_threads; i++) {
             cs =3D CPU(core->threads[i]);
             pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
         }
     }
+
+    /*
+     * Set compatibility mode to match the boot CPU, which was either se=
t
+     * by the machine reset code or by CAS.
+     */
+    if (hotplugged) {
+        for (i =3D 0; i < cc->nr_threads; i++) {
+            ppc_set_compat(core->threads[i], POWERPC_CPU(first_cpu)->com=
pat_pvr,
+                           &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+        }
+    }
 }
=20
 static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 45e2f2747f..1d93de8161 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -41,13 +41,6 @@ static void spapr_cpu_reset(void *opaque)
      * using an RTAS call */
     cs->halted =3D 1;
=20
-    /* Set compatibility mode to match the boot CPU, which was either se=
t
-     * by the machine reset code or by CAS. This should never fail.
-     * At startup the value is already set for all the CPUs
-     * but we need this when we hotplug a new CPU
-     */
-    ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort=
);
-
     env->spr[SPR_HIOR] =3D 0;
=20
     lpcr =3D env->spr[SPR_LPCR];
--=20
2.21.0


