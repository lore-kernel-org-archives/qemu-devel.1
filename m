Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887BCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530172073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ps9ME2Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530172073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjU40-0003XX-GY
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAX-00027a-EE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAT-0001Ra-0W
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKJIvV9OiKDJs+uKZkXRizJk0uQGzPTTdysb8e5qLKM=;
 b=Ps9ME2MryqwwxGa7/F5qG7XEU8uJ2JoNoi5ZRwpVIc1i2tFFCHYmP7l87FdURX5eRR0WuD
 ypTd4VMM3ItFxO5O58XKJE/R6Jece8UHoHa+md+MR19qJyBswb1KMJd+G9ZiV5P2iN2Oh8
 tQkYCV/Oeo5vV+CMu8D4u8Ky43TyGGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-ySrPJyMiMseRkM8Yjq81Nw-1; Thu, 11 Jun 2020 15:47:14 -0400
X-MC-Unique: ySrPJyMiMseRkM8Yjq81Nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18AC9194092A;
 Thu, 11 Jun 2020 19:47:13 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8560060CC0;
 Thu, 11 Jun 2020 19:47:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 107/115] target/i386: sev: Remove redundant handle field
Date: Thu, 11 Jun 2020 15:44:41 -0400
Message-Id: <20200611194449.31468-108-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Gibson <david@gibson.dropbear.id.au>

The user can explicitly specify a handle via the "handle" property wired
to SevGuestState::handle.  That gets passed to the KVM_SEV_LAUNCH_START
ioctl() which may update it, the final value being copied back to both
SevGuestState::handle and SEVState::handle.

AFAICT, nothing will be looking SEVState::handle before it and
SevGuestState::handle have been updated from the ioctl().  So, remove the
field and just use SevGuestState::handle directly.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200604064219.436242-9-david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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



