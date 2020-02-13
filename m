Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABCEC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F7D21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WgmC6wae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F7D21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2HFP-0001WP-5v
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 11:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2HEY-00017D-Jl
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2HEX-0000vF-B4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:20:58 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2HEX-0000u2-57
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:20:57 -0500
Received: by mail-oi1-x243.google.com with SMTP id q81so6361673oig.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4sj+ojd7EwAcIGFuGFpmrPQerfH/kv181SmGlfYNydY=;
 b=WgmC6waep2xFeOg27yAbzXdm8okm1aCvFmQC99fFOhHF+q0BEp7VMOysw1Cn0Ra2Bw
 EaC7nw/zxad6tIxSN4ZbvV/PsLIBuzgr3fNDGl+gQJ7P/o98DxPa1TsuJClqxgsDLDFZ
 fRz2VhdyIGQi8u1tah42rSuEuCVeP5xEQhDmTgTRG5Y9pup1G1lo3sDZYdqnOYJHy3x1
 ioe9WPkdbbVbgQCYt6wdcEdkGi3kNxSMXDKhxR0F3l9HyFx06EQINw4R4i5mtAjXYpuj
 CvYOFeSm8sshWjmkWiV+efSzE/+mxOPXoJzDS5dYA+vkjzdegZHNyo6Q7RjYUgzDOC/2
 rYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4sj+ojd7EwAcIGFuGFpmrPQerfH/kv181SmGlfYNydY=;
 b=XmLB8/27CXmqYCBOZPssTKqbYo4J3RA/7plQL8fH6zakKTnp3p20uwZoDwiRIjW1BE
 oaLdun3X9gYWdPelyLoeWnKnOSMXCzV4zWt5JWd3nolNt+mQnDyWiz4nq3zYKHE8R74q
 AJY1hhKcfX+dmQmYgtBUyo0ggn1sNXCeFvRTUzswtixw5oQ67QS8Pk7aOIQ2Mcfky+d/
 EcsiT9wQljShnXhzWGH7MZaQ7F2BT1IljA8ZEuA+ivYp1I6xZ7BH4saRdFwGtBtLH+Cj
 U0NbFZowOK4XT9jW4cahjvS5FDaCEm5OzE2Fi0msYNQ8+pniwEjAnSab4aXchgFLTi2D
 iNnw==
X-Gm-Message-State: APjAAAUUl4FG5oHSirgDRhkzY84MMDMgNZ4IjPh0xlNXId+ze186p7Bh
 1VDzxxEL0mDldjJdI2gPRD+yVuw3Ax+p0OWeyyGfGQ==
X-Google-Smtp-Source: APXvYqwvzuHZmBjMRPa+aDwR0xzfQ8qNzTuFMca3Kz2cpnxf8LAN6mWwzn4R4qFDp4w2WzooQUy4YHFQM93brFyj2ng=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr3522034oid.98.1581610855969;
 Thu, 13 Feb 2020 08:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-7-peter.maydell@linaro.org>
 <871rr6vlu5.fsf@dusky.pond.sub.org>
In-Reply-To: <871rr6vlu5.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 16:20:45 +0000
Message-ID: <CAFEAcA-DExXM7E21d_0A-JBNwYzRp1KFB==esZaGsQbvqC04pg@mail.gmail.com>
Subject: Re: [PATCH 06/29] qga/qapi-schema.json: minor format fixups for rST
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 08:33, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > rST format requires a blank line before the start of a bulleted
> > or enumerated list. Two places in qapi-schema.json were missing
> > this blank line.
> >
> > Some places were using an indented line as a sort of single-item
> > bulleted list, which in the texinfo output comes out all run
> > onto a single line; use a real bulleted list instead.
> >
> > Some places unnecessarily indented lists, which confuses rST.
> >
> > guest-fstrim:minimum's documentation was indented the
> > right amount to share a line with @minimum, but wasn't
> > actually doing so.
> >
> > The indent on the bulleted list in the guest-set-vcpus
> > Returns section meant rST misindented it.
> >
> > Changes to the generated texinfo are very minor (the new
> > bulletted lists, and a few extra blank lines).
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> > @@ -767,17 +771,17 @@
> >  # Returns: The length of the initial sublist that has been successfully
> >  #          processed. The guest agent maximizes this value. Possible cases:
> >  #
> > -#          - 0:              if the @vcpus list was empty on input. Guest state
> > -#                            has not been changed. Otherwise,
> > -#          - Error:          processing the first node of @vcpus failed for the
> > -#                            reason returned. Guest state has not been changed.
> > -#                            Otherwise,
> > +#          - 0: if the @vcpus list was empty on input. Guest state
> > +#            has not been changed. Otherwise,
> > +#          - Error: processing the first node of @vcpus failed for the
> > +#            reason returned. Guest state has not been changed.
> > +#            Otherwise,
> >  #          - < length(@vcpus): more than zero initial nodes have been processed,
> > -#                            but not the entire @vcpus list. Guest state has
> > -#                            changed accordingly. To retrieve the error
> > -#                            (assuming it persists), repeat the call with the
> > -#                            successfully processed initial sublist removed.
> > -#                            Otherwise,
> > +#            but not the entire @vcpus list. Guest state has
> > +#            changed accordingly. To retrieve the error
> > +#            (assuming it persists), repeat the call with the
> > +#            successfully processed initial sublist removed.
> > +#            Otherwise,
> >  #          - length(@vcpus): call successful.
>
> Source readability suffers a bit here.
>
> Can we break the line after the colon?
>
>    #          - 0:
>    #            if the @vcpus list was empty on input. Guest state has
>    #            not been changed. Otherwise,
>
> Or would a definition list be a better fit?

A definition list does produce nicer rendering in the rST, but
it breaks the rendering in the texinfo (which interprets the
indent of a rST definition list as meaninglist and renders it
all as one long run-on paragraph). For the purposes of this
initial cleanup, I'll put in the newlines you suggest, which
have no effect on rendering output for either texinfo or rST.

thanks
-- PMM

