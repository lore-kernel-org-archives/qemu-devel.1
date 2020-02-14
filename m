Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523CAC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4D924688
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2da0WDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4D924688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2dDu-0001HC-CI
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2dCy-0007xN-K1
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2dCx-00081X-EU
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:48:48 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2dCx-00080k-8a
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:48:47 -0500
Received: by mail-oi1-x243.google.com with SMTP id d62so9776962oia.11
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 07:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xmDaE+Uwzz91yepIAcFrDQzcZ7v5TR0OQU1cs8r+QY4=;
 b=o2da0WDoNCSqozxVGa5MAcRnOeys8y3VYMXD/UcNnir5xTBNpsUFhW6HQRI7OlgTGI
 jCeoeE6WiIv+TPKz6mgfiMymv1DfZTlLnaFJOC9kkaO2cNkplCKR76W+MmeTsHHFp0R2
 Z5HBlGfGSOwgXxDKujxvFa7iPo8deOTQWOs4q2gtYF8A1iKlkGzyTOW7OicXtraoGog6
 /U7KimB9gK67X0dQgQA4UhpSU0IO95zOI64oguz6ghYQ1+qWrJvQueRHfh5juQAEM8Bl
 3b8chLcsI43QzOYmi6C77i8d1r3OLDaUBJ8XFtlTUKoYuHkKxk/iM3GlR4jnYx2ivjlX
 Aw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xmDaE+Uwzz91yepIAcFrDQzcZ7v5TR0OQU1cs8r+QY4=;
 b=FK/Vcfq2jn0DnlNLDP6E/d0Aq9Iqy9Ga0vCu+0GWNwHSxPUKhWRen/EIbHwRAP90uw
 lBYiL1vEu2zqUdpnR6bcKrOFjVaSBokO11D1WcuGkvSrKcPEhXDMizmB129sOTA+7VqG
 trws5B6FKQw1b9p06Bc0VPVZng3jDnxhefRAMjQtmOgkSQqIT3WUZZauU4t72MRupWkA
 yA5BwCEICu38LA2qwJFDw16FZxoOv5XAtSiVy1/NsrAbQUI56rBAM4Xn106WRqO7KhV6
 kUOTKABaK0SE+xATUdWaKLrJZZYojmJFPhUSap37JssT91KNOpqoOcr8HnIIdbbDgu3w
 ufXQ==
X-Gm-Message-State: APjAAAVGCmD9m/s8oJ52q0Vamp9BwPv1YnrVKnRUw6/2RNaY8Hkkjvbo
 TbtIiKwkOyECw1qM2Q49sHdLI8DsRAx2GRm1EXSWEg==
X-Google-Smtp-Source: APXvYqzh1t8+qvGh/YEiRUzQDajJDzdDzDBOBhPB1I+PkkEufA7ty6PeQJZAXKGW4E8PLEvTqJxyKG78JMfLy1g207E=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2355898oiy.170.1581695326489; 
 Fri, 14 Feb 2020 07:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-16-peter.maydell@linaro.org>
 <87wo8ptfh9.fsf@dusky.pond.sub.org>
 <CAFEAcA8fGvMk1mdOwrpYiYCiz-1vRUi6KOJkvHyLwoCpPNfLhQ@mail.gmail.com>
 <871rqxrx2n.fsf@dusky.pond.sub.org>
In-Reply-To: <871rqxrx2n.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 15:48:35 +0000
Message-ID: <CAFEAcA-G5Y+foaecpJD-O4f7Jycs5GVFXY9R+rTvQvCtcU=AZw@mail.gmail.com>
Subject: Re: [PATCH v2 15/30] qapi/{block, misc, tmp, net}.json: Use explicit
 bulleted lists
To: Markus Armbruster <armbru@redhat.com>
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 15:46, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 14 Feb 2020 at 14:23, Markus Armbruster <armbru@redhat.com> wrote:
> >> What's the rationale for the split between
> >>
> >>     [PATCH v2 13/30] qapi/block-core.json: Use explicit bulleted lists
> >>     [PATCH v2 14/30] qapi/ui.json: Use explicit bulleted lists
> >>     [PATCH v2 15/30] qapi/{block, misc, tmp, net}.json: Use explicit bulleted lists
> >>
> >> ?
> >
> > Just keeping down the size of individual patches for ease of
> > review. ui.json and block-core.json both had enough uses that
> > needed fixing to feel like reasonably patch-sized amounts. This
> > patch is all the straggler files, none of which had numerous
> > enough changes to seem worth splitting further.
>
> I see.
>
> Separating block.json and block-core.json is a bit odd.
>
> Mind if I squash all three?

I don't mind; the split was as I say mostly just to keep
commit sizes down, so if all-squashed-together works better
for you as a reviewer feel free.

thanks
-- PMM

