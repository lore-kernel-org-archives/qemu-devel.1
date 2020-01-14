Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08487C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C770124658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKEvSgwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C770124658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irTV9-00065T-Om
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 16:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irTRK-00022g-Nm
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irTRJ-0001Qe-R0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:30 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irTRJ-0001PM-LR
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 16:09:29 -0500
Received: by mail-pf1-x442.google.com with SMTP id p14so7180613pfn.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 13:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4s1PqpDA2phXf0Lid2sF9zCU5S3KdedJJZ1I7QflK10=;
 b=OKEvSgwyeHh3f0wJjlOVQQtX+sacNY++tkDoDrglulLWsMrjJAlgkMcwSpchzowu+/
 lMgcgQpqXhCXN3eE1pCH3yytK/ZTGAICUiXDTB5+uSryCpKcZwXh+ayHuQGkBYpLgsMh
 mkFkAh+Nia0vFqBQ7fVb0xtAo9ysZBBcdx9xAZm0ZtWrj8413lj5JNbvyUdxiuIzV3sL
 UwuSWO9p1CyayR+U6q+VSSjpYD3dD6AQPaCnf8gk8scOZSBDCdixAsH2bOYf4LKy/y4i
 2egnwstlxDKmw+gQn4SbLEmuxKLcL/KeQUKtCLOpaZY0JA1pPkMHpn3C7AACjQ75NrpO
 qAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4s1PqpDA2phXf0Lid2sF9zCU5S3KdedJJZ1I7QflK10=;
 b=M1JeVuyO9CfivnfGUgzTznaRlUBsgi9SPv0ytiTON3a14E2f7B07GUgPBtMWkUzkhZ
 iQ2clYiD6zsqDA9lLrQOtwr8Yd53fwQf+R0L3SPrFLzZODv97AX3gAb9h8G/kuGOiX8G
 b1Fg9qmB0KssZKRoQmaqlQn+6zAkQAfNLpcbLo1p0CBI5nCVxb0BZd3hF/4iD/KRLDlP
 iamnWp77rYz/N7Xsj6n2oR2EZpVXfnOXLxBcLzWj7iHnOV0uzTmlUqqQRgmz5i+NuYhY
 /vH4Jfv+PX/Z6080CIqqJxwKk2ApkOR8pX1GdQBkzOhvDQZeaEiciWSMmJ6wi8bFqNZe
 h/Aw==
X-Gm-Message-State: APjAAAXd4mAjitN5mvyptraGnvNiPKkQiskm83cyJZa5Asnc/qX+x5DD
 /j3iubqnrut4InSt6rhZWQ5AFiyobdg=
X-Google-Smtp-Source: APXvYqyXPA1WupNkOBPSoMvUE3OVlL85WYspCcGAmLg+N6VsrO9SrjBK3bXbRmzZGXNDICAw2/OpIg==
X-Received: by 2002:a65:644b:: with SMTP id s11mr29280672pgv.332.1579036168326; 
 Tue, 14 Jan 2020 13:09:28 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id d26sm17881020pgv.66.2020.01.14.13.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 13:09:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/i386: Renumber EXCP_SYSCALL
Date: Tue, 14 Jan 2020 11:09:19 -1000
Message-Id: <20200114210921.11216-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114210921.11216-1-richard.henderson@linaro.org>
References: <20200114210921.11216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: pbonzini@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are not short of numbers for EXCP_*.  There is no need to confuse things
by having EXCP_VMEXIT and EXCP_SYSCALL overlap, even though the former is
only used for system mode and the latter is only used for user mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 594326a794..164d038d1f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -998,9 +998,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define EXCP11_ALGN	17
 #define EXCP12_MCHK	18
 
-#define EXCP_SYSCALL    0x100 /* only happens in user only emulation
-                                 for syscall instruction */
-#define EXCP_VMEXIT     0x100
+#define EXCP_VMEXIT     0x100 /* only for system emulation */
+#define EXCP_SYSCALL    0x101 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
-- 
2.20.1


