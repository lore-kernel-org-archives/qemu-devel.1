Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011C3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1B220774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4rXS5Zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1B220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vqj-0001j0-QK
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpb-00082P-EY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49816
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpZ-0004X9-VQ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZH4WbM9lDKriwvJR5iWPBD2dYg3ljxsK8g2n7Z4PXs=;
 b=c4rXS5ZlM2e31IGgaRtH/NKlk5C0nbWzxrK7I6gx4KWrTN7ytHkzDbVqkkE4wGnHOCKlsq
 elR25hlEpW1yUtH9rzwLj9vhgwoTO4lHJYWwXFpS2mELZR3Nb6XKvfr/F4GQndPK9neKov
 Q3SWrIlWEZ/RM58WdyQYq5mMBjYazg4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-ZTgcM46QNN2brc5Yuv2d7A-1; Wed, 12 Aug 2020 14:50:31 -0400
X-MC-Unique: ZTgcM46QNN2brc5Yuv2d7A-1
Received: by mail-wr1-f71.google.com with SMTP id z1so1211094wrn.18
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HZH4WbM9lDKriwvJR5iWPBD2dYg3ljxsK8g2n7Z4PXs=;
 b=DyljpD5G/oKERWP10yLZSm+IhP3J9eQ79jEVR+5DRYk1qOW7VaNwlI/ikx/q787B7n
 sNWUtGkt2JRJwOAIv6HpeW/J7DuD8gE0a9cM2UFfHSLsuOdp8s1RNg6tvgwKQC32R9ch
 t5xiWUszXq7swIR8dgwEgB7woqHop/QuabakmyKUXXiO0dF+ES8sj21kjRH9dq2bKppa
 3xEh9jQEfc3+8L7fv3nLf010hv6tUA2P+aRPhVmuFUzdLcnVeCtY4/PI1WnAG6jauSZ3
 m3Qik2RFLssBow6TBY6iPTWhrq1zM1g70y7ZjrgtR9xaPQu1i+wvh8bZrckAiqbGp0aW
 V8PA==
X-Gm-Message-State: AOAM531Tq8t2Xv5rkl6gKQdvfrl/WYcstgEqrmX8ZsNQ30d6rMxsHFjs
 GVflEjV7s+X+AxdHxuWQfZsb9/JX5te7PCoLDmSE1K4hzRwoKpgu9lt4RSRG1n0d9rl+sjSUI+4
 Y9mEus/+/MWy1lhA=
X-Received: by 2002:a1c:c1:: with SMTP id 184mr976568wma.105.1597258229422;
 Wed, 12 Aug 2020 11:50:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9P2Trtaws4EeZ6vdxHEsS2TCAwMxZMIbIEFs111t5TvegeukN0kbeV2dtdy21GPlrVGDaAQ==
X-Received: by 2002:a1c:c1:: with SMTP id 184mr976556wma.105.1597258229261;
 Wed, 12 Aug 2020 11:50:29 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m20sm14523159wmc.1.2020.08.12.11.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:50:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/14] block/nvme: Avoid further processing if trace event
 not enabled
Date: Wed, 12 Aug 2020 20:50:02 +0200
Message-Id: <20200812185014.18267-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812185014.18267-1-philmd@redhat.com>
References: <20200812185014.18267-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
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
index 2f5e3c2adf..8c30a5fee2 100644
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
2.21.3


