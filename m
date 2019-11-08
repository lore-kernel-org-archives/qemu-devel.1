Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F6DFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3C4207FA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcDI2rDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3C4207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT803-0001Zq-IK
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT7yy-0000g2-VJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT7yx-0003On-G5
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:23:36 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:34396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT7yx-0003NU-Al
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:23:35 -0500
Received: by mail-ot1-x331.google.com with SMTP id t4so5868478otr.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OXw3yO1bZZ7tOppOthN87xDHKGTjp1pYs1e0WQ4s494=;
 b=vcDI2rDQ9XgD6GmsF+Hmlkzd3KtA3d5wAuOPOZtvyWNra8Qykt4SZB9o9V1lX3cMnJ
 sYrCWisLonLF1Iu+XhdHrrzf2tbUfyk5rpeW8y2A8qaKUERICAAWCdYCvOyM06vd+/ka
 qQmr/56XSWVMV5V3rMaN0drpSzQexApJTdZrOICrctmFtX9l1aGxtwyoifz990mHEVhE
 Is3+LTr5whkSRI5GwXUSNW5tRKMJZHdu9NJ4UJohp5HKWD+b03YfbJCOfLKBC1fWXtu2
 Q5VO5fXEb8QwlVF9MemuorKFJYxtERpjdEp5PSkTmhEY4qPXwVH7X/oRhpXe6TNKmDJt
 dINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OXw3yO1bZZ7tOppOthN87xDHKGTjp1pYs1e0WQ4s494=;
 b=MW//JS0YAppvF4J9ZU8M4apDXhms2xGyxB0A4npLTTh6evJMpiQxYaPfuha6WDamcd
 AR0tYjBZMu3WsWcmicXlcseOPMkI17ISZoM2BVZGDikj93nU6ncSBqjkk6BHu4C5RhZw
 51pz/cI1G8WJMTl+gqQIEnfEwPVq25S6yk4W4GS0D56ylJYQ8V7WKZeD1omTK/2MP9uP
 O35EjPyK3W3G/kNKbzI0YP+ErrQgNbVDdrxlTFHDU5uVLceQaSOyUkXvWWUeTDKTmyPn
 xBj6qtb9Xl+VOc7JcSvQuua0ZYdFff134LkbFouiJlocGh4ErYAvp/UMQL7dbe5QJdIQ
 1fPg==
X-Gm-Message-State: APjAAAVyo8b7NLqEBnxBfMckDl5nkZ4eyJoxWdZ031WL6yhkvPDn2Yix
 GXEafJVE6BOfYoIHTrPkQURvmcMKIARG9Bb1d3+3mnnnC4o=
X-Google-Smtp-Source: APXvYqyL8JnBG4HY5ZIZdmnY+gofafWkA7MC1zUUkqjMol1xeFMy2t3vYHDosf9+halUumfx/4qlBE3wYJsVeHM7/Z4=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr8972399otq.221.1573233814201; 
 Fri, 08 Nov 2019 09:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20191025063713.23374-1-alex.bennee@linaro.org>
 <87lft9rnfs.fsf@dusky.pond.sub.org> <87lft8lvdh.fsf@linaro.org>
 <874kzw60bp.fsf@dusky.pond.sub.org> <87h83hqiph.fsf@dusky.pond.sub.org>
In-Reply-To: <87h83hqiph.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 17:23:22 +0000
Message-ID: <CAFEAcA_cBSw_M4qkMjixofr9wMrWQenPyjwi_qruhtz=BtPXqQ@mail.gmail.com>
Subject: Re: [PULL v2 00/73] tcg plugins and testing updates
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 Nov 2019 at 12:42, Markus Armbruster <armbru@redhat.com> wrote:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
> >
> >> Markus Armbruster <armbru@redhat.com> writes:
> >>
> >>> I hate to interfere with the merging of working code for non-technica=
l
> >>> reasons....
> >>>
> >>> This is a plugin interface.  As I wrote in reply to v4, I'd like to s=
ee
> >>> a pragmatic argument why abuse of the plugin interface to circumvent =
the
> >>> GPL is not practical.  This might include "not a stable interface", "=
you
> >>> have to link with a truckload of gpl code", "the set of things you ca=
n
> >>> do is deliberately extremely limited".
> [...]
> >>> If merging this could be delayed until the licensing ramifications ha=
ve
> >>> become a bit more clear, I'd be obliged.
> >>
> >> I'd rather not unless we can make an exception for late merging of the
> >> PR. I've worked quite hard to make sure everything is ready for the 4.=
2
> >> window and I'd rather not miss a whole release cycle on a
> >> misunderstanding of what these plugins allow.
> >
> > I think there are multiple ways to avoid the nuclear outcome.
> >
> > Coming to a conclusion before the soft freeze is the nicest one.
> >
> > Making an exception for late merging is another one, but Peter may
> > prefer not to.
> >
> > Yet another one is merging the pull request before the soft freeze with
> > the understanding that it'll be reverted unless we come to a positive
> > conclusion before say -rc0 (Nov 5).  I'm confident we can work it out i=
n
> > Lyon.
>
> The series has since been merged, so just for the record: we did.  The
> plugin interface looks useful for its stated purposes, yet pretty
> useless for GPL circumvention.  We'll evolve it deliberately to preserve
> that property.

The one specific thing that did come out of discussions at Lyon
was that we'd like to have a basic "check the version" to catch
mismatched/out-of-date plugins; Alex has a patch on list for that.

thanks
-- PMM

