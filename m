Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E45BC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C318C2469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQvGqIRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C318C2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ht8-0006gV-Sw
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhR-0001jh-9N
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhQ-0005AO-C0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:13 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hhQ-0005A1-6G
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:12 -0500
Received: by mail-wm1-x332.google.com with SMTP id n64so2335803wme.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=56kPrnyJ+3Nv01Gc4oaPOxv6Z0aZWG0PExBTYvUHd9E=;
 b=IQvGqIRvflD8dXpKLqYA90i0MO6rAlEd98zWF0EYSExbU+gmF6tT91Ckl1HCwOQd+T
 hCLV+1lGXdIAByLliGdpBxFnN5yIqVJvYnAIhKkg7WtU02d+yLviMm6yaXEVbcL2WYNw
 Bf9zkbGMgZ1Jt9x2dD6JECyubhjZYzJMJm+iEBogbv6rxwbMMWK9w2XlI5fDPvtq9uVu
 xiGfQrJ/TALqt5QntoJLOovDnRz2wl6svPafePKZUdIJyH8A80L6ET2CqZ54Us0qncZ9
 6xrldqd29qqu3WFfHnWlAjh5WZChAGStmqD12F6hMwiAivYllEC0XZGhAJgFnkoA5fTg
 jS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=56kPrnyJ+3Nv01Gc4oaPOxv6Z0aZWG0PExBTYvUHd9E=;
 b=DpWV13tg8xh+e3L/QvGFQr2D8UAmr3ynhRlKAqLtTnbF+/1HNf9xt36Orq5qmENGTX
 SNBsOC6njPz4oY2F8HgZz+AZTSCgcJf8s1euZ5LYyW/OimuDuzHqeRwqAbUkj4av79mc
 ULi1X4o+ZVaS0ZnN3cTCHcBMrIkC9n2ZMkFPtCo8DRQM5+Sn21ppD22yiwnsDF4dT+fw
 nWVFUeVEnFs6XWiSfnOkW1U9fOjTcMayZ7ZK8s6sUJ8UlJ5DA912U9QnPKPsgCmISwe0
 9QXBdyvmrEAGLCRk/fb1D71qScTuwHc9P/pKAlOFCAaMwgMKuDK3RcAVH3P+OQBFGywj
 eWlw==
X-Gm-Message-State: APjAAAUAMopoOCU6WDb0LfnaoXaTgZKc+ii9br0fgiMvCHDXI6PfelvR
 Iw5A3Bx4Ciw2450qkEBHfJHjk55tKwRx7g==
X-Google-Smtp-Source: APXvYqxff0AmRjQafXZTZ0DebiZ7/Yau5oug6BzibB+orerxw+cqhViYq8ozT9H2g5tJUnTzAsbQDw==
X-Received: by 2002:a1c:990b:: with SMTP id b11mr5342121wme.15.1582904230896; 
 Fri, 28 Feb 2020 07:37:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:37:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/33] ui/cocoa.m: Update documentation file and pathname
Date: Fri, 28 Feb 2020 15:36:16 +0000
Message-Id: <20200228153619.9906-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to stop generating the old qemu-doc.html; first we
must update places that refer to it so they instead go to
our top level index.html documentation landing page.
The Cocoa UI has a menu option to bring up the documentation;
make it point to the new top level index.html instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 747a70839af..cb556e4e668 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1174,7 +1174,7 @@ QemuCocoaView *cocoaView;
 - (void) openDocumentation: (NSString *) filename
 {
     /* Where to look for local files */
-    NSString *path_array[] = {@"../share/doc/qemu/", @"../doc/qemu/", @"../"};
+    NSString *path_array[] = {@"../share/doc/qemu/", @"../doc/qemu/", @"../docs/"};
     NSString *full_file_path;
 
     /* iterate thru the possible paths until the file is found */
@@ -1198,7 +1198,7 @@ QemuCocoaView *cocoaView;
 {
     COCOA_DEBUG("QemuCocoaAppController: showQEMUDoc\n");
 
-    [self openDocumentation: @"qemu-doc.html"];
+    [self openDocumentation: @"index.html"];
 }
 
 /* Stretches video to fit host monitor size */
-- 
2.20.1


