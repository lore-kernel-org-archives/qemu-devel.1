Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76559C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B0320767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecazPpGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B0320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoN7-0001Mp-U3
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLh-0007p8-ML
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52777
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLe-0007nM-6H
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbGtgnVOqvqBbChkwfkGif/qNdiRkoX+i++pJMa/DR4=;
 b=ecazPpGyQZtVLbEJTTjXPKxk4HWQVeGH+3FDCtr60v0wtzLzkymMwk0as/scWQ8+pbnO+J
 MjNAO54HpI6VKWx5UAQXE3Mw2IJ8yY6pCDkyp+4a5SGWThWjTr2AM194qU/ip1uorW53GS
 ygaLmE+yg78dHxVd4KprMsRqHYiK5Vs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-FwVYTQRnMxedOE4gIZlJjg-1; Thu, 03 Sep 2020 08:28:11 -0400
X-MC-Unique: FwVYTQRnMxedOE4gIZlJjg-1
Received: by mail-wm1-f69.google.com with SMTP id c186so909071wmd.9
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UbGtgnVOqvqBbChkwfkGif/qNdiRkoX+i++pJMa/DR4=;
 b=er8EvkK7yWNLDkM+k5IMf7XCo2PJF+CgvgQzZGpOu7u5t+YEaoq6ofcPTzDPNj0FVp
 ml+7WBHD6GOOcmVSuRT4MCjembOfE8zqiEcqJgf7Az4splRm86wYyDu+AoLr6pHdVfBm
 XzH4T+A+Bxrk82NSvIPLRviaidbm/VoSbxZ1C6ziGkOHfwIW20Wwh6OP23VE/L8tJm57
 VkTD24USCgWZ5WVIUVmdRh9k3WehiLYPJPS9RF65/bWSQrM0IFQQKtgjE8agNDory/3u
 PbE1RYbp1Qcllsiglu31Wdki4zALNjWYgedMdFjI3VOOIM4CuwqhhcyoBe4uDl1CnnsA
 nkzg==
X-Gm-Message-State: AOAM5335oFYYIFChi1k4+RLIF/bkYwmwtHmtYGo3JgF9syQtGV3xGHgl
 1dLbpyNZytCwGIhk3wCo1B/cVfE12tupUYtQNAnoruthQqHfAnhv/utzZjLO+3iq+K5nG25rivw
 8SAt8y2MLgEkf7FA=
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr2132447wrn.47.1599136090375; 
 Thu, 03 Sep 2020 05:28:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmAljjZHGAQ3AKo5HHF65v5jXYKT3hQud4OSbkqsAy81mlP2ECJDa0ubrTbZ4mQU+X85Obrg==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr2132430wrn.47.1599136090222; 
 Thu, 03 Sep 2020 05:28:10 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id l21sm4112872wmj.25.2020.09.03.05.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 01/15] block/nvme: Replace magic value by SCALE_MS
 definition
Date: Thu,  3 Sep 2020 14:27:49 +0200
Message-Id: <20200903122803.405265-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit SCALE_MS definition instead of magic value.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 05485fdd118..a2b006be56d 100644
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


