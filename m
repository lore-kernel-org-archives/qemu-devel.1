Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841A0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEEC2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWDFC206"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEEC2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfDd-00061F-4K
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kCfCJ-000425-0u
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kCfCH-00066Y-02
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssFNL+9qWeW2P1mJTJW0Zet2cgcckYhuIXxlrOvmdhI=;
 b=EWDFC20677lvi4lSTLkKjYfV/UCe2NPB9QmZ2epULzO1yz6oYvTY8eazKivGj0N/iVczw3
 vSxI/9UW6UYBWthX8n/TKd0kA02RVFKxGewL7aelLXc+QszygvF8nahkjD2GSfGmNGtjUG
 Jpyq5vGvoUTdqA4niy1rXdDbdMxD76o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-wG_5OrXnM0-K52Cof_QwpQ-1; Mon, 31 Aug 2020 04:29:46 -0400
X-MC-Unique: wG_5OrXnM0-K52Cof_QwpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA05D1019626
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 08:29:45 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-88.pek2.redhat.com [10.72.12.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 842145D9D3;
 Mon, 31 Aug 2020 08:29:38 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 7/9] vhost-vdpa: squash net_vhost_vdpa_init() into
 net_init_vhost_vdpa()
Date: Mon, 31 Aug 2020 16:27:35 +0800
Message-Id: <20200831082737.10983-8-jasowang@redhat.com>
In-Reply-To: <20200831082737.10983-1-jasowang@redhat.com>
References: <20200831082737.10983-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lulu@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch squashes net_vhost_vdpa_init() into
net_init_vhost_vdpa(). This will simplify adding pre open file
descriptor support.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-vdpa.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 1d3ac89135..f5cc4e8326 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -172,27 +172,6 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_ufo = vhost_vdpa_has_ufo,
 };
 
-static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
-                               const char *name, const char *vhostdev)
-{
-    NetClientState *nc;
-    VhostVDPAState *s;
-    int vdpa_device_fd;
-    int ret;
-    assert(name);
-    nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device, name);
-    snprintf(nc->info_str, sizeof(nc->info_str), "vhostdev=%s", vhostdev);
-    s = DO_UPCAST(VhostVDPAState, nc, nc);
-    vdpa_device_fd = qemu_open(vhostdev, O_RDWR);
-    if (vdpa_device_fd == -1) {
-        return -errno;
-    }
-    s->vhost_vdpa.device_fd = vdpa_device_fd;
-    ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa);
-
-    return ret;
-}
-
 static int net_vhost_check_net(void *opaque, QemuOpts *opts, Error **errp)
 {
     const char *name = opaque;
@@ -215,6 +194,10 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
                         NetClientState *peer, Error **errp)
 {
     const NetdevVhostVDPAOptions *opts;
+    NetClientState *nc;
+    VhostVDPAState *s;
+    int vdpa_device_fd;
+    int ret;
 
     assert(netdev->type == NET_CLIENT_DRIVER_VHOST_VDPA);
     opts = &netdev->u.vhost_vdpa;
@@ -227,5 +210,19 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
         error_setg(errp, "vhost-vdpa requires vhostdev to be set");
         return -1;
     }
-    return net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name, opts->vhostdev);
+
+    assert(name);
+
+    nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, TYPE_VHOST_VDPA, name);
+    snprintf(nc->info_str, sizeof(nc->info_str), "vhostdev=%s", opts->vhostdev);
+
+    s = DO_UPCAST(VhostVDPAState, nc, nc);
+    vdpa_device_fd = qemu_open(opts->vhostdev, O_RDWR);
+    if (vdpa_device_fd == -1) {
+        return -errno;
+    }
+    s->vhost_vdpa.device_fd = vdpa_device_fd;
+    ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa);
+
+    return ret;
 }
-- 
2.20.1


