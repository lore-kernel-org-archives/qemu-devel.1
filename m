Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CFBC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A825720787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5RJhWQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A825720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6Py-0002zB-Pm
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jU6Lm-00067C-M4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jU6Lm-0004f8-3v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:23:26 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jU6Ll-0004ey-NY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:23:25 -0400
Received: by mail-pg1-x544.google.com with SMTP id n11so2536237pgl.9
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=u4m6+vzCc96Nl5shiNMOZfZokMTmk6NsaXZkY+++sic=;
 b=d5RJhWQdl9VZdQN1bKV7r0TNSwm9C+PPjymWbohpU1a7duM4xtHjALdP3npVifxFle
 JpfgJSgPqf9jL5mTXCOd4VLjKW4IrVJ//ty/17JNPzNcW0DM6kU0k+vf9FK6IsM2ZZoA
 vmZ2+gRUWOVt6CTSnyohfHWfWNWZllR9G45af2iUVgOpYFaMPzFei1bywvsOEAkCb4/K
 gz8sJoJwUY2QEJ7KOo73A89vjLw4ztI7n+rGPb5bFUzd2qAQrAgPboooGqPEGPrgCF0N
 YzFf3LSrP8frD4QnF6KOCqqtnxJIcspugTaU/weVc55pReIUUTsHeSvn0LZuPqDUhHzq
 4kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=u4m6+vzCc96Nl5shiNMOZfZokMTmk6NsaXZkY+++sic=;
 b=N7s37y3mDiDc4B/02usvz9iO+8O0shTS99Ae4nOoNoXws+mWaUmau57psspEoCu+9m
 o9gj6RwfqZad1yJn3sBmzo48SbRBa0ng6bsegk1ChkrKOaG4x83+N14gu65kqYuc08EK
 ybxKW+MPtedue9qnQ5Nyos99ATIgBQLAc+DnmG3L7tZbQw0f9I1fgTUcpe4ynmY6J64+
 2udeJ9XEGut0oQV4G8bajSzndV0uz4GENLgev2tBWvQ4km4SKK1HrOMTm9/dQpAX+39B
 +ycvvl7yamJr3UIPYrQY2ybB3NoDeuMW7mMQnkM2MkFNgWOaEpIMpbo6MGbd5cVV5hYm
 Qcaw==
X-Gm-Message-State: AGi0Pub1N2Pcs0YbeL3+v40qbiUrIFcyrVI4rsm8I53CuRGQwcsM5l9w
 X1Fin13mBW6j7ey/sg5+iZtLxFlGd6k=
X-Google-Smtp-Source: APiQypLW2XkW2ABN83GCbbcrJ2x3+Tq4l7AfQxzQebqSwRmOHteAEIBMNTIod/h3ODbvS/+bTFE0cA==
X-Received: by 2002:a63:dc56:: with SMTP id f22mr2679770pgj.284.1588242204391; 
 Thu, 30 Apr 2020 03:23:24 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id a15sm1397872pju.3.2020.04.30.03.23.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Apr 2020 03:23:23 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V2 1/7] configure: Add KVM target support for MIPS64
Date: Thu, 30 Apr 2020 18:22:29 +0800
Message-Id: <1588242155-23924-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588242155-23924-1-git-send-email-chenhc@lemote.com>
References: <1588242155-23924-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preparing for Loongson-3 virtualization, add KVM target support for
MIPS64 in configure script.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 23b5e93..7581e65 100755
--- a/configure
+++ b/configure
@@ -198,7 +198,7 @@ supported_kvm_target() {
         arm:arm | aarch64:aarch64 | \
         i386:i386 | i386:x86_64 | i386:x32 | \
         x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
-        mips:mips | mipsel:mips | \
+        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
         ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
         s390x:s390x)
             return 0
-- 
2.7.0


