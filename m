Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CAFC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F172208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGfwK1MA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F172208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJIC-00066M-FK
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ7b-00054V-Rl
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ7a-0005g0-1j
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600446023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zU1UuXmYbLJaJZ3QFezYItjoYd07TLF83B1qBr2RadM=;
 b=gGfwK1MAbZ369zFCW1TEg/3BW8DV8ehiZK+cOdjoAGQQB49JqwjaWLsPL7w6eR+7pjYAYr
 XI3agc8b1hginA+V0M0PNFPib14MwZxVfq0x6ZTkeDWSHJ995ljVlohEXLiaBU7JfZpQ62
 Nsm7glKXC/e0Q5tGsE0aTtVK3tbCvXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-NlVKJQxVNBOdpcplvQxW5w-1; Fri, 18 Sep 2020 12:20:21 -0400
X-MC-Unique: NlVKJQxVNBOdpcplvQxW5w-1
Received: by mail-wm1-f72.google.com with SMTP id a7so2245299wmc.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zU1UuXmYbLJaJZ3QFezYItjoYd07TLF83B1qBr2RadM=;
 b=a5XgMAhpCZNCvnwRKj4FnEG7IkntEpGs+ZJbKvmnK0duqwwyXoQjGdHBl3gaUD99oJ
 Z83NjlCi3W4ErRdAJD/ofrB1yV6zlkWC3ZDOktZWafCNNlLHM68kDTa0QH3HedzA0654
 RZQ38km8CXrXrby3eX+yMmZgAzaHgx63V4kwEEMA1wbDSV5kw4rcmqo9gPhwIvjqOLKF
 xaxLqMPGpKtNWJYibbbsvPHRjqiyJ4bvYbmxtHGrVIHgU692Vk4mIpYGKMMxn5QFLLzg
 JaGn72hk7IAB7o/CpWlu+mIxXPiWrZH+J4WjHUsTuKXscD7vX/HjwKT25U7zAfRo473x
 A+lQ==
X-Gm-Message-State: AOAM533qozixLWiXUeZlL71CLQtgMM9EzkOEYSp/pSkHf1Lh1Z3YcuVK
 ncqcf1oa09+MB2PCywQkQtfHvzSZbRg6ryxp+GA7sjPdi0XTr7zkCX6Qg/JVawtIi9W0Lg+x6qK
 AewFp24xQTaL7VMw=
X-Received: by 2002:a05:600c:252:: with SMTP id
 18mr15393289wmj.63.1600446019265; 
 Fri, 18 Sep 2020 09:20:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdEJwP8cWRridimELEROz+TLBXqSVzTljEw/v/N8HgUwH4ImJTUd8TzXfsCdKWMyAegyWVFw==
X-Received: by 2002:a05:600c:252:: with SMTP id
 18mr15393275wmj.63.1600446019075; 
 Fri, 18 Sep 2020 09:20:19 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id l10sm5788364wmh.27.2020.09.18.09.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:20:18 -0700 (PDT)
Date: Fri, 18 Sep 2020 12:20:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/15] vhost: check queue state in the vhost_dev_set_log
 routine
Message-ID: <20200918161836.318893-8-mst@redhat.com>
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
index 1b2d735b54..7c9542b1f6 100644
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


