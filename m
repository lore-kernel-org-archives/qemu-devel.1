Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D55C4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CC622243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoqOLsmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CC622243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlmq-0003lF-Q1
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZljj-0001sK-39
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlje-0003ZE-D0
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v40hj3qY78whRoPdfOU/jnlm9Vu0+VmOWNSL1HaIBaY=;
 b=DoqOLsmGtEb6DzCfMBFsL6mjm8Iz/eMad8yit2l7Ettpdo5mci4wa+Pdr9u2XcT+wJ+jfx
 OfQGjgXSjN2UGT4VLShLC0JndEB2is03hjFEatEEOpxLB8a+B9xpz5zFtadtJKtrUD14GG
 6NuOKg6oht2jYfynb7NXIJUziiBzDww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-GJc1FljLMkyrG0unTJIHSQ-1; Mon, 02 Nov 2020 21:07:43 -0500
X-MC-Unique: GJc1FljLMkyrG0unTJIHSQ-1
Received: by mail-wr1-f71.google.com with SMTP id 33so7144525wrf.22
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v40hj3qY78whRoPdfOU/jnlm9Vu0+VmOWNSL1HaIBaY=;
 b=dhX4bvoGT8bAawh54Tns/naObv19Rb+3zKll2lNJ442drZEyUN6RjoCnCzU+CZu3wO
 WOsDrlGVJxP7Bsv+isxWY78cw7pLjQRTkna4QI5SXs0HdcC0zkVTTe5Xpe3D0l1d69ha
 FACz+HN1+a0aQmUP9ZrYKP82YLWVXN1m/xBgq+JImyV6/ego6G03U4nQ75hkIvK1fcfz
 5Vd7LCtEs9UsgdqB2QKxw9woXw0JIdWyI+ePeMOs8M0Cs82CpuzUFVPg0FNx8k3PCIJa
 zNsGUdHlHsqYDOr1EhFCVEoRiF4HyY2LJ5RpplNkX0LPtQ/tWtGZ1SzrW3oN/XhqxAtk
 tQXw==
X-Gm-Message-State: AOAM530SieDVFmijr2xh4YFJTdRRB+5bP0mrAPf3xkoVgihgNJJQ8k8z
 3TFjecw0lutCV9jqdvttziL9g2GpZe5zdt3cyl7Je/ji9xShE+wPWOYwpDEDmY1k1RergWA5JvT
 s2hxvqSdTBFKokEI=
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr1017678wmg.68.1604369262171; 
 Mon, 02 Nov 2020 18:07:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz450qaEXBid9Vp8M8JguvttfT2sSjp/RpJ8d68k3Znh00PpBSFmmEbKwWxsNsWH3KJKRcZJA==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr1017655wmg.68.1604369261850; 
 Mon, 02 Nov 2020 18:07:41 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n4sm1270710wmi.32.2020.11.02.18.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 18:07:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 1/7] util/vfio-helpers: Improve reporting
 unsupported IOMMU type
Date: Tue,  3 Nov 2020 03:07:27 +0100
Message-Id: <20201103020733.2303148-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103020733.2303148-1-philmd@redhat.com>
References: <20201103020733.2303148-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:36
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


