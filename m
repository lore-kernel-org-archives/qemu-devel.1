Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77510C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E8C20773
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="m4Jqcpd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E8C20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQAK-0005m2-Qz
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnk-0002JA-2q; Tue, 27 Oct 2020 10:18:17 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35441 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnh-0007dT-66; Tue, 27 Oct 2020 10:18:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLv1Sncz9sj4; Wed, 28 Oct 2020 01:17:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808279;
 bh=yd7ohoOB+WlDIzkrSuWTS8MDQlQz4yTL9YB3notFaJw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m4Jqcpd2YN125aiGBZpdO7CDZyllSJJT+wXAunXIYBuakWbmQD3rZfbh2OSA2eZCg
 KFPbwQ4R6mAa6bUr/RupvWoQWqNWUDKILlEmwLWKzsazwEXAJqI3F1azVFWGOyYh4P
 4iYqRzF6c4V478wmyYzv12/0roq9QHlvKnWpkAQE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 17/18] spapr: Improve spapr_reallocate_hpt() error reporting
Date: Wed, 28 Oct 2020 01:17:34 +1100
Message-Id: <20201027141735.728821-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

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

[dwg: Fix compile error due to omitted prelim patch]
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160371605460.305923.5890143959901241157.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 20 +++++++++++---------
 include/hw/ppc/spapr.h |  3 +--
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ec2536dba1..227075103e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1483,8 +1483,7 @@ void spapr_free_hpt(SpaprMachineState *spapr)
     close_htab_fd(spapr);
 }
 
-void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
-                          Error **errp)
+int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
 {
     ERRP_GUARD();
     long rc;
@@ -1496,7 +1495,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
 
     if (rc == -EOPNOTSUPP) {
         error_setg(errp, "HPT not supported in nested guests");
-        return;
+        return -EOPNOTSUPP;
     }
 
     if (rc < 0) {
@@ -1504,8 +1503,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
         error_setg_errno(errp, errno, "Failed to allocate KVM HPT of order %d",
                          shift);
         error_append_hint(errp, "Try smaller maxmem?\n");
-        /* This is almost certainly fatal, but if the caller really
-         * wants to carry on with shift == 0, it's welcome to try */
+        return -errno;
     } else if (rc > 0) {
         /* kernel-side HPT allocated */
         if (rc != shift) {
@@ -1513,6 +1511,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
                        "Requested order %d HPT, but kernel allocated order %ld",
                        shift, rc);
             error_append_hint(errp, "Try smaller maxmem?\n");
+            return -ENOSPC;
         }
 
         spapr->htab_shift = shift;
@@ -1526,7 +1525,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
         if (!spapr->htab) {
             error_setg_errno(errp, errno,
                              "Could not allocate HPT of order %d", shift);
-            return;
+            return -ENOMEM;
         }
 
         memset(spapr->htab, 0, size);
@@ -1539,6 +1538,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
     /* We're setting up a hash table, so that means we're not radix */
     spapr->patb_entry = 0;
     spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
+    return 0;
 }
 
 void spapr_setup_hpt(SpaprMachineState *spapr)
@@ -2292,11 +2292,13 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
     }
 
     if (section_hdr) {
+        int ret;
+
         /* First section gives the htab size */
-        spapr_reallocate_hpt(spapr, section_hdr, &local_err);
-        if (local_err) {
+        ret = spapr_reallocate_hpt(spapr, section_hdr, &local_err);
+        if (ret < 0) {
             error_report_err(local_err);
-            return -EINVAL;
+            return ret;
         }
         return 0;
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bb47896f17..2e89e36cfb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -846,8 +846,7 @@ void spapr_hotplug_req_add_by_count_indexed(SpaprDrcType drc_type,
 void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
                                                uint32_t count, uint32_t index);
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
-void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
-                          Error **errp);
+int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp);
 void spapr_clear_pending_events(SpaprMachineState *spapr);
 void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr);
 int spapr_max_server_number(SpaprMachineState *spapr);
-- 
2.26.2


