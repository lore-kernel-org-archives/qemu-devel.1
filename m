Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9DFC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654F52076B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mdv9Ev0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654F52076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB5G-0005Gc-IO
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEArY-0005Dd-5A
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEArW-0007Vj-Pd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:58:23 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEArW-0007Tg-EB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:58:22 -0400
Received: by mail-oi1-x241.google.com with SMTP id j5so5374238oij.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6tLG0UvowYMxwNr6UXAFjrYE3UP2cWO9OOJLVI6SNuM=;
 b=Mdv9Ev0hWdBHO5UtWJBB5vCi54nNKxRYMIn7zCsdg1tggsr/dFr1x5TNXD+4ERd0q2
 PUoF44Wb4BkSNPkR9ulesNTcwjCkGsbALj4ZupRv8XsmzqWwS5YJXopOOx8syMeK4533
 7eJYFQUad/uIAzsDKrZnKv5hZtUuKt17hNXGdkfIJoDgY97TICZViYb6603+aR6OzAIb
 2WSTWc2I0/1ENQjAE2ngPZCWMxZ8qIWEyPqceeV2NDusE76aX2/SupifuU1JiiZ96QMT
 fuESbGTlTjfcLIhal4/lii+GTNk+pVzllv8CdXvcxNo+Wm9dlKrXPl602p7K7WcrqKHS
 8gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6tLG0UvowYMxwNr6UXAFjrYE3UP2cWO9OOJLVI6SNuM=;
 b=uSg/0QaLl86+ehyV7DIR/qyWPdEgTR4OeSdb0sYeqzK1kFPiEVHPoLfXwshTQ3M4oY
 rEmYwV1sn6HjoXyD8XbP6i4hq8gSd0VdFugzt8hFGWLpNfMl4bMbQ3aTbbSN8Kpiv4vv
 LfWbovBTyEINfRYoyqhDSYKh2ZaP3yYqXE8IRbS8ttEYZKrvtAwH0IQlDAAFNpwAXclK
 E+G5Pbkp7YfpeNW5ZrgmJ4ghmOwsr8FrhGl7+7bZdomjVKbhMajjMk5Uyj2a9P6Zhkm2
 jFxbQesOscxt48jKUuyd1SMsgVKWcIXvqUR11nLlHYOAHpAb8E9rWQ3QhzONX2M/MfhM
 bOPA==
X-Gm-Message-State: ANhLgQ30o3WJgE6bKF3Iw/x5O+ShF9kYwndSd0e8WwO2ftk1StJrfXed
 p0tH3XUmq5mzm1pVJ6X2bKoAEey0U6EJmjwap8hW0g==
X-Google-Smtp-Source: ADFU+vv2vA2intsubk2Bd6nP5kQhiggirL2UjEzCPX13Y5LB21Ez3zUMdijWMELThsGoCt5RUUEDjjKOmgDyl+5iHeY=
X-Received: by 2002:aca:c695:: with SMTP id w143mr3238753oif.98.1584446301315; 
 Tue, 17 Mar 2020 04:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
In-Reply-To: <20200317113153.7945-1-linus.walleij@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 11:58:09 +0000
Message-ID: <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Theodore Ts'o <tytso@mit.edu>, Linux API <linux-api@vger.kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, stable@vger.kernel.org,
 Florian Weimer <fw@deneb.enyo.de>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 11:31, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>
> The personality(2) system call supports to let processes
> indicate that they are 32 bit Linux to the kernel. This
> was suggested by Teo in the original thread, so I just wired
> it up and it solves the problem.

Thanks for having a look at this. I'm not sure this is what
QEMU needs, though. When QEMU runs, it is not a 32-bit
process, it's a 64-bit process. Some of the syscalls
it makes are on behalf of the guest and would need 32-bit
semantics (including this one of wanting 32-bit hash sizes
in directory reads). But some syscalls it makes for itself
(either directly, or via libraries it's linked against
including glibc and glib) -- those would still want the
usual 64-bit semantics, I would have thought.

> Programs that need the 32 bit hash only need to issue the
> personality(PER_LINUX32) call and things start working.

What in particular does this personality setting affect?
My copy of the personality(2) manpage just says:

       PER_LINUX32 (since Linux 2.2)
              [To be documented.]

which isn't very informative.

thanks
-- PMM

