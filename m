Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5085C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768212075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUiEhDXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768212075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAUz-0004Fs-Gc
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9ym-0004rW-0Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yj-0001sF-8X
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:23:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j5RffHzeFT5mK5A9LdgEfScrMDIAINQmjFAOhNS4EM0=;
 b=UUiEhDXPYn94OhHfqQICa1P5JYRjvAJQRJUD/GmiP8hczZ2aPa/TdliBTJ5MGWaZICijbV
 eSgBL0wPMDoJJ/3qvSIRw8kBtcElbduMCQ50pJrLwwdEMh4zb/1QyhDxGikkMJXWzxrKeU
 IOiVjlx2Bhk74NxzuT9vobBbvjDZ7jU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-JZey1F1KMpWWB2r_uKGG0w-1; Tue, 29 Sep 2020 03:23:10 -0400
X-MC-Unique: JZey1F1KMpWWB2r_uKGG0w-1
Received: by mail-wr1-f70.google.com with SMTP id w7so1376591wrp.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=j5RffHzeFT5mK5A9LdgEfScrMDIAINQmjFAOhNS4EM0=;
 b=ZGJMZLs8xYQ8ZS9NJ9bI5H2sudfUnBCDWthh33/iahEQUXEmoeg7AgzNnaDO51Qo7I
 m+UU3xKWg8InfyFpmywlwRUU8cZr+/OI6kvmwHUOzSbghq3Li/yTYD/DKerykLkKkRZj
 TQ8HxN1DraE2qZ7LVcBUsxSNL1R3wHwSyB3HYUMntG1I9aOJM8xuoE0gvR6zSC/5Ax58
 IJkqPL9KBh+XBk8piugVbAxDL54JiBEbo8RmdUD3HA7f56ZXh2L+QKZRvuSBtfuEwFH7
 nL28E0sGpZhE1rLuo7aO2INyHztq2/fhrI3fVIVdM+4ONMkaTiRPk1JG6tB3otDklSi0
 uLYA==
X-Gm-Message-State: AOAM530saas7uO+fr1U04JwrUtbeaNw0FEfR27bCRF/GRxGfck1+ugvX
 eWuPpff/FV0ot0WR1e2BXo0cIUCA7F48cvK7KgIGFUc3uzQuqXnPiWqiShzwMlstglEm4c6ng/x
 z0adn/qBX+4Se30Q=
X-Received: by 2002:adf:80e4:: with SMTP id 91mr2508079wrl.223.1601364188628; 
 Tue, 29 Sep 2020 00:23:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1Odj3K4PmApq1ydzmVEyJHeUyZC7d9wBRyk6zXMwd6OKfrTh/OsKPd/KvaLmndRm34EhZlQ==
X-Received: by 2002:adf:80e4:: with SMTP id 91mr2508061wrl.223.1601364188474; 
 Tue, 29 Sep 2020 00:23:08 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id c14sm4699251wrv.12.2020.09.29.00.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:23:07 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:23:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 46/48] hw: virtio-pmem: detach the element fromt the
 virtqueue when error occurs
Message-ID: <20200929071948.281157-47-mst@redhat.com>
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
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

If error occurs while processing the virtio request we should call
'virtqueue_detach_element' to detach the element from the virtqueue
before free the elem.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20200813165125.59928-1-liq3ea@163.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: 5f503cd9f3 ("virtio-pmem: add virtio device")
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 hw/virtio/virtio-pmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 1e0c137497..ddb0125901 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -77,6 +77,7 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
 
     if (req_data->elem.out_num < 1 || req_data->elem.in_num < 1) {
         virtio_error(vdev, "virtio-pmem request not proper");
+        virtqueue_detach_element(vq, (VirtQueueElement *)req_data, 0);
         g_free(req_data);
         return;
     }
-- 
MST


