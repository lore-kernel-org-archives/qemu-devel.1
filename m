Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4C0C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D434D2081B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txot3Llf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D434D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWKK-0000OW-2x
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icWJe-0008H0-Jh
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icWJd-0003At-CB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:11:46 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icWJd-0003AL-3W
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:11:45 -0500
Received: by mail-ot1-x343.google.com with SMTP id g18so6561207otj.13
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4/Qwt0GouNX9aM/smKfTqvCUQpZ3KJlj3iVgRiG22vk=;
 b=txot3LlfUrdPFV8xcn0ktczbFaWdRP1NcTfchRBQkBGqH90l52P+tEJFZXMzQ+rolk
 TbQuZu0N6AHmidT+gG5Hh4cIc6xy2uumCVA1ZSUryVZNcRYTjBtGrfyO795gtClyltA9
 LNlLVIRMtFRGx4nIxvtXa6Re2lcf0yplU2TAmlLlfnWNpdg8BpxFpumnHqo6aQE40oEy
 7H1gWQ3u08m+kGhL6YTImwX9jcmtWkEF7iOiDACu5hVbRbDALgiv+hF7u6a6uG6NgcQ4
 b830G/n6nL7SqOeaqbgBDQtUwKAGG2HkrdVthEpQ+UWPquAFmPE2mTNArofaqyL+6yqZ
 SWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4/Qwt0GouNX9aM/smKfTqvCUQpZ3KJlj3iVgRiG22vk=;
 b=TW0pv+hEIbjG/RoVq93Y8vr2vpr58J6ppGhvMoHSKHuHrnyqVey7XvZpo09Wo9Mi78
 EK74HN/G+zt7gJLOIfEnDrHCDghPMI30dRikkejEXLZrZ35YpyVohofMobDHZoI2DYMr
 j4wJw6v3gQcNB0qs0S0NdDKHJ/BZ3P5yphqAwAcswV2mnl0zUXyG4N4oeILWX4YopBp0
 oqfnHO9MMgAjIFqAcNVwXZGAFhWcI8DU5hhT6G7VCubX+KxE4DxOVAbuJNPJZPIiIsoH
 gvk9ArDBECyCNWQQqFLOrFa92xjCgMyq1gd+6OAzdRA4Wen4VgH3zzBcSPnOQKqpE2n2
 Intw==
X-Gm-Message-State: APjAAAUR5zglO7SFNkha0jhMAnJuu38oAtTVDt7k9cIXRjk2pGvhl1sY
 3DfTBuUaQe7g2DqXy3AXwTpzZTPsXIL3oKCuMXM1jg==
X-Google-Smtp-Source: APXvYqwrdxglaHM3KUKhMSJK609w99Cskdit0Oyeklq+626ssgw7G53HY6EhmHBLglmIr8Un0Hh3R8/BWBW5gJtUC3k=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr2733664otm.221.1575472303955; 
 Wed, 04 Dec 2019 07:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20191129150508.24404-1-bilalwasim676@gmail.com>
 <afe9efde-7ac1-8607-446a-8fbf10accece@redhat.com>
 <8c956ae31e8f44a2b831a5030b2448b4@SVR-IES-MBX-03.mgc.mentorg.com>
 <CAP+75-X_POJfTO=gOUu1zCPtcfnQ5yemQo0hqB_s3jy_C17o9g@mail.gmail.com>
 <db2c5074-307c-d20e-73f2-9c2b44612d6f@redhat.com>
In-Reply-To: <db2c5074-307c-d20e-73f2-9c2b44612d6f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Dec 2019 15:11:32 +0000
Message-ID: <CAFEAcA89Zw+MUJzhwSx39qVv8cRVNgRf7fe1K1oLYVjZfur9Wg@mail.gmail.com>
Subject: Re: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support loopback
 mode.
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aa1ronham@gmail.com" <aa1ronham@gmail.com>,
 "jcd@tribudubois.net" <jcd@tribudubois.net>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "Wasim,
 Bilal" <Bilal_Wasim@mentor.com>,
 "bilalwasim676@gmail.com" <bilalwasim676@gmail.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Dec 2019 at 02:15, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/11/30 =E4=B8=8A=E5=8D=8812:04, Philippe Mathieu-Daud=C3=A9 wrote:
> > On Fri, Nov 29, 2019 at 4:59 PM Wasim, Bilal <Bilal_Wasim@mentor.com> w=
rote:
> >> Thanks for the pointers philippe.. Is the patch okay to be merged with=
out it or do I need to do a re-submission with the updated username ?
> > If there are no review comments on your patch, I think the maintainer
> > taking your patch can fix this details directly, no need to resend.
> >
> >> -----Original Message-----
> >> From: Philippe Mathieu-Daud=C3=A9 [mailto:philmd@redhat.com]
> >> Sent: Friday, November 29, 2019 8:38 PM
> >> To: bilalwasim676@gmail.com; qemu-devel@nongnu.org
> >> Cc: peter.maydell@linaro.org; aa1ronham@gmail.com; jcd@tribudubois.net=
; qemu-arm@nongnu.org; Wasim, Bilal <Bilal_Wasim@mentor.com>; linux@roeck-u=
s.net; Jason Wang <jasowang@redhat.com>
> >> Subject: Re: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support l=
oopback mode.
> >>
> >> Hi Bilal,
> >>
> >> Cc'ing Jason, the maintainer of network devices.
> >>
> >> On 11/29/19 4:05 PM, bilalwasim676@gmail.com wrote:
> >>> From: bwasim <bilal_wasim@mentor.com>
> >> Your git setup misses your 'user.name', you could fix it running:
> >>
> >>     git config user.name "Bilal Wasim"
> >>
> >> (eventually with the --global option).
> >>
> >> The patch looks good otherwise.
> >>
> >> Thanks!
>
>
> Applied with the fix for user.name.

Could you fix up the non-standard block comment formatting too?

thanks
-- PMM

