Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8F7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 21:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E26222B6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 21:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXCRRnAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E26222B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXAu2-0002Hr-Hu
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 16:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXAtG-0001tA-MV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 16:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXAtF-0002en-Ow
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 16:18:26 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXAtF-0002eX-I7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 16:18:25 -0500
Received: by mail-oi1-x243.google.com with SMTP id y194so20439573oie.4
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 13:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QjMNz+4TePyGkHe+ygN/OynQIxVDQA/Cce3RiDNY9Bs=;
 b=eXCRRnArudFhBWR/jFuVsOIAdJxGBgnJu577jW31xzdYt0jgNEjbtHpGBi8d+6r8qy
 a8nzKfuZ2VPxJRu8+br1v0pJDyJ6BBuL0kqCEBonSbc2TT1dJVhKQl+ZI2R60OrMghOI
 aRZWu08xGYASqfQ/sE00kUVGj+AGKEjjsJBj/6gOdGx5tsKX4Bwv8buSxqIylRje3WPZ
 u+kI+FTPJ3ISsk6i+2D5MdgPPEEMjU7OHYz0Im4SHgpQsQmMvBAFDmQyR2cpQ7Fatar/
 QDFqX8vvseyIGO0eyWMhRw2x5bpKhkFip0GosPaCgqyKRT002mrzM8xSIZDd5WtC3xmQ
 idFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QjMNz+4TePyGkHe+ygN/OynQIxVDQA/Cce3RiDNY9Bs=;
 b=HQb1wdvS2eIArEBcJryeXvlH7OOi4h1KpRXitVVVrzMQybdssQf76AIPXc1q+uwKAC
 h9cx7KJ+WxExadGGsG/PItwP2pv8ctxjtmlIzTd0L5C1gEcAK6cJsGajT1RTpj0rQags
 Sfq4hQDJeVWHRATsoHTRVE9G6oFH3BjPThy4OK4GCYThzGRuyzyNJOwU8PPfRmXtoz26
 VHfRTyvKYj2kGZj1sI58YltcbXa3lpWqlY2mkbxYVAl+xkv56Qp7w/NuSN989MuoAcMK
 xPgYlMl3pWDIZDfw2rTaSSSTnWxO7rCOPP6ccL1t54mxevG3EC0CsUgUiokubiQVUDNd
 Ca7g==
X-Gm-Message-State: APjAAAUIpdoJH1OsnOo7SGCHDUMnYb14Dyui3hLM+z9MarvlwAv4Olip
 yUfAPzBlWq7XW5jfP22eUCQhMlgjiqaBxzHFelc=
X-Google-Smtp-Source: APXvYqxN/Uzy2QHdCjwsH8fwdt9+rbbP/g8B7Q1qlX+GYc3VrSpVAb7fbrYa2WN+UkWQJ+NXcF1CxSta0IdUO+Lc4Ic=
X-Received: by 2002:aca:670b:: with SMTP id z11mr5767576oix.79.1574198304693; 
 Tue, 19 Nov 2019 13:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-6-mrolnik@gmail.com>
 <CAL1e-=gKGJC4X9aNtj1SL7+s5UryNtEF81YcG4kvhjPNP247Kw@mail.gmail.com>
 <CAL1e-=gXr5KJ7W3_bnuBaupuz6jYr0LnAX7FXJ8+F8rJ=ARKxw@mail.gmail.com>
 <14d51697-9415-14b9-8f92-3ae3de2fca58@linaro.org>
 <CAL1e-=g6ctnzUSgq3eRn98nOMPJ88ucUNX7xc5MxCr6J=k4YMg@mail.gmail.com>
 <CAK4993j1a6Eo+FjM7rrOZgL7u955-fTXboyOWR2BriCcyFmCuw@mail.gmail.com>
In-Reply-To: <CAK4993j1a6Eo+FjM7rrOZgL7u955-fTXboyOWR2BriCcyFmCuw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 19 Nov 2019 22:18:14 +0100
Message-ID: <CAL1e-=gQF3CDiYnim6NCQu=n8=S8V4J0Ej8fMaWC7bzLJKFjjA@mail.gmail.com>
Subject: Re: [PATCH v35 05/13] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 9:09 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> Hi Aleksandar et al.
>
> how is it going? should I rebase or not?
>
> Michael
>

I am just in the process of taking a detailed look to the whole series.

I don't have any serious objection so far, I may just suggest a couple
of things that will improve readability of the code - so nothing of some
really serious nature.

Stay tuned (and be patient). Will hear from me soon.

Yours, Aleksandar

