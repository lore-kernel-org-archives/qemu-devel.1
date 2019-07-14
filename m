Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5650EC73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 17:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18ACD20644
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 17:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMwP/pNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ACD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmiKx-00052i-OR
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 13:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hmiKm-0004dr-5p
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 13:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hmiKk-0001oN-UE
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 13:30:48 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:36817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hmiKk-0001n3-Op
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 13:30:46 -0400
Received: by mail-oi1-x22d.google.com with SMTP id w7so10958456oic.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YsZCMh28wva8rQf3jFCirpyC+pj5GXbhzeTV8Ad+56E=;
 b=NMwP/pNQGawfRJQDb5lRxgUg+t28WuvOXq+cd+krjfhJ3L6vQtRv4Gv01e/Q0hl/rm
 TL8OK4yWy8EeOp686f1Iyd3fq6mZ/C01QPOSt2TwNv9og+9rH2qNyO1KXlk280Zl9j8M
 BiKCEbjRwD8v6vJSGJEG7frK0socOv8RRo+XzckuImWru8vttfhal17eMe6bIgxV2hPH
 RNWFGUPjL2U+9N/r0xIblXEOUPycLXnMtg+KcMLBkzbNxOYEFHeD4Q/9edC0G9613kUL
 ZQhrV/VumGcR1JjSW6FJAxS9L5bDhlrNgw8Q2TqBIVjwcu4qXCf0gdp3o6/fgC5QE83l
 t7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YsZCMh28wva8rQf3jFCirpyC+pj5GXbhzeTV8Ad+56E=;
 b=Hv/VbL3WGio+lei8BvDp8nkxOP6+Igo21XimsSTyb5QmjK4cm+rjBopQ/ho/f4o5pR
 S+IjofoWCzl9g+iB7A6IP46DQAKKgHbyFXe5LfoCwH/H9Qo3E7K5ouhF+XO9788J04Dg
 xB0YxQfxOYjtJvT0lNgwwMk0HnsJwYQqClh1l71sYLLrzDzfkoAOqXxANqbQJMyYXxzA
 5rntI5+xBigoXXlQc2IdE5Yvwz1BzcmtfhjVbyyJubXNNOvAvscuXqnmac8iffq2Er6+
 E9Kvv6VtZW+STahgGbSKon7KHLM5HIO8N/oorzALFHQKfnMpdS9A4aCFvWrOzhzu3vcS
 XcHQ==
X-Gm-Message-State: APjAAAXIOw7gb3KeVzVPnfcJhmUcULUrTaXDoGLtonCB5EskmMdPjJ+r
 u8WeTizSSAkQDwYE1LtOp1LH+Hm56RFY7CrTryNIMg==
X-Google-Smtp-Source: APXvYqzsqBNSo26omh85CXjU07zPB20a/cYMGLxtjzWNLLhHRxqloMemDl/U4cm6i9fmiTffKzJFlXaGULd52h2OHTk=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr10117272oib.146.1563125444784; 
 Sun, 14 Jul 2019 10:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <030a439f-bb17-8232-bd1c-3585905e8feb@weilnetz.de>
In-Reply-To: <030a439f-bb17-8232-bd1c-3585905e8feb@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Jul 2019 18:30:33 +0100
Message-ID: <CAFEAcA-ZEsX2nf7OmLmBE+v3VLHYQo60m8Vay28o7VNVgcn_ig@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Subject: Re: [Qemu-devel] [BUG] 216 Alerts reported by LGTM for QEMU (some
 might be release critical)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 13 Jul 2019 at 18:46, Stefan Weil <sw@weilnetz.de> wrote:
> LGTM reports 16 errors, 81 warnings and 119 recommendations:
> https://lgtm.com/projects/g/qemu/qemu/alerts/?mode=list.

I had a look at some of these before, but mostly I came
to the conclusion that it wasn't worth trying to put the
effort into keeping up with the site because they didn't
seem to provide any useful way to mark things as false
positives. Coverity has its flaws but at least you can do
that kind of thing in its UI (it runs at about a 33% fp
rate, I think.) "Analyzer thinks this multiply can overflow
but in fact it's not possible" is quite a common false
positive cause...

Anyway, if you want to fish out specific issues, analyse
whether they're false positive or real, and report them
to the mailing list as followups to the patches which
introduced the issue, that's probably the best way for
us to make use of this analyzer. (That is essentially
what I do for coverity.)

thanks
-- PMM

