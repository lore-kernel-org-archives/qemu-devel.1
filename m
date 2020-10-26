Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC03AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683DC207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683DC207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX1qW-0001Mq-H4
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX1ob-00086C-9A
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:41:34 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:44866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX1oX-0007YX-Ua
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:41:32 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-yMjQvGxEOQaQ_CLlSGR1mg-1; Mon, 26 Oct 2020 08:41:21 -0400
X-MC-Unique: yMjQvGxEOQaQ_CLlSGR1mg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ECFCA0BEB;
 Mon, 26 Oct 2020 12:40:56 +0000 (UTC)
Received: from bahia.lan (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EEEE28545;
 Mon, 26 Oct 2020 12:40:55 +0000 (UTC)
Subject: [PATCH 4/4] spapr: Improve spapr_reallocate_hpt() error reporting
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 26 Oct 2020 13:40:54 +0100
Message-ID: <160371605460.305923.5890143959901241157.stgit@bahia.lan>
In-Reply-To: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 08:40:32
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

spapr_reallocate_hpt() has three users, two of which pass &error_fatal
and the third one, htab_load(), passes &local_err, uses it to detect
failures and simply propagates -EINVAL up to vmstate_load(), which will
cause QEMU to exit. It is thus confusing that spapr_reallocate_hpt()
doesn't return right away when an error is detected in some cases. Also,
the comment suggesting that the caller is welcome to try to carry on
seems like a remnant in this respect.

This can be improved:
- change spapr_reallocate_hpt() to always report a negative errno on
  failure, either as reported by KVM or -ENOSPC if the HPT is smaller
  than what was asked,
- use that to detect failures in htab_load() which is preferred over
  checking &local_err,
- propagate this negative errno to vmstate_load() because it is more
  accurate than propagating -EINVAL for all possible errors.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |   18 ++++++++++--------
 include/hw/ppc/spapr.h |    3 +--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ff7de7da2875..12a012d9dd09 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1483,8 +1483,7 @@ void spapr_free_hpt(SpaprMachineState *spapr)
     close_htab_fd(spapr);
 }
=20
-void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
-                          Error **errp)
+int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp=
)
 {
     ERRP_GUARD();
     long rc;
@@ -1496,7 +1495,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, i=
nt shift,
=20
     if (rc =3D=3D -EOPNOTSUPP) {
         error_setg(errp, "HPT not supported in nested guests");
-        return;
+        return -EOPNOTSUPP;
     }
=20
     if (rc < 0) {
@@ -1504,8 +1503,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, i=
nt shift,
         error_setg_errno(errp, errno, "Failed to allocate KVM HPT of order=
 %d",
                          shift);
         error_append_hint(errp, "Try smaller maxmem?\n");
-        /* This is almost certainly fatal, but if the caller really
-         * wants to carry on with shift =3D=3D 0, it's welcome to try */
+        return -errno;
     } else if (rc > 0) {
         /* kernel-side HPT allocated */
         if (rc !=3D shift) {
@@ -1513,6 +1511,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, i=
nt shift,
                        "Requested order %d HPT, but kernel allocated order=
 %ld",
                        shift, rc);
             error_append_hint(errp, "Try smaller maxmem?\n");
+            return -ENOSPC;
         }
=20
         spapr->htab_shift =3D shift;
@@ -1533,6 +1532,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, i=
nt shift,
     /* We're setting up a hash table, so that means we're not radix */
     spapr->patb_entry =3D 0;
     spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
+    return 0;
 }
=20
 void spapr_setup_hpt(SpaprMachineState *spapr)
@@ -2286,11 +2286,13 @@ static int htab_load(QEMUFile *f, void *opaque, int=
 version_id)
     }
=20
     if (section_hdr) {
+        int ret;
+
         /* First section gives the htab size */
-        spapr_reallocate_hpt(spapr, section_hdr, &local_err);
-        if (local_err) {
+        ret =3D spapr_reallocate_hpt(spapr, section_hdr, &local_err);
+        if (ret < 0) {
             error_report_err(local_err);
-            return -EINVAL;
+            return ret;
         }
         return 0;
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bb47896f173b..2e89e36cfbdc 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -846,8 +846,7 @@ void spapr_hotplug_req_add_by_count_indexed(SpaprDrcTyp=
e drc_type,
 void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
                                                uint32_t count, uint32_t in=
dex);
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
-void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
-                          Error **errp);
+int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp=
);
 void spapr_clear_pending_events(SpaprMachineState *spapr);
 void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr);
 int spapr_max_server_number(SpaprMachineState *spapr);



