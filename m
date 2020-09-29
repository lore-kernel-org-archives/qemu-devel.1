Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA56C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E11207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erNmToZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E11207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA1E-0007kQ-5L
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9wm-0002I6-0p
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9wh-0001Xk-LZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Msq8goiUIrREy947KknDtEH1ZqD2k0E/AfsZQGv/SGY=;
 b=erNmToZPnusoNK3G3u2yBlJYlp4Z2CxPFvr8ezd7x7H68gO21HCb/5Zf546L8aabaUcr6D
 wxGXH/wQ+DFDWBsoXpF4NJoee48Ko88ieFodAQyz3aGtpvfwfPbXtF64vU8eSEyXB87z7l
 frg772hB4ew+cFkNRvZcXyY4tXDlXVw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-T1acoe7kMdKUCWVhkclJRw-1; Tue, 29 Sep 2020 03:21:04 -0400
X-MC-Unique: T1acoe7kMdKUCWVhkclJRw-1
Received: by mail-wm1-f69.google.com with SMTP id m19so1453462wmg.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Msq8goiUIrREy947KknDtEH1ZqD2k0E/AfsZQGv/SGY=;
 b=ZKZdoIty36yq11e79lPUT3S1NHMgkRD1KDYLzEZsXXfR/GhbIDA43lJyUJK/C8pMhb
 t+kaVS1RMNgkVAG5SX0UHyU/0eGOXENQCuT67GfN+DE+hicGDzKsFqITq9lcnmhOPbg7
 Jbiu9kj9VhpimO7xZmOy+9gQ1kcoW39InYBXURCUw8c8W03M1fNxSOXt5vZdcR4kKG/M
 vyWTz/LX9+Fjh5eWLj7EWXeLJJ2n7ICQVMe8Z68xpCVj6AV0cVEZtOEWhT5mnF5SDmVS
 iWWG88oaXino90gKSm+75/RPs46cJxRdxO3Wh6E4AqfwPBeoVH+ziOjqg0+Lh7/eCO/L
 /Mzw==
X-Gm-Message-State: AOAM530cRVH5LVWeeXCTbwd77ZylWMK1y/IOAcJPfbXcYor6qKXUrl60
 yPOkLERm853889bJWaP2FAVUcPPzWZjdv3A19NikxV9D24GyJeG72+4Ys2a/AUmNjBuNDucVvDU
 A2bg0yoW34SmTwPY=
X-Received: by 2002:adf:fd12:: with SMTP id e18mr2627960wrr.96.1601364063200; 
 Tue, 29 Sep 2020 00:21:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOimFGDiWuDMXon/kWYFUIvYCNDyv5BtqrebWujLQLnAVXzVsmidBkr20zCZHrHhvYaJeMMA==
X-Received: by 2002:adf:fd12:: with SMTP id e18mr2627945wrr.96.1601364063005; 
 Tue, 29 Sep 2020 00:21:03 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id a13sm3905305wme.26.2020.09.29.00.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:02 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 04/48] virtio-mem: detach the element from the virtqueue
 when error occurs
Message-ID: <20200929071948.281157-5-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@163.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

If error occurs while processing the virtio request we should call
'virtqueue_detach_element' to detach the element from the virtqueue
before free the elem.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20200816142245.17556-1-liq3ea@163.com>
Fixes: 910b25766b ("virtio-mem: Paravirtualized memory hot(un)plug")
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 8fbec77ccc..7c8ca9f28b 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -318,6 +318,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
         if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req, len) < len) {
             virtio_error(vdev, "virtio-mem protocol violation: invalid request"
                          " size: %d", len);
+            virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             return;
         }
@@ -327,6 +328,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
             virtio_error(vdev, "virtio-mem protocol violation: not enough space"
                          " for response: %zu",
                          iov_size(elem->in_sg, elem->in_num));
+            virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             return;
         }
@@ -348,6 +350,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
         default:
             virtio_error(vdev, "virtio-mem protocol violation: unknown request"
                          " type: %d", type);
+            virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             return;
         }
-- 
MST


