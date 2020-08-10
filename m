Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E93C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0F822D07
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0F822D07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5B71-0002vj-Ud
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 12:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B4o-0006mG-Fw
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:55:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57021
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B4m-0000mt-TT
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:55:10 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-f9Y9hy54M0O6kAR2OcFVgg-1; Mon, 10 Aug 2020 12:55:04 -0400
X-MC-Unique: f9Y9hy54M0O6kAR2OcFVgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DE991940920;
 Mon, 10 Aug 2020 16:55:03 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 585656F129;
 Mon, 10 Aug 2020 16:55:02 +0000 (UTC)
Subject: [PATCH 10/14] spapr/xive: Fix error handling in
 kvmppc_xive_post_load()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:55:01 +0200
Message-ID: <159707850148.1489912.18355118622296682631.stgit@bahia.lan>
In-Reply-To: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that all these functions return a negative errno on failure, check
that because it is preferred to local_err. And most of all, propagate it
because vmstate expects negative errnos.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 1686b036eb2d..005729ebffed 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -631,6 +631,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_=
id)
     Error *local_err =3D NULL;
     CPUState *cs;
     int i;
+    int ret;
=20
     /* The KVM XIVE device should be in use */
     assert(xive->fd !=3D -1);
@@ -641,11 +642,10 @@ int kvmppc_xive_post_load(SpaprXive *xive, int versio=
n_id)
             continue;
         }
=20
-        kvmppc_xive_set_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
-                                     &xive->endt[i], &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            return -1;
+        ret =3D kvmppc_xive_set_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
+                                           &xive->endt[i], &local_err);
+        if (ret < 0) {
+            goto fail;
         }
     }
=20
@@ -660,16 +660,14 @@ int kvmppc_xive_post_load(SpaprXive *xive, int versio=
n_id)
          * previously set in KVM. Since we don't do that for all interrupt=
s
          * at reset time anymore, let's do it now.
          */
-        kvmppc_xive_source_reset_one(&xive->source, i, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            return -1;
+        ret =3D kvmppc_xive_source_reset_one(&xive->source, i, &local_err)=
;
+        if (ret < 0) {
+            goto fail;
         }
=20
-        kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            return -1;
+        ret =3D kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &loc=
al_err);
+        if (ret < 0) {
+            goto fail;
         }
     }
=20
@@ -686,15 +684,18 @@ int kvmppc_xive_post_load(SpaprXive *xive, int versio=
n_id)
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        kvmppc_xive_cpu_set_state(spapr_cpu_state(cpu)->tctx, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            return -1;
+        ret =3D kvmppc_xive_cpu_set_state(spapr_cpu_state(cpu)->tctx, &loc=
al_err);
+        if (ret < 0) {
+            goto fail;
         }
     }
=20
     /* The source states will be restored when the machine starts running =
*/
     return 0;
+
+fail:
+    error_report_err(local_err);
+    return ret;
 }
=20
 /* Returns MAP_FAILED on error and sets errno */



