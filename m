Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85455206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLlN1ueD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85455206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKpo-0005Nz-Jf
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnD-0002BU-S2
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnC-0005ts-AD
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591634313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPqqJcTQRXNoN1ReoZxx50tLxA8LNxWCFtz6iEs+CGc=;
 b=jLlN1ueDEUXqgcYqUV5+5JjS08zD0v+5MSycHVQlgb8HUs7sWL0NgzBEmF/3TP8zBi/5Bx
 SemNTNmiCMf2g9zErxMYWS/LIt85saVx83X1JDqiJxJfQVA+zu2o1SLCwc8PFJYmDWSimo
 uOY5m1upsdKnYb7DWKH9MJ57kPLdWPI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-z6NNLKU0Ori2Z0Dh3t3grA-1; Mon, 08 Jun 2020 12:38:32 -0400
X-MC-Unique: z6NNLKU0Ori2Z0Dh3t3grA-1
Received: by mail-wm1-f69.google.com with SMTP id t145so35384wmt.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PPqqJcTQRXNoN1ReoZxx50tLxA8LNxWCFtz6iEs+CGc=;
 b=UO0F/KKTUlipO5mNb6cGC/Fn4YrPpqPII9L8Vi0HixYibnQ+SoC3tLcGH6cjSqvyx6
 Wvmf7/niaGK0Clwc9N+jmseWrutpoJaE7KJMLreKPnONL4oxW5ZkYs9KuzngQKcbGWee
 115LJqN0PyPwdmm9ykFfOCgH/7hd1DZG2+YHNi/fgo9J+wHCA0uegRYifz4ZZnOT914s
 lhudy/6M9U4JPMirOP9WRs8cKyeBVrzUuMAix+jUkTamH+SaKEtcIWbCTjMya6QO37cG
 sQa4QEeIuvqLlAacKAVAAkVvASFqfSPyS1gJAlCowrvWPOjN/bhD5Vv5ps3xBrxYrKAU
 TruQ==
X-Gm-Message-State: AOAM532MRLLqfUKOXaa2ki1JtfrR1CvmegWBuO9rsWWiEsn7tTl266eZ
 4lC41MgcOndfIP2geRIljz46aUaUnT/twbmwpHnCF+2675IkWaa7lvH6QQvVL+22X7asGU/j1x0
 vTXSZ4bXKYbH9a60=
X-Received: by 2002:a1c:9896:: with SMTP id a144mr178773wme.75.1591634310580; 
 Mon, 08 Jun 2020 09:38:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5NR0EQ7cCB1RBHITVWGEONC2CZ0ccQGdC8nTbHLrt/uP/viKxOSNbPeEsfOdr3jvVYXAXRw==
X-Received: by 2002:a1c:9896:: with SMTP id a144mr178756wme.75.1591634310401; 
 Mon, 08 Jun 2020 09:38:30 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z22sm125228wmf.9.2020.06.08.09.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:38:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 01/10] MAINTAINERS: Fix KVM path expansion glob
Date: Mon,  8 Jun 2020 18:38:14 +0200
Message-Id: <20200608163823.8890-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608163823.8890-1-philmd@redhat.com>
References: <20200608163823.8890-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM files has been moved from target-ARCH to the target/ARCH/
folder in commit fcf5ef2a. Fix the pathname expansion.

Fixes: fcf5ef2a ("Move target-* CPU file into a target/ folder")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7890ce82..53239b060b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -362,7 +362,7 @@ Overall KVM CPUs
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


