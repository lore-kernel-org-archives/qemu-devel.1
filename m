Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D021FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6B62078D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="du1G9TUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6B62078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Qby-0006yH-Ph
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8QYw-0003UW-4J
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:03:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8QYu-0005rr-IJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597853019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9O15VX2DFK35iLFC0RSB8xSgR+TCb7ZNW9WsEjB+21k=;
 b=du1G9TUTddJUE2a75CUzCaTMRMb1qIdrnfbsXanCjQyyz/EFLa5+CH0t2zb2yNnsvmkjXd
 x8aKLBzdZ+oOH16J61pBT+Mqvcc7wlHycyoFEq4AhtfUOFSt+SqHxuKmvsE1y3AblUqCot
 f/TQVq4VX8hwwBXqBXUrYJcJyKhIGgw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-2yvh-WbuObmpIZjrJjpEiw-1; Wed, 19 Aug 2020 12:03:33 -0400
X-MC-Unique: 2yvh-WbuObmpIZjrJjpEiw-1
Received: by mail-wr1-f69.google.com with SMTP id r14so9543839wrq.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 09:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9O15VX2DFK35iLFC0RSB8xSgR+TCb7ZNW9WsEjB+21k=;
 b=T7z2hfRCwE8yoX94zYBXxTRufiTiD14WefSc009miejIxmpVvQ50AgB63KvqFMdSjP
 ZdvULrNwhyjeabAUAtQpZHXQgt8CxR+P1uNDBseVD5FTCWr3mJVZF1DmWZQj9zyDrsJr
 NH355QCEqmoj/OcBZOwrPMh9fVaagtPOMCd8x3V5exoxng79nauX85EOzZdmXuHoGMmT
 nCEbkcro14Zl1Ngv9ia234bnBj7G4m99G3YIp9CSJ6i7fZPrVDg42Gqqd13HC2mIyBnB
 tZROjqYeGzdNq/37GqbN/K8dbjg8ePdwJwtU2mp06eCthM0yw0K38f6la4JxkJcz+xFR
 kHog==
X-Gm-Message-State: AOAM533OLU/sNW9JWwdCvxexfQDM6vbls+8OMQ4Ei6JGQ+iSJMKUznf+
 2Uj8AyW3EFPnyfztYBYqGTDR1hiHFT4Dr7Y1Gx9si6Zo7M8HBzxAQ6fx/2l/hd+C65+siJn/94K
 RwtCgzWHuPoG1UwY=
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr5462660wmg.69.1597853011783; 
 Wed, 19 Aug 2020 09:03:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysHluD3qJEOPzuP/ieMVbQZdvyPdTRQa9d/tedAA0fTG5mpQAGZ/n77/9Nz+kT0qOMlH62DQ==
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr5462648wmg.69.1597853011616; 
 Wed, 19 Aug 2020 09:03:31 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 128sm6149049wmz.43.2020.08.19.09.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 09:03:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v4 2/5] util/vfio-helpers: Improve reporting unsupported
 IOMMU type
Date: Wed, 19 Aug 2020 18:03:15 +0200
Message-Id: <20200819160318.835292-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819160318.835292-1-philmd@redhat.com>
References: <20200819160318.835292-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index e399e330e26..9a83e6084e5 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -261,7 +261,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     }
 
     if (!ioctl(s->container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU)) {
-        error_setg_errno(errp, errno, "VFIO IOMMU check failed");
+        error_setg_errno(errp, errno, "VFIO IOMMU Type1 is not supported");
         ret = -EINVAL;
         goto fail_container;
     }
-- 
2.26.2


