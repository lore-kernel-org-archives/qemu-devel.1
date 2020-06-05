Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE5EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743292074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLMCZfyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743292074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9Vi-0004Sv-I2
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9Uo-0002om-KO
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:22:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33422
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9Un-0006KI-Rw
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=styZe25JXYPNj6ZLjRZ2KyeoWgaRA9nMMleh8tvZmSE=;
 b=gLMCZfyrbnIppyQMddLMXkWVItZoC+InrTyssjUBtLMQO0wdkioDogzPDINPNRd/hyHc8c
 Ppi+YV3b3GykzEvSwshl7Nt0OEj2MyzqWiQhpjWPlbBNbeI83ylHCvH0AZZZkiP30uPOj1
 YwCXmJaemgGo2A/GriohKKy0hLCD21U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-vy1kAYY0NoWbrkdpZ8OUHw-1; Fri, 05 Jun 2020 06:22:39 -0400
X-MC-Unique: vy1kAYY0NoWbrkdpZ8OUHw-1
Received: by mail-wr1-f72.google.com with SMTP id a4so3594911wrp.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=styZe25JXYPNj6ZLjRZ2KyeoWgaRA9nMMleh8tvZmSE=;
 b=nRWC0eH3dD+5gLqryFFWp1SX9mx4KzDnb0QapGPnelZQQfmvSUMDkzA4ZPcM/3463B
 TGqUxjErfEf1Nxv+5dLS5CIMy6ghlr9cVDjAqg7LuBBZuOn+IWnUenJBavfg9NONSqTk
 NZmNvf3zYR8PoLgdGFaRxPbfzMtEVsowR74+igwD5Ve9Win5cFTcZp0zm9fQpy1uNiRk
 Ap27s9JvmzJmVhpFxtEo5vmuTKH8+ze1L6/liKV03gBl9yrwXF0M3gnyU2b04Hdd/vhe
 rhdpuQwAGcIljmVZQPpHUsGpFZiiblw+Hp66YHXg5hxCV2sd6UT2QUufFQsa6YHp/CpX
 owZw==
X-Gm-Message-State: AOAM5331t05/sUNM/p4QymGcNYk4WSLsVaKXX92n7fgghemxJ+WX6b7r
 r2N/StwQw3KChpF8QEyREADVgXpWVuqY0Ugi0QxTZiV0aKee3XamIrLkN5GNdoztRbqjjals57a
 K33akRTMyKr7Oix8=
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr8667453wrn.373.1591352558069; 
 Fri, 05 Jun 2020 03:22:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc8rs/qgwznm0TyPhroBDC3DMBk+GG1qZ2hOwJ/pyEZe4xEBBHEO05tWIq9al5FddkYmtBRg==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr8667434wrn.373.1591352557843; 
 Fri, 05 Jun 2020 03:22:37 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k13sm10220723wmj.40.2020.06.05.03.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:22:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/11] MAINTAINERS: Cc qemu-block mailing list
Date: Fri,  5 Jun 2020 12:22:20 +0200
Message-Id: <20200605102230.21493-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605102230.21493-1-philmd@redhat.com>
References: <20200605102230.21493-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We forgot to include the qemu-block mailing list while adding
this section in commit 076a0fc32a7. Fix this.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e7d9cb0a5..20b3a68d00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1599,6 +1599,7 @@ F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/sd/sd*
 F: hw/sd/core.c
-- 
2.21.3


