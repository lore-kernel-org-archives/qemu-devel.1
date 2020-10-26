Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497ABC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81A6222EA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePl2R3Kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81A6222EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0F0-0005Mw-QP
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0A6-0007IH-04
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0A3-0008FL-7h
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v40hj3qY78whRoPdfOU/jnlm9Vu0+VmOWNSL1HaIBaY=;
 b=ePl2R3KqIeerkAl03ElWG+flDa7PG2vR7mg82IH0nxOyyJGFEWJtfsDnz4JsVH3JYDtvll
 hnASa1rbaodVbmIKzNmfSlHqXGswWCQ+vW7MUXQQ0CcB/dlB6ylo+Nfb6O6XTaV0FlNsm4
 XompFkGHDlZH+GEDIyTvaTEi0UikUjo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-1inJM73QO7-XfztiREmXUQ-1; Mon, 26 Oct 2020 06:55:32 -0400
X-MC-Unique: 1inJM73QO7-XfztiREmXUQ-1
Received: by mail-wr1-f71.google.com with SMTP id 33so8153739wrf.22
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v40hj3qY78whRoPdfOU/jnlm9Vu0+VmOWNSL1HaIBaY=;
 b=UTevnFfWcMV7U6bRBrqDjLVX0GJ0KmkHzHhw3rj22cXNfv+juoqY7+6KpH60dlMC7c
 oHHg4KFLyAjq6mzwidDujQ06uEI9Cbwg6StvoVUmdEosXvBxemgJPAgpi/1pbVRFHFPp
 2cqHhHRBDdjVBtsIP1l4ybyYKp4VZuZsT0V0UjBITbCjAh54V9AZ9d8c4e6g7eu1F9By
 xiwiGmK5ygljC9JCoDFxh7FE70EtcnmeDKgRJoS7JBEVSjn43ULFpYSY3TYUtqofW88G
 m6o9hjZcBNIM1HFeW8yIKLFSTauMJFPsWaM+mRSIpUgo1RrLSVRpPNJNXc4DQTUXlRE5
 k3eA==
X-Gm-Message-State: AOAM532NpIB4RbCHGXLpEDjp/1Mbaeoy2nj0gQvnK6gxewtiWR/Zb9je
 tMg5OdFpZTGhGjeEW+1lvmN1IjIdjhPqCrtryVpPsyae346+UFoF/nKw292lfZv7iYtPZFCQ/L4
 3Ig4CfgC1ltU0ZYc=
X-Received: by 2002:adf:b787:: with SMTP id s7mr18080753wre.390.1603709731141; 
 Mon, 26 Oct 2020 03:55:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxArnquS83MoKMOGB9wkQvP/rs0d4NxPjydeloJhB2Mh9ZkwP/gL2SCIvEIBjtZbOso4aloNw==
X-Received: by 2002:adf:b787:: with SMTP id s7mr18080737wre.390.1603709730967; 
 Mon, 26 Oct 2020 03:55:30 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v19sm18878384wmj.31.2020.10.26.03.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/19] util/vfio-helpers: Improve reporting unsupported
 IOMMU type
Date: Mon, 26 Oct 2020 11:54:50 +0100
Message-Id: <20201026105504.4023620-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


