Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D9DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326BD206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUqWCk1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326BD206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLin-0007px-NJ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhL-000627-7N
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:13:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhG-0005W9-Bq
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593544413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSpxL68KI0zjY+P0ZTv/agflMQHnncdM/JAB05rWw4M=;
 b=MUqWCk1fAyLdZ4ENaxkf+eA6qC71is5wdgHnB8QYlZB5gxj9r0EEglts62rZzXw6EWVvkw
 L37PObXtcrZN/E+rHkNp0V/ZszzX7h6l+anppx9eME3NTY/3HYNLkDWfxHpG1MrWZ9UF1s
 gU4E/bLKPy+1PxSzuDqwAtMAnB6mt50=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-05q7PtuFPqapqQmFngKUMg-1; Tue, 30 Jun 2020 15:13:32 -0400
X-MC-Unique: 05q7PtuFPqapqQmFngKUMg-1
Received: by mail-wm1-f69.google.com with SMTP id v24so21394945wmh.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sSpxL68KI0zjY+P0ZTv/agflMQHnncdM/JAB05rWw4M=;
 b=I4A7GyUboRGiJqRTK3XVrqLDNMaO32KJiByLmcROvHpK/ZtW8Vvyh/YpcNOmGgd8H9
 86qAG/rBnVrEHnrPiGlv6UGF34tffdBbbhmUrtHd9KUQqSGhL7ed420r5r8AZ4nyNrUu
 bXM/7VtANPcYv/0g3ig25RxpLXNln0QtwUFtpAebEdQ/PpLO8draOqw253jASDIy3n5Y
 e0aZgd/WPb7skQmRHIEgTJtvMngCqu9DaYBacruA0Se7b1clRnacRZQKFf09F7zFwINq
 oWBDA/2S9nDpna7YXuoUDuzDopSKRzYi4L7YYkI6/uKo0uQqwZQwSXTrSGL7216nOrcG
 HoTg==
X-Gm-Message-State: AOAM532pg1dUxhmIu1+ppBZW3Ett0BWtl4mI9mrQbI9TSN5yBIRWt4JY
 xzxn1UVaIZ3VfbCUe33p1+mqFA43f7vcTAlIqHvN7NBZ3doiejpF68qU2npAa2XtMPXjMNFO+Q5
 DXumdegVqTI1GESU=
X-Received: by 2002:a1c:2602:: with SMTP id m2mr23955274wmm.50.1593544410828; 
 Tue, 30 Jun 2020 12:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLyipKg//WKrV8o5D+oPIV/Utzm3hTol8MMrTlA3AQVAJTLZ+Tx5dgMEDayArhX8VC+GGiLw==
X-Received: by 2002:a1c:2602:: with SMTP id m2mr23955260wmm.50.1593544410661; 
 Tue, 30 Jun 2020 12:13:30 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c6sm4670385wma.15.2020.06.30.12.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:13:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/12] block/nvme: Avoid further processing if trace event
 not enabled
Date: Tue, 30 Jun 2020 21:13:08 +0200
Message-Id: <20200630191318.30021-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630191318.30021-1-philmd@redhat.com>
References: <20200630191318.30021-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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

Avoid further processing if TRACE_NVME_SUBMIT_COMMAND_RAW is
not enabled. This is an untested intend of performance optimization.

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


