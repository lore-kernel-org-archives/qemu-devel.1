Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596EAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157F02072D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoRZjnJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157F02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nv2-000489-5n
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nuE-0002fT-L6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nuD-0006A4-1u
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHEDYeSrjvvdM00HU33Jyl9/4zi6c/EmJ9icWxpRyDY=;
 b=AoRZjnJ0urMnf8AXnnBwIIjjC1GqLgLQqSoyivcyEf4hwNGx6xXKL3J0uJ1CCtOwb3qoMu
 fQgkjUjC/nFlMYIUIt0ZqNNpboPK7iXI6+9Cja+SJ0FzFQXqlerXpuxgGMbma2xlKcxBGz
 rDYVDwMSzm/lGnfjUpLHLIqRHLUaKEY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-2wEAvMIbM82AEPYnC3vkGg-1; Thu, 20 Aug 2020 12:59:10 -0400
X-MC-Unique: 2wEAvMIbM82AEPYnC3vkGg-1
Received: by mail-wm1-f69.google.com with SMTP id z10so995213wmi.8
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rHEDYeSrjvvdM00HU33Jyl9/4zi6c/EmJ9icWxpRyDY=;
 b=oM1cvfZE9bjvJ/RpVo3K0aG0p6w6D7ofIc2YNl0mFKDXO0uf1voAA3IqPMt0TBLX5w
 b8R1brTxzBMP7H9VZzQEj2ZMn9w4OgMKoHDqQUUJ7Z+3Eds2HdIhtMM7fG/rIEoRyJYn
 6G8+C7yYLDdhwVCbFUg5Ty+h5yLq5EG7mUni6i3HgaGDLrZfunf/25RhsDELapOf7ZoH
 wO575ZpgP+v03ei+HYUCW0w+AHCE4FaTTYFE9ZmSOaSC9CHSl9CzRPHxpwPyZVvSu+jo
 1NDS8CKFqcwqo19WI9zPmO/pAj9fFCHkXtPgwXRzbuzXbwWTR/Uwn36ubQX5odyps2jq
 wgqw==
X-Gm-Message-State: AOAM533jS1DgmRoaq9TtgLZcDcq90VRAHMZgtNVP0yDu/RoV6Ec4pPKt
 KoIENBRihfy1HJplGvIjI1ZkWg/QMI7ed6Eae0Rv859r5FCgGqyceIxAnR3jTEnkPg4He+7C9LV
 Y8J8DmTQnvJ8d308=
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr4311870wmj.124.1597942749095; 
 Thu, 20 Aug 2020 09:59:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ1+7nSnEuUcdp2mGQLt76o7rxF/UHkHpx7JEeHP81SvccPF8tsRDQtgOGenvWRH+SuFP1Cw==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr4311850wmj.124.1597942748903; 
 Thu, 20 Aug 2020 09:59:08 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id n5sm4967691wrx.22.2020.08.20.09.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 09:59:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/15] block/nvme: Replace magic value by SCALE_MS
 definition
Date: Thu, 20 Aug 2020 18:58:47 +0200
Message-Id: <20200820165901.1139109-2-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 08:28:03
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

Use self-explicit SCALE_MS definition instead of magic value.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 374e2689157..2f5e3c2adfa 100644
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
2.26.2


