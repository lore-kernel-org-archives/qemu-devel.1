Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C9A2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gICMijik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C9A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nvE-0004a0-E4
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nuL-0002rj-9Q
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nuI-0006Bk-CW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=969biaX/G7f1D/6G5QoxlHmmKW8KQsbMUTT5iH7LPeo=;
 b=gICMijik9Gxjerw5fl0/huO5++3bfxnwVN+PjvZbJ+8dkEtNNXvs9F8dK9K2chYucZdOCr
 G53QPLm7UmQVVthRRLse+BQfbspeS5gP5lZ4E8kmQWg0IOab9LlBLVO1CJtqA94xBWZqM8
 BZmey4zfjxu6zgPerLeRP668F57aIlY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-aFmcf4dPNzSxntWvncaNCw-1; Thu, 20 Aug 2020 12:59:16 -0400
X-MC-Unique: aFmcf4dPNzSxntWvncaNCw-1
Received: by mail-wr1-f70.google.com with SMTP id b13so858856wrq.19
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=969biaX/G7f1D/6G5QoxlHmmKW8KQsbMUTT5iH7LPeo=;
 b=AqiLG3Hy12dJywZ//3v06umtJq+fW/VMvNTjzVssS3PrP5yss16PgNo3rknzSsR5hs
 H6NSY/Wu7VUADtSRXIHmJkEQKqdVf+JpZjrJWD6ieAzZ9gyiV3kU8D7UgoBbycs/0Gaj
 K3w81ZqgnJ164f+mwWQs+XgssZ9csPvHrHpSwc+EaSqsHcUg5rt8knIA0rOPuJR0Yfj7
 +/zD3T7nuQnXZZvlXjYwTn0jjDffXg7DfM3O5CsYdHC9kHxRr2/dHHpVo2JmFsLEwpwd
 dvqBR62WlzkNXen5LvDqquhd/U0m7SCiF/1ndyicT1t8abMz1i/YNKx5HvCTnZe89jbb
 nu7w==
X-Gm-Message-State: AOAM530yeMXEWpQrTQEPBwiDfYG0Q+G1itEO4HAkXonzWl9SkxUFw/RR
 zyFo/5yBSQTpEPgk75VJGtz9mOpY1HO2aVKwgEyTiVbf04Ypi2dPIvS2M8vIZvOwCJ7CvT6r4l7
 ZC9gGU5DcAYyf+64=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr4527093wmh.144.1597942754949; 
 Thu, 20 Aug 2020 09:59:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpAZRQsucfAlWmgf3Z92nfj1GPVqihI5RimRNPIm7nB2a2UeIIZIehaKoQs0Jjx0Ang7SPdw==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr4527082wmh.144.1597942754736; 
 Thu, 20 Aug 2020 09:59:14 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g70sm5873153wmg.24.2020.08.20.09.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 09:59:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/15] block/nvme: Avoid further processing if trace event
 not enabled
Date: Thu, 20 Aug 2020 18:58:48 +0200
Message-Id: <20200820165901.1139109-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820165901.1139109-1-philmd@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Avoid further processing if TRACE_NVME_SUBMIT_COMMAND_RAW is
not enabled. This is an untested intend of performance optimization.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 2f5e3c2adfa..8c30a5fee28 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -441,6 +441,9 @@ static void nvme_trace_command(const NvmeCmd *cmd)
 {
     int i;
 
+    if (!trace_event_get_state_backends(TRACE_NVME_SUBMIT_COMMAND_RAW)) {
+        return;
+    }
     for (i = 0; i < 8; ++i) {
         uint8_t *cmdp = (uint8_t *)cmd + i * 8;
         trace_nvme_submit_command_raw(cmdp[0], cmdp[1], cmdp[2], cmdp[3],
-- 
2.26.2


