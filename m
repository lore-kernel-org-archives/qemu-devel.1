Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63CDC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4232C2083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cr0fSj2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4232C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA6i-0006Wj-6A
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9x1-0002kt-Qk
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9wz-0001at-58
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:27 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IiK5qvCobeUOC+twrCHu2MpA9Z7XZegxxrbNBvwmzOg=;
 b=Cr0fSj2O43DwND4RxjnRJKhDjxvpLEmkPoTEXXT9c68cIIHfyoW/qGMjTQz1o66w3ypo/n
 Ox5vewaeGOi+3J4n+Q4CwkV+6npI43PDsbZ5hGJX1RVPZiDSQ55x47bFvfwHxTA9jCqkaC
 xzuKbewpvk4/OtgxXFMG1rgiqkn4jKw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-ikzmfVB5Na6KC9MOvmaIcA-1; Tue, 29 Sep 2020 03:21:22 -0400
X-MC-Unique: ikzmfVB5Na6KC9MOvmaIcA-1
Received: by mail-wr1-f69.google.com with SMTP id g6so1375255wrv.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IiK5qvCobeUOC+twrCHu2MpA9Z7XZegxxrbNBvwmzOg=;
 b=SplbooHSWLsOlzHjHn0CqT0FcUSrcbDxQrExsQjs0b+bcHG0bgRGRWBvnR592quZaJ
 /vld/d6B50zMkX8jpgxtrSEBxp8QZaFOeidIk/XgcE1cwQi1UCR40kYAEAfHssDQnDSX
 6j/n7xb8EQ670l8lTMSlyc66AOaocFuVrVb5uZBSEdO4AUxsBYmLK/yG4MjlizOc42Lr
 mxG6CXvLW/tUsxzJ/VNcq6CucJd3eC5N4LVOFexrR9Esf9VU1b1wo5r2GXiOi+/KSjJF
 7EjSFQjxqRuFcG1//ILGJm7n8XdRsO6/7Ed/fCNM2pzEbUQSLcSOelvPpBHh0gVD0m6Y
 rNHw==
X-Gm-Message-State: AOAM5323Jw9A+V1uVpEYGTXhtoqA1fEOLCGBHy79uT1RERXCpdgyNj0m
 7erknLh7J5SmZ5xh9pppbSArfKcy7rjLt2GFMWTClzGLuqLS/jn2QQhhQJLmtgS2Sw6C2XoAU/c
 MmmnZIgc6k2+kwkQ=
X-Received: by 2002:a05:600c:21d4:: with SMTP id
 x20mr2884358wmj.26.1601364080530; 
 Tue, 29 Sep 2020 00:21:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFX6N8W6E3N/bEZ/xGCWIgxj0fqD0X4f52JU6p9Y2as5+Ii6Ug+hQM+yrP6n+X47Vs7CIy8Q==
X-Received: by 2002:a05:600c:21d4:: with SMTP id
 x20mr2884343wmj.26.1601364080382; 
 Tue, 29 Sep 2020 00:21:20 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id 185sm4602970wma.18.2020.09.29.00.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:19 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 10/48] virtio-iommu: Check gtrees are non null before
 destroying them
Message-ID: <20200929071948.281157-11-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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


