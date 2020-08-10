Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C5422D07
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C5422D07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5B71-0002sT-Fp
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 12:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B4u-0006yT-KZ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:55:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B4r-0000nk-PT
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:55:16 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-Kk3b-ToDNXS291tDU34NoA-1; Mon, 10 Aug 2020 12:55:11 -0400
X-MC-Unique: Kk3b-ToDNXS291tDU34NoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24C771005504;
 Mon, 10 Aug 2020 16:55:10 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F5226111F;
 Mon, 10 Aug 2020 16:55:09 +0000 (UTC)
Subject: [PATCH 11/14] ppc/xive: Fix error handling in vmstate_xive_tctx_*()
 callbacks
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:55:08 +0200
Message-ID: <159707850840.1489912.14912810818646455474.stgit@bahia.lan>
In-Reply-To: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
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

Now that kvmppc_xive_cpu_get_state() and kvmppc_xive_cpu_set_state()
return negative errnos on failures, use that instead local_err because
it is the recommended practice. Also return that instead of -1 since
vmstate expects negative errnos.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xive.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a453e8f4dcbe..17ca5a1916b4 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -695,12 +695,13 @@ static int vmstate_xive_tctx_pre_save(void *opaque)
 {
     XiveTCTX *tctx =3D XIVE_TCTX(opaque);
     Error *local_err =3D NULL;
+    int ret;
=20
     if (xive_in_kernel(tctx->xptr)) {
-        kvmppc_xive_cpu_get_state(tctx, &local_err);
-        if (local_err) {
+        ret =3D kvmppc_xive_cpu_get_state(tctx, &local_err);
+        if (ret < 0) {
             error_report_err(local_err);
-            return -1;
+            return ret;
         }
     }
=20
@@ -711,16 +712,17 @@ static int vmstate_xive_tctx_post_load(void *opaque, =
int version_id)
 {
     XiveTCTX *tctx =3D XIVE_TCTX(opaque);
     Error *local_err =3D NULL;
+    int ret;
=20
     if (xive_in_kernel(tctx->xptr)) {
         /*
          * Required for hotplugged CPU, for which the state comes
          * after all states of the machine.
          */
-        kvmppc_xive_cpu_set_state(tctx, &local_err);
-        if (local_err) {
+        ret =3D kvmppc_xive_cpu_set_state(tctx, &local_err);
+        if (ret < 0) {
             error_report_err(local_err);
-            return -1;
+            return ret;
         }
     }
=20



