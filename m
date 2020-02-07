Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888CDC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525B720726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RP6xBJzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525B720726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izzvs-0004M2-FZ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izzv6-0003wH-JP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izzv5-00063K-9t
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:27:28 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izzv5-00062R-4M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:27:27 -0500
Received: by mail-ot1-x341.google.com with SMTP id j20so1565045otq.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 01:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6NKcJ++1RVpiMWyKni2qRxl3vg319yHM5dOzJtLhpwU=;
 b=RP6xBJzE12ciJbLqbTdNb128y8g8tV1Gw/p+rFarEv4N3Mwxvpf1iJRgoJUNOXjT3z
 X1AJOxKCP/xmiT4i3N6ICpuxh7QwATs8q8P5B08tfNa8ByVx9AhGn/nNNbCNcevzLtc3
 aSu3tx7RkGFaqwmqE6OR8NV2Ta7jzUs+z/cKpScITMkYsZwSmzsIlwkJ18VHN+GYPRnI
 sorIO9m9WSC1Dgic3mEPoKSGc3EDkzDvLfiR9ZgWnxjW3eX45/HLa/X+7NqHHopFQycH
 Fq6LHuT53SH4+KAiJU/gPZQWhGvG5BEKAoJez6Pmt5WY2/tzJ2eD6g6PN3NH5pBRdb5n
 d1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6NKcJ++1RVpiMWyKni2qRxl3vg319yHM5dOzJtLhpwU=;
 b=UJQrAvUPKKpQ9KxzoCcNVEp7KLYFKBz8kFfl+kTLBSI8h13RGsr+UX9leUkuJtuiw+
 t4Nxgn4lZX7oc3De+67YgOnIHQ2nlGGOxSNdcIe5lsGKbMEqknjTMVhrdDCdZlVCdHZo
 dj5O+LaNTk9M70zXSLYAcwmCkWvYtIBquH5qGOF0aKMimVwD/wLWG7djuvEQe7mj2EE3
 ttQNI3NbhXLUafONYWp0/KV6VXKtlPIUHuEpE6qDGhfW1QIfkfoCw0i9vkzd0KDBcK21
 jyhvhijSxjijjXy5dJFELxQds0wYSXyY86siTBvtH1tU9zdsQQYAc/QyzzEL3JD78vto
 On2Q==
X-Gm-Message-State: APjAAAUuA67tY9UlP4GFTAvc0l5Bzjal70PLUIlhkvKFofCd0jYrAO3G
 4tu4dMQN1ZuHYjfcgxu2YOKZyiMWgLkCAYgqnqCFew==
X-Google-Smtp-Source: APXvYqz/cFKfaScTKg9vJYY8xVklBexWZFsRN7rHP3VouJYgSeYRfD+8tytEhx+eoB3nnyQc6SARSHub1C+CvHnD8Uo=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr2017846ota.232.1581067646180; 
 Fri, 07 Feb 2020 01:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-8-peter.maydell@linaro.org>
 <87tv42u6fz.fsf@dusky.pond.sub.org>
In-Reply-To: <87tv42u6fz.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 09:27:15 +0000
Message-ID: <CAFEAcA8Z45L4+NTxTtQ-7XWUypv7QazpxSDQZJ2rwuF2VAGn_w@mail.gmail.com>
Subject: Re: [PATCH 07/29] qapi/block-core.json: Use literal block for ascii
 art
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Fri, 7 Feb 2020 at 08:50, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The ascii-art graph in the BlockLatencyHistogramInfo
> > documentation doesn't render correctly in either the HTML
> > or the manpage output, because in both cases the whitespace
> > is collapsed.
>
> Plain text and PDF output is just as bad.  Suggest "doesn't render
> correctly, because the whitespace is collapsed".
>
> > Use the '|' format that emits a literal 'example' block
> > so the graph is displayed correctly.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  qapi/block-core.json | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index ef94a296868..372f35ee5f0 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -550,13 +550,13 @@
> >  #        For the example above, @bins may be something like [3, 1, 5, 2],
> >  #        and corresponding histogram looks like:
> >  #
> > -#        5|           *
> > -#        4|           *
> > -#        3| *         *
> > -#        2| *         *    *
> > -#        1| *    *    *    *
> > -#         +------------------
> > -#             10   50   100
> > +# |       5|           *
> > +# |       4|           *
> > +# |       3| *         *
> > +# |       2| *         *    *
> > +# |       1| *    *    *    *
> > +# |        +------------------
> > +# |            10   50   100
>
> Wow, we're acquiring a second use of the '|' feature.
>
> It's actually broken, because the doc generator puts each | line in its
> own @example environment.
>
> Doesn't really matter, because PATCH 26 replaces it by rST markup that
> actually works.  A note in the commit message could make sense, though.
>
> But instead of making it differently broken until PATCH 26 fixes it for
> good, I'd simply leave it broken until then :)

IIRC I need to fix it early, because without the '|' prefix it's
a syntax error in rST because of the inconsistent indent. (Otherwise
I probably wouldn't have noticed it at all.)

> If you decide to keep the patch: can we keep the table aligned with the
> preceding paragraph?  Like this:
>
>    # |      5|           *
>    # |      4|           *
>    # |      3| *         *
>    # |      2| *         *    *
>    # |      1| *    *    *    *
>    # |       +------------------
>    # |           10   50   100
>
> >  #
> >  # Since: 4.0
> >  ##

Sure, why not.

-- PMM

