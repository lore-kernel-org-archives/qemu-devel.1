Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC4C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C2C20722
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g67K0Q7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C2C20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDuNL-0002ko-PZ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kDuMa-0001T8-Nm
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:53:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49530
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kDuMZ-0005cI-5r
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599159214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Xa/Eo0mHN9VAabkFhhaj/1662E5XKgexnLl38Jnm0c=;
 b=g67K0Q7mGtKCXwDYJrjuDlKA5/NvzW6hn1y1eDA/M1Se95CMmMMVDW+8oA7gzI3TsRdu2i
 kikol0C1jEzDo8Aaov1n49TIAG4ORnxVcZ7mBZlnVkdE02o+QKezXQ/ooYGsR1WdKtnumj
 AT+3apHvyoflByWmaMfl/NHH77sbq8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-2jTx7jw0OPyAJ4oTa2ayqQ-1; Thu, 03 Sep 2020 14:53:32 -0400
X-MC-Unique: 2jTx7jw0OPyAJ4oTa2ayqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACF8D393B7
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 18:53:31 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-112-218.ams2.redhat.com
 [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F795672C6;
 Thu,  3 Sep 2020 18:53:30 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] vhost-vdpa: define and use default value for vhostdev
Date: Thu,  3 Sep 2020 20:53:26 +0200
Message-Id: <20200903185327.774708-2-lvivier@redhat.com>
In-Reply-To: <20200903185327.774708-1-lvivier@redhat.com>
References: <20200903185327.774708-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vhostdev is defined as optional in net.json, and if not set
/dev/vhost-vdpa-0 should be used.

The default value is not set and if vhostdev is not provided
QEMU crashes with a SIGSEGV exception.

Fixes: 1e0a84ea49b6 ("vhost-vdpa: introduce vhost-vdpa net client")
Cc: lulu@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/vhost-vdpa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index bc0e0d2d35b7..24103ef241e4 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -24,6 +24,9 @@
 #include "monitor/monitor.h"
 #include "hw/virtio/vhost.h"
 
+/* default vhostdev as defined in qapi/net.json */
+#define VHOST_VDPA_DEFAULT_VHOSTDEV "/dev/vhost-vdpa-0"
+
 /* Todo:need to add the multiqueue support here */
 typedef struct VhostVDPAState {
     NetClientState nc;
@@ -224,5 +227,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
                           (char *)name, errp)) {
         return -1;
     }
-    return net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name, opts->vhostdev);
+    return net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
+                               opts->has_vhostdev ?
+                               opts->vhostdev : VHOST_VDPA_DEFAULT_VHOSTDEV);
 }
-- 
2.26.2


