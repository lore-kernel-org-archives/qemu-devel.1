Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B26C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B212076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikZFrorP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B212076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVAX-0005Jo-W0
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8I-0003dV-Ef
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8G-0007Eq-LV
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zjLk5rYnsVamvL3ZAKIsdxK/c57DAaLzJqbsx6rIiu4=;
 b=ikZFrorPSIsCAAhiBgOrTmCZtHh63PlJhUJIgmC7/XKMJ9yd2cXy6JywRa96IM/jrD3n/a
 RrXx2Ktvc3+F5oY1Gi2EE/WGHFjq3fyKQ9DBEudoSDmAB3rlanYQW4edF2Ann5M0peWhOi
 6/+uTJdljVVH56/7vg4J8K1R8j0yWRg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Du8iAnm_PF6prei9SduhxA-1; Fri, 30 Oct 2020 10:11:53 -0400
X-MC-Unique: Du8iAnm_PF6prei9SduhxA-1
Received: by mail-wr1-f69.google.com with SMTP id t11so2711890wrv.10
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zjLk5rYnsVamvL3ZAKIsdxK/c57DAaLzJqbsx6rIiu4=;
 b=b7/nd31lW9a7gHXpt+Nx2pzVY1nEaqLJsRtklKs21n9r30AR+/p+RdRCy7hvGAOc1+
 VBZkM2bPpputDbPd+v6JVmVYAi5sPtVcKDYUTeLYbcKVhrShkOmHNz5eEd1YxceF/u2o
 S+BGPrjEGpe8afd1qRQZnxtdzmo2j6scRfnRe3aCMrlEnrMUjZoi2NW9VTCQQsBKtjNY
 PXg6YsFbq9bYqthTqK73H39lohUg+wQrnh7PQXWCYWStmTuB/RW2AMvifBOBOQWH7fXE
 ygWjb3kd6I+vXpomKozZuFjv2UXK/4jcQAwmlGLiAj+sP0Bwl8jBo3E1A0g4Tnh97ncA
 MI1w==
X-Gm-Message-State: AOAM530KmRZ6GbZiRmZgGsSMJeSk4lo4axDFcjMiJDOYXuyl6tOnbzBa
 t6jjdRemx3QXC5OXj3u9qm3010VfcSc3p90SxN4n9wyBTbuYWGEIHENknfEGsFczkmk9jahVyQh
 Y01lBmXYoE2PaEoI=
X-Received: by 2002:adf:e801:: with SMTP id o1mr3445194wrm.359.1604067111977; 
 Fri, 30 Oct 2020 07:11:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ7rwxJD03mNtlZc9HA8WzkmryMRJRZMfCq1l1d5syilYFhE7x+osPmSN8FHFqIWSVk54Qhg==
X-Received: by 2002:adf:e801:: with SMTP id o1mr3445174wrm.359.1604067111841; 
 Fri, 30 Oct 2020 07:11:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id u202sm5046704wmu.23.2020.10.30.07.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:11:51 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:11:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/15] vhost-vdpa: negotiate VIRTIO_NET_F_STATUS with driver
Message-ID: <20201030141136.1013521-2-mst@redhat.com>
References: <20201030141136.1013521-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030141136.1013521-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Si-Wei Liu <si-wei.liu@oracle.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Si-Wei Liu <si-wei.liu@oracle.com>

Vendor driver may not support or implement config
interrupt delivery for link status notifications.
In this event, vendor driver is expected to NACK
the feature, but guest will keep link always up.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-Id: <1601582985-14944-1-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e2b3ba85bf..99c476db8c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -55,6 +55,7 @@ const int vdpa_feature_bits[] = {
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_PACKED,
     VIRTIO_NET_F_GUEST_ANNOUNCE,
+    VIRTIO_NET_F_STATUS,
     VHOST_INVALID_FEATURE_BIT
 };
 
-- 
MST


