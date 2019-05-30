Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B3C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 15:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7107525CF3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 15:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw+mFOoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7107525CF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55551 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWMwy-0003dT-FH
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 11:26:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hWMw9-00035J-Cu
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hWMw8-0006ep-Iu
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:25:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <thatlemon@gmail.com>) id 1hWMw8-0006dm-Cl
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:25:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id l17so4470777wrm.10
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=to:from:subject:cc:message-id:date:user-agent:mime-version
	:content-language:content-transfer-encoding;
	bh=PJtLEoH5vpdQyQyomfFW/fhuefsDO+DnL8daoj0GhF0=;
	b=Iw+mFOoTezzmbp7HA3pWT1CoV56b0HP8T6uo2ylKVlc9Kkn2ed8ok3napmVv9qqsjO
	RbYZqo+aABhDltKR+EM7bYrIjtUhPCwIsMw2g8c3EXe20r517k60bC11VEEkWVDGaLs9
	HWX1i8w4YM+6fvFwvMv01YEKPRKY0eHrhvlALlzDE7bQCWzJ/zyRRAFnJQ38nxteLT43
	fZNfBIjGjcEHURtq8z7+w3696UEkAetY5U/f7F+wThT8snmfEKq+jQNvQ+xSB9gCDL4J
	kN5p+ZEZKmVnJQAyhj857c6UW7wggW07ajMnqdiHZ3n8Sh3H9fMAFKvCY1py8UOnwUwX
	8lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
	:mime-version:content-language:content-transfer-encoding;
	bh=PJtLEoH5vpdQyQyomfFW/fhuefsDO+DnL8daoj0GhF0=;
	b=IyGy9iUDY/3aU7GpSb+LvHmyxen8TjP/u87JXMm8imi+3191JNY6GqA5fnm8LyCgKi
	5Azw8ssr3l8N07uXGO1SJgftqLpIS5HErgYHAhfxBzluhxDozKbkDYgnpcVhRkNykqKj
	9PVTZM9/PQtqa2lUWYtof1ppHG3cvPW2gdIABWZQdw3hJFTwL1x4ju0aqeuZY57g+Df/
	yKs4NenFGeig1/558lby+1dmmm2iibGUbuU9ImvDhXDj3XVW2A3f5hPFERqmrnByYr7M
	XP+kZ19iNKOvGvDx3bmV/iHHhhpNE1aWRmiq9Nv5VyCBEmWQu7oup720u0U3TVn6qnKb
	uVPA==
X-Gm-Message-State: APjAAAXOuYWsY6xiZS1B+Cjsvwx8M8IL3rlaklKdhhOgGjVh65xBBLt5
	HG3GQb8+O24orLTwM3shBjo=
X-Google-Smtp-Source: APXvYqxnldVEpDhfMCQBotcGhxSOedWlHmi9GiaVKUlY1xubjghmLLzS9Jzuyw8rZr3W9zYw+v4PdA==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr3174297wru.87.1559229946955;
	Thu, 30 May 2019 08:25:46 -0700 (PDT)
Received: from [192.168.1.103] ([151.60.67.168])
	by smtp.gmail.com with ESMTPSA id c12sm4036204wmb.1.2019.05.30.08.25.45
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 08:25:46 -0700 (PDT)
To: qemu-devel@nongnu.org
From: Giuseppe Musacchio <thatlemon@gmail.com>
Message-ID: <9028dc83-82a2-fc51-b559-0020b2c0a892@gmail.com>
Date: Thu, 30 May 2019 17:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH] Avoid crash in epoll_ctl with EPOLL_CTL_DEL
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The `event` parameter is ignored by the kernel if `op` is EPOLL_CTL_DEL,
do the same and avoid returning EFAULT if garbage is passed instead of a
valid pointer.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
---
  linux-user/syscall.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5e29e675e9..32d463d58d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11329,7 +11329,7 @@ static abi_long do_syscall1(void *cpu_env, int 
num, abi_long arg1,
      {
          struct epoll_event ep;
          struct epoll_event *epp = 0;
-        if (arg4) {
+        if (arg2 != EPOLL_CTL_DEL && arg4) {
              struct target_epoll_event *target_ep;
              if (!lock_user_struct(VERIFY_READ, target_ep, arg4, 1)) {
                  return -TARGET_EFAULT;
-- 
2.20.1


