Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AD9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4CE22D72
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 16:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4CE22D72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5B8c-00062i-3x
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 12:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B5F-0007P1-QI
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:55:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29796
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5B5E-0000wV-5I
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 12:55:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-KjOy7M5_NbC-bVCsfgcv1Q-1; Mon, 10 Aug 2020 12:55:31 -0400
X-MC-Unique: KjOy7M5_NbC-bVCsfgcv1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D283C57;
 Mon, 10 Aug 2020 16:55:30 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 088A96F120;
 Mon, 10 Aug 2020 16:55:29 +0000 (UTC)
Subject: [PATCH 14/14] spapr/xive: Simplify error handling of
 kvmppc_xive_cpu_synchronize_state()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Aug 2020 18:55:29 +0200
Message-ID: <159707852916.1489912.8376334685349668124.stgit@bahia.lan>
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

Now that kvmppc_xive_cpu_get_state() returns negative on error, use that
and get rid of the temporary Error object and error_propagate().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   14 ++++++--------
 include/hw/ppc/xive.h    |    2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index e9a36115bed6..d871bb1a0016 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -119,7 +119,8 @@ int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **e=
rrp)
=20
 typedef struct {
     XiveTCTX *tctx;
-    Error *err;
+    Error **errp;
+    int ret;
 } XiveCpuGetState;
=20
 static void kvmppc_xive_cpu_do_synchronize_state(CPUState *cpu,
@@ -127,14 +128,14 @@ static void kvmppc_xive_cpu_do_synchronize_state(CPUS=
tate *cpu,
 {
     XiveCpuGetState *s =3D arg.host_ptr;
=20
-    kvmppc_xive_cpu_get_state(s->tctx, &s->err);
+    s->ret =3D kvmppc_xive_cpu_get_state(s->tctx, s->errp);
 }
=20
-void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
+int kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
 {
     XiveCpuGetState s =3D {
         .tctx =3D tctx,
-        .err =3D NULL,
+        .errp =3D errp,
     };
=20
     /*
@@ -143,10 +144,7 @@ void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx,=
 Error **errp)
     run_on_cpu(tctx->cs, kvmppc_xive_cpu_do_synchronize_state,
                RUN_ON_CPU_HOST_PTR(&s));
=20
-    if (s.err) {
-        error_propagate(errp, s.err);
-        return;
-    }
+    return s.ret;
 }
=20
 int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 785c905357dc..2c42ae92d287 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -488,7 +488,7 @@ void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring,=
 uint8_t ipb);
 int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp=
);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
-void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
+int kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
 int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
 int kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
=20



