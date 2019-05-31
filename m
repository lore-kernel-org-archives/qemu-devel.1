Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183CBC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 08:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FC7265C6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 08:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GS2twhP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FC7265C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWcws-0001KG-1Q
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 04:31:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWcvl-0000ot-JH
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWcvj-0003yO-Mr
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:30:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWcvi-0003s0-CN
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:30:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id f204so1479418wme.0
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=nTKHyf+Tg6V3JFjX7S3qTj0yReqy9kAieC8xt0L9DKk=;
	b=GS2twhP4rLj0UkrfecbSwyUTvNdou77AEK7zcnlHC49+qOko46TQWv7RvZ7Hc/98md
	4hnata0pTncaLwrsyHWcbc0ceh0KDXcP4Erru8k+mQxRQrvBtCdNAKw+hrR7hEYhthtD
	UhQqDZOL05i52vry6dQCTbW9rnks7FnjRtvyvasqs8FHB3aMoxwo2VszDtHGq71AdIqr
	fK+2jy6x0LlMZeLIffYrwuECrLBdsr8wYaBh/eMA044Pkc5hpiv/t+/tjyFopMe7Diyh
	yPiTwiyBOOv11cf/Fj4nl80kcxdRkCOWZ40SuSn5jLMXyufKWk2STfDX0IdMoM6JBJrq
	xTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=nTKHyf+Tg6V3JFjX7S3qTj0yReqy9kAieC8xt0L9DKk=;
	b=PlmmrrDEu0bps7wHCPouliYwLnaAEkmnFUpoxBHxRcDJZDMm2E1e4rl5BJMxdHQtya
	H1DGfSa5U953OVvWmdFzWnwOLuZ2vYMMD7BY0bWyZpRjKagQfHaDcZlBFwrdC6cg2m79
	mqJfzjKHm8hteqoIgP0NM1L003tKaABkeq6mpW9a2+nTnIuufjBmTGRct49/EkJahHkO
	5QdRNhqZmvTV7Jeq+Z/LIvfJW2QAc+hMHwuWuGxIuOBgJNL0LWVulYdyMs1cMokvUaNZ
	JHXCaA9ES0HsqaXIwBS429DnZ/RTYkGaDlfXqXf6NCIo8sKrV/pGkRXssoOHd/OeRFnm
	vEyQ==
X-Gm-Message-State: APjAAAVs+JHTH5+ud2XmcSNfGWCcA1f014Rm0FDTrS4yks7J8s12vf4J
	hMM0f9y7BC8Sey8HAa8N7Mf7VQ==
X-Google-Smtp-Source: APXvYqxI/TbLgNs1dtmpe/AFDzb/7jgL3nHjj+XcV7Uvv+XrZnXvLj9ZNet9Ei5nFgB3V69jZvsQGw==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr4861676wmc.169.1559291425173; 
	Fri, 31 May 2019 01:30:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z20sm5325997wmf.14.2019.05.31.01.30.23
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 01:30:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7C05C1FF87;
	Fri, 31 May 2019 09:30:23 +0100 (BST)
References: <20190530143916.20255-1-alex.bennee@linaro.org>
	<ced800af-8f00-cc27-358d-57cb0e715e45@vivier.eu>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
In-reply-to: <ced800af-8f00-cc27-358d-57cb0e715e45@vivier.eu>
Date: Fri, 31 May 2019 09:30:23 +0100
Message-ID: <87tvdb3u1s.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RFC PATCH] semihosting: split console_out intro
 string and char versions
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 30/05/2019 =C3=A0 16:39, Alex Benn=C3=A9e a =C3=A9crit :
>> This is ostensibly to avoid the weirdness of len looking like it might
>> come from a guest and sometimes being used. While we are at it fix up
>> the error checking for the arm-linux-user implementation of the API
>> which got flagged up by Coverity (CID 1401700).
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
<snip>
>>  /**
>>   * qemu_semihosting_log_out:
>> diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
>> index 9554102a855..b7cdc21f832 100644
>> --- a/linux-user/arm/semihost.c
>> +++ b/linux-user/arm/semihost.c
>> @@ -15,10 +15,34 @@
>>  #include "hw/semihosting/console.h"
>>  #include "qemu.h"
>>
>> -int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, =
int len)
>> +int qemu_semihosting_console_outs(CPUArchState *env, target_ulong addr)
>>  {
>> +    int len;
>>      void *s =3D lock_user_string(addr);
>> -    len =3D write(STDERR_FILENO, s, len ? len : strlen(s));
>> +    if (!s) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: passed inaccessible address " TARGET_FMT_lx,
>> +                      __func__, addr);
>> +        return 0;
>> +    }
>> +
>> +    len =3D write(STDERR_FILENO, s, strlen(s));
>
> You could avoid 2 calls to strlen() if you inline directly
> lock_user_string() content:
>
>     len =3D target_strlen(addr);
>     if (len < 0){
>        qemu_log_mask(LOG_GUEST_ERROR,
>                      "%s: passed inaccessible address " TARGET_FMT_lx,
>                      __func__, addr);
>        return 0;
>     }
>     s =3D lock_user(VERIFY_READ, addr, (long)(len + 1), 1);
>     len =3D write(STDERR_FILENO, s, len);
>
>>      unlock_user(s, addr, 0);
>>      return len;
>>  }

It's a nice clean-up but I've just looked at what was going on inside
with lock_user. I guess g_assert(s) on the lock user would be fair as we
can't fail at this point?

--
Alex Benn=C3=A9e

