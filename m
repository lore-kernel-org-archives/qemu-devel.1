Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAD5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9F3207DA
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fYPgJp43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9F3207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjei-00056O-RO
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaG-00050g-7E
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:36 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaF-0000nX-Ab
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cx6D0D02z9sTR; Thu,  4 Jun 2020 16:42:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591252948;
 bh=A3PAjiRQqKl9hfB8R8V83gpgLEOrxMNBxGAfULeW6JA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fYPgJp43wTfIc597kgX6lH5DcKQAUEWrazYjIpJWYcZY+fwqeVjf0AcF9Sk1V3JcU
 blbJthmppYKSHOg96Q6A/jtWCslf90YrmM6xV/CYrGsc/OWSFjCUL+G40bhp3GNOUn
 vF8BLW2l2+eviso+LX47IMPS7KaLNkrH05sHtN4A=
From: David Gibson <david@gibson.dropbear.id.au>
To: rth@twiddle.net, pbonzini@redhat.com, ekabkost@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 8/9] target/i386: sev: Remove redundant handle field
Date: Thu,  4 Jun 2020 16:42:18 +1000
Message-Id: <20200604064219.436242-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604064219.436242-1-david@gibson.dropbear.id.au>
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: brijesh.singh@amd.com, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, dgilbert@redhat.com,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The user can explicitly specify a handle via the "handle" property wired
to SevGuestState::handle.  That gets passed to the KVM_SEV_LAUNCH_START
ioctl() which may update it, the final value being copied back to both
SevGuestState::handle and SEVState::handle.

AFAICT, nothing will be looking SEVState::handle before it and
SevGuestState::handle have been updated from the ioctl().  So, remove the
field and just use SevGuestState::handle directly.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/sev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4b261beaa7..24e2dea9b8 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -40,7 +40,6 @@ struct SEVState {
     uint8_t api_minor;
     uint8_t build_id;
     uint64_t me_mask;
-    uint32_t handle;
     int sev_fd;
     SevState state;
     gchar *measurement;
@@ -64,13 +63,13 @@ struct SevGuestState {
     /* configuration parameters */
     char *sev_device;
     uint32_t policy;
-    uint32_t handle;
     char *dh_cert_file;
     char *session_file;
     uint32_t cbitpos;
     uint32_t reduced_phys_bits;
 
     /* runtime state */
+    uint32_t handle;
     SEVState state;
 };
 
@@ -398,7 +397,7 @@ sev_get_info(void)
         info->build_id = sev_guest->state.build_id;
         info->policy = sev_guest->policy;
         info->state = sev_guest->state.state;
-        info->handle = sev_guest->state.handle;
+        info->handle = sev_guest->handle;
     }
 
     return info;
@@ -517,8 +516,7 @@ sev_launch_start(SevGuestState *sev)
 
     start = g_new0(struct kvm_sev_launch_start, 1);
 
-    start->handle = object_property_get_int(OBJECT(sev), "handle",
-                                            &error_abort);
+    start->handle = sev->handle;
     start->policy = sev->policy;
     if (sev->session_file) {
         if (sev_read_file_base64(sev->session_file, &session, &sz) < 0) {
@@ -544,10 +542,8 @@ sev_launch_start(SevGuestState *sev)
         goto out;
     }
 
-    object_property_set_int(OBJECT(sev), start->handle, "handle",
-                            &error_abort);
     sev_set_guest_state(sev, SEV_STATE_LAUNCH_UPDATE);
-    s->handle = start->handle;
+    sev->handle = start->handle;
     ret = 0;
 
 out:
-- 
2.26.2


