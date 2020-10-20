Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF1C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A262222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpHj5u5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A262222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvPS-0000ds-FY
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNU-000661-Dj
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNI-0007t6-BD
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4W8kZsSKWJcjh8HqyDoLc1LkrTctt68co791MXFzTk8=;
 b=NpHj5u5nzFmogoDmzMfDX1XZGeVGgZgUvCEl3u9lUsol6cxNb63n6h/3xeDDz5xOe3Tj7E
 fcmrsVOwFmqKa3Sk+SOHGaEg4gLGS1JliHSQZHFFKolwXeBXpyBw1XWCwdJYAxpvKH9hz0
 KrpUKtUunGPoPm2i1EByHfJ5GZCd6Qo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-I9rNd_PFOt2U18-NRSigeQ-1; Tue, 20 Oct 2020 13:24:37 -0400
X-MC-Unique: I9rNd_PFOt2U18-NRSigeQ-1
Received: by mail-wm1-f69.google.com with SMTP id w23so629563wmi.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4W8kZsSKWJcjh8HqyDoLc1LkrTctt68co791MXFzTk8=;
 b=naIiiN9JB42wHinG6c7c16nkaXk1z9trCx7NunV+zqpHi65dV1ogQoGIpFCnD/FFQR
 eCuN2k1ePnp7PwHLw1Clc+2jpSQ30hrnPXrjyXrLp7FkeSFezx1R6i3UnNKVzJJ8ypZG
 KzK9F8SD1LPNGKCN38M9j6hhT95vsUj0Een582FtYxgZ3y02ortlE3drSKVAVuu3w+GZ
 Sr179y+Le1EKaqgh87vTI8rAjm77k+MHVPIP19VaIJSTVuOSnSeHxOEkLGRywnr/bb/z
 lJ2fhtReqZ2SHjnftJvbJ2Uz5Pjfxbpn2ya20O2XTir0/oR51d25fhEvEmpYhTHX9rfX
 tzRA==
X-Gm-Message-State: AOAM532PEs6hsrbMaoziJ76inp3cpw9hc/HYPucQ1RQINEoWEL/zGIbJ
 Q78sgx9I7fpfs7GwiAfIQY4kLFqYXKCRJ48/raexyiASYVYU6qP30zi0H5gcHI2DVp9diOHDi/8
 j/X2RPxyIqQa8tLY=
X-Received: by 2002:adf:f305:: with SMTP id i5mr4694389wro.346.1603214676003; 
 Tue, 20 Oct 2020 10:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5IauIUEXQk0ERMzuRpB8broMsmB1ex+OysnPFWe959gKhHsJWl3VqAf44vKZAZweBHakFAQ==
X-Received: by 2002:adf:f305:: with SMTP id i5mr4694358wro.346.1603214675825; 
 Tue, 20 Oct 2020 10:24:35 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p11sm3940667wrm.44.2020.10.20.10.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:24:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/16] block/nvme: Correct minimum device page size
Date: Tue, 20 Oct 2020 19:24:13 +0200
Message-Id: <20201020172428.2220726-2-philmd@redhat.com>
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
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While trying to simplify the code using a macro, we forgot
the 12-bit shift... Correct that.

Fixes: fad1eb68862 ("block/nvme: Use register definitions from 'block/nvme.h'")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index b48f6f25881..029694975b9 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -724,7 +724,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         goto out;
     }
 
-    s->page_size = MAX(4096, 1 << NVME_CAP_MPSMIN(cap));
+    s->page_size = MAX(4096, 1u << (12 + NVME_CAP_MPSMIN(cap)));
     s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
     bs->bl.opt_mem_alignment = s->page_size;
     timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
-- 
2.26.2


