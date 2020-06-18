Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC68C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A05920663
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zh0XducK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A05920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltqS-0000AL-KI
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkT-0004qt-Er
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20624
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkR-0004p9-Op
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mudvUnPjIjY+tEXSbdcmkJJnpEWaA/5osfwu5rAd88Y=;
 b=Zh0XducK4ThRH6zX7HPF7MyoDdeocPALONnVp1PxQF4nP/CBZlSteCERtzTCy1kByWdoXV
 5HuRMAg0ns+6HJjcs2hy36f7GkSxHEtY8LdCYzTbLwdkptO15JGRQMNcirDwdllrUtyx3t
 Mvh2fEYGyLlkEB1I0pLNo0UtYr+t+nc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-T7u9uXunPaSDf7uV5slD8w-1; Thu, 18 Jun 2020 08:34:24 -0400
X-MC-Unique: T7u9uXunPaSDf7uV5slD8w-1
Received: by mail-wm1-f69.google.com with SMTP id t18so404650wmj.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mudvUnPjIjY+tEXSbdcmkJJnpEWaA/5osfwu5rAd88Y=;
 b=GAV/qnb8K/+VC4L/uHeagkQ/c5MXmv+UIXnFkkjOrDm6H/ZTiZobEpJzsR0M97hB9T
 uzOYoafLB76DsygVE4qzxHA3BhBdnv0sCZKOWBRjIFE6JFPtUsMorFANVGW9cSlMjs96
 JY9eoHwAgd+J27J1qOEIwtP3IwWf6xqrvBEj3ngbdiH+qRomVdfGR5MBP2HHSVrCqxOr
 hZEPiZ6942K0Zo5v1WenKSzOz0RLUsilcThx7yBYqTgTDlZ705qd7b4yoKCsrBdqgthf
 +s1dDWMcTADvprjA/MS+L8nZSqCkeupQKanrkIY8TI44GCDHwJdxDac8szfOqb0K2pH6
 +C2Q==
X-Gm-Message-State: AOAM5310V4PYU6W2vxdS6FGhf49RHgWFpi794wAn4O+9bxxD7wrATrq2
 IVi9GY5tAlcYixTDjxGGvx3c/ypMtsDj+FsMAq5IHl2ncVtqXj5fML1pxwZSTsRyb6YKYGzeDW5
 hWclU2Og05b1AomM=
X-Received: by 2002:a5d:6a01:: with SMTP id m1mr4619971wru.115.1592483662670; 
 Thu, 18 Jun 2020 05:34:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4Qh2v9rMWzQ0BcND9aDJ9iV6YqnSoQxlU2gJdVjI2HANf8PnIDK654dIWzrYbCgGBFFK4xQ==
X-Received: by 2002:a5d:6a01:: with SMTP id m1mr4619955wru.115.1592483662532; 
 Thu, 18 Jun 2020 05:34:22 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id u74sm3400711wmu.31.2020.06.18.05.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:34:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 08/10] accel/Kconfig: Add the TCG selector
Date: Thu, 18 Jun 2020 14:33:40 +0200
Message-Id: <20200618123342.10693-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200618123342.10693-1-philmd@redhat.com>
References: <20200618123342.10693-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
index f14f59fb2b..00e8553745 100644
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


