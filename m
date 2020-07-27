Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEE5C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1D92070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLCvmUxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1D92070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03ZK-0002jX-OG
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vq-0005U9-DA
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vo-0001wN-KJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595857792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bb6OtX/LD4ZX58mGeq2eGBkZlXvZDtQoKpqNCcHDcU=;
 b=KLCvmUxA8pvPEU50bvWzM1f6RgxhbfUSS4h9clFDKx0E+LpRLK+FDpoQZmTYxi07XlXanj
 9cNb+NQr6f1AneU9LIVfG+20qVS3ncxHUmOSwizAZtuk/+53waV+KtWNFeZdtiOxADQgl3
 d2s8cAzQVGUglCF3sQE+e/oqUWclvdU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Dd-KUaD3Ncesp6VF0v6SXQ-1; Mon, 27 Jul 2020 09:49:50 -0400
X-MC-Unique: Dd-KUaD3Ncesp6VF0v6SXQ-1
Received: by mail-wr1-f70.google.com with SMTP id w1so1938234wro.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2bb6OtX/LD4ZX58mGeq2eGBkZlXvZDtQoKpqNCcHDcU=;
 b=QgErNLfwF/g11kCFUoEEKAKKwUxG2TUQKxxGcNjY1G9pChBmhEpnMi3JjODqvNCpg0
 ziA2K40IoD11JDMfYVlh9Hgr6aDv3hG1TbyCtWRq2PzCWmFR+8NwLb84Q8mxkXNHrJHh
 7Q81h4bPl7mzLkLI9fDl416IvdoSopeg2ZtzVVYeVblwEgtm9sTzjp2h7z/5fSWyB2jT
 j76uUUtcnvM33ZSJbC/YMhuAHZKYzEQrg10EG7KH2hubXLc//W1D3h6mC3CRyeQ2qGE1
 cV/uCM/vuLJZvyjpkx+3gRCNjei4zQ12pQFQmgZg03myg+mFbABdo2CdUgb2yoLeHFMz
 eKuQ==
X-Gm-Message-State: AOAM530K5gP2BrZlxJdenb+O6WdBhXDL2licRseBZONkC6nKjCqCpqxH
 9lqq3nO8FBjqnEbQ7szFstE015f7tqGkGuImgUmT+w4x1sL8Wq0OHRjllVtpWBnQh847wJH2GfJ
 ToLJVdZqzS9uGVwk=
X-Received: by 2002:a7b:c205:: with SMTP id x5mr21975195wmi.161.1595857787737; 
 Mon, 27 Jul 2020 06:49:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc0bxZIVZdfd15jK1aD0TSqhIErH70IAF/kCvzhu9EUpS5F5h75F08gfobn/wRL4DKmLbSUg==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr21975179wmi.161.1595857787498; 
 Mon, 27 Jul 2020 06:49:47 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id 32sm12283552wrn.86.2020.07.27.06.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:49:46 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:49:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] Fix vhost-user buffer over-read on ram hot-unplug
Message-ID: <20200727134614.96376-5-mst@redhat.com>
References: <20200727134614.96376-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727134614.96376-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS vhost-user protocol
feature introduced a shadow-table, used by the backend to dynamically
determine how a vdev's memory regions have changed since the last
vhost_user_set_mem_table() call. On hot-remove, a memmove() operation
is used to overwrite the removed shadow region descriptor(s). The size
parameter of this memmove was off by 1 such that if a VM with a backend
supporting the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS filled it's
shadow-table (by performing the maximum number of supported hot-add
operatons) and attempted to remove the last region, Qemu would read an
out of bounds value and potentially crash.

This change fixes the memmove() bounds such that this erroneous read can
never happen.

Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1594799958-31356-1-git-send-email-raphael.norwitz@nutanix.com>
Fixes: f1aeb14b0809 ("Transmit vhost-user memory regions individually")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 31231218dc..d7e2423762 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -672,7 +672,7 @@ static int send_remove_regions(struct vhost_dev *dev,
         memmove(&u->shadow_regions[shadow_reg_idx],
                 &u->shadow_regions[shadow_reg_idx + 1],
                 sizeof(struct vhost_memory_region) *
-                (u->num_shadow_regions - shadow_reg_idx));
+                (u->num_shadow_regions - shadow_reg_idx - 1));
         u->num_shadow_regions--;
     }
 
-- 
MST


