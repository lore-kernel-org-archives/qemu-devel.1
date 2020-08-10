Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261B2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DC420829
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DC420829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5B5M-00073J-1x
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 12:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B42-0005Ib-B1
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53156
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B3z-0000hS-TJ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:54:21 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-5ZahJmd7NiGx9KDWL06zWQ-1; Mon, 10 Aug 2020 12:54:15 -0400
X-MC-Unique: 5ZahJmd7NiGx9KDWL06zWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79A408015FB;
 Mon, 10 Aug 2020 16:54:14 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 506276F12D;
 Mon, 10 Aug 2020 16:54:13 +0000 (UTC)
Subject: [PATCH 03/14] spapr/xive: Rework error handling of
 kvmppc_xive_source_reset()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:54:12 +0200
Message-ID: <159707845245.1489912.9151822670764690034.stgit@bahia.lan>
In-Reply-To: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
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

Since kvmppc_xive_source_reset_one() has a return value, convert
kvmppc_xive_source_reset() to use it for error checking. This
allows to get rid of the local_err boiler plate.

Propagate the return value so that callers may use it as well to check
failures.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index aa1a2f915363..d801bf5cd11c 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -248,24 +248,25 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, in=
t srcno, Error **errp)
                              true, errp);
 }
=20
-static void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
+static int kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
 {
     SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
     int i;
=20
     for (i =3D 0; i < xsrc->nr_irqs; i++) {
-        Error *local_err =3D NULL;
+        int ret;
=20
         if (!xive_eas_is_valid(&xive->eat[i])) {
             continue;
         }
=20
-        kvmppc_xive_source_reset_one(xsrc, i, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
+        ret =3D kvmppc_xive_source_reset_one(xsrc, i, errp);
+        if (ret < 0) {
+            return ret;
         }
     }
+
+    return 0;
 }
=20
 /*



