Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4504EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121F720723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDdtNBrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121F720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAj5-0002Ld-5q
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAgV-0006Di-W3
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37870
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAgU-0002Qk-Gg
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590165489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4vj8R5EnRSJIwJ44iAQIsL562FetSOJ7g/4vcs4/XI=;
 b=eDdtNBrNCxpq2PooUlu0r4HteiRtOAktq1rQ8jNKnfk18SZcrNi6lC3Z4hnNJstxaYPLaY
 Hk6oWWK/VclmfbwRMHGwpAZCczp9quVQPaRLCNj15b8Kq0MWK9zbCjv4Fa//akIofi+26H
 HCR4y/7Wr50OnU3fTpk5Myg9eJ/tWME=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-7fDLjzdSN1-GSLjxHqlAkw-1; Fri, 22 May 2020 12:38:07 -0400
X-MC-Unique: 7fDLjzdSN1-GSLjxHqlAkw-1
Received: by mail-wm1-f71.google.com with SMTP id b138so1439923wmd.5
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j4vj8R5EnRSJIwJ44iAQIsL562FetSOJ7g/4vcs4/XI=;
 b=Ony0X+LJ+KGeKXPMQqhoDdNcJZK8be4dTAYx0IfPc59librFodVIMpUllc1+DjN9AP
 mUHk1Ac0IoWJPjyXs0qsluNRc67sQQtd9jjb05zhR9ck1jEnCaY/iviSbQWxm/oE5Y5k
 CZxs+XQW+5zv4noHt99IAhnsApDsOKbqa1Z2dW0EEqzgkKocekY7XaS3UbKGWjvtNs3o
 c24stSL50V0vI3ScsqbXG24hyhMP1rQDWI79msLBjO2k0qMHlyrb+n42aE3V3p0Z5EGK
 LCcoQs6i2kGyHrTiTMMQpO0W1SOG1AKCaMfWsycYTerhuz2sNpCoJheGNuK1BWuBt3xt
 EP7Q==
X-Gm-Message-State: AOAM531Fz27yz+y+0GDkVo9DClMFlUD7hPWrEfOqH/As79APUknjN0pg
 2/B/GoBShnGv7hZquzBLKQageug9qMjatFmELJiDppg7Q2SOiDUtpNUcuNEsk20snKWopk9TurY
 FtKaVumCjrXGS4NM=
X-Received: by 2002:a1c:9e8a:: with SMTP id h132mr14034704wme.32.1590165486134; 
 Fri, 22 May 2020 09:38:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg+zstIfvBaTff5kwFb0xa4NnHIbdKZgh+PGV02BW+mvBlKdTYfJjNhw8lSgi2WU7OHE4Jfg==
X-Received: by 2002:a1c:9e8a:: with SMTP id h132mr14034689wme.32.1590165485956; 
 Fri, 22 May 2020 09:38:05 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id y204sm1962983wmg.36.2020.05.22.09.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:38:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/11] MAINTAINERS: Fix KVM path expansion glob
Date: Fri, 22 May 2020 18:37:49 +0200
Message-Id: <20200522163759.11480-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522163759.11480-1-philmd@redhat.com>
References: <20200522163759.11480-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 10:36:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM files has been moved from target-ARCH to the target/ARCH/
folder in commit fcf5ef2a. Fix the pathname expansion.

Fixes: fcf5ef2a ("Move target-* CPU file into a target/ folder")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12edb66dac..00c1c1ed8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -361,7 +361,7 @@ Overall KVM CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
-F: */kvm.*
+F: */*/kvm*
 F: accel/kvm/
 F: accel/stubs/kvm-stub.c
 F: include/hw/kvm/
-- 
2.21.3


