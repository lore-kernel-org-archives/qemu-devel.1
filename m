Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AF3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EC8206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5vjhlRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EC8206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWyt-0004GH-C6
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvc-0007ds-8j
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:48:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWva-0000uK-Ow
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n++iKDu2XPmmW15plWQ8LpzZ4HXc4YUB4AbgsZmqpcg=;
 b=K5vjhlRUrVBKEVBssn5/OawdnaxMgtGwe8H2jHzGjOUuGLXWcOvAjqyXJ6eMNqMVkSwVkD
 SuR6QqnzbzBOoGegmGhAQzZ+hlazx68EZn5JQ0GFZB38oeAsDZhhVKOlPy1ZcxFSTlYT8X
 Bd2n0mOujnb1YwK59ikYcUvcyi/Ai6Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-Flv67x9iMY6eBNKeH7XmyA-1; Thu, 25 Jun 2020 14:48:46 -0400
X-MC-Unique: Flv67x9iMY6eBNKeH7XmyA-1
Received: by mail-wm1-f72.google.com with SMTP id t18so7977293wmj.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n++iKDu2XPmmW15plWQ8LpzZ4HXc4YUB4AbgsZmqpcg=;
 b=I1vrV5Ita2twDXpY4ImWdcgfDJSH/I05kDcRQV2IwbTGwzzwX8wzrwbBIw2767g0jy
 5Lly2kTLG87HZ0TIFkXyHE3/cn69CLOnYMBXmz5sCfFx5sMZwMZky2Hii0a4UufzEILQ
 3HYEg7pDWTfYbTeuVbzexgF57t1W3FBzuVGLyMzkKpjR4TXeSHNZxAnHjp8DWvZwLRon
 lsmKk8iBV3K2cfNlkhawfc4RMD3sSws4JDZRfChGiatAgB9QGHLwo/a/tFycDk8x46wz
 9gZyjt9uvCGnEeEmj7wfXP1SKyMWkqeXEf0Ei7/xDxRCbWbIVcXYbDVR6RpSLjKWHmVm
 06RA==
X-Gm-Message-State: AOAM530HMSf2qMwjfz4NzjiDlDB1sqPD7elziGoHfX4LochBLOUelWPp
 mRtgw0RT1JNjNTSO2X96wZy4MQaQJq1+WJbVc3VQi4w94clB/9a6Awzl/VCmnKf4vK/QxH61mJo
 HHfH6ZJCy3lWcwUk=
X-Received: by 2002:a1c:c908:: with SMTP id f8mr4952654wmb.150.1593110925476; 
 Thu, 25 Jun 2020 11:48:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzUPqhXLHIH7O2Xge4yU5cRPBuBUGfQvd8msCxd589G/0uY0Tj9oZBm+7cKPCrmrGd5VwQeQ==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr4952634wmb.150.1593110925222; 
 Thu, 25 Jun 2020 11:48:45 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c17sm11192390wmd.10.2020.06.25.11.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:48:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 01/17] block/nvme: Avoid further processing if trace event not
 enabled
Date: Thu, 25 Jun 2020 20:48:22 +0200
Message-Id: <20200625184838.28172-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid further processing if TRACE_NVME_SUBMIT_COMMAND_RAW is
not enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index eb2f54dd9d..1e5b40f61c 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -367,6 +367,9 @@ static void nvme_trace_command(const NvmeCmd *cmd)
 {
     int i;
 
+    if (!trace_event_get_state_backends(TRACE_NVME_SUBMIT_COMMAND_RAW)) {
+        return;
+    }
     for (i = 0; i < 8; ++i) {
         uint8_t *cmdp = (uint8_t *)cmd + i * 8;
         trace_nvme_submit_command_raw(cmdp[0], cmdp[1], cmdp[2], cmdp[3],
-- 
2.21.3


