Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85112C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 11:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AB220665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 11:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap9qjYaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AB220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htVQ9-0003KP-E6
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 07:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1htVPl-0002s4-4E
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1htVPj-00032s-Tt
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:08:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:36133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1htVPj-00032W-N3
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:07:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id g67so61841444wme.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 04:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MYgdsVcC5OegUB2mLSIa6W/58FALZHARjp94FnSlMek=;
 b=Ap9qjYawwxKTLyzsVK/iPRTRJ+M0lAX6MueBd9yfdGhapYqgfWZn7yoHAJKTlx63ol
 0I44vMsSco90pgOP5D7KMczwcDrZQCTA++6msssS+g63mUAInOh/rtVK9h7/r/fdOtrf
 swPNvPqjjkUviok+pAlCHfH7kdoOI/hsrZhgkFlZ7QuH0votNW7DdGHWvj4jtDCCk5QF
 gm16m5fGEWBE7QV8Hk9xs/winNPPrIbe0SZxq9lvc6OVegtLMhwuBlIpfXuclmG/zU3q
 2djGnTHViD3AGxy7uP2MwdUYM8jJsNtS7ZrgwG935zcCX5xDkpNDWQm53JeoQ2AhMWR6
 W9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MYgdsVcC5OegUB2mLSIa6W/58FALZHARjp94FnSlMek=;
 b=LoRN0cm9K1J4M4kZaKKyxEFHjK1CV6vRoEYjB+wHQSoXbHRwxqbplg9yp+yEh1b7Tg
 kqrynPdcyCUiZFWM1IlFT8E67qRXZMPVowow3GRLT2vo9c8bfPmNzuR8Mp++tyVFjnr+
 4ZSflNo/2hDWt81la2EWuRzOsPqZzW5xhdlwnmCHFq1SLJjaDQsesLU9frbJFmoy/vI5
 aQTvdhzWx5QDdUAzNP13ZgqCVomx0lP90um4AskBREjcemLsrC5R08kHFEvfkaIDygPa
 XJmfiO91Ul8/vyT/dUKAsuJqTv/lSsGGFxffOL5ziQEaBK9M350wjfdEPTJQ/2qBdu3g
 0zrA==
X-Gm-Message-State: APjAAAUM62ABdd7s7yIrsAd7MSebBmAbmQjyG6+GD9OPL3DxmLpRcVQ1
 Ourb/DZjcLgiDEJFpScRaoIjC1cgVA0JiU84tE4=
X-Google-Smtp-Source: APXvYqx5SZy5qbTzjdWMsVqiZCR/ioz9DtcHceJPMbwwQj5s5tHxkGMcCtw3OK3xFqCPrbIRSZMxh6dSs/EsbUPG050=
X-Received: by 2002:a1c:a909:: with SMTP id s9mr4104132wme.20.1564744078267;
 Fri, 02 Aug 2019 04:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <156452993884.16169.12168229409049273970@sif>
 <3c6ebc55-9416-a467-cfbe-73d2df6a64f2@redhat.com>
 <CAFEAcA9Vs=N_kaO1_DHM=Azttp=1Ju=bKFMU3iZdt6-+J=Oq4Q@mail.gmail.com>
 <CAFEAcA-dcHzyH0ojrpbKuq-NALToxRLjCwz9MiZqNfN2=xLLsA@mail.gmail.com>
 <CAJ+F1CJj8F3PFBDiKanqGdZ22r9AmeqYuTDQFq0RjeayR7U4dQ@mail.gmail.com>
 <CAFEAcA8xnvg3QjwZV8Yhkk4g7rM2cHn5GYkmXngNDVVkE290=Q@mail.gmail.com>
In-Reply-To: <CAFEAcA8xnvg3QjwZV8Yhkk4g7rM2cHn5GYkmXngNDVVkE290=Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 2 Aug 2019 15:07:46 +0400
Message-ID: <CAJ+F1CLbtvJjhekp===mb6ggUYdGqXj87hkoErS2G6JesJ+tMw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.1.0-rc3 is now available
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Samuel Thibault <samuel.thibault@gnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Aug 2, 2019 at 2:44 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On Fri, 2 Aug 2019 at 11:31, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Fri, Aug 2, 2019 at 2:19 PM Peter Maydell <peter.maydell@linaro.org>=
 wrote:
> > >
> > > On Wed, 31 Jul 2019 at 19:17, Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > > >
> > > > On Wed, 31 Jul 2019 at 19:05, Philippe Mathieu-Daud=C3=A9 <philmd@r=
edhat.com> wrote:
> > > > >
> > > > > >   Unless there are any release critical bugs discovered, this
> > > > > >   will be the last release candidate before final release of 4.=
1.0
> > > > > >   on the 6th August. Otherwise we'll do an rc4 and release on
> > > > > >   the 13th August.
> > > > >
> > > > > We forgot to update the slirp submodule :(
> > > >
> > > > Were there any RC bugs in it?
> > >
> > > Ping! If we want to put this into an rc4 can we have a
> > > pull request with a justification on the mailing list
> > > sooner rather than later, please?
> >
> > It's about a CVE-2019-14378, that Samuel fixed a few days ago:
> > https://gitlab.freedesktop.org/slirp/libslirp/commit/126c04acbabd7ad32c=
2b018fe10dfac2a3bc1210
> >
> > Imho, it's not a regression, so no need to delay qemu release.
>
> Yeah, but it is a security bug, presumably, given the CVE.
> https://access.redhat.com/security/cve/cve-2019-14378
> suggests the consequences are more than just a DoS.
> I think that merits including in the release.

I don't think non-regression deserve rc4, it could be a stable update.

And Samuel probably thought the same, since he didn't update the submodule.


> > I would encourage distributions to switch to the shared library
> > version instead, so they can more easily and quickly apply updates.
>
> Well, that might be nice eventually, but it's not where we are
> right now. QEMU is the primary consumer of the slirp library
> and we ship a copy of it, so we need to coordinate about releases
> and potential security issues.

fwiw, Fedora rawhide qemu links to libslirp already, and it is also
possible to do it on f30 and earlier.

podman uses slirp4netns, which also embeds an old copy of slirp.

With the upcoming libslirp release, we should have what is necessary
to make slirp4netns link to libslirp.

I hope in the near future we will have better alternatives, such as
vpnkit or netstack or other.

> Could you send out a pull request which updates our slirp
> submodule to a version which just has that CVE fix on top
> of what we already have (slirp commit f0da6726207b740f6),
> please?

According to MAINTAINERS, this is for Samuel to take care of. But I'll
do it if he ask me.

--=20
Marc-Andr=C3=A9 Lureau

