Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794F2C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CCB205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="d9DLhVjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CCB205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE98i-0006cr-EW
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95X-0000kB-DK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95V-0001DS-Me
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:42 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38125 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95U-0000PW-R6; Tue, 17 Mar 2020 06:04:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKv3svgz9sRY; Tue, 17 Mar 2020 21:04:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439475;
 bh=PBE+gjeFRpPSfcZJVO9UNrzoIcWu1Dh/piS9F0gC7rg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d9DLhVjged4dRVvvfm3UA5Nzy6VpWGUVjkCj1YMaKRp5rNUuMh2lZfqFyU4QKxkBI
 5ORD3vecbyvmsnzBZY5y1/UWN+k26Y69ZVS+Uy1OO+UAZ8vcengpVysb+EbHIsdi6n
 UWX8AWR0gUSlTeUqCXEMN7Otg9JyPyxDmGUS0KyY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 02/45] spapr: Handle pending hot plug/unplug requests at CAS
Date: Tue, 17 Mar 2020 21:03:40 +1100
Message-Id: <20200317100423.622643-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

If a hot plug or unplug request is pending at CAS, we currently trigger
a CAS reboot, which severely increases the guest boot time. This is
because SLOF doesn't handle hot plug events and we had no way to fix
the FDT that gets presented to the guest.

We can do better thanks to recent changes in QEMU and SLOF:

- we now return a full FDT to SLOF during CAS

- SLOF was fixed to correctly detect any device that was either added or
  removed since boot time and to update its internal DT accordingly.

The right solution is to process all pending hot plug/unplug requests
during CAS: convert hot plugged devices to cold plugged devices and
remove the hot unplugged ones, which is exactly what spapr_drc_reset()
does. Also clear all hot plug events that are currently queued since
they're no longer relevant.

Note that SLOF cannot currently populate hot plugged PCI bridges or PHBs
at CAS. Until this limitation is lifted, SLOF will reset the machine when
this scenario occurs : this will allow the FDT to be fully processed when
SLOF is started again (ie. the same effect as the CAS reboot that would
occur anyway without this patch).

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158257222352.4102917.8984214333937947307.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_events.c  | 13 +++++++++++++
 hw/ppc/spapr_hcall.c   | 11 +++++------
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 8b32b7eea5..2afd1844e4 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -983,6 +983,19 @@ void spapr_clear_pending_events(SpaprMachineState *s=
papr)
     }
 }
=20
+void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr)
+{
+    SpaprEventLogEntry *entry =3D NULL, *next_entry;
+
+    QTAILQ_FOREACH_SAFE(entry, &spapr->pending_events, next, next_entry)=
 {
+        if (spapr_event_log_entry_type(entry) =3D=3D RTAS_LOG_TYPE_HOTPL=
UG) {
+            QTAILQ_REMOVE(&spapr->pending_events, entry, next);
+            g_free(entry->extended_log);
+            g_free(entry);
+        }
+    }
+}
+
 void spapr_events_init(SpaprMachineState *spapr)
 {
     int epow_irq =3D SPAPR_IRQ_EPOW;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 934eb12d27..c2b3286625 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1640,7 +1640,7 @@ static uint32_t cas_check_pvr(SpaprMachineState *sp=
apr, PowerPCCPU *cpu,
     return best_compat;
 }
=20
-static bool spapr_transient_dev_before_cas(void)
+static void spapr_handle_transient_dev_before_cas(SpaprMachineState *spa=
pr)
 {
     Object *drc_container;
     ObjectProperty *prop;
@@ -1658,10 +1658,11 @@ static bool spapr_transient_dev_before_cas(void)
                                                           prop->name, NU=
LL));
=20
         if (spapr_drc_transient(drc)) {
-            return true;
+            spapr_drc_reset(drc);
         }
     }
-    return false;
+
+    spapr_clear_pending_hotplug_events(spapr);
 }
=20
 static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
@@ -1834,9 +1835,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
=20
     spapr_irq_update_active_intc(spapr);
=20
-    if (spapr_transient_dev_before_cas()) {
-        spapr->cas_reboot =3D true;
-    }
+    spapr_handle_transient_dev_before_cas(spapr);
=20
     if (!spapr->cas_reboot) {
         void *fdt;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 09110961a5..a4216935a1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -824,6 +824,7 @@ int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
 void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
                           Error **errp);
 void spapr_clear_pending_events(SpaprMachineState *spapr);
+void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr);
 int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                       uint64_t pte0, uint64_t pte1);
--=20
2.24.1


