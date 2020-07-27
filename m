Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562C0C433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2E02083E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRDbaQoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2E02083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04CH-0005Cm-CT
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04B3-0003X3-Az
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58938
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04B1-0001HB-HZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nUT7Qbk7nFEddXYspzd8aisJc0jjaXW+jFGJmy8zWts=;
 b=fRDbaQoEkEAfQIHY3i5i3CfgmtGhQi6YpKaV21/8QDEIaTDp7J6yL8mnt/XJt1xjBblrRb
 1mJuov0dLO38iVlrzf43KN4K5ha/0c5EKk5ASfU09h2pw0Tx1tjaJbk4o2mPakxF9k4X0T
 lJgGcoSUrVbMq9mH2zpo9GTo2FQwQKE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-1hM2uzHSOmKfC8tE19Odyg-1; Mon, 27 Jul 2020 10:32:22 -0400
X-MC-Unique: 1hM2uzHSOmKfC8tE19Odyg-1
Received: by mail-wr1-f71.google.com with SMTP id b13so1243774wrq.19
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nUT7Qbk7nFEddXYspzd8aisJc0jjaXW+jFGJmy8zWts=;
 b=esBJioYhlfL4hRZdwxQM3STxLCS2vTa90XdWEpE8Qp04CtR5ubPt1TE/2zovQpJRQp
 OZtJm3lIuah+fvYWKB1+ll8IOnAKroQ77kjP3I6SpUZhqEUf3ttPhK86s6hM2VK5sNI/
 q8oGeTDumf0SMow6MUERexUVX9eBGayiQMDLAB9r9Vy+SbQk5Hmi6gYhbVorG315NAZP
 fWPcdHfYUeaLOB0UUTBQfZEwOKbOdmoxmewMWTpwNvfYJZtY6e9TNL5hEbSLCC+OVUsC
 eE9YhZefXN6mrF4DmMIk8EBFk9W88kiIMwcrfcgKPuwM4/DtLKz2EEWGwMytzOvXpWEv
 8ETw==
X-Gm-Message-State: AOAM531/9toX2HnEGXRakGEMyd4qGHnruOCT8D+I5RSu4bxvKUR/blDN
 a2o9YzkUN58+eTQnX/UVWAaVw+kVtR8JQOPMIgc8tm4Ee5ZY0o1wDlvTAhBOB9vlk/F0dgPtoIw
 V67qERnf49CKQ6t8=
X-Received: by 2002:a5d:5681:: with SMTP id f1mr19717243wrv.192.1595860341049; 
 Mon, 27 Jul 2020 07:32:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8MHx1L/eyPoQr0fnBOnzpdB3FcgPK1jA6IB8cGpbZnjoG51hhFlDuFbLh3J69EnF+2LRmUA==
X-Received: by 2002:a5d:5681:: with SMTP id f1mr19717226wrv.192.1595860340837; 
 Mon, 27 Jul 2020 07:32:20 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id e5sm11873243wrc.37.2020.07.27.07.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:32:20 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:32:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 5/6] vhost-vdpa :Fix Coverity CID 1430270 / CID 1420267
Message-ID: <20200727143104.97776-6-mst@redhat.com>
References: <20200727143104.97776-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727143104.97776-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

In the function vhost_vdpa_dma_map/unmap, The struct msg was not initialized all its fields.

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200710064642.24505-1-lulu@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 65d5aaf08a..4580f3efd8 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -37,7 +37,7 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section)
 static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
                               void *vaddr, bool readonly)
 {
-    struct vhost_msg_v2 msg;
+    struct vhost_msg_v2 msg = {};
     int fd = v->device_fd;
     int ret = 0;
 
@@ -60,7 +60,7 @@ static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
 static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
                                 hwaddr size)
 {
-    struct vhost_msg_v2 msg;
+    struct vhost_msg_v2 msg = {};
     int fd = v->device_fd;
     int ret = 0;
 
-- 
MST


