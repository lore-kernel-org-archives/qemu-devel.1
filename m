Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BF0C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CCA206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKeiyLpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CCA206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLfY3-0004lk-7g
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jLfXW-0004Ig-G3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jLfXV-0008PW-H8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:08:42 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1jLfXV-0008PE-CU
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:08:41 -0400
Received: by mail-pg1-x541.google.com with SMTP id r4so1105817pgg.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 21:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VY8EXWInn53xWStAWvO0Odlxm9siUurzI0xC2KnjtOs=;
 b=BKeiyLpGmhSgTyILSnFrd4Wy2ApL6MHMtv/3VwSFh4UdZhAZR1MbNARwl8B1BfBWhp
 TpVXjHKEpVNIQmaMiRkHAkWmCQKtpokKaTvYtVbzRX9SOrVODFGrGkOOzLQGYN0EvJJB
 TGpkf0ntrxNYYj/yc3BF0v3kR8Fj3YHH0dbWNSQrStXiipTEFmQ2JriuP5txU7Oao2DG
 MiBUYHE2k5zUxIxOAZMbVEk8ZYJTywL54M/Fing9xJOwU6p5+CeczryyRYCk/d9lj5Tl
 49z2f5OR6WMh4x+94DVbSwcqFbH8XZHs4/CssW17lOQY2GL63m6EdScmIL1P2/4noZj+
 4hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VY8EXWInn53xWStAWvO0Odlxm9siUurzI0xC2KnjtOs=;
 b=itIW0F3RTV2JOHr2UzDYW2CKUOthJKOSJIzWNBcb9HeJpXl7pb3U3Y5epASoDmeQgj
 wWx5VhJTDWSd2wPJkSK1dtotrVcWDddcugY1yoXVW1nKTvmk6mLn9r9Gb5cOwt1WBdD7
 DEwmXBsEFWy2eMbjaxA0CjufR4BY+Pi1ZZkuLDWCfk8pGx3rudLABTbEyR/5z3jOt//J
 o3hFY8bKsSYXY/FlzK6gQMN3hOepYjcXxxKq9vz4tT35G9WFGCOMUQD5lfQg9FXEFE2R
 mkwc4lfAZfHFvbut961+fQR+53FSrAavb5KKcGPA5FypS0kL1dy/1Aar6v9L6Dabnh/o
 0HrQ==
X-Gm-Message-State: AGi0PubIQliLmwxh9zIEMmlyIqMcd50Ly51j3qZh1SxLJvVerHEADHK6
 LETMp4PZpvNfVrTcDF2lWHJwzvsXIsClw3m1auw=
X-Google-Smtp-Source: APiQypK8eHIFZ0bJYnwWIzXjcNO3vYQ98r+ehOKnKVl20Z7e1spnwzwZsUs7DJRUwdeWeOfkzVdweKFZyUWt065tdt4=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr696458pfj.130.1586232520238; 
 Mon, 06 Apr 2020 21:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200407030938.26537-1-richard.henderson@linaro.org>
 <CAMo8BfJ9+fnA2xp8PMKm039oW-qVtTxpON6Ux=tkBySS=cQhxQ@mail.gmail.com>
In-Reply-To: <CAMo8BfJ9+fnA2xp8PMKm039oW-qVtTxpON6Ux=tkBySS=cQhxQ@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 6 Apr 2020 21:08:29 -0700
Message-ID: <CAMo8BfKW5NE7jPGbzk10_chUeSbHj5GPOjA9WoFOB9Wsj27tsw@mail.gmail.com>
Subject: Re: [PATCH for-5.0?] target/xtensa: Statically allocate
 xtensa_insnbufs
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 6, 2020 at 9:04 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> index 376a61f3397c..278415ae0e06 100644
> --- a/target/xtensa/helper.c
> +++ b/target/xtensa/helper.c
> @@ -96,6 +96,7 @@ static void init_libisa(XtensaConfig *config)
>
>      config->isa = xtensa_isa_init(config->isa_internal, NULL, NULL);
>      assert(xtensa_isa_maxlength(config->isa) <= MAX_INSN_LENGTH);
> +    assert(xtensa_insnbuf_size(dc->config->isa) <= MAX_INSNBUF_LENGTH);

No 'dc->' here...

-- 
Thanks.
-- Max

