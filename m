Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C1BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3AD20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnG/xX/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3AD20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisWq-0007sT-P9
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKs-0008FA-2u
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31841
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKr-0008Gh-0W
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faqMeqxMHWHCdUO54aiSA0UglN7d7KGvOFdxDmBlKuk=;
 b=UnG/xX/VpoSGNgGXhtbiUPiq65gddO5VYQbLehN+Bryhfb+ivehDhkeUccq3kUr1nKzM6Q
 uOD018N8+sZfGkralTTODgAzHiKR/V1B+w5fqaoSVmsFOtCnY65qDIOFdBA5r8hD6R11lH
 Q35u0n17EC5O44vedy5YrnipTO6r7BQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-kyyfFywaOOOG4PwSxXcfyA-1; Wed, 10 Jun 2020 00:27:30 -0400
X-MC-Unique: kyyfFywaOOOG4PwSxXcfyA-1
Received: by mail-wm1-f72.google.com with SMTP id b63so1446640wme.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=faqMeqxMHWHCdUO54aiSA0UglN7d7KGvOFdxDmBlKuk=;
 b=DthM6Z2rr4RAH0kXcB9q3BaTCatiWyTCNevmjNzdGMzcSgdaQ/OvanrXUSYH5ZIftH
 Z2EtaH1T8IXWQEEs02BQNsQ9LELNzgdJ7h1FndAKIJWZ+tnp3k6Uh/zNxpWdfsipTSxj
 85RrE4stAwtrsnSLeM6Y0VivyUTlJq8/iumkSvzvo/cmZSBZ74cZKz6PVHH2IW4qx/x/
 wGhLdDQQLS8dCsRMqxIKyW9Y/kfozXbDNsAOF4SVrRI+mNcI0ptKicDUjS69jsJhf1bH
 r1aO83FlybbJ+p7m54X+KK6xME9Eq5rFLzwt58xKWKqVOhKEdOuJfus68BeaAlnsIpAJ
 1mEw==
X-Gm-Message-State: AOAM530V7Y8kYm3MnOoTjrwp/fzrn28UTSTY78rrIIXiOtIwKzlYqJ9L
 NWtE4dWCrNQBHPW6XAoEqgFNNq0XUBM/q7xDwIOcfcyELX/ha9Dtd6LOSWsWhrU+ceeN351KnQR
 HGjf6fgdV8402aYg=
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr1185054wml.188.1591763248810; 
 Tue, 09 Jun 2020 21:27:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbNJuPVgzkeH8IO/7ZK6UExSU3MCuj7E6d3ZbQ+GPZjnFBJDdC8rFiL6kQPOVwWQDgOJTCzA==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr1185042wml.188.1591763248645; 
 Tue, 09 Jun 2020 21:27:28 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id c16sm6272609wrx.4.2020.06.09.21.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:28 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/56] virtio-balloon: unref the iothread when unrealizing
Message-ID: <20200610042613.1459309-25-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

We took a reference when realizing, so let's drop that reference when
unrealizing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: qemu-stable@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200520100439.19872-4-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 32e9fe3f64..cff8eab6a1 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -820,6 +820,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     if (s->free_page_bh) {
         qemu_bh_delete(s->free_page_bh);
+        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
         precopy_remove_notifier(&s->free_page_report_notify);
     }
-- 
MST


