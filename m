Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F83C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CEA20771
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CEA20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnmr-0007Mw-MN
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnht-0006iB-4F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhp-0000k0-Ex
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-GT-HPUMAOIqtAYs0i-SESQ-1; Mon, 14 Sep 2020 08:35:32 -0400
X-MC-Unique: GT-HPUMAOIqtAYs0i-SESQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 774D01021D32;
 Mon, 14 Sep 2020 12:35:31 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2908510023A7;
 Mon, 14 Sep 2020 12:35:30 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/15] spapr: Simplify error handling in prop_get_fdt()
Date: Mon, 14 Sep 2020 14:34:59 +0200
Message-Id: <20200914123505.612812-10-groug@kaod.org>
In-Reply-To: <20200914123505.612812-1-groug@kaod.org>
References: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.0
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

Use the return value of visit_check_struct() and visit_check_list()
for error checking instead of local_err. This allows to get rid of
the error propagation overhead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 04a6bf134ee8..697b28c34305 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -302,7 +302,6 @@ static void prop_get_fdt(Object *obj, Visitor *v, const=
 char *name,
 {
     SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(obj);
     QNull *null =3D NULL;
-    Error *err =3D NULL;
     int fdt_offset_next, fdt_offset, fdt_depth;
     void *fdt;
=20
@@ -321,6 +320,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const=
 char *name,
         const struct fdt_property *prop =3D NULL;
         int prop_len =3D 0, name_len =3D 0;
         uint32_t tag;
+        bool ok;
=20
         tag =3D fdt_next_tag(fdt, fdt_offset, &fdt_offset_next);
         switch (tag) {
@@ -334,10 +334,9 @@ static void prop_get_fdt(Object *obj, Visitor *v, cons=
t char *name,
         case FDT_END_NODE:
             /* shouldn't ever see an FDT_END_NODE before FDT_BEGIN_NODE */
             g_assert(fdt_depth > 0);
-            visit_check_struct(v, &err);
+            ok =3D visit_check_struct(v, errp);
             visit_end_struct(v, NULL);
-            if (err) {
-                error_propagate(errp, err);
+            if (!ok) {
                 return;
             }
             fdt_depth--;
@@ -355,10 +354,9 @@ static void prop_get_fdt(Object *obj, Visitor *v, cons=
t char *name,
                     return;
                 }
             }
-            visit_check_list(v, &err);
+            ok =3D visit_check_list(v, errp);
             visit_end_list(v, NULL);
-            if (err) {
-                error_propagate(errp, err);
+            if (!ok) {
                 return;
             }
             break;
--=20
2.26.2


