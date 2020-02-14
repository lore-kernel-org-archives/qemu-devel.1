Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383D4C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0116D20675
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqeZXlIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0116D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2aHr-00078c-91
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 07:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2aHG-0006aX-9x
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2aHF-0008Qk-AI
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:41:02 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2aHE-0008Bf-Tc
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:41:01 -0500
Received: by mail-ot1-x343.google.com with SMTP id l2so2796075otp.4
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 04:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fCGxRe1S1VJduDqsTC3ZS7EVguAg68ZIVkLyBNIY5qg=;
 b=eqeZXlIHK45fP7q8LS4UbbexVVs9tsk9MINOx+NJkssXVgERbiP0MLj8On1uGpIbQz
 VR2X7qrWT2FAAeQb2+U1dKvMGsClf3FvhvQoWBXuNkSJ3Gh02H3rocb6ihN9Ca7JYCoo
 M2Jr3RBGjqWtXiAvUGBh4cE9N4i20U2hxDsGK1eKL9AyY5fUk2TpyhOya+LtYvbIHBQj
 6N+BURYH6/id6qNKB2Tul4bGCPYPg66atK+lItPLyIjkS3COgHfvibnICn8NA0AJlyrc
 pC7sZsKDYLaueTLre0jgmUy7WZAGrrPKR4b5DWmwODxetKlYlzWYbfQvUaGqhZO0maGg
 d96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fCGxRe1S1VJduDqsTC3ZS7EVguAg68ZIVkLyBNIY5qg=;
 b=jHqunnXZFyN5AobsCA1TkDMrspwl92yjTmCcvFkSqE0k9Ufz6E+gW/e6wh0mj+t7d0
 q02gRqXRbGIc1NWeurNLR1igxNqD9yeOgcOtPcF6sl0c2CjRklutgJdURv6XbwaWol81
 p4tsKYP3U6MoAO0duA1lEZXJeZ+dZ0KJ4voBZITMGtoo7CDEx3pcv+o3IGuS6MwRMfa4
 wuVmsU+mcwMHsSRAE6OcenZbHqJhimyIyC7ZRBm1JtUTk57QMoC4hj8seW1VVcATZ3/K
 bFGtBjfxq8bSjkR5zdpI1oYRIICAorE+j9q40LvuHcNPhEhxMXESrHvf8yxRlpfiEaPi
 kbvQ==
X-Gm-Message-State: APjAAAWXvWMeBa9KJX5mowYj3d7LlUEcwbD2TYB0x5pPyfq66UAiv2vL
 9FL/oD/bngmqDJIMJHepF1M3nSPjBFG8OLLEcxt6qQ==
X-Google-Smtp-Source: APXvYqzbwRw1QJQ6Xqb4cCXNAIDQCzhXD1NdhTyqUhd6mqLiqoRdDKkNbz5xvNqIlzLBKBQCyuO0GQ2uA/Vpf+IR7tk=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr2107505otq.135.1581684059844; 
 Fri, 14 Feb 2020 04:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-6-peter.maydell@linaro.org>
 <874kvtxs4k.fsf@dusky.pond.sub.org>
In-Reply-To: <874kvtxs4k.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 12:40:49 +0000
Message-ID: <CAFEAcA-xXauthaN9yxrQztg7v7Z3ru8GXouAQ+Y7hviEL3F7Lg@mail.gmail.com>
Subject: Re: [PATCH v2 05/30] qga/qapi-schema.json: Fix indent level on doc
 comments
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 12:36, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The texinfo doc generation doesn't care much about indentation
>
> Let's spell Texinfo with a capital T.
>
> > levels, but we would like to add a rST backend, and rST does care
> > about indentation.
>
> Nitpick: an rST *backend* should not care about the doc generator's
> *input* format.  We actually intend to change the input format into a
> domain-specific dialect of rST, as you state in your cover letter: "This
> series switches all our QAPI doc comments over from texinfo format to
> rST."
>
> Perhaps:
>
>   The current doc generation doesn't care much about indentation levels,
>   but we would like to switch to an rST format, and rST does care about
>   indentation.

Works for me. Let me know if you're OK just making this kind
of commit message tweak/minor fixup and sending a pull, or
if you want me to roll a v3.

thanks
-- PMM

