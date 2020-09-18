Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A1AC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525B420717
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V84BjClw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525B420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIDN-0007uT-0B
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHyE-0006ha-OU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48454
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHyB-0000ad-A5
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600441595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IiK5qvCobeUOC+twrCHu2MpA9Z7XZegxxrbNBvwmzOg=;
 b=V84BjClwIKoWxfqmHCzApMTK/PNH8tGco+o/qSFFjnfNu7usZha3RmZK2ZXd2Va3RYqgJm
 c0cprTm7ObPPffynU0d1nasnm5ydtrRiQBsJd/sOdqzG9HnPqYTgaiSq65VBtGrOw0w60t
 evn/Z3jo4nd8fTbGiCJ6uMqvy07aLpY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-E5QERX7POce9EsqCi2Tsxg-1; Fri, 18 Sep 2020 11:06:31 -0400
X-MC-Unique: E5QERX7POce9EsqCi2Tsxg-1
Received: by mail-wr1-f71.google.com with SMTP id l17so2223878wrw.11
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IiK5qvCobeUOC+twrCHu2MpA9Z7XZegxxrbNBvwmzOg=;
 b=iBUPt19sWSZBkvR5otCLNmrkLN+MoJUSgR5CSn4QLYHs6z4WKIaBL/ISFGtIrDqB+m
 St3YB5Gf0ehVLDm6AOsRRzbx/Fq2tnJuxOAjs2SFM+9qIeD3B+q/PY2q1NUbjSHzkvkw
 jO3HW+oBPgYMEvZqn2VWCliiRsAgTCA+VKh+jK1VItTWGO9YhY8bCEWJG+KQ8k29AKn+
 ZPfLuhgBF7HMrk6nau8KFfllQlvPXDUddj9NMdovDec7W3ULEoalZIDOh6xp3bAAf7dD
 6GJFKf8pvkHhj9CWd7LX+c2Y1/VLPTB7NBe1bZXWgnRdGlPypiUpNniUqQZLkZ32tkI6
 ktvg==
X-Gm-Message-State: AOAM533okZIK7QdWJuGjcu3D+/x0SyRAzQRTCwwrGo/uGCXSjQxm0a6p
 XKEzCDBjYIQPbMVVsBkIjnYnGKh8nnnIRGCtDAmlIq6trr7zTB/QQj+osJTOJlaovSSkME0LbnD
 xGI0HdZxnRLewrxE=
X-Received: by 2002:a1c:2903:: with SMTP id p3mr16595717wmp.170.1600441589900; 
 Fri, 18 Sep 2020 08:06:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZCfnAAg0F9H8+BrH+z/wQZfqer4MnVwx4mMwzKqT9Q0DEsN8e9M5/qSzXic4ish5EufM7Pw==
X-Received: by 2002:a1c:2903:: with SMTP id p3mr16595700wmp.170.1600441589729; 
 Fri, 18 Sep 2020 08:06:29 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id t203sm5866140wmg.43.2020.09.18.08.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:06:29 -0700 (PDT)
Date: Fri, 18 Sep 2020 11:06:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/15] virtio-iommu: Check gtrees are non null before
 destroying them
Message-ID: <20200918150506.286890-15-mst@redhat.com>
References: <20200918150506.286890-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918150506.286890-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 11:06:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


