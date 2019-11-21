Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F7C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363C020672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvw0tdW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363C020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXrbd-0008HM-Eq
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXraP-0007Kx-Ei
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXraO-0005Jo-ER
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:53:49 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXraO-0005JS-9w
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:53:48 -0500
Received: by mail-ot1-x343.google.com with SMTP id n23so3856986otr.13
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=13mH7LoGaR8vUUTJZ9lh9VdYwAMZl5nziDtsFytuOIw=;
 b=nvw0tdW6DRwu67ZzR81OlVV/aiB8bQALDbv2VKvo35ifsXCJ7v+a6TKcLbH0LTOfXM
 JU5G5h9gz9qy6Z60QrkV3Ch2u4MRWAO/3KEIeXV1Jpp+sblwYqGrYsa+MdIebsKKDgoJ
 SJWA+ph6/9tbBbouhbH/yRU0dQYmPPR2tJg9Jsu4HrICxmhId/JjnPDltY9ouCpYsJKr
 JNk1XCOmBH1iccMv5GCannxJ4fjSKGt8mULXR5c3hDDYY6dfVilB7gRzZvQlUeNTpCnT
 7rLagUvMmIw74FzmUNHhQTHJMmSN+Te8hdDVaRRVbSJMofPD95suIxFohBpbVeM08qt+
 gShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=13mH7LoGaR8vUUTJZ9lh9VdYwAMZl5nziDtsFytuOIw=;
 b=GsuoJBGwlAiJ+b+H8VW2SFm4Is0v1V7POUkTNFPrnb/aZ9ss8qe2EkfnhyK9hU/LKM
 ze2vVCyUulpCurveZEPuASwjYzr89aDj6SAZtMs5W439Jb7g10TKZrcCkE+enlLqGLZL
 hfRF6cWrUAMtjQQjIpJNcpUsZEdoO+i4C0sr0NhxHb7woDmmHlGFk4eipB0FepJId2xc
 GzWAkMczGZBXpRBAulPlOAeTDyJWG/8dIkmOBOc4b48H7UiEhTYLEbNLs0XSSHPwa4Op
 wYSx2Qsx8NWTQNBoQu81e6aG4R2ijPvCZP7PG9jM7iX7AObFRQreEzy6pP+ynVjBSb5H
 XsZg==
X-Gm-Message-State: APjAAAXcCCzCLH+YTtkj2Mo0y5o2ni22rBluBjyrrE9or4EeRRtmZqHI
 Eq5lUh13Rzj3teT1r3PP3A0iDOcDVmlc7zHWbXA=
X-Google-Smtp-Source: APXvYqwaTHQzBr3+l1S2zyDBore9Bgwa9aw0zB6Rq57dDlaMf58aC7UeepWfnex+gk6iIoq5y+/LNECoyJDDb7vCR/E=
X-Received: by 2002:a05:6830:1383:: with SMTP id
 d3mr7731748otq.306.1574362427732; 
 Thu, 21 Nov 2019 10:53:47 -0800 (PST)
MIME-Version: 1.0
References: <20191120145555.GA15154@ls3530.fritz.box>
 <bc8c7e0d-861d-87c3-d63d-4bcf82d4cdb2@vivier.eu>
In-Reply-To: <bc8c7e0d-861d-87c3-d63d-4bcf82d4cdb2@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 21 Nov 2019 19:53:37 +0100
Message-ID: <CAL1e-=g8aHeLZdcx5J8xYf8x359tKe7X6p+v9ig7p-wJA739+w@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/strace: Add missing signal strings
To: Laurent Vivier <laurent@vivier.eu>
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
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 21, 2019 at 6:27 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 20/11/2019 =C3=A0 15:55, Helge Deller a =C3=A9crit :
> > Add the textual representations of some missing target signals.
> >
> > Signed-off-by: Helge Deller <deller@gmx.de>
> >
> > diff --git a/linux-user/strace.c b/linux-user/strace.c
> > index 3d4d684450..de43238fa4 100644
> > --- a/linux-user/strace.c
> > +++ b/linux-user/strace.c
> > @@ -146,6 +146,19 @@ print_signal(abi_ulong arg, int last)
> >      case TARGET_SIGSTOP: signal_name =3D "SIGSTOP"; break;
> >      case TARGET_SIGTTIN: signal_name =3D "SIGTTIN"; break;
> >      case TARGET_SIGTTOU: signal_name =3D "SIGTTOU"; break;
> > +    case TARGET_SIGIO: signal_name =3D "SIGIO"; break;
> > +    case TARGET_SIGBUS: signal_name =3D "SIGBUS"; break;
> > +    case TARGET_SIGPWR: signal_name =3D "SIGPWR"; break;
> > +    case TARGET_SIGURG: signal_name =3D "SIGURG"; break;
> > +    case TARGET_SIGSYS: signal_name =3D "SIGSYS"; break;
> > +    case TARGET_SIGTRAP: signal_name =3D "SIGTRAP"; break;
> > +    case TARGET_SIGXCPU: signal_name =3D "SIGXCPU"; break;
> > +    case TARGET_SIGPROF: signal_name =3D "SIGPROF"; break;
> > +    case TARGET_SIGTSTP: signal_name =3D "SIGTSTP"; break;
> > +    case TARGET_SIGXFSZ: signal_name =3D "SIGXFSZ"; break;
> > +    case TARGET_SIGWINCH: signal_name =3D "SIGWINCH"; break;
> > +    case TARGET_SIGVTALRM: signal_name =3D "SIGVTALRM"; break;
> > +    case TARGET_SIGSTKFLT: signal_name =3D "SIGSTKFLT"; break;
> >      }
> >      if (signal_name =3D=3D NULL) {
> >          print_raw_param("%ld", arg, last);
> >
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>

Laurent, I have a significant objection over this patch (in this
form). Please read my response in this thread.

Thanks,
Aleksandar

