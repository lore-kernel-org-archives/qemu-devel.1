Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9692EC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626DF206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lre//vQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626DF206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j22U8-0001pj-L2
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 19:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j22TY-0001Br-GC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j22TW-0002Xe-EW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:35:28 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j22TF-0002OZ-3O; Wed, 12 Feb 2020 19:35:09 -0500
Received: by mail-oi1-x244.google.com with SMTP id c16so4027017oic.3;
 Wed, 12 Feb 2020 16:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=neCJl8v2+5Bvn9SnpKvBpQ8bVOHvbi7jlXoVjtff8vg=;
 b=lre//vQxJjPmaNAlx+N+DcgavsifRIRr9JJDazR3zVybwkG0DXrwHuEEqrr7qAIS9G
 J/P2dZGxnfOYMN2N/RHBQ1aOQV5OHObLLeJYJ+yMSsuAZTMg1e0iTjjdoNhJF2819cEO
 /wtb/ZhOJzBc3u8spVaLI8vBZH5mkXi9wpBuGChgQ4zS/wEkqDpi7QLbMwrALueUlJc8
 EdAOcaYKwQCdjPLeIHzE0sl4oWzULfAO73+u9/udFU/T/O9AOjcIb0xqpUnvJ0v/+Fvx
 RoHxD2xMr5kf/rDp36giD/2jC/VJeQtmJIayBwVch3ef1CNBkjI6829tb07uZP6uVCed
 5cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=neCJl8v2+5Bvn9SnpKvBpQ8bVOHvbi7jlXoVjtff8vg=;
 b=lNBjPdK1yB347LSWpW/C2KrWujtznY0bcFK7mXS7HBFlfLH8wb8SOhY2kkx3HZzUgi
 Z5dZ+1w5ZvWfzlelKYjyhlSZryTG934Bu8i9cGSKPpl6ctOQYbIbKi8XQiTXHAAuLay4
 rnlDagW2MO0OW5/+zokUh9kpoEF16/DsRDxrQkGtQmQ4Qi4uV9kWZZH/h9Vwbpa6IvoK
 +X1lhZ3MzrnputQVXMW9CBdmNq5c4l1Yk9SSYxUunA+90qgwUxWdmHNngNGss1dGy6+1
 xGNjV/bY4YSakKmIw81nDACCrW88xwKdoiucjwcpFXaxKvgstTPJshR2QvJPAkzRsL92
 YZvw==
X-Gm-Message-State: APjAAAVYaNwonaFy6rJR2Y3tqklTum7VW6EtIHMP4d+Zfxe/M1RlnXt2
 7TKyHQcy/dhHh3S6u3hbSseJDv3yERSV+I//vkQ=
X-Google-Smtp-Source: APXvYqziMD6I7xYH3SY9CT1q5q7ho+oW+jLGz0Put8FIV24y21BzE8BOS7xfWtWWvveKK2ZZCtrbWKOwiR6ql2AseKA=
X-Received: by 2002:aca:5248:: with SMTP id g69mr1196391oib.106.1581554107911; 
 Wed, 12 Feb 2020 16:35:07 -0800 (PST)
MIME-Version: 1.0
References: <20191221155306.49221-1-jhogan@kernel.org>
 <CAAdtpL7CrEAZz5GWJoYCegchQ=-hdkcih07icgoFd-ghJ3nMBw@mail.gmail.com>
In-Reply-To: <CAAdtpL7CrEAZz5GWJoYCegchQ=-hdkcih07icgoFd-ghJ3nMBw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 13 Feb 2020 01:34:57 +0100
Message-ID: <CAL1e-=jdpp2W-B1cERU4srRQUkPTjewM3hVrndoh4nr-vPSRGA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Orphan MIPS KVM CPUs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Paul Burton <paulburton@kernel.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 James Hogan <jhogan@kernel.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 7:44 PM Philippe Mathieu-Daud=C3=A9
<philippe@mathieu-daude.net> wrote:
>
> Cc'ing qemu-trivial@ & Paolo.
>

We are in the process of handling this within the company, and this
patch should go via MIPS tree, not trivial tree - will be updated when
the opinions are crystallized, and all consultations with others were
done. There is no rush.

Thanks,
Aleksandar


> On Sat, Dec 21, 2019 at 5:42 PM James Hogan <jhogan@kernel.org> wrote:
> >
> > I haven't been active for 18 months, and don't have the hardware set up
> > to test KVM for MIPS, so mark it as orphaned and remove myself as
> > maintainer. Hopefully somebody from MIPS can pick this up.
> >
> > Signed-off-by: James Hogan <jhogan@kernel.org>
> > Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 740401bcbb86..a798ad2b0b8a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -363,9 +363,8 @@ S: Maintained
> >  F: target/arm/kvm.c
> >
> >  MIPS KVM CPUs
> > -M: James Hogan <jhogan@kernel.org>
> >  R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> > -S: Maintained
> > +S: Orphan
> >  F: target/mips/kvm.c
> >
> >  PPC KVM CPUs
> > --
> > 2.24.0
> >
> >
>

