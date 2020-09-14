Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF7BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBCB20771
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBCB20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnop-000392-Gr
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhx-0006st-H6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhv-0000lP-Nt
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:45 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-cqBDgbwINseq0AClHZNAHw-1; Mon, 14 Sep 2020 08:35:39 -0400
X-MC-Unique: cqBDgbwINseq0AClHZNAHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BFD68030A2;
 Mon, 14 Sep 2020 12:35:38 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B03441002393;
 Mon, 14 Sep 2020 12:35:36 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/15] spapr: Add a return value to spapr_check_pagesize()
Date: Mon, 14 Sep 2020 14:35:03 +0200
Message-Id: <20200914123505.612812-14-groug@kaod.org>
In-Reply-To: <20200914123505.612812-1-groug@kaod.org>
References: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Greg Kurz <groug@kaod.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As recommended in "qapi/error.h", return true on success and false on
failure. This allows to reduce error propagation overhead in the callers.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/hw/ppc/spapr.h | 2 +-
 hw/ppc/spapr.c         | 4 +---
 hw/ppc/spapr_caps.c    | 7 +++++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 11682f00e8cc..114e81996988 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -941,7 +941,7 @@ void spapr_caps_cpu_apply(SpaprMachineState *spapr, Pow=
erPCCPU *cpu);
 void spapr_caps_add_properties(SpaprMachineClass *smc);
 int spapr_caps_post_migration(SpaprMachineState *spapr);
=20
-void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
+bool spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
                           Error **errp);
 /*
  * XIVE definitions
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bfa2a00da77e..e813c7cfb949 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3493,9 +3493,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
     memdev =3D object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PROP,
                                       &error_abort);
     pagesize =3D host_memory_backend_pagesize(MEMORY_BACKEND(memdev));
-    spapr_check_pagesize(spapr, pagesize, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!spapr_check_pagesize(spapr, pagesize, errp)) {
         return;
     }
=20
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 10a80a8159f4..9341e9782a3f 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -310,13 +310,13 @@ static void cap_safe_indirect_branch_apply(SpaprMachi=
neState *spapr,
=20
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
=20
-void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
+bool spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
                           Error **errp)
 {
     hwaddr maxpagesize =3D (1ULL << spapr->eff.caps[SPAPR_CAP_HPT_MAXPAGES=
IZE]);
=20
     if (!kvmppc_hpt_needs_host_contiguous_pages()) {
-        return;
+        return true;
     }
=20
     if (maxpagesize > pagesize) {
@@ -324,7 +324,10 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hw=
addr pagesize,
                    "Can't support %"HWADDR_PRIu" kiB guest pages with %"
                    HWADDR_PRIu" kiB host pages with this KVM implementatio=
n",
                    maxpagesize >> 10, pagesize >> 10);
+        return false;
     }
+
+    return true;
 }
=20
 static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
--=20
2.26.2


