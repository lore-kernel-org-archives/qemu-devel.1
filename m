Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB4CC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB88023888
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZ9hl5Zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB88023888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJI3y-0005Mb-Qt
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHxx-0006aH-Vh
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHxo-0000YM-6r
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600441573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6NfdktJge9yb9E6AqjpIh53ZkYpwE8OXxtfPUIP1V1Q=;
 b=QZ9hl5ZhWGJybXAIvxUoxyr+NoJMWZjOe0rvUqN9pq+TZIxAoDt9aMKFB4wcCjYe+XMVK4
 T7kuD2ppSNvjHmsnHZVTf23I0deWfo2rtAaXFyYpnNExfLKsqaDFP4e00eTCs3gPcJ4Cpw
 AwbfyP7+JJSohdnkuOxhVAdv0V2evyk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-V_l6MZP1M56ibY9SVdCflw-1; Fri, 18 Sep 2020 11:06:11 -0400
X-MC-Unique: V_l6MZP1M56ibY9SVdCflw-1
Received: by mail-wr1-f69.google.com with SMTP id f18so2234023wrv.19
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6NfdktJge9yb9E6AqjpIh53ZkYpwE8OXxtfPUIP1V1Q=;
 b=traTPPHqaZ6NXl6uGyrGhFL+EawhaTz8GRtBF4Dd81IT1U3oweK1UwnVwqCCeE3eN/
 yPMcSpnR6zQ58meovPy7RZZMoVhtLhseB8VLLTf1x/UTeWMdzYTgnVhfwqAFeg5KHZ1/
 rwPMsMhCeRJZ4TjqAoAqa/MTZHdITkKjX+20EdaRALfULx/0P/mj0SIdatnGNn2dxDah
 8Fg2aMiLzgQW4f1iwRToRLrmPXyl7RJ0KVZg+gvPxYsTCSVOTOJxwO9/NUW3I9cYUi2J
 /fTDOu9OPirn8hXcLhyG1iA3BYcb8D5M2Ae1D+o7IWhsnrW5FMjRkbsBmWIK+6gcY/cQ
 4zNw==
X-Gm-Message-State: AOAM532JnEf1H88etMNZmPLFthWO9HERAHgte7RHQKcNqLWQvV1YeqjE
 LDTzBkdyPDlH2ND4mdq12bRUmvd7IuvO6LF7E0NKDLD0s34F/Zp1Atcs+iYZiR0NWfAHvMnswHB
 DEhr6v2mJFc4GvZ0=
X-Received: by 2002:adf:f084:: with SMTP id n4mr14810604wro.26.1600441570160; 
 Fri, 18 Sep 2020 08:06:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6z8usrvNebtrJsSon/SOh/ASXGs306FfAqLWmDSsB6Wwmi5OyarYlEY+O413MRK9s9ueVaQ==
X-Received: by 2002:adf:f084:: with SMTP id n4mr14810580wro.26.1600441569956; 
 Fri, 18 Sep 2020 08:06:09 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id m1sm5206846wmc.28.2020.09.18.08.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:06:09 -0700 (PDT)
Date: Fri, 18 Sep 2020 11:06:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/15] vhost: check queue state in the vhost_dev_set_log routine
Message-ID: <20200918150506.286890-8-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dima Stepanov <dimastep@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

If the vhost-user-blk daemon provides only one virtqueue, but device was
added with several queues, then QEMU will send more VHOST-USER command
than expected by daemon side. The vhost_virtqueue_start() routine
handles such case by checking the return value from the
virtio_queue_get_desc_addr() function call. Add the same check to the
vhost_dev_set_log() routine.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Message-Id: <2da64fc45789094b6bd6f1c283cac9e47eeeb786.1598865610.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1b2d735b54..abe0fe3e67 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -835,12 +835,24 @@ out:
 static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
 {
     int r, i, idx;
+    hwaddr addr;
+
     r = vhost_dev_set_features(dev, enable_log);
     if (r < 0) {
         goto err_features;
     }
     for (i = 0; i < dev->nvqs; ++i) {
         idx = dev->vhost_ops->vhost_get_vq_index(dev, dev->vq_index + i);
+        addr = virtio_queue_get_desc_addr(dev->vdev, idx);
+        if (!addr) {
+            /*
+             * The queue might not be ready for start. If this
+             * is the case there is no reason to continue the process.
+             * The similar logic is used by the vhost_virtqueue_start()
+             * routine.
+             */
+            break;
+        }
         r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
                                      enable_log);
         if (r < 0) {
-- 
MST


