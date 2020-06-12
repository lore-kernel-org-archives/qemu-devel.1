Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D5EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E3C20691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFluY8ZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E3C20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl96-0002qJ-5m
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2J-0006lM-7r
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32829
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2H-0001SZ-Lo
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWR60ercXQZVd22zZQp4vrHc0/weVq8wSWjY7Go6ogE=;
 b=HFluY8ZARDoMUe0RcVyzi/3zAerUygUtxyv4o5PmHTSZF4dzz2MbXzfI/3Ovl/eA1nBMpE
 vT4LxuUoHY0m739zy/UPXuX4A9xkUEEovf2yBFu2s7Db5xpow/qOanOIReMt05O5WDTPDo
 MD5nYPJVESLG3v+DcBTCaGrR0L+NlFY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-WGJQsmkFNrWpb-q3VnQyAg-1; Fri, 12 Jun 2020 10:51:57 -0400
X-MC-Unique: WGJQsmkFNrWpb-q3VnQyAg-1
Received: by mail-wr1-f70.google.com with SMTP id p9so3999992wrx.10
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=IWR60ercXQZVd22zZQp4vrHc0/weVq8wSWjY7Go6ogE=;
 b=akNU12vKYGVRMtoIesqmOrJJGrJ2uZaX0YWp293I2t8opLs5rhecKcmCAo0JMkaGed
 bhng+Zrp9v8l7amznsKI9yaIUe1J6fPzfXVQ6Ch21jiW7XLLjRuevfjIeGJDP1Oc4m6I
 EB/R6MxW+R+roF+1bC0YViheER2rh+RDnpmNAvR53VEFKFP28pl8myGxI6sQmd5ITcjM
 OsnwDRSpgt1Y9BoHSSi+s0ft/+rC3XjyoVkDs1wU80PJgptiWJ81a+X1iEvgrEqWXcWu
 h2hdswikfL3298VONHZfj3N9dWURoOYCdNO75JUHcHZzBuhMGPeWUTq1WOqxSj9B2lcB
 RmGw==
X-Gm-Message-State: AOAM531cSDEZuamovin3a402ENdWJhPJ7A4tgMzC6cxczBFSX6TEegIx
 qhJAmgzm1OLkWdfTA2LL37pMFC8NPfl09uinafMoUmY1GrONw4cifP8rYnPWxG/SubYFBRAOcRI
 WxiqWnjhL43OXPCk=
X-Received: by 2002:adf:f507:: with SMTP id q7mr15102989wro.353.1591973515954; 
 Fri, 12 Jun 2020 07:51:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9aYbpLDGlpygvbyw4emBwQrJQ6UUxUvE8vn4WScLdcWYfa1YnBBAE0JoVm8dT86pZTFsegQ==
X-Received: by 2002:adf:f507:: with SMTP id q7mr15102966wro.353.1591973515749; 
 Fri, 12 Jun 2020 07:51:55 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id a16sm10113673wrx.8.2020.06.12.07.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:55 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 23/58] virtio-balloon: fix free page hinting check on
 unrealize
Message-ID: <20200612141917.9446-24-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>, Wei Wang <wei.w.wang@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Checking against guest features is wrong. We allocated data structures
based on host features. We can rely on "free_page_bh" as an indicator
whether to un-do stuff instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: qemu-stable@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200520100439.19872-3-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 7ff6a7aa7c..32e9fe3f64 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -818,7 +818,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBalloon *s = VIRTIO_BALLOON(dev);
 
-    if (virtio_balloon_free_page_support(s)) {
+    if (s->free_page_bh) {
         qemu_bh_delete(s->free_page_bh);
         virtio_balloon_free_page_stop(s);
         precopy_remove_notifier(&s->free_page_report_notify);
-- 
MST


