Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74DBC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680122222C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jb0FSSkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680122222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPkh-0006ZJ-DN
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSF-0002gM-8n
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSD-0004Co-FM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kHDg5TLpZChWqON6ng1k59lvL09+LS2LIxOnQI0wvdw=;
 b=Jb0FSSkzvv66RV48Xp5qQw6MaUYb2pwI9gcjz5tq1deSx0P5MKpUGJ5Mm1RvP3S/tVntiN
 pUQV/Max8O1wp8RSapaR4oph0rQ0HxZVu4brRbEZ1/JyErp/SITshAJTG6WDBh43lh/5bE
 0RS039hGHN1gJCFZNhhw7T4FBMbNsPM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-jWakotsxNj2WOQhYlitD6w-1; Tue, 27 Oct 2020 09:55:57 -0400
X-MC-Unique: jWakotsxNj2WOQhYlitD6w-1
Received: by mail-ej1-f69.google.com with SMTP id lf18so899790ejb.13
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kHDg5TLpZChWqON6ng1k59lvL09+LS2LIxOnQI0wvdw=;
 b=NO1PfvXfGrYptN3L7dtfVm1EYYk+CPLJ3O+oI07eTmbRvR8R0fG2sr3fzJS/VQtzKH
 fR0XU9A3hq4UVVVAsnI0QF0/y76Ah668g8jjEIzJ/gzjgWFFGF5Y6dia747Z3cyhMAXP
 Smq7ZZIOV+6gzhXJ4uHZDvtKYV2N279d7U6u9bea0cNMibh+V+7KVIz1YJfBeSo1cVb4
 EyzaMX+ZuHNBrlJjPoTChPvMcqSGguaPrarjINU3jfaHWfb+ZayItyEnrJl8iiFDwYVi
 CMtX73sOr4xZOY5RrkMqBVeu6DkjPNsbVXvOGj2vwlOSNSVJLJeDsAM5h7VlT6k5emw9
 X+3Q==
X-Gm-Message-State: AOAM530xDHcMmAYwFzFdggqbuo/sckXF76Fdt/ugmo5hnCENB+QoHuKq
 vb8el+n0rdJJkEn7VslA7HEUGGtnfeZgXghwV4V1GbAGdck4V0xU1rojGW+T6H5QInHD5I+bIdF
 J9091vV2dzv+/Ym8=
X-Received: by 2002:a17:906:640d:: with SMTP id
 d13mr2421977ejm.223.1603806955970; 
 Tue, 27 Oct 2020 06:55:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm+Sl0xVtt5k1/E4kvlxHQw7ySGnLPNQx9gg/R1TcWwzq2Qq5fjEGpc4SmSIpFAXuWjm9txw==
X-Received: by 2002:a17:906:640d:: with SMTP id
 d13mr2421945ejm.223.1603806955659; 
 Tue, 27 Oct 2020 06:55:55 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id bw25sm1111452ejb.119.2020.10.27.06.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:55:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/25] MAINTAINERS: Cover 'block/nvme.h' file
Date: Tue, 27 Oct 2020 14:55:23 +0100
Message-Id: <20201027135547.374946-2-philmd@redhat.com>
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
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "block/nvme.h" header is shared by both the NVMe block
driver and the NVMe emulated device. Add the 'F:' entry on
both sections, so all maintainers/reviewers are notified
when it is changed.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef6f5c73998..9366a1b2b3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1876,6 +1876,7 @@ M: Klaus Jensen <its@irrelevant.dk>
 L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
+F: include/block/nvme.h
 F: tests/qtest/nvme-test.c
 T: git git://git.infradead.org/qemu-nvme.git nvme-next
 
@@ -2953,6 +2954,7 @@ R: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/nvme*
+F: include/block/nvme.h
 T: git https://github.com/stefanha/qemu.git block
 
 Bootdevice
-- 
2.26.2


