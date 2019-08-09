Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F50C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F07021743
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCmHOc+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F07021743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw2C2-0005jZ-Ti
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hw2B8-00056u-SM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hw2B7-0004Hq-4i
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:31:22 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hw2B6-0004Ha-VU; Fri, 09 Aug 2019 06:31:21 -0400
Received: by mail-ot1-x343.google.com with SMTP id j19so54062131otq.2;
 Fri, 09 Aug 2019 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x9z4SEeQla6rmDACSJZleWM2O1lvW+qJMcmmRggvV8A=;
 b=ZCmHOc+31wYa1C2mWsjR2WKpoTjG0gVRHTjX3lhibOAv7Q/MwCpCf7ZkIGx00opFSs
 fsGUoJLvTcN/KHrUZ4GLgQDOt5+mLO71OeA1MGfbCayeFagkO4YmipxqE/EAPL/fStX1
 n4QCEn37h4KO7zZo0NQVujKCQwll2FrgXUIVkYCE5mdaLJEb0/kH15xR8LV1wdieohwE
 ViJ1qTW401mpdpGbXwWnHQU/FCMzatZluBt3SFkl+kit1XPNti6lO/b9dV8e2GQ2eAAq
 1ZWE1mb24WwGO3nSa1x7zxkYgD31YNXfKMWnjDqBMJz0UQ8phCn3Ft2ST9zSWMnz3GBl
 wCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x9z4SEeQla6rmDACSJZleWM2O1lvW+qJMcmmRggvV8A=;
 b=M2LKnhHnWg8soJoakN8r3QCcvFwk+8V8dRKGrpPUyxvoKP96KZE8i+fqWrWVkvaB1V
 zRmE16FmGO9gmFtm2yqP8taJQiXTtyw5r1FdL8lyHqMUz0aNIjXs6VcKHiiHqIXySG1C
 zAbMpGSMPO2nuKzCeM9jgL811B+fGdVcHeeLzM1AditTbMmGx6bhIl4haOLn0NIAOpOI
 cbIltUyqMM42G8KuYHsXQZ1OqP9tMwpywZgcgEK+3bkg9jq8UyZrtIlD8j73Nu/rP+CC
 3+SMoQolFpiDStSmgEmFzDSonODXAedIE6+DaXUYwQ+ovg6KkXgVe3sgB2qO6AZAO7AX
 Wvnw==
X-Gm-Message-State: APjAAAWp9pgjjXKfZxwjoFad+yfcq3poGkTNfkvyh2/Or9BQm0PZv7hl
 4Y/FE6kzaq6GfRnVqVrmJOQJLknYVDRIotLDNrRdUc/r
X-Google-Smtp-Source: APXvYqzNlWaNh5Lv0/Bgk5d7T1R2xoFclTJ2DVuy86C7yreL661K+oTgMEz56iG5gOw8Qkwu5kLr/wYxSaqaLpgsFtg=
X-Received: by 2002:aca:abd8:: with SMTP id u207mr5883409oie.136.1565346679795; 
 Fri, 09 Aug 2019 03:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-12-richard.henderson@linaro.org>
 <CAL1e-=gwyGB4ibo_B5W1MpFy-9bB7=5juqTJVBdD9N6XFOOsSQ@mail.gmail.com>
 <0f37edc5-2fb6-c92d-fb47-a381af649072@linaro.org>
In-Reply-To: <0f37edc5-2fb6-c92d-fb47-a381af649072@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 9 Aug 2019 12:31:09 +0200
Message-ID: <CAL1e-=hWVfYVYySkMCF4NUkHbe=47qUTuAA0vK23TGMBzuA+PQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 11/67] target/arm: Add stubs for aa32
 decodetree
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:Stellaris" <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 8, 2019 at 5:43 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/8/19 4:41 AM, Aleksandar Markovic wrote:
> >     +/*
> >     + * Include the generated decoders.
> >     + * Note that the T32 decoder reuses some of the trans_* functions
> >     + * initially declared by the A32 decoder, which results in duplicate
> >     + * declaration warnings.  Suppress them.
> >     + */
> >     +
> >     +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> >     +# pragma GCC diagnostic push
> >     +# pragma GCC diagnostic ignored "-Wredundant-decls"
> >     +# ifdef __clang__
> >     +#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
> >     +# endif
> >     +#endif
> >     +
> >
> >
> > This looks more like a "band aid" solution rather than the right one.
>
> What would the "right" solution be, would you say?
>
>
The right (without quotation marks) solution is not to generate the code
that generates compiler complaints.

However, I do not say that this is a stopping issue for this series.
Perhaps at some time in future you can think of ways that would achieve not
resorting to pragmas. Obviously, in this case, decodetree-generated code
shows that it is inferior to human-generated code. Still, for now, go ahead
with this patch, as far as I am concerned.

Yours,
Aleksandar



> A couple of days ago Phil suggested moving these pragmas into the generated
> code, so that this need not be done by hand in the several targets that use
> multiple decoders.  That sounds reasonable to me.
>
>
> r~
>
