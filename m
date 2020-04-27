Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1847CAB322
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF700206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya9om7/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF700206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT3lC-0003xO-SD
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1jT3k7-0002il-Ar
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1jT3k6-0004N5-ST
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:24:15 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <changbin.du@gmail.com>)
 id 1jT3k6-0004Mn-Cy
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:24:14 -0400
Received: by mail-pf1-x441.google.com with SMTP id d184so9013739pfd.4
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=A8ZiC6wfGM4q6lYV/4Q9VsxqwJxJlB5dx+hBVyZCGNs=;
 b=Ya9om7/bUyzXzmXHqw2TCaSQyihLVV3Mh0H57vTwK5KOQ0nLQCuyf+MtLmV9+dcmet
 zmx6AZGUBUQrj0XdUjemWHPCNBKsSjRRJYUl7kgNiDjdK6Xxvn9rKtNO1Yp9wxWxammE
 Tcf3CaW+68OjDNDLMaiA2nMHJEYNOIaqdGTPpBPJMy3Zd7fCbopV3jE/pZfsytWJIM0P
 oeSTVr0BRkmP8M6Rjd/N/+mHtBTV91+xqM/Yj4mE2uHE+dey9E1TF9dofVO06NVI/szx
 iQMvhBdKYA48VfCC+pbk8K5YhBMFhzT/hQd0p5AmMSFsUycTwqkvxSjs54BR3dd6SD7m
 6nAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=A8ZiC6wfGM4q6lYV/4Q9VsxqwJxJlB5dx+hBVyZCGNs=;
 b=bO5qI46dKdkILSXadG3BkwsiXgZTXBX1/4toCldXUSzHjyCcgLydr6D/1I21d47nB0
 h/GCiJBV1Ugz77kTu7VfmR6FyiQYMzphlv/QxdHzqfibV7EAsBlT6yptqNTBv6k2qmVL
 9Xrt6bJPC4g/OlGaU5RUff/BA9w1igjwcEpF23ZhHgHPf7X+DZ6iopuQFcYEgYv5XHEI
 4z4t3qJbrRo33C3pd+ogUAI2D8XsevLHsE1aeDpBIsiq4+jZV7G25DHt3sgfcvg/OVOM
 eSapb6l65a2h2V9Wkktvz/0llhaHAwr2qO8cJulaLj3AxlibP72YM56SBr9hAttgipuE
 vunw==
X-Gm-Message-State: AGi0Pua15FI+5O3QMvB1RB0nE4+TkkwWsRr2+JHzMoHxxlYpEDj43Mg3
 CpVPOdmYGWipwqzQLjN732s=
X-Google-Smtp-Source: APiQypL/7BomcPcLVirTDY6XjitOa7U9lxjbxZsPaIruqeCqhw92j1jqNVqpvBByo4sCBQlhpGGBXQ==
X-Received: by 2002:aa7:9218:: with SMTP id 24mr23978453pfo.312.1587993853009; 
 Mon, 27 Apr 2020 06:24:13 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id z25sm12536092pfa.213.2020.04.27.06.24.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 27 Apr 2020 06:24:11 -0700 (PDT)
Date: Mon, 27 Apr 2020 13:24:10 +0000
From: Changbin Du <changbin.du@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] ui/sdl2: fix segment fault caused by null pointer
 dereference
Message-ID: <20200427132409.pvlyqmyujsrz6idy@mail.google.com>
References: <20200427121823.8094-1-changbin.du@gmail.com>
 <CAFEAcA8jBM5M3FLajekUpSzdqjHV-euBn+jU7GZ_ihHgjvKMjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8jBM5M3FLajekUpSzdqjHV-euBn+jU7GZ_ihHgjvKMjw@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=changbin.du@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 02:11:59PM +0100, Peter Maydell wrote:
> On Mon, 27 Apr 2020 at 13:19, Changbin Du <changbin.du@gmail.com> wrote:
> >
> > I found SDL_GetWindowFromID() sometimes return NULL when I start qemu via
> > ssh forwarding even the window has been crated already. I am not sure
> > whether this is a bug of SDL, but we'd better check it carefully.
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  ui/sdl2.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > index 3c9424eb42..7c9c93b951 100644
> > --- a/ui/sdl2.c
> > +++ b/ui/sdl2.c
> > @@ -332,6 +332,9 @@ static void handle_keydown(SDL_Event *ev)
> >      int gui_key_modifier_pressed = get_mod_state();
> >      int gui_keysym = 0;
> >
> > +    if (!scon)
> > +        return;
> > +
> >      if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
> >          switch (ev->key.keysym.scancode) {
> >          case SDL_SCANCODE_2:
> > @@ -412,6 +415,9 @@ static void handle_keyup(SDL_Event *ev)
> >  {
> >      struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
> >
> > +    if (!sconf)
> > +        return;
> 
> It's generally a good idea to make sure your patch at least compiles
> before sending it :-)
>
sorry for this. I don't know why my make didn't recompile it after
changing.

> QEMU coding style demands {} on all if statements.
> 
sure.

> thanks
> -- PMM

-- 
Cheers,
Changbin Du

