Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF219C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E142082F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwaABdu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E142082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6EId-0007RQ-QP
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6EHl-0006uT-Ry
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6EHk-00038I-7N
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:00:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6EHk-00036i-3B
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582552835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=klQmUBEWGUr42IxIyyPx1luLfNmLR0L5WcigVJOvdcA=;
 b=JwaABdu0sG/mQqa4dAPsbLfAEP18Fj3U5SRrzJCZtoIxYxc8YRvWSYoY8oslbZ16gCWtJy
 WTEifIi/Des90hI7E72NhiEwLFUCcM7gfg3Pe0dNg4eTTO3WrjI4nU0rH70Fh1ueiklVoV
 0MyBgpdmzXZwU8JmxbNiMF9ND5BQMP8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-NtQZCf64MFa4sPtFxdyuIw-1; Mon, 24 Feb 2020 09:00:33 -0500
X-MC-Unique: NtQZCf64MFa4sPtFxdyuIw-1
Received: by mail-wm1-f71.google.com with SMTP id n17so2415103wmk.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 06:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=klQmUBEWGUr42IxIyyPx1luLfNmLR0L5WcigVJOvdcA=;
 b=XkwC5V77VD+wKxZnHNeAMeLh4GP7DEF2l9L7pbaUP9TuB6NttHeUuGAPc5ElB1/QjO
 J49FKZtBBVwiI80rxGWxHv3GG782mi0kZx7D+AtL8tUclrVNTCJYfz5cwKSG/ok33Bfh
 xh5aLzq7OgWlLhReNpa697FVycDFi5PjoIx+txrK02j1GPDwIf43BfD/bL48aQw1Wdis
 WZ5ie9n2jmiSRYkCJ2naYbLC4k7HJR0xdmxWpffUmXZsl8AtZ6ndb1LrN1zC43AM2kFj
 w2VQ6W9WKOnwQYgtxogH4gi4DxUtMwkMQeaGrwrtJgHGUTvXCm4YKSpcwtTLAq6x2rZ6
 w0VA==
X-Gm-Message-State: APjAAAXgFzX7GFIqp98JUiMimSVizLv6TbjmyMqZKWIyIk3CwoZrE2ad
 pJOfBUrfAlhjrPjbGXbld4VPRYvGZ2anSSpU7Dr/AdhAYw6IV1evWNEtCHsv80uKMHGjle5KQl6
 1VlwNhT54oo7OfWJxAEahwWNnmX9U0iQ=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr23847868wmb.137.1582552832003; 
 Mon, 24 Feb 2020 06:00:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3DHhSNnWVq+8YDjWWfe05sSLPaFU0F2D+YVkraLz2O5/WddoJAfOeuXGrzAxnWd6jH77j7jlvu6jsZDKyyNY=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr23847851wmb.137.1582552831817; 
 Mon, 24 Feb 2020 06:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20200223132750.69480-1-ysato@users.sourceforge.jp>
 <20200223132750.69480-24-ysato@users.sourceforge.jp>
 <f8f438a8-c7ed-a7c5-4620-21b1dd10bfb4@redhat.com>
 <87r1yk9jik.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87r1yk9jik.wl-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 24 Feb 2020 15:00:20 +0100
Message-ID: <CAP+75-WYaEZ6OPymJzxojMQ8KqvquQq+K9dQoicV+EXTiLo_RA@mail.gmail.com>
Subject: Re: [PATCH v31 23/23] fix warning.
To: Yoshinori Sato <ysato@users.sourceforge.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 2:56 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> On Mon, 24 Feb 2020 17:51:30 +0900,
> Philippe Mathieu-Daud=C3=A9 wrote:
> >
> > On 2/23/20 2:27 PM, Yoshinori Sato wrote:
> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > ---
> > >   hw/rx/rx-virt.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
> > > index 6cf7936201..4ee6647728 100644
> > > --- a/hw/rx/rx-virt.c
> > > +++ b/hw/rx/rx-virt.c
> > > @@ -90,8 +90,10 @@ static void rxvirt_init(MachineState *machine)
> > >         /* Load kernel and dtb */
> > >       if (kernel_filename) {
> > > -        /* The kernel image is loaded into
> > > -           the latter half of the SDRAM space. */
> > > +        /*
> > > +          The kernel image is loaded into
> > > +          the latter half of the SDRAM space.
> > > +        */
> > >           kernel_offset =3D machine->ram_size / 2;
> > >           rx_load_image(RXCPU(first_cpu), kernel_filename,
> > >                         SDRAM_BASE + kernel_offset, kernel_offset);
> > >
> >
> > Hopefully the maintainer taking this can squash this fix to patch #17
> > "hw/rx: RX Target hardware definition".
> >
>
> Oh, Sorry.
> I'll sent v23.

No please don't! This is not needed.


