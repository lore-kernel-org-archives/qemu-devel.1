Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214AAC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 06:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A242086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 06:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A242086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haafT-0005nG-0G
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 02:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56435)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tiwei.bie@intel.com>) id 1haaew-0005Iv-Gk
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tiwei.bie@intel.com>) id 1haaev-0007O2-Ga
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:53:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:16010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tiwei.bie@intel.com>)
 id 1haaev-0007JR-8n; Tue, 11 Jun 2019 02:53:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jun 2019 23:53:21 -0700
X-ExtLoop1: 1
Received: from npg-dpdk-virtio-tbie-2.sh.intel.com ([10.67.104.151])
 by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2019 23:53:20 -0700
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Date: Tue, 11 Jun 2019 14:51:37 +0800
Message-Id: <20190611065137.16329-1-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: [Qemu-devel] [RFC] vhost-user: don't ignore CTRL_VLAN feature
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VIRTIO_NET_F_CTRL_VLAN feature requires the support of
vhost-user backend. But it will be advertised to guest driver
as long as it's enabled by users in QEMU, while it's not
supported by vhost-user backend. This patch fixes this issue.

Fixes: 72018d1e1917 ("vhost-user: ignore qemu-only features")
Cc: qemu-stable@nongnu.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
It's not clear in the spec that, whether vlan filtering is
also best-effort:
https://github.com/oasis-tcs/virtio-spec/blob/37057052e7/content.tex#L3372

 hw/net/vhost_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index a6b719035c..1444fc9230 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -75,6 +75,8 @@ static const int user_feature_bits[] = {
     VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
 
+    VIRTIO_NET_F_CTRL_VLAN,
+
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
 
-- 
2.17.1


