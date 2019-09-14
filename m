Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FFC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D686206A4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOb4AQz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D686206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9CLQ-0005F4-PH
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 14:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i9CKW-0004mn-GW
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 13:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i9CKV-0003K4-ER
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 13:59:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39399)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i9CKV-0003Ib-7P
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 13:59:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id v17so5381991wml.4
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NWUyEGPwuc0Q7Z50HZqva8FdhEC01fGpzAb17AMvhak=;
 b=hOb4AQz4GIyC6lTk8SnqaBzYRxRtplH2NAvkHeBt/wDrM1+vcnVgVhtHoiEBkmwM70
 LsPma9mwnfEvwdzrF4XdUiFvirY35HqlPxrJu6wn2yprDmjMMTr/5TxEpuH9O6zrPlXj
 3wPcr9oPqv/CnWleknnL7ySq5PescaA+OB4SzxLahrKGZXfRmd97P+jUFLqWfz5RUnQ6
 /Cz1eQu+iQd+b+UFI0zl4m9zYefz9f6TDGQp+o5r7U8Q80rJiOK0oUn49SvIPTRK+6+m
 9hiFab4RWuW99hiMEyrbeI6Ud3EQ1Q+6kjAwKrKr+YP1s93SAjrKxnJzuzUDKLA+ykms
 Ohrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NWUyEGPwuc0Q7Z50HZqva8FdhEC01fGpzAb17AMvhak=;
 b=pCBW7QGnBtrjl1juOqMbAWe9t/xtcHJMVMqsTtnbP3CPl1DiA79P/1vavSvDT5AskG
 VnyFk4VFYgXLXz5SGVt9tF9s5xB7+9BNLfQ0dqSdq3qAkpoJSRFGsCK4m4hpeONXimE1
 +NBk7DA6VDk9Wnl2jvAyy8KXPkaK73w8o0BnX0lAxRzlrqv6aVNFdIAlrZegN7bGs/W7
 BLQihI5edkGh7JhfLQ1JPE0lYSk9U0D91hKKXFHck3alVaprI1g1MKbSStqnlb6rZFNN
 qT9LLWqrAMNP7O0es7tnJ+h9CkWwKyl5rhbMqoQ6/Dw9Cn0BgGb3R/iG2wzSBa5OxcTC
 nxXg==
X-Gm-Message-State: APjAAAUBGGEhY/8Zz1UnVfZaQcBcPNduXd2gssuf5mLfJtFBNreI0K5b
 yICdg3L7ORktrdVwO9AyNFIfzA==
X-Google-Smtp-Source: APXvYqwRxlwrRqgCpXGuBytT5cxH4jOu9YceDbOGBh6qfWWFWoGuwJ42dQREIMgLUlPajYhMYxGwIw==
X-Received: by 2002:a1c:3bd6:: with SMTP id i205mr7700871wma.135.1568483965613; 
 Sat, 14 Sep 2019 10:59:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s10sm13328019wmf.48.2019.09.14.10.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Sep 2019 10:59:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 534661FF87;
 Sat, 14 Sep 2019 18:59:24 +0100 (BST)
References: <20190913134935.29696-1-alex.bennee@linaro.org>
 <6ef910fa-d387-faf3-4647-209beaf7886a@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <6ef910fa-d387-faf3-4647-209beaf7886a@linaro.org>
Date: Sat, 14 Sep 2019 18:59:24 +0100
Message-ID: <87v9tuahdv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] tests/tcg: add float_madds test to
 multiarch
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
Cc: 1841592@bugs.launchpad.net, qemu-devel@nongnu.org, pc@us.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/13/19 9:49 AM, Alex Benn=C3=A9e wrote:
>> +                    /* must be built with -O2 to generate fused op */
>> +                    r =3D a * b + c;
>
> I would prefer to use fmaf() or __builtin_fmaf() here.
>
> Although you'll need to link with -lm just in case the
> target doesn't support an instruction for fmaf and so
> the builtin expands to the standard library call.

I can do that - we have other tests that link to libm.

I was expecting to see more breakage but the ppc64 tests all passed (or
at least against the power8 David ran it on). What am I missing to hit
the cases you know are broken?

I've also experimented with reducing the number of iterations because if
we want to have golden references we probably don't want to dump several
hundred kilobytes of "golden" references into the source tree.

> I also like Paul's suggestion to use hex float constants.

Hmm I guess - look a bit weird but I guess that's lack of familiarity.
Is is still normalised? I guess the frac shows up (without the implicit
bit).

>
>
> r~


--
Alex Benn=C3=A9e

