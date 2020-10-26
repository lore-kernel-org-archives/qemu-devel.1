Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E7BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA43B207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA43B207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX1qO-00010H-Sb
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX1nt-0007Rv-Ae
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:40:49 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:46893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX1nr-0007O5-QZ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:40:48 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-qjS5u66jOH6oKD70H9xtFw-1; Mon, 26 Oct 2020 08:40:43 -0400
X-MC-Unique: qjS5u66jOH6oKD70H9xtFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDD2810E2186;
 Mon, 26 Oct 2020 12:40:41 +0000 (UTC)
Received: from bahia.lan (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 368C710013D9;
 Mon, 26 Oct 2020 12:40:41 +0000 (UTC)
Subject: [PATCH 2/4] spapr: Use error_append_hint() in spapr_reallocate_hpt()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 26 Oct 2020 13:40:40 +0100
Message-ID: <160371604030.305923.17464161378167312662.stgit@bahia.lan>
In-Reply-To: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 08:40:37
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

Hints should be added with the dedicated error_append_hint() API
because we don't want to print them when using QMP. This requires
to insert ERRP_GUARD as explained in "qapi/error.h".

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f098d0ee6d98..f51b663f7dcb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1486,6 +1486,7 @@ void spapr_free_hpt(SpaprMachineState *spapr)
 void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
                           Error **errp)
 {
+    ERRP_GUARD();
     long rc;
=20
     /* Clean up any HPT info from a previous boot */
@@ -1500,17 +1501,18 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr,=
 int shift,
=20
     if (rc < 0) {
         /* kernel-side HPT needed, but couldn't allocate one */
-        error_setg_errno(errp, errno,
-                         "Failed to allocate KVM HPT of order %d (try smal=
ler maxmem?)",
+        error_setg_errno(errp, errno, "Failed to allocate KVM HPT of order=
 %d",
                          shift);
+        error_append_hint(errp, "Try smaller maxmem?\n");
         /* This is almost certainly fatal, but if the caller really
          * wants to carry on with shift =3D=3D 0, it's welcome to try */
     } else if (rc > 0) {
         /* kernel-side HPT allocated */
         if (rc !=3D shift) {
             error_setg(errp,
-                       "Requested order %d HPT, but kernel allocated order=
 %ld (try smaller maxmem?)",
+                       "Requested order %d HPT, but kernel allocated order=
 %ld",
                        shift, rc);
+            error_append_hint(errp, "Try smaller maxmem?\n");
         }
=20
         spapr->htab_shift =3D shift;



