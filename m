Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E723CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B092921734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcD1MV1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B092921734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueYq-0000J7-8v
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrC-0004k3-Lh
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrA-00032j-L4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:14 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:52975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrA-00031K-EV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:12 -0500
Received: by mail-wm1-x32a.google.com with SMTP id p9so2644038wmc.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gl7eWmA7CA9XKm3RFgregvJlE8LU8fI3r6RyQ6MZ0c0=;
 b=PcD1MV1fsFXokrsvY7vAKB2jiAGEru343pJDBzGqPZLOpuKsYuYbBf4V8oze8KzU9P
 owaXjKVf9sEX1ap/k/DLD+FTfhLbLVgxfZeiE1xGOs5Va3j2oE8bNJ55CatZL8MJD2yG
 VexI0WFmT260AtxLcoK+u/10rADHiS4XVUpREsc9psUQuSJn2NfJrJKRHnEDvUeiqegQ
 7c4LTmg1cwUv7Rq0nsVKEybAigs1wgeEzWOusSfvH/Tv9rwHhjQntn8yUfK9R96dx6Kt
 NoXoExhXzjAL/7Vr+AVAf2pwTjOS0WJVZqngW/tE3U2yZdkXaxLl5q8z0Qw8DssqACEA
 ErNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gl7eWmA7CA9XKm3RFgregvJlE8LU8fI3r6RyQ6MZ0c0=;
 b=nLatFqlRHQxym8i1uWLWcZ1MDdpx0/UECuU/RbNuEi+XPZc4vBLcZUnxbAs73nsJVj
 lwaMjPlF58P0oRjvDjK58l3bW4rqq9ZL3At8siPrj8AmtQXOT4Z1E1jsXeZu7YtCakUI
 j4b3w6QGKZ3w4lGN+I70oI47PNqBFtbbFSbPa+nVGL2mWAhRwfEVwPzErWZc10ky95Ab
 EbCpyLpM4+dKplU6v+ztlbXebZkqQTKxzcH7ojMi3CaLTmssV1V+y29dalx5/FeD3IAX
 DSyWT4oUxiXCZ1hDCPP68xiHEMHxsOidm8fcekinpPfz2f4uwqn/4kYTwe9I4pQVUFDT
 kR+w==
X-Gm-Message-State: APjAAAUiZNW7WQC+uqBxEQMlcEbeNKzjwyXuoILYtN5YixNRLKrmHJ0v
 +YCieQHyOGRKBqMsiOhnqoyfTLy+
X-Google-Smtp-Source: APXvYqwvLR8zAiuT8HwiV6xD2SjZCQBDBntTtI6MMzovI074bivLArp1PA/Ru6JICV4EX7cIoVvC3w==
X-Received: by 2002:a7b:c3d8:: with SMTP id t24mr4312838wmj.175.1579787351077; 
 Thu, 23 Jan 2020 05:49:11 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/59] audio/audio: Add missing fall through comment
Date: Thu, 23 Jan 2020 14:48:09 +0100
Message-Id: <1579787342-27146-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When building with GCC9 using CFLAG -Wimplicit-fallthrough=2 we get:

  audio/audio.c: In function ‘audio_pcm_init_info’:
  audio/audio.c:306:14: error: this statement may fall through [-Werror=implicit-fallthrough=]
    306 |         sign = 1;
        |         ~~~~~^~~
  audio/audio.c:307:5: note: here
    307 |     case AUDIO_FORMAT_U8:
        |     ^~~~
  cc1: all warnings being treated as errors

Similarly to e46349414, add the missing fall through comment to
hint GCC.

Fixes: 2b9cce8c8c
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20191218192526.13845-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/audio/audio.c b/audio/audio.c
index abea027..f63f397 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
         sign = 1;
+        /* fall through */
     case AUDIO_FORMAT_U8:
         mul = 1;
         break;
-- 
1.8.3.1



