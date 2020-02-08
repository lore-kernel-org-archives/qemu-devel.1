Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63221C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2652C21775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXTP3QAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2652C21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0SZ6-0002Y2-AT
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 11:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j0SYC-0001tt-1y
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j0SYA-0007tN-Lu
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:01:43 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:36188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j0SYA-0007rN-FC
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:01:42 -0500
Received: by mail-oi1-x232.google.com with SMTP id c16so5142847oic.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QWweQ5/aWdKoM9GbXJkCgFoSUxU8p2/lRXLB1M5F7I8=;
 b=JXTP3QAIfXt9G5EsgUsWtzhD8/1OVB3ZFNwXbSaoLsGAM4/9HB195uot5M6B3C7kRE
 lkl4HHKlIo3zJmqdIu3a+zZZwgeYBX+Z4jjpyuX9iOl+p0vT1fHn8mriTmTQTgm+C4us
 mzX46sex0vU+A83pqSShwnnvARFbuIwCxtszwneC0+7TLaBRbReGSF2ightDOnlbwPSX
 IGU5qMl1f1GDdVhhyIbOfw/eQMXyzEiYiFJyO6dFBpumBuMxRWXQCow9p5FluBjffA7Z
 HGNLkLfrHyzlCfqYNWEcEpxvswYScvF0k9/fG7XdvsfM/cFXzrQi42win/DywE7Vb59L
 eJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QWweQ5/aWdKoM9GbXJkCgFoSUxU8p2/lRXLB1M5F7I8=;
 b=tVH2NIvhmSgagWkIWLOsdCjfosGe/8GNgl7is4/O3vMkTxxMZyUfrwuyPc8yJaeyfx
 Nnl1p9Fn21CFWggMl/gG9zrJyC3T0dlY0Sw6Q1sVxnTOSHbu2DrwNqJzjp3j7tD+xv3h
 /1ehf1v91v59JmP9u8kk2xpQALt1tskIMlmfRi5HAMzcmMGcE3OwtgQsrngUgEhTjwTs
 DxhUIM73/g2V8M0xE8FzRZyDKnbMcF8VuANLBHGgaW6UisASYGSzd/u0nH+tcnLwKOjf
 vKeqbjr608B/ETZPi5zFsZNRIscDbX2p9VKlmAsKp5sKDjY4jjXMYBgBihBIK4IVy8ZG
 BbLw==
X-Gm-Message-State: APjAAAVkz7tgot7DbhD58S6LCT/lw8c7FyTbg1Y4hvZtI97qCp1A2vyw
 ckb0uzc4124lb2MLzAGSOnnwhau6PDyVtmvAJk4=
X-Google-Smtp-Source: APXvYqxOmZ9VV3wRe8reVK1y3ME8ZxYmjFsu163UNUL0XvQJ64vwO3rnUF0Z+Xu1yTNccC2Iy6hi5NvCZtl+S76KAdo=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr5413952oih.79.1581177701651; 
 Sat, 08 Feb 2020 08:01:41 -0800 (PST)
MIME-Version: 1.0
References: <1581040680-308-9-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200207112338.27754-1-philmd@redhat.com>
 <CAL1e-=jqCgakxTn1zQaNu7WqLjEien_Nd+nxQRe7NdmXKiivfw@mail.gmail.com>
 <556ea4ff-7af6-5a84-b793-f31b8d58d202@amsat.org>
In-Reply-To: <556ea4ff-7af6-5a84-b793-f31b8d58d202@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 8 Feb 2020 17:01:30 +0100
Message-ID: <CAL1e-=g9cAHdHaQ3Zbbuk1tZ3ugE6vFWsxC57GwN5TuRUZLoQA@mail.gmail.com>
Subject: Re: [PATCH] !fixup "target/avr: Add defintions of AVR core types"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 8, 2020 at 3:06 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Hi Aleksandar,
>
> On 2/8/20 8:10 AM, Aleksandar Markovic wrote:
> > On Friday, February 7, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com
> > <mailto:philmd@redhat.com>> wrote:
> >
> >     These cores have unresolved review comment:
> >     https://www.mail-archive.com/qemu-devel@nongnu.org/msg674105.html
> >     <https://www.mail-archive.com/qemu-devel@nongnu.org/msg674105.html>
> >     https://www.mail-archive.com/qemu-devel@nongnu.org/msg674259.html
> >     <https://www.mail-archive.com/qemu-devel@nongnu.org/msg674259.html>
> >     and:
> >     https://www.mail-archive.com/qemu-devel@nongnu.org/msg676046.html
> >     <https://www.mail-archive.com/qemu-devel@nongnu.org/msg676046.html>
> >
> >     As we don't want a bad start with this architecture, remove them.
> >
> >
> > I agree with underlying motivation of your fixup.
> >
> > Still, the division of AVR cores into avr1, avr2, ... , xmega7 is here
> > to stay. The reason is that because such coding is a part of ELF header=
,
> > and this means they will stay forever (as they are approved by some kin=
d
> > of ELF comitee, and are meant not to be ever changed in future).
>
> I am not removing anything ELF related. We don't have any machine using
> CPU avrtiny/avr1/avr2/avr25 so AFAIK I'm simply removing unreviewed dead
> code.
>

The portion of the code that classifies AVR cores is and should remain
as independent as possible of the machine-related code. In other
words, my point is that your fixup  is inadequate. We should not touch
the portion of the code that enumarates AVR core types, except to add
some TODO notes as noted during review. If one wants to remove "dead"
code as defined by you, one should leave just two AVR core types and
also eliminate at least half of "AVRFeatures", which is absurd.

There is much less intrusive solution to this, that will also provide
guarantee that we never emulate the code that we know has some issues,
or support for it is not completed yet.

You should read more carefully previous reviews, and you'll see that
Michael and I agreed that support for "avrtiny" cores will be provided
in some point in future, but this doesn't mean we should delete that
AVR type from the current code.

I hope I am clear enough to you now. :)

Regards,
Aleksandar

