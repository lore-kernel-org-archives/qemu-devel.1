Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E18C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2AB206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5iY2+vM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2AB206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjP8-0004op-B7
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBj-0004rQ-JK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBe-00010m-1m
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KZ4OlirG8Onm3Jtad3QpAqRCwzSXUh6XNOAp0g51qc0=;
 b=H5iY2+vMz8MdTP9DgrQlFbZkOYhQMCyfUaetbIZoX5Ys46u5lXBggPP1MFUUriyehXPzt6
 NLg3x0HJHNYGZu/MJ0DU8k1jqU0uYpa6LWhFjPdTSx8/9FZvhA3iyeRdkiZCsZRGaBoFmZ
 gXAJCAp5Nexl/qdbs0IHX6OsovrV1WM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-Np-ec252MMu3jGWljjzqjw-1; Wed, 14 Oct 2020 11:59:31 -0400
X-MC-Unique: Np-ec252MMu3jGWljjzqjw-1
Received: by mail-wm1-f69.google.com with SMTP id c204so5047wmd.5
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KZ4OlirG8Onm3Jtad3QpAqRCwzSXUh6XNOAp0g51qc0=;
 b=tX902X0pplUbv7flIuNAx8p6Aff87biXWdHe5uD12saHHFuI3+jKzcUyMLHif1iGbw
 BC/80Z2wtqlxUne/vHv8/qEASS4rdNCh8wcg/Zgjhap4c32uiMkxduY+PRtAHIBMi409
 WVb/2PtDS7q/3NUuwMWc1d7CC7K3Aloci085Hw5PY6MZo3/oXAXfkx5q5To/yYNISgKO
 xIzGcwmjOFnhIKbK467EeroeonHjpVvc2Lb656Zw2O5Ude+N6oRvn1/QO0T5T3gmJ4Ia
 mUpMxxjqveZ0XfQ0aFwn/BH7lm22aWc9uhFBK3N4HWKgn7vq+Avo0c3HYNHW7ftMX/r4
 /7lg==
X-Gm-Message-State: AOAM531hSPxx6mu3wmOhg26UpegD9vncEpT+Cl9AixMfwslbL4QgsVP4
 S1zjRDVk/sRKBIBsfjc79koYDpen56HhFvLLi4YKh0Dmsj9iwxo05Ai0amNPssd9YqAnnfDPJDe
 vJjE+5GuIpGeBVkw=
X-Received: by 2002:adf:9f4c:: with SMTP id f12mr6361134wrg.108.1602691168524; 
 Wed, 14 Oct 2020 08:59:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybi0k9qApaltJAIu/BtwQS/Z0EvcXNsTFDkcNMzR1Vy3U0q1Sh3SKLC4zJMrL/O8U3mbbmXA==
X-Received: by 2002:adf:9f4c:: with SMTP id f12mr6361115wrg.108.1602691168296; 
 Wed, 14 Oct 2020 08:59:28 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 88sm5873022wrl.76.2020.10.14.08.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:59:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/15] block/nvme: Set request_alignment at initialization
Date: Wed, 14 Oct 2020 17:58:10 +0200
Message-Id: <20201014155810.102841-16-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014155810.102841-1-philmd@redhat.com>
References: <20201014155810.102841-1-philmd@redhat.com>
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When introducing this driver in commit bdd6a90a9e5
("block: Add VFIO based NVMe driver") we correctly
set the request_alignment in nvme_refresh_limits()
but forgot to set it at initialization. Do it now.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nvme.c b/block/nvme.c
index 4d2b7fdf4f4..04608b49f56 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -745,6 +745,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     s->page_size = MAX(4096, 1 << NVME_CAP_MPSMIN(cap));
     s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
     bs->bl.opt_mem_alignment = s->page_size;
+    bs->bl.request_alignment = s->page_size;
     timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
 
     /* Reset device to get a clean state. */
-- 
2.26.2


