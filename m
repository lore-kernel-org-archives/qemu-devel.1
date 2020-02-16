Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F9C7114E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 02:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291802073A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 02:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCXZJgQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291802073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j39QT-0002zp-DB
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 21:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j39Pd-0001ss-8V
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j39Pc-0003qD-BZ
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:12:01 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j39Pc-0003of-4x
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:12:00 -0500
Received: by mail-pf1-x444.google.com with SMTP id 185so7018541pfv.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 18:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Cb4yQdcURDdIX4q8WdA6bqODiwVHtN16RhHyChu6rSs=;
 b=sCXZJgQmbm9E+YbEwKaJO3rLCq8UD9SYwQFkprWDHNF9cR//vYe1baDUzBGFp9PSFL
 f27f+feBVsk+Vr59vrcxEwbJU4XpEsj8okbMtadIMasi5Bb2cM2BHdsE1JYa21GUYJgp
 wbC31Tb++DMS7msAUwmqilUksnog+3RJndcRMG9wCpy5RB+yY7aTafydkd8X6U/TzVFy
 1xiuAXqoGdzXgqjcKhReompSGAtacxMupg2oTzH1NQKLIuDpK6dXSaZHbuoQYI3q/d9A
 HMW1Jv+3PNjl2/mi7hgeIOvMuZjB1Qelm95D1q0SMZYYTzk5XZMDr6jX8aTYPXyP7vQQ
 F9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cb4yQdcURDdIX4q8WdA6bqODiwVHtN16RhHyChu6rSs=;
 b=W6XHB0ecM8TllKiFUatNyZ9jm1bKeIenC5r1l+eWBsGM6ygAo98XU4f7BrB2WtA1tM
 CBb9pcJn2A3LR0fX/BJjREVf6cvbv1lX3LkU/PQD/9YW+7WoF6TO9nM0mjaGJyGqPHf3
 NMP6rdIVe0IyLlr9FTfnSJwEMtV5w63Vxq+TWQO0VbqCeyoBzlpaCgPeXDW/ZZ39ieYs
 fcy8CSsjyx4tusw2aiq+51cu75/t1dz58qxiBqW3unCZDlBjEAiaDtlVIARt5rAE3rRY
 Oldq8EAoHA99NbdIw7H9s6ke2bI9Icm+RXy3cvTUVaYiNovqMPJcOJ4L0cb+u8vkpSct
 bgjQ==
X-Gm-Message-State: APjAAAVQSM6j2KXpl+izUDgGvj/0njlHyoMzcgB7KhuQUCjmbBR7J/Tq
 5RWq5D0SU5uZzc/Z7JHlPM/b0Q==
X-Google-Smtp-Source: APXvYqz/Ppvrsvq1mPWqOgbOiW/1zOMcDc666CxJlxzVTlUi2SeocSK+MbFER18JkspD2zL5JZvN5Q==
X-Received: by 2002:a63:4617:: with SMTP id t23mr11060090pga.444.1581819118753; 
 Sat, 15 Feb 2020 18:11:58 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 c10sm11906610pgj.49.2020.02.15.18.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 18:11:58 -0800 (PST)
Subject: Re: [PATCH 1/3] block/qcow2-bitmap: Remove unneeded variable
 assignment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200215161557.4077-1-philmd@redhat.com>
 <20200215161557.4077-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d501d7a0-c97c-2b88-4387-7b4f48b541f2@linaro.org>
Date: Sat, 15 Feb 2020 18:11:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200215161557.4077-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/15/20 8:15 AM, Philippe Mathieu-Daudé wrote:
> Fix warning reported by Clang static code analyzer:
> 
>     CC      block/qcow2-bitmap.o
>   block/qcow2-bitmap.c:650:5: warning: Value stored to 'ret' is never read
>       ret = -EINVAL;
>       ^     ~~~~~~~
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/qcow2-bitmap.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

