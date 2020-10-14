Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A61C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF2A20848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZpm3SGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF2A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfMV-00017Z-W7
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLC-00084B-VC
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfL7-0000TF-El
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wTH3wc2I2rRV2/wVEdRkSxgLY/gmXgNT0mExNm6R6I=;
 b=DZpm3SGMzq4i77j6wNLAtjMQBy7VXeif5Zvmpr/t4wREbjNSK77bMSStRqiMi8XTrjtApZ
 eDnRYXhFB9jQ5SgKkY+KlCG0J7k6WWBTIYDENXg9O1XZyQjLOUk4ir1hHiBkQh7T+ZKZ+Y
 2Y2SsL3zcjy4+9wBPiY2XR6LqnnHI74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-geWXVkfTM_et3okPNlOjnA-1; Wed, 14 Oct 2020 07:53:02 -0400
X-MC-Unique: geWXVkfTM_et3okPNlOjnA-1
Received: by mail-wr1-f70.google.com with SMTP id 33so1171708wrk.12
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2wTH3wc2I2rRV2/wVEdRkSxgLY/gmXgNT0mExNm6R6I=;
 b=VL35h1Mrro/OGZLLkrxEnNAPngkU8ErpM8O5HtnGK6/fhVGt+GdeeVEVYqgHM1cy6c
 L3XUe1tenB+goJmhXfey4FbnTW6LeDGbde/zerrMy3ZkeKj4Tlj/jO3whF4hU7innEQw
 EasEwhGdjUXJU+3e+PIqbAroeFIRxgQtOMpJke6GlZ2PrT/+vjnRIW0gi41Ib0Mvf6du
 3XBB0ar+eYbqtFOINVE7fmCpqikmlja8RRY8T3ZCCxWGgCUxDEWUiBu6COttU1yUfBW4
 s+ux7eceLM4hKu+JdM/zB7XPl2QkmtSLbvdYExOWCqATpeOzrW/vmrgqnAzCnb8BPd2c
 nXUQ==
X-Gm-Message-State: AOAM531S0yqWZqU65EKP9kbXn4C4E3cVL7TW9o61pIYu8luNHjPJNvEs
 dnjfKhvloEVoz0k8Re4vyh4N0dyC/WuIfG4uOo2QM/Nw0UQ/CRapw/JSvcBVXaTKVFX8gS/uGRj
 HayROrP4NzHMOyLE=
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr5434773wrp.179.1602676380913; 
 Wed, 14 Oct 2020 04:53:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0U1ZK9ta+Epay7AuhvWvB4Ol2G6irIn8WjV4FZZx1WacWHGo3jYExAPVw7Y/2g7p1s8/lMQ==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr5434757wrp.179.1602676380696; 
 Wed, 14 Oct 2020 04:53:00 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n3sm3468979wmn.28.2020.10.14.04.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 04:53:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/9] util/vfio-helpers: Improve reporting unsupported IOMMU
 type
Date: Wed, 14 Oct 2020 13:52:45 +0200
Message-Id: <20201014115253.25276-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014115253.25276-1-philmd@redhat.com>
References: <20201014115253.25276-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change the confuse "VFIO IOMMU check failed" error message by
the explicit "VFIO IOMMU Type1 is not supported" once.

Example on POWER:

 $ qemu-system-ppc64 -drive if=none,id=nvme0,file=nvme://0001:01:00.0/1,format=raw
 qemu-system-ppc64: -drive if=none,id=nvme0,file=nvme://0001:01:00.0/1,format=raw: VFIO IOMMU Type1 is not supported

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index c469beb0616..14a549510fe 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -300,7 +300,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     }
 
     if (!ioctl(s->container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU)) {
-        error_setg_errno(errp, errno, "VFIO IOMMU check failed");
+        error_setg_errno(errp, errno, "VFIO IOMMU Type1 is not supported");
         ret = -EINVAL;
         goto fail_container;
     }
-- 
2.26.2


