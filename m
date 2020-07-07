Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE86AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CDC2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2G6/cra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CDC2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsq8c-00055g-Ol
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq79-0001wX-VM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq72-0006nq-QO
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ka0Bl6KaonGt2VTVzxk7TviRf5c0bxEvNQCkAhpSfmM=;
 b=C2G6/cra9UO9cp6D9CGIxH0okeb2zvDbVvS1SERbFNQUSfZNOipXxw1tmIvrR6tshA08hU
 cdqlHf3QnATMF8AvJA+9a1sjHOxnQQHTH5ylZUqZZOJWbIczeEfecOBd3u1IyWhXrYxT6f
 3qHV5CuLGjwL0Rbcn7Uo2iyB1UtIzS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-OXZE_gYaNAaXnzR0AzGn8A-1; Tue, 07 Jul 2020 12:06:26 -0400
X-MC-Unique: OXZE_gYaNAaXnzR0AzGn8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEE88107ACF2;
 Tue,  7 Jul 2020 16:06:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77F4419D7B;
 Tue,  7 Jul 2020 16:06:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6C3A1144259; Tue,  7 Jul 2020 18:06:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 23/45] qom: Crash more nicely on object_property_get_link()
 failure
Date: Tue,  7 Jul 2020 18:05:51 +0200
Message-Id: <20200707160613.848843-24-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass &error_abort instead of NULL where the returned value is
dereferenced or asserted to be non-null.  Drop a now redundant
assertion.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/core/platform-bus.c     | 6 +++---
 hw/ppc/spapr_drc.c         | 3 ++-
 hw/ppc/spapr_hcall.c       | 3 ++-
 hw/ppc/spapr_pci_nvlink2.c | 3 ++-
 ui/vnc.c                   | 2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index d494e5cec1..5037ca265e 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/platform-bus.h"
 #include "hw/qdev-properties.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 
@@ -63,9 +64,8 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDevice *sbdev,
         return -1;
     }
 
-    parent_mr = object_property_get_link(OBJECT(sbdev_mr), "container", NULL);
-
-    assert(parent_mr);
+    parent_mr = object_property_get_link(OBJECT(sbdev_mr), "container",
+                                         &error_abort);
     if (parent_mr != pbus_mr_obj) {
         /* MMIO region is not mapped on platform bus */
         return -1;
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index d10193f39e..1f18b79348 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -870,7 +870,8 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
             continue;
         }
 
-        obj = object_property_get_link(root_container, prop->name, NULL);
+        obj = object_property_get_link(root_container, prop->name,
+                                       &error_abort);
         drc = SPAPR_DR_CONNECTOR(obj);
         drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0f54988f2e..c1d01228c6 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1655,7 +1655,8 @@ static void spapr_handle_transient_dev_before_cas(SpaprMachineState *spapr)
             continue;
         }
         drc = SPAPR_DR_CONNECTOR(object_property_get_link(drc_container,
-                                                          prop->name, NULL));
+                                                          prop->name,
+                                                          &error_abort));
 
         if (spapr_drc_transient(drc)) {
             spapr_drc_reset(drc);
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index 8332d5694e..dd8cd6db96 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -358,7 +358,8 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
     for (i = 0; i < sphb->nvgpus->num; ++i) {
         SpaprPhbPciNvGpuSlot *nvslot = &sphb->nvgpus->slots[i];
         Object *nv_mrobj = object_property_get_link(OBJECT(nvslot->gpdev),
-                                                    "nvlink2-mr[0]", NULL);
+                                                    "nvlink2-mr[0]",
+                                                    &error_abort);
         uint32_t associativity[] = {
             cpu_to_be32(0x4),
             SPAPR_GPU_NUMA_ID,
diff --git a/ui/vnc.c b/ui/vnc.c
index 527ad25124..f006aa1afd 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -568,7 +568,7 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
                        &info->vencrypt, &info->has_vencrypt);
         if (vd->dcl.con) {
             dev = DEVICE(object_property_get_link(OBJECT(vd->dcl.con),
-                                                  "device", NULL));
+                                                  "device", &error_abort));
             info->has_display = true;
             info->display = g_strdup(dev->id);
         }
-- 
2.26.2


