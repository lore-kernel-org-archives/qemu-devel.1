Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1C2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81BB207DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81BB207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BAx-0000o6-SJ
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B5A-0007CO-DH
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:55:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60020
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B57-0000ur-DC
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:55:32 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-2M_Cz48CMNuw0Rch-kwwig-1; Mon, 10 Aug 2020 12:55:25 -0400
X-MC-Unique: 2M_Cz48CMNuw0Rch-kwwig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E59EE59;
 Mon, 10 Aug 2020 16:55:23 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BD155D9CD;
 Mon, 10 Aug 2020 16:55:22 +0000 (UTC)
Subject: [PATCH 13/14] ppc/xive: Simplify error handling in xive_tctx_realize()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:55:22 +0200
Message-ID: <159707852234.1489912.16410314514265848075.stgit@bahia.lan>
In-Reply-To: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.61; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=unavailable autolearn_force=no
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

Now that kvmppc_xive_cpu_connect() returns a negative errno on failure,
use that and get rid of the local_err boilerplate.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xive.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 17ca5a1916b4..489e6256ef70 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -662,7 +662,6 @@ static void xive_tctx_realize(DeviceState *dev, Error *=
*errp)
     XiveTCTX *tctx =3D XIVE_TCTX(dev);
     PowerPCCPU *cpu;
     CPUPPCState *env;
-    Error *local_err =3D NULL;
=20
     assert(tctx->cs);
     assert(tctx->xptr);
@@ -683,9 +682,7 @@ static void xive_tctx_realize(DeviceState *dev, Error *=
*errp)
=20
     /* Connect the presenter to the VCPU (required for CPU hotplug) */
     if (xive_in_kernel(tctx->xptr)) {
-        kvmppc_xive_cpu_connect(tctx, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (kvmppc_xive_cpu_connect(tctx, errp) < 0) {
             return;
         }
     }



