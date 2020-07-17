Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8429C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 04:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72453206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 04:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="jqqi6EKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72453206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwHsv-0000A6-N5
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 00:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jwHsO-0008B4-FA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 00:21:36 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:61086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jwHsL-0007U6-9Z
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 00:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:to:cc:content-type:content-transfer-encoding;
 s=smtpapi; bh=n2XHF9IAzaoZOCZL7/AZ7k2Y/YwG4AIDrh2Fz46ecUw=;
 b=jqqi6EKG75C8Iel2Y7bWJUv8mWoGmsMk2lIPRUe5+PMk38lRaL/ENRDnFB+TvMd63nar
 KwlKuL1etmxHShe3bSMsoUJrfb2TF+kGpCCJqAeVEbhU9nzwbtBsFcKYSj/ph/egUEGrNJ
 P1/qV5gb3aWOTzfSjVz3ob58YjXSPszrs=
Received: by filterdrecv-p3mdw1-75c584b9c6-qxmj9 with SMTP id
 filterdrecv-p3mdw1-75c584b9c6-qxmj9-18-5F11274A-2F
 2020-07-17 04:21:30.945048284 +0000 UTC m=+1768314.500731978
Received: from localhost.localdomain.com (unknown)
 by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP
 id iigHLbBXTmeIT48_lZ1Nlg Fri, 17 Jul 2020 04:21:30.605 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH] Fix vhost-user buffer over-read on ram hot-unplug
Date: Fri, 17 Jul 2020 04:21:30 +0000 (UTC)
Message-Id: <1594799958-31356-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zcpxOIOngOxJjXA3i?=
 =?us-ascii?Q?pN71ZbxZPfO78Id=2FFbP+jiXD=2F=2F0+OSsDL240shO?=
 =?us-ascii?Q?5HXoUE3i7rKsbgfTSATvYbuXc8qywTvPh37Our=2F?=
 =?us-ascii?Q?DMCZKSLDADrRBBjd=2FZI=2F8qRFwu9HXdmo3mm5FRS?=
 =?us-ascii?Q?xAWA+TPtdw9MEXkpWVLkm9zp87DXbys=2F1pHGQI8?=
 =?us-ascii?Q?FBzMest4E1PcGHifAKQcw=3D=3D?=
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mst@redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 00:21:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS vhost-user protocol
feature introduced a shadow-table, used by the backend to dynamically
determine how a vdev's memory regions have changed since the last
vhost_user_set_mem_table() call. On hot-remove, a memmove() operation
is used to overwrite the removed shadow region descriptor(s). The size
parameter of this memmove was off by 1 such that if a VM with a backend
supporting the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS filled it's
shadow-table (by performing the maximum number of supported hot-add
operatons) and attempted to remove the last region, Qemu would read an
out of bounds value and potentially crash.

This change fixes the memmove() bounds such that this erroneous read can
never happen.

Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3123121..d7e2423 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -672,7 +672,7 @@ static int send_remove_regions(struct vhost_dev *dev,
         memmove(&u->shadow_regions[shadow_reg_idx],
                 &u->shadow_regions[shadow_reg_idx + 1],
                 sizeof(struct vhost_memory_region) *
-                (u->num_shadow_regions - shadow_reg_idx));
+                (u->num_shadow_regions - shadow_reg_idx - 1));
         u->num_shadow_regions--;
     }
 
-- 
1.8.3.1


