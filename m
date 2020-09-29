Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57567C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41FF207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYIcZh65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41FF207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN9yt-0004LB-QP
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9ws-0002UA-1l
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9wp-0001Zj-JX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RgWjwZluRPth9SroB+SpBqoWFRsbgiGKRfLsPVOBGfE=;
 b=XYIcZh65AKRffz/xeQym94bV+11sf1BwY7FQ3+z27GyfskGe+j4esWG+cqBfa7OlGBL6YV
 VstW5T4UDfW6pk52dJEEeLQQGZwU9GpMSCVdPILXnFBRiQAX4MpmIOx8MWVIzkr5i+ODTl
 IAO3wm1RuDhgNC8a9zPWhdsOt56jGBI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-YPsqyhVcOtWbSzZ5yV5asA-1; Tue, 29 Sep 2020 03:21:13 -0400
X-MC-Unique: YPsqyhVcOtWbSzZ5yV5asA-1
Received: by mail-wm1-f71.google.com with SMTP id t8so1350219wmj.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RgWjwZluRPth9SroB+SpBqoWFRsbgiGKRfLsPVOBGfE=;
 b=CCL6AwqZ8MA+yOXx3vPz4L9NaX0GJwfCs6+BT7HnC6YNexGQEanq0cI7yJplscgWK+
 mZ2y4R2nBDmELyiEjbIV7gg5vcyzMx6Qp6eOsImINDoNhhUoRho00rZsFs/cix/gF6Qm
 YkjbmYUAfpzQQ+b8ImKb5IrieyH8KUdrH3QV380hd3MZeUjAG16A0+xs2zL/gdevK10B
 QmZcrRAD59XEnFrfAbbR/bN/eH252+svqVnHC7sQl9dL8UoVA0lmeSO3rsIXI8noR4xF
 UltiN98K2L1YXQBgK0ITjDAX27IRu1iTgJfBqkPC8iTsC8zo1EDzWT9YA+Ry94riJCks
 tmkQ==
X-Gm-Message-State: AOAM531ZI48d6pBlFmWNlGNBI/dU+EF093qpHPXKKsKhAVurI+muMbG8
 gBHFJyi0tVFA+NWb1IPLIESjTGsFb3eZbAhZ5+ROkPX/sq9iTg636NZF5euGvN7rDOlCpHQnw3S
 2oV1JWEWYYHcxUJk=
X-Received: by 2002:a05:600c:21cd:: with SMTP id
 x13mr2912912wmj.63.1601364071650; 
 Tue, 29 Sep 2020 00:21:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaDM0dV5gjI8sejhS0nlKH8EGqlNy/BbscRqngxW274wHnOYTjFzyBDoNgTqIGup1Suoxopw==
X-Received: by 2002:a05:600c:21cd:: with SMTP id
 x13mr2912898wmj.63.1601364071457; 
 Tue, 29 Sep 2020 00:21:11 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id z9sm4133903wmg.46.2020.09.29.00.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:10 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 07/48] vhost: check queue state in the vhost_dev_set_log
 routine
Message-ID: <20200929071948.281157-8-mst@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
 Dima Stepanov <dimastep@yandex-team.ru>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
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
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <6232946d5af09e9775076645909964a6539b8ab5.1599813294.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 60bc516003..68f0a75134 100644
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
+            continue;
+        }
         r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
                                      enable_log);
         if (r < 0) {
-- 
MST


