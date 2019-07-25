Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCBBC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44665229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44665229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfkT-0000i3-4b
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfim-0003o7-U3
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfil-0001zo-Qe
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:56 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:38691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfil-0001zc-LY
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:55 -0400
Received: by mail-qt1-f172.google.com with SMTP id n11so49469725qtl.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dA9LUO6VEsx//VU7t8V1eZMwkDlrJzb1dpjUR6L1COU=;
 b=EpvqwaLLULvcrfcZCJihXR4Xw8hcwjw1+AuVML+RVPqIcKSORYJT66wca6Y42Oyr5U
 BGkMN3tCdv/I0ERnb7yL7mOnv+WWUDZlnP0k69mMGw9bB6YsJhEthoi8VTp3S//eChzP
 ddXbd59fIVFgwrlLF4PwNfuWyMBRRaBbZ+8XGCFOGfSNVbL8YA8AhWXSFokthD0kWJ2W
 xfr8EI9vGdLQw9rGlsgqBlZN0cUyBuqw3/fXKyQOoM5RLqjMY4jqT+HOIt8abiEAxoHS
 zNq/nf23bJwYpVHPBATt7mSYkNJv9mhdnoUVsofUrJ54VuhPm4bilNuktEpfQACScw8k
 l+Ug==
X-Gm-Message-State: APjAAAWe7EQ6IXv0qagBrHcmWaDlHrOiZlQrIS0iaQDsfMUrzqaerOuN
 pdGWEbu11cs1paIFrUkL+2pKVQe24mmAgA==
X-Google-Smtp-Source: APXvYqxZCws6qgZeuf32d1SbcE4YpdOWAde5wy2uAKriVp2OIYr2Rlqohy9pvoVDLXSNTyKfvyKVMA==
X-Received: by 2002:a05:6214:1274:: with SMTP id
 r20mr61646308qvv.127.1564068714754; 
 Thu, 25 Jul 2019 08:31:54 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 c5sm31052308qta.5.2019.07.25.08.31.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:31:54 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:31:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190722134108.22151-2-david@redhat.com>
References: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.172
Subject: [Qemu-devel] [PULL 05/12] virtio-balloon: Fix wrong sign extension
 of PFNs
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
 David Gibson <david@gibson.dropbear.id.au>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190725153150.o1xhr_LFwGPdPjwZFeHm3mepzcnRU-5fDGwzhujyZ6I@z>

From: David Hildenbrand <david@redhat.com>

If we directly cast from int to uint64_t, we will first sign-extend to
an int64_t, which is wrong. We actually want to treat the PFNs like
unsigned values.

As far as I can see, this dates back to the initial virtio-balloon
commit, but wasn't triggered as fairly big guests would be required.

Cc: qemu-stable@nongnu.org
Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190722134108.22151-2-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/virtio/virtio-balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e85d1c0d5c..515abf6553 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -343,8 +343,8 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
         }
 
         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
+            unsigned int p = virtio_ldl_p(vdev, &pfn);
             hwaddr pa;
-            int p = virtio_ldl_p(vdev, &pfn);
 
             pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
             offset += 4;
-- 
MST


