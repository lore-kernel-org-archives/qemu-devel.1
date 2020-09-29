Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1C5C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2CE20756
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpZdOjbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2CE20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOPe-0001VS-AJ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOM7-0005HA-L9
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOM6-0004a9-1T
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVtzhoPQ9oRe5A4whgi5/tX3r24KuxvOyig0n+4hw6k=;
 b=WpZdOjbH3DkBcuD37XIZDrvB8TfBcDznx4QoeAdwwx53qGjMnnHadu1vHLlhNZaWd6zVdY
 ax1B3a325SULXCRQA4nChYnzEZGIB3mT2Fi7ZSVMIdTC+CSFTxwUsyaqVGczwJrtPj2sRu
 MUYDlBWSAD6xvbH2n6ikP0VEenjPWjI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-bGrD3NEbPoGogs7UNJcPzA-1; Tue, 29 Sep 2020 18:44:15 -0400
X-MC-Unique: bGrD3NEbPoGogs7UNJcPzA-1
Received: by mail-wr1-f72.google.com with SMTP id 33so2341658wrk.12
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fVtzhoPQ9oRe5A4whgi5/tX3r24KuxvOyig0n+4hw6k=;
 b=mCT2i/xeZbH+GvGkbkiYRdyPRopkWhEGhmRet3qQUo6p/C13g4KlHRuveQo+msFN5W
 waGlexJqLwpuzjqOfQ0cgHOiNDxSSo8BqzCHlwKeZrfsh4uPhEtXk3VQYRiyoutqREne
 TQi4AFeGHz6dNd9lMVo8qGxuHbrCsvRf7qu6eJ/Xnlc52BKANKQz4mxqMDtRJKCzELce
 woilGU5C4nBjqf6XGmgbdolKWiY+4xc50q+ehOFHozKFP4SujKJ9DEqOUSL+UW3ZYXoO
 ZPIwHhaykxhwqb5PAA8UhUovpJzxskpPSG3UrrtpmTJDVDat8OXfDN40+NTKVfLJQTPD
 CH+w==
X-Gm-Message-State: AOAM532L6B6mYpkZUW0Bcepda7NaCP5Ug5nCa9HbPAZJbF0MDJKUtGBl
 BOGjs8CFbvDk6FhATTIruosS+YSdxda0gmtA2x8S+CmolynQCFaZvCXYP8/bpDdXqlPgCHmYzYV
 HjGdIVkZcm/u6v/E=
X-Received: by 2002:a5d:5261:: with SMTP id l1mr6619436wrc.193.1601419453412; 
 Tue, 29 Sep 2020 15:44:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeOEbx68Td8hBaYyIFzxkCzoKhQ+EE4XU8IG3LB8RbTCWtKeOlhoOS8sgyI3yT3aeSBndgRw==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr6619416wrc.193.1601419453250; 
 Tue, 29 Sep 2020 15:44:13 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id l18sm7902646wrp.84.2020.09.29.15.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/12] target/arm: Select SEMIHOSTING if TCG is available
Date: Wed, 30 Sep 2020 00:43:46 +0200
Message-Id: <20200929224355.1224017-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929224355.1224017-1-philmd@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a kconfig entry which not explicitly selected by another
entry, but which selects SEMIHOSTING if TCG is available.

This avoids:

  /usr/bin/ld: libqemu-aarch64-softmmu.fa.p/target_arm_arm-semi.c.o: in function `do_arm_semihosting':
  target/arm/arm-semi.c:784: undefined reference to `qemu_semihosting_console_outc'
  target/arm/arm-semi.c:787: undefined reference to `qemu_semihosting_console_outs'
  /usr/bin/ld: target/arm/arm-semi.c:815: undefined reference to `qemu_semihosting_console_inc'

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/arm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 target/arm/Kconfig

diff --git a/target/arm/Kconfig b/target/arm/Kconfig
new file mode 100644
index 0000000000..972d9a1b9a
--- /dev/null
+++ b/target/arm/Kconfig
@@ -0,0 +1,4 @@
+# arch-specific rule to select SEMIHOSTING if ARM && TCG
+config ARM_SEMIHOSTING
+    default y if TCG
+    select SEMIHOSTING
-- 
2.26.2


