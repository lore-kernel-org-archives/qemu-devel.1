Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F82C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE8720CC7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4mX5ztx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE8720CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrpnf-0007Wm-HF
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpkW-00024c-Ru
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpkU-0003sx-BT
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkqdCy476re75wjyst3nMLbIFP1njQZj90UgXgmJOZc=;
 b=T4mX5ztxGBAWy4Ve8WNnEWfzjrQ2KbyA/OjoQc3kfnFKSzxDPUB8BEzqkqe3qbcY0E1Vyi
 p2PPYy2lzBCclaiIvgV/08LEpUW96fpNOiMjwPTEwYkxeLxuKdh1g526+3yO08vkzwj3MX
 VL6FabfrOcmh5AsOd08E5twYqYAf4GU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-wXMdoBshMpWg0juncB4aKg-1; Sat, 04 Jul 2020 17:31:00 -0400
X-MC-Unique: wXMdoBshMpWg0juncB4aKg-1
Received: by mail-wm1-f71.google.com with SMTP id t18so40756282wmj.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XkqdCy476re75wjyst3nMLbIFP1njQZj90UgXgmJOZc=;
 b=tnvIOVGfnrglXswXVRAAC9Q8veY42DRgL503/KbHFIy6MqvTQbh5dNZuO/ZiJm0rqa
 67Cn8DqnrTB3p6DPzF3K7Xj16YU8jvqoV8orAqZ5/qcSfUtSbkQpExJyp3JjGjLsCqVM
 Cf4TSQk5kZqS8HaWU3+FKf2FmFPUMZc3/xAxSydraNQ5L9k2Qt1fpSLCZMg0LVLNSbP0
 h4QmgCCCuzUlDaWWYKGj0bZJ6DFPJEJlLDzsJM4QWPHgTDycEIxFs17DeFWh0EnpVJzw
 sJGKNaD88H3U94nDw9mfz7Bs/WAAXPk7fPGQgaeglz/X3Ye9J70JgAtTKB5A8wAPBw7S
 fC3Q==
X-Gm-Message-State: AOAM530Sqsm8qAR/Muh4kHZWDCTXZ78qvj80Frnzfn1m3KvTuofPSaj6
 ho1DhZQMxnQPy3NdJJxol35WRnDFs2oquSzeennLvU4ijAjWJehNbgNWLobn2z8tzmqooTZwR7t
 BsabmIs8roUp8wyc=
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr43284360wrt.5.1593898258784; 
 Sat, 04 Jul 2020 14:30:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfwWt1fjUku4LRRK7AY6ZXQ2wQ8vRyQodplhGmCIRNNFqfGpKJiO0omWy3PTU2j4Iu1mpSlg==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr43284347wrt.5.1593898258605; 
 Sat, 04 Jul 2020 14:30:58 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g195sm17732913wme.38.2020.07.04.14.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:30:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 01/16] block/nvme: Replace magic value by SCALE_MS
 definition
Date: Sat,  4 Jul 2020 23:30:36 +0200
Message-Id: <20200704213051.19749-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704213051.19749-1-philmd@redhat.com>
References: <20200704213051.19749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:28:03
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit SCALE_MS definition instead of magic value.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 374e268915..2f5e3c2adf 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -715,7 +715,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     /* Reset device to get a clean state. */
     s->regs->cc = cpu_to_le32(le32_to_cpu(s->regs->cc) & 0xFE);
     /* Wait for CSTS.RDY = 0. */
-    deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * 1000000ULL;
+    deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
     while (le32_to_cpu(s->regs->csts) & 0x1) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
-- 
2.21.3


