Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A56BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4AF2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyZU4Qkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4AF2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvPj-00010g-RY
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNW-00066p-HG
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNU-0007tt-9I
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wTH3wc2I2rRV2/wVEdRkSxgLY/gmXgNT0mExNm6R6I=;
 b=WyZU4Qkwh2mre6b0n34ps3+93EyzuaWEmVDLZfMP4ukMP4Ft81i63z6I/eVOnPXCQZe7K7
 u9qKS3+mLRt6xRbWMWydKUJXgwmg8zanHhL+BL96JNKznHrUEMISF1l0BId2jUoyKwIIYO
 GUQePMy9Md9WGiy1BUl5EFiy8iAI/xA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-c-KoPa7xMj6f4N_FrVrq0w-1; Tue, 20 Oct 2020 13:24:42 -0400
X-MC-Unique: c-KoPa7xMj6f4N_FrVrq0w-1
Received: by mail-wm1-f69.google.com with SMTP id w23so629618wmi.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2wTH3wc2I2rRV2/wVEdRkSxgLY/gmXgNT0mExNm6R6I=;
 b=rEavoYqAoA/GIVJdXwsp/pnoPBxMC47Bh1WgVPMMKdl06CqXd8lJoWcAOaqg+YuX1m
 yiJbRK7dOCAVccE9bvjm27NDNDle7g8OD/cWHXMNkWOA72s2E0wOzEh5oZuF3PAVS7SA
 7HdgqRx3QqDkpuxI0rA1d6Fa/XojTFeUl8ni1M0FcLw9sDy8pAjT1GwYZkINSAeErmo/
 9IyfimABwkxnxackC/39VNFV0E6pMM+aaVfK/u+snR0LWeDTZ2crrPZAwbLV/leG82Bh
 k4K5iUZrAY8QrNx7N9LBg8zueCYMm0xLNOxEgdUISvvtxRwcXswMBWJgjkE9uG6t10JW
 9nCQ==
X-Gm-Message-State: AOAM533+0WzL+8/xQpHgy2AO98E5RjfhK0IdBlsRIoVGK5TTpkbbdlfz
 DsrJU9mEjRKJ3h6bRMYTWLjJtjaHQPYwrkcSIVWxQKU45M+lbERb2n1AYH9pT2Va80W+KR8qk3B
 eJFXJULgYIrFdvAo=
X-Received: by 2002:adf:e412:: with SMTP id g18mr4641262wrm.211.1603214681014; 
 Tue, 20 Oct 2020 10:24:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBNhKVmJ/kwz/H/9cX3uBa72fxsg1FHIIl+2JBiGA8x9BVJUC4kBEDX0YVj0zyn0Xb8jdImA==
X-Received: by 2002:adf:e412:: with SMTP id g18mr4641246wrm.211.1603214680850; 
 Tue, 20 Oct 2020 10:24:40 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y185sm3676545wmb.29.2020.10.20.10.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:24:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/16] util/vfio-helpers: Improve reporting unsupported IOMMU
 type
Date: Tue, 20 Oct 2020 19:24:14 +0200
Message-Id: <20201020172428.2220726-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020172428.2220726-1-philmd@redhat.com>
References: <20201020172428.2220726-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


