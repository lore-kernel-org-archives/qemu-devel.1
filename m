Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F8C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96FF207DE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrGTr2yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96FF207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFhyy-0005Cu-Sv
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFhyF-0004HB-Uf
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFhyE-0004tw-Cm
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599588233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ys5iI2rugUeM4Q6hyE8pePXf/XviYW8aVvJSLc6fkdk=;
 b=CrGTr2yQL75NvQDWX44IIko3ph6bHvK9/7lvJu64mPCUrwEJv16hDHrnzxjKoi6n2gDkRi
 lCLo1r+b9gz3kmUvpYy6P0kudPgwB4IoXp34UkwS7cNsbx7epIm/42lJCErs/oX2GtQm9g
 GWIa4BTEmZ39M6JOaELmt+KFawuzLPk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-oHsNojcwNCWHJwYBnXad7g-1; Tue, 08 Sep 2020 14:03:52 -0400
X-MC-Unique: oHsNojcwNCWHJwYBnXad7g-1
Received: by mail-wr1-f70.google.com with SMTP id j7so5625359wro.14
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ys5iI2rugUeM4Q6hyE8pePXf/XviYW8aVvJSLc6fkdk=;
 b=OR9ZnYn0do2xOasEAwZlJYbcsRuK6xX/nZqEN7HB+HnbQpuEp+8JkV7m1GhyhPFo+j
 1njzK3OLqsD+NUwnlrON4lzbBUY3ym4E6mGcsiuYBati1DPCXTc5n2TX3fqw8N7O41ZF
 6bUuBC7OflIq4NuJQORY+I/3TCwgqVhRcK+GwkLQx+QQAp3LdWmfSppYUjh537PqQcy8
 N9WYtWaCz6Gl8SC1nEyRHlJ2FnsQpRQS/A2XIX0J9cL53AVjnkDQyKd7mpW3FxLnYlsB
 M666O/TZm5rvn794GeaBVUUKtZPlCYfuQtvwAGGf0yXXBYc6aIXzzkhKk1zHfiMZUZuW
 HUbw==
X-Gm-Message-State: AOAM533hFs4ROiQ0Sx81J2ImriMBuf5rDgImhf7AcXyXp/R060G5ognp
 0Dx52CG/4fA1juNsFBxTFST+7/S1MPTV+U/5JvIpzGhSGQYKP/JE07xgu5ZCLyR2Qc0oj+nI9wm
 DuzbsvWOyzZnWKQE=
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr308310wme.140.1599588230960; 
 Tue, 08 Sep 2020 11:03:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw90McKws2WAqrdoNB0r14Xlw+wZxzcwWaX26dJFeUwAFfGGYNDo7xd8jcCrNYLJShDqqrysg==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr308278wme.140.1599588230617; 
 Tue, 08 Sep 2020 11:03:50 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o128sm188701wmo.39.2020.09.08.11.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:03:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v5 1/4] util/vfio-helpers: Improve reporting unsupported
 IOMMU type
Date: Tue,  8 Sep 2020 20:03:39 +0200
Message-Id: <20200908180342.280749-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908180342.280749-1-philmd@redhat.com>
References: <20200908180342.280749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
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
index 583bdfb36fc..55b4107ce69 100644
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


