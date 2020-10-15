Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB0C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F9A2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F9A2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTAi5-0007nR-5u
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kTAeL-0004c7-Ir
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:19:01 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:49307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kTAeJ-0001Do-4c
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:19:01 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-edjElHy5NOSg5FY3J8C8Xg-1; Thu, 15 Oct 2020 17:18:56 -0400
X-MC-Unique: edjElHy5NOSg5FY3J8C8Xg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1B3518A8221;
 Thu, 15 Oct 2020 21:18:54 +0000 (UTC)
Received: from bahia.lan (ovpn-112-78.ams2.redhat.com [10.36.112.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26D2A75128;
 Thu, 15 Oct 2020 21:18:53 +0000 (UTC)
Subject: [PATCH v2 5/5] spapr: Simplify spapr_cpu_core_realize() and
 spapr_cpu_core_unrealize()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 15 Oct 2020 23:18:53 +0200
Message-ID: <160279673321.1808373.2248221100790367912.stgit@bahia.lan>
In-Reply-To: <160279669833.1808373.9524145092720289601.stgit@bahia.lan>
References: <160279669833.1808373.9524145092720289601.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 17:18:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the error path of spapr_cpu_core_realize() is just to call
idempotent spapr_cpu_core_unrealize() for rollback, no need to create
and realize the vCPUs in two separate loops.

Merge them and do them same in spapr_cpu_core_unrealize() for symmetry.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 317fb9934f58..2f7dc3c23ded 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -238,10 +238,6 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
                                          &error_abort)) {
                 spapr_unrealize_vcpu(sc->threads[i], sc);
             }
-        }
-    }
-    for (i =3D 0; i < cc->nr_threads; i++) {
-        if (sc->threads[i]) {
             spapr_delete_vcpu(sc->threads[i]);
         }
     }
@@ -326,7 +322,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Er=
ror **errp)
                                                   TYPE_SPAPR_MACHINE);
     SpaprCpuCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(OBJECT(dev));
-    int i, j;
+    int i;
=20
     if (!spapr) {
         error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machine");
@@ -337,14 +333,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, E=
rror **errp)
     sc->threads =3D g_new0(PowerPCCPU *, cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
         sc->threads[i] =3D spapr_create_vcpu(sc, i, errp);
-        if (!sc->threads[i]) {
-            spapr_cpu_core_unrealize(dev);
-            return;
-        }
-    }
-
-    for (j =3D 0; j < cc->nr_threads; j++) {
-        if (!spapr_realize_vcpu(sc->threads[j], spapr, sc, errp)) {
+        if (!sc->threads[i] ||
+            !spapr_realize_vcpu(sc->threads[i], spapr, sc, errp)) {
             spapr_cpu_core_unrealize(dev);
             return;
         }



