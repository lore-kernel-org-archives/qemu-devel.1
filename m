Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F60CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2BA205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa/u5UXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2BA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNezJ-0008HZ-2k
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdir-0007aO-QB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdim-0007g9-Es
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdim-0007ff-4x
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id q13so21264718wrs.12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dj03/Yqw2HLWY4su1lbnJ5oTSp3WYGgIZYAiK8OHCfc=;
 b=sa/u5UXvW7bIAM29nT9SfCwoR7RUZ2o7/pJsXRH+pZ0ffKo0o14IHybwhGly5ZUQDp
 nX88YRQbX6wpv/MMDWzp4lX4XbIMoy7qpXoCDoD/nqPkaq2UHNJUkAwWkrih4066F3Bv
 sT5mam9r7EdqhCzAR+Ap7Wne8A8j2vP9NTnx/v+DOYtoSI7MfDDMt+w7LlqSw9GH0yBR
 kZFl+CcyNjSMFlRV8lA7A59daX/itt1X+SVRv1ywh8/z2jAVIB1orpkaVQVv5Gy1FFDk
 SqOcgSfJPvjcjikNLJ9PxZ4LyB2YR6U1QH6x3oDp0wlnQTtc/OYFxy3muZgizkC2wELl
 4hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Dj03/Yqw2HLWY4su1lbnJ5oTSp3WYGgIZYAiK8OHCfc=;
 b=hN9W3vF8DBi6TRVzeX3B0bYFuNwsojJR3vu1JF25tzkdA1UnvHhNRamG9z8uWfhLIp
 tX7rUq2c7JZUgbpEcNWJQ3V9B6SI03h2C4o7qOBxSo+7ZveFY22qR9i1EInFzwEH4nZJ
 zWzymo3cxxFAWekIvMdJJ2unSQvjZfAIEwKqbBmyu+y/1BEFsULvHXmUmypdZJ0oiwLZ
 Ye0ajJ3gaApTBCYLt8Gfg9eaY0pODj2y5HSmxkDoADGnCE/VnSqhx7t4HzUalars3K/R
 nKe1GPTjVefmMX2gdLgZj3TlABQEKqlQXLf8VrBFBROBB19sI58hUikie/df8ENV3J5j
 pd3Q==
X-Gm-Message-State: APjAAAUlT1NDf/U7iPRZdae7BdDF49JXFPKaInkOKF4cjNXI5INxHO94
 6Q6tYPNYZyDrvj3wjEUomh6kR+d9
X-Google-Smtp-Source: APXvYqxfzqKCxNokxBjtcaDfEc8Hfe8IVUZwHnBiWJ+CJ2qMwXS6gNcWpgckElSEocsbLsOC2kcG7Q==
X-Received: by 2002:adf:9c81:: with SMTP id d1mr3871019wre.238.1571925850869; 
 Thu, 24 Oct 2019 07:04:10 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/39] hw/i386/pc: avoid an assignment in if condition in
 x86_load_linux()
Date: Thu, 24 Oct 2019 16:03:27 +0200
Message-Id: <1571925835-31930-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Follow checkpatch.pl recommendation and avoid an assignment in if
condition in x86_load_linux().

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/i386/pc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b5b660f..77198d5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1045,7 +1045,14 @@ static void x86_load_linux(PCMachineState *pcms,
 
     /* load the kernel header */
     f = fopen(kernel_filename, "rb");
-    if (!f || !(kernel_size = get_file_size(f)) ||
+    if (!f) {
+        fprintf(stderr, "qemu: could not open kernel file '%s': %s\n",
+                kernel_filename, strerror(errno));
+        exit(1);
+    }
+
+    kernel_size = get_file_size(f);
+    if (!kernel_size ||
         fread(header, 1, MIN(ARRAY_SIZE(header), kernel_size), f) !=
         MIN(ARRAY_SIZE(header), kernel_size)) {
         fprintf(stderr, "qemu: could not load kernel '%s': %s\n",
-- 
1.8.3.1



