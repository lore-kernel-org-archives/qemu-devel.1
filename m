Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A8DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A469820723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrqskPvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A469820723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHru-0007h6-RG
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHd8-0001B6-5r
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:05:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49190
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHd6-0004bq-Cp
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h8govD67lanJJAmIgSTuxQeH9ZylAQ7cIEwKwJSkzkc=;
 b=OrqskPvurMM7QZVKm0WcbICIT8sBJH6O7JEA7M9F3VdsIeeXLTNhKISJxKgpSEv/wXf8h5
 U7iOL8FE7Jcla7R8ODB9yn0J6PEO+YJN2NaG+19AXHeM3zIIofxDEr6BaLwHWz+0SHKIgh
 BFcFXvKZXQC10rcPY6qBdQ5Vq+2QGLk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-EydxFMhdMYGC0GKBdehszw-1; Fri, 03 Jul 2020 05:05:06 -0400
X-MC-Unique: EydxFMhdMYGC0GKBdehszw-1
Received: by mail-wr1-f69.google.com with SMTP id i14so30960236wru.17
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h8govD67lanJJAmIgSTuxQeH9ZylAQ7cIEwKwJSkzkc=;
 b=rCVYzL34eryrJUKbo7HZMMIFijuiPKcGs619XQl19F8+RhONF+WFA+SgAPy0CIaoSE
 Z6RYbdPTAefQ4itF5wfD4Nhlftf+16922CPj20LBjupKhRVtE0L5S6O2fSqDyLRGlKji
 UktlceqrQUzU2FItUsNLQdowZJq6w++3xykk35mJl0LItD4BLh6AelWlOd5UtMwRxSx/
 0O0BSMbaL95yLlmT7Nht4GyGweOnk/veP4hyxBXJ0dzMO2bFb6CUvZ9O4h+u4dB0SXK/
 0CVeP+bcBmWIYY3CeMP4+xax/ZeqbYsQYCH/TP0iKO+ThSTozs5bVXMgWwnwLSgHJt3H
 ngsA==
X-Gm-Message-State: AOAM533TbFfmdnnJY/zvXurFr6dhFIv3hQxvKuU7PAuibH1/nA81qBBi
 qJuVtPQDhTufU67I6sSHaueOYV27r2/AIXyQEPx6EwPrWAwclmPHz1OUUTmWoWeKS+UuoQwXWVl
 t+2i5QJkrFOI0MXE=
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr37412149wmj.160.1593767104806; 
 Fri, 03 Jul 2020 02:05:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxw9o7TRfLhPHdEA8xMwSlObOpYQ+u2d2VAOlL693TBRr/mKkxAYrXtSYnnMia9fXwBlayaw==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr37412134wmj.160.1593767104651; 
 Fri, 03 Jul 2020 02:05:04 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 q1sm13323187wro.82.2020.07.03.02.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:05:04 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:05:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/41] vhost: introduce new VhostOps vhost_vq_get_addr
Message-ID: <20200703090252.368694-36-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

This patch introduces new VhostOps vhost_vq_get_addr_op callback to get
the vring addr from the backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-9-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost-backend.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index b80f344cd6..fa84abac97 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -34,6 +34,7 @@ struct vhost_vring_state;
 struct vhost_vring_addr;
 struct vhost_scsi_target;
 struct vhost_iotlb_msg;
+struct vhost_virtqueue;
 
 typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque);
 typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev);
@@ -113,6 +114,10 @@ typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
                                         struct vhost_inflight *inflight);
 
 typedef int (*vhost_dev_start_op)(struct vhost_dev *dev, bool started);
+
+typedef int (*vhost_vq_get_addr_op)(struct vhost_dev *dev,
+                    struct vhost_vring_addr *addr,
+                    struct vhost_virtqueue *vq);
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -154,6 +159,7 @@ typedef struct VhostOps {
     vhost_get_inflight_fd_op vhost_get_inflight_fd;
     vhost_set_inflight_fd_op vhost_set_inflight_fd;
     vhost_dev_start_op vhost_dev_start;
+    vhost_vq_get_addr_op  vhost_vq_get_addr;
 } VhostOps;
 
 extern const VhostOps user_ops;
-- 
MST


