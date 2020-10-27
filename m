Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCCDC55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D69A22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqJEUmTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D69A22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPdB-0005Oa-4A
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPT3-0003Gq-S4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSv-0004Jt-CF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+ZJ92q9c8sHM7tIK104/2szOIvYpUY13gacvPM2KaM=;
 b=fqJEUmTF5RetYB704NJwudyDuCaZ8KYaHVwABTtMog4kowKqfqDcWHcLFCP7FbwQ+mKn6r
 6wrfRQQ/M03z1Jbilq2yq4QbPGgzPEkfGBJqGFrmjx5dX4f7Ql/cY6rykcwUZiVWjKP5CY
 faDKqmxOdv1CyTx1UHPu5xhv6AsNRQY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-e_RJLRwyMiO1DeYQQUqdAA-1; Tue, 27 Oct 2020 09:56:36 -0400
X-MC-Unique: e_RJLRwyMiO1DeYQQUqdAA-1
Received: by mail-ed1-f70.google.com with SMTP id cb27so708703edb.11
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H+ZJ92q9c8sHM7tIK104/2szOIvYpUY13gacvPM2KaM=;
 b=NlogwzKUb+82llUUug5liD8i724jN10kD5XC1zeDB8YQ++pJ8ndBu7JMn54KPwChco
 /Gnp5KIX26PGweAJdC3wstDSB+Kz1xShDZ4EuhFYKz7nsXaEH929FWl9Y9HMjIwO5Qp0
 NPz90+eyQluAFmjx16mWFBkC5L9zOFCYYTA6lH3IF90Zk3tMz4ccv8otnqfAQAIgd+sU
 tZDXuovDwsf6csOqosROpY/Prb+diugN49KQUU/UsYy2+87Qe8oWewA/pmzTdNs7ks4F
 nCu/idiHt4ptMLTUF3OC0KfqJ1Qa3EmB2jpTg1awyz1Iq/WjfzxJBzaPl7sV2vrw6QQG
 xZ5g==
X-Gm-Message-State: AOAM530PY+l8S5zWqSdAhglvn+z18qLWrKoTquce52E4S+J8Bx33yDFw
 9jRaWefc2y+bUwvYF6elWb3fD5BKPvjlpYsjlYpZclAuiioo4DZVseoeBaAZHDxb+NXsin3wFey
 2Nh4CHmSYWWbJnfk=
X-Received: by 2002:a50:b023:: with SMTP id i32mr2279432edd.377.1603806993704; 
 Tue, 27 Oct 2020 06:56:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBHskYR7MdFyujMfh7jJZtXEwL7Sga5wgF1zNKHEZcbBSH0cK23mgenucEppfPBb6oRjPsaw==
X-Received: by 2002:a50:b023:: with SMTP id i32mr2279410edd.377.1603806993546; 
 Tue, 27 Oct 2020 06:56:33 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id r1sm1094650eju.40.2020.10.27.06.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:56:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/25] block/nvme: Simplify device reset
Date: Tue, 27 Oct 2020 14:55:30 +0100
Message-Id: <20201027135547.374946-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid multiple endianess conversion by using device endianess.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index e95d59d3126..be14350f959 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -755,7 +755,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
 
     /* Reset device to get a clean state. */
-    regs->cc = cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
+    regs->cc &= const_le32(0xFE);
     /* Wait for CSTS.RDY = 0. */
     deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
     while (NVME_CSTS_RDY(le32_to_cpu(regs->csts))) {
-- 
2.26.2


