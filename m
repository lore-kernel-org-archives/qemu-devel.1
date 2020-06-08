Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37998C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051792076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA8P1Y+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051792076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKv3-0005rk-4t
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnu-0003WZ-FM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:39:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43516
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnt-00064i-4u
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591634356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pROdAkqrKtPTbGGsirSAjOC9p/YOWAeyZ2CTLEMsDG4=;
 b=cA8P1Y+EIjVnLCUz9M+VEKEX7rp6tr0rntNmlhLuf+a4sRlPaaterrEuIhjkIXDPcWXmc+
 awhViaQkPoRTTdo8x5Kjk7ZvBphleFBSLSIZBIiOJE4xcdzHIgQiEUXNSy0j806Y1/sOAU
 wV3EnOiWzvqt8MU6kJMvSM0RDgqM4Ao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-NPAz7tL2Oa2NnWPV1Fcbbg-1; Mon, 08 Jun 2020 12:39:04 -0400
X-MC-Unique: NPAz7tL2Oa2NnWPV1Fcbbg-1
Received: by mail-wr1-f69.google.com with SMTP id p10so7401475wrn.19
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pROdAkqrKtPTbGGsirSAjOC9p/YOWAeyZ2CTLEMsDG4=;
 b=AShXOOguElsdk3w3Aim4MbN0MALtHTkRGAJbBjTsZbFHhhdnlzkW3CGL+Qnp6Opt1P
 Uw58YTVLkcEZc0RLym2/9nANHLH5g23vLXj5U1ObjCpLa5Gp3tbTWve9HZbuSKKdkKBV
 ldDpLYlJl9/x6ebyttlOTO7bG8exe0/7F2cxiWxYTvHGkbjv2XlJt/09NKQh9ElXMB5a
 a0nGyjGTVbxTi1jYuDIdCb1N3YfhHIk4A18o4WyUvFZYmTywV5hMQoP43Vuo9WkChHAv
 Y/bFfcSVO2yp8/j2ngASXOilghse+uBx/XMLzzNI62dlDHIQJun6o8inbcXg617fNmlq
 Ad8A==
X-Gm-Message-State: AOAM533JDH2WRyZZQKmZ/Z7zTosy3fENcGUyUxxVLw+o1ewpNPYrm2mr
 EeS6Saq+1prSwTksUkNmufkANf9QIbZlNNYO4EH294NkgAXR66ED3rMAhBG7ewwVjv9cDKAH5bm
 wYJHLJ6v+jlfBe9Q=
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr23335638wrj.333.1591634343694; 
 Mon, 08 Jun 2020 09:39:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8CmI8Ne50Q4EI+77/gANXpjr4GucVXSOpFwCcvu9yVHQ9EJyJNdiY25CcVjXmHVMwxbhg3Q==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr23335624wrj.333.1591634343546; 
 Mon, 08 Jun 2020 09:39:03 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a3sm125644wmb.7.2020.06.08.09.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:39:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 08/10] accel/Kconfig: Add the TCG selector
Date: Mon,  8 Jun 2020 18:38:21 +0200
Message-Id: <20200608163823.8890-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608163823.8890-1-philmd@redhat.com>
References: <20200608163823.8890-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose the CONFIG_TCG selector to let minikconf.py uses it.

When building with --disable-tcg build, this helps to deselect
devices that are TCG-dependent.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile      | 1 +
 accel/Kconfig | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 7c055a9e32..aef466b0b9 100644
--- a/Makefile
+++ b/Makefile
@@ -405,6 +405,7 @@ endif
 MINIKCONF_ARGS = \
     $(CONFIG_MINIKCONF_MODE) \
     $@ $*/config-devices.mak.d $< $(MINIKCONF_INPUTS) \
+    CONFIG_TCG=$(CONFIG_TCG) \
     CONFIG_KVM=$(CONFIG_KVM) \
     CONFIG_SPICE=$(CONFIG_SPICE) \
     CONFIG_IVSHMEM=$(CONFIG_IVSHMEM) \
diff --git a/accel/Kconfig b/accel/Kconfig
index c21802bb49..2ad94a3839 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -1,3 +1,6 @@
+config TCG
+    bool
+
 config KVM
     bool
 
-- 
2.21.3


