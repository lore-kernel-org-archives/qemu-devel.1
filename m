Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09692C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C06C208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOBerWl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C06C208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJhx-0005Vx-A6
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ87-0005MV-Ap
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ7w-0005mP-JM
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600446044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IiK5qvCobeUOC+twrCHu2MpA9Z7XZegxxrbNBvwmzOg=;
 b=SOBerWl/Euekoryv41/GF9EZ57qyfDaZfHBeH5y+12WWMhLzXfTQYmhLynQCPz4dv7F7MJ
 OoKx9fkNz7l3opi2VCTyEoksR8kgA3cE/jG+j5voQrDgZ73q1hlkyVKuJIx1WQDzevEYUY
 pvaRI2p/YTHAFlr5QPXwNxAgNdb4afA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-K2mp6DgPOFKT4MKj2RL36A-1; Fri, 18 Sep 2020 12:20:41 -0400
X-MC-Unique: K2mp6DgPOFKT4MKj2RL36A-1
Received: by mail-wr1-f71.google.com with SMTP id w7so2331726wrp.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IiK5qvCobeUOC+twrCHu2MpA9Z7XZegxxrbNBvwmzOg=;
 b=G2X+dYsDjfMsyu2fcMpCpgcbwBLFyXjMhxX3OJwrfd33gQWO1NdjS/cyJ9A/rH7Vmr
 8A3qboV6n5HcqjDAJxUQzfSuTopXmlIoKTztVdedUVA/QiyZbCvzipPTi3vKoKv4f6iM
 m7dF16jmibNL/ZdHkUPidbUHlxnuHJPfhxx9qQRUcgIG+drEmFHuJEl1YxARsrm3Hz5Y
 KIh6HuXPN3lJ66H940fo1vX7Oxd+OWd7OHcLM+9en+K6w58p8kZ0kqj5NHe0Z1GyKyNI
 viOpXVApxA3JGcNUdTGjYXmPXoKugvktMpZJIQYGEpw27KFDYvgkcqUrgEMo4c+PCeWX
 +fvA==
X-Gm-Message-State: AOAM531FD5drVcualYO7SeTxSDlRRvGQz18QxH+6x+G8vvtCsiuBob4e
 ch7D6Tm8PP4LhkQOsH6hSSsrszi49rjkvQgaU+U22g8N0IhsK7qskrp8r2bivwCYw5hZX9rEr7+
 FUGS+8bdghQdchH8=
X-Received: by 2002:a5d:660f:: with SMTP id n15mr41548741wru.103.1600446039782; 
 Fri, 18 Sep 2020 09:20:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyU8gMy+Bu9s6kVYjRS5fbFgzkIWh34UnlkBXH8oSUpBcAtp3jG7Uy6+Phjc2vMDgrewFH6MA==
X-Received: by 2002:a5d:660f:: with SMTP id n15mr41548719wru.103.1600446039571; 
 Fri, 18 Sep 2020 09:20:39 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id a15sm6708269wrn.3.2020.09.18.09.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:20:38 -0700 (PDT)
Date: Fri, 18 Sep 2020 12:20:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 14/15] virtio-iommu: Check gtrees are non null before
 destroying them
Message-ID: <20200918161836.318893-15-mst@redhat.com>
References: <20200918161836.318893-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918161836.318893-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-stable@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

If realize fails, domains and endpoints trees may be NULL. On
unrealize(), this produces assertions:

"GLib: g_tree_destroy: assertion 'tree != NULL' failed"

Check that the trees are non NULL before destroying them.

Cc: qemu-stable@nongnu.org
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Message-Id: <20200908193309.20569-2-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 5d56865e56..21ec63b108 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -801,8 +801,12 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
     VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
 
     g_hash_table_destroy(s->as_by_busptr);
-    g_tree_destroy(s->domains);
-    g_tree_destroy(s->endpoints);
+    if (s->domains) {
+        g_tree_destroy(s->domains);
+    }
+    if (s->endpoints) {
+        g_tree_destroy(s->endpoints);
+    }
 
     virtio_delete_queue(s->req_vq);
     virtio_delete_queue(s->event_vq);
-- 
MST


