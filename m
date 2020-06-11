Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B34DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B7120720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVXEa1wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B7120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTu1-0002kk-6M
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA3-0001F4-Lm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA1-0001LR-Si
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F81J/ZRp0YOpkDwfZ6abXb/SMvXJi0mCgUnRO82JJ0A=;
 b=aVXEa1wqKssPrZqFwBQ4HtqICC2MTefQ90TMBaA2XVy4FQTrgWu8eba9V6Xe+N4VPK1lZk
 TuVjOy+pUGsn8Bmo/6lM1A6ET3ecT+Pbp84/LiTUEsNtqMUuMCJfSCUyelfZdG7SGzkjSH
 6kZtbZbg1/9YOUjByAYScujy9dPDcME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-n7l9T1rvOumJbNpS-2jgzw-1; Thu, 11 Jun 2020 15:46:47 -0400
X-MC-Unique: n7l9T1rvOumJbNpS-2jgzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C9541005512;
 Thu, 11 Jun 2020 19:46:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0D6660CC0;
 Thu, 11 Jun 2020 19:46:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 072/115] hw/i386/amd_iommu: Fix the reserved bits definition of
 IOMMU commands
Date: Thu, 11 Jun 2020 15:44:06 -0400
Message-Id: <20200611194449.31468-73-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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
Cc: Wei Huang <wei.huang2@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Huang <wei.huang2@amd.com>

Many reserved bits of amd_iommu commands are defined incorrectly in QEMU.
Because of it, QEMU incorrectly injects lots of illegal commands into guest
VM's IOMMU event log.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Message-Id: <20200418042845.596457-1-wei.huang2@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/amd_iommu.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index fd75cae024..4346060e62 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -370,7 +370,7 @@ static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
     hwaddr addr = cpu_to_le64(extract64(cmd[0], 3, 49)) << 3;
     uint64_t data = cpu_to_le64(cmd[1]);
 
-    if (extract64(cmd[0], 51, 8)) {
+    if (extract64(cmd[0], 52, 8)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
@@ -395,7 +395,7 @@ static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
     uint16_t devid = cpu_to_le16((uint16_t)extract64(cmd[0], 0, 16));
 
     /* This command should invalidate internal caches of which there isn't */
-    if (extract64(cmd[0], 15, 16) || cmd[1]) {
+    if (extract64(cmd[0], 16, 44) || cmd[1]) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
@@ -405,9 +405,9 @@ static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 
 static void amdvi_complete_ppr(AMDVIState *s, uint64_t *cmd)
 {
-    if (extract64(cmd[0], 15, 16) ||  extract64(cmd[0], 19, 8) ||
+    if (extract64(cmd[0], 16, 16) ||  extract64(cmd[0], 52, 8) ||
         extract64(cmd[1], 0, 2) || extract64(cmd[1], 3, 29)
-        || extract64(cmd[1], 47, 16)) {
+        || extract64(cmd[1], 48, 16)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
@@ -438,8 +438,8 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 {
     uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
 
-    if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 16, 12) ||
-        extract64(cmd[0], 3, 10)) {
+    if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
+        extract64(cmd[1], 3, 9)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
@@ -451,7 +451,7 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 
 static void amdvi_prefetch_pages(AMDVIState *s, uint64_t *cmd)
 {
-    if (extract64(cmd[0], 16, 8) || extract64(cmd[0], 20, 8) ||
+    if (extract64(cmd[0], 16, 8) || extract64(cmd[0], 52, 8) ||
         extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
         extract64(cmd[1], 5, 7)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
@@ -463,7 +463,7 @@ static void amdvi_prefetch_pages(AMDVIState *s, uint64_t *cmd)
 
 static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
 {
-    if (extract64(cmd[0], 16, 16) || cmd[1]) {
+    if (extract64(cmd[0], 16, 44) || cmd[1]) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
         return;
@@ -479,7 +479,8 @@ static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
 {
 
     uint16_t devid = extract64(cmd[0], 0, 16);
-    if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 9)) {
+    if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
+        extract64(cmd[1], 6, 6)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
         return;
-- 
2.26.2



