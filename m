Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769EFC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 03:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98992087D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 03:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJCW+fEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98992087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTG8m-0007x5-Gs
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 23:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kTG7X-0006nH-H3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 23:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kTG7Q-0002tM-So
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 23:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602817761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E8HbX5QjLUvwJ9BsUeae3ntLOMJglZce6F9CqEC3w8E=;
 b=WJCW+fECifMXDUYA86bXsy9/ItskAl0FiWytpzKI3c7THe9G88t2TJH+1WLFs9ThVQIq8x
 mtqiyox5L/gLHRNhCWYz7ZTG5wLmv5W8rFtiFMxzksvfkzuPTymG5fqD9GmjkGfSXNnzjL
 7NmC+LT8kTe55G4H2Xoa/AEA560MCAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-wBz24efLOKmD7CSeSfU3uA-1; Thu, 15 Oct 2020 23:09:19 -0400
X-MC-Unique: wBz24efLOKmD7CSeSfU3uA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721DA803634;
 Fri, 16 Oct 2020 03:09:18 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-176.pek2.redhat.com [10.72.13.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F3FA6EF55;
 Fri, 16 Oct 2020 03:09:13 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] vhost-vdpa: Add qemu_close in vhost_vdpa_cleanup
Date: Fri, 16 Oct 2020 11:09:08 +0800
Message-Id: <20201016030909.9522-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 23:09:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-stable@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fix the bug that fd will still open after the cleanup

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/vhost-vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index bc0e0d2d35..0480b92102 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -144,6 +144,10 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         g_free(s->vhost_net);
         s->vhost_net = NULL;
     }
+     if (s->vhost_vdpa.device_fd >= 0) {
+        qemu_close(s->vhost_vdpa.device_fd);
+        s->vhost_vdpa.device_fd = -1;
+    }
 }
 
 static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
-- 
2.21.3


