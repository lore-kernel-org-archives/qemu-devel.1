Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898CDC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E2220656
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hb6+nHN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E2220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3W3-0004Lz-GX
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1iS3SJ-0000YL-Rs
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1iS3SI-0001hm-MU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:21:27 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1iS3SH-0001ey-N1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:21:26 -0500
Received: by mail-pl1-x641.google.com with SMTP id q16so9875806pll.11
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 10:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QZSSnmANKuYNNfeFA4kh0cvKnd7/E6AYhiSQDUOzoQk=;
 b=Hb6+nHN3IOdtgYa5RsJyvTDxs0sIAFxGdtY9Ip7o5ZC9T8YAOTJG26w652HbknAEo7
 CgRPJR5P9I//Ckhf2CqGB7KqevY5R9cr3deT+0WF+e5AEMuPBEltQWxy589+LzWH6R2m
 4BouNlxbEhenWzY9omlkNeWVa6zz/yt936DYeVjFkFH9DsW4ed+xJEmOYhaMD2kEBUc6
 w0g8s6kQ58RfOIkzK97PRZ4wubbrXOo4HEmnIp4tYbRTkv3o+cmK6BHMoVFYFJmWpeb6
 G3zhAwUQET7uKTIm5y90xdJP47IMKTuyTR3WrL5qhPtPmH0ZKWOyJuDi7Iv43plpegmy
 CYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QZSSnmANKuYNNfeFA4kh0cvKnd7/E6AYhiSQDUOzoQk=;
 b=WdG/rb7mBpvHZos0RadDCW1EQjH6TcV9ZYHF59JGSG0A8QREcXFLJoPEhkmFpDhnFt
 CE6JJ5F3BTAoyISWT1g7S485wyZ5WTFIzujJcpdQ9Bz33KJ2g3fyRki9pTgBgSIKaKGE
 l2BOtxh5rbDuGnvAxt8i/Syl6C2XbGTY2pdFhweEAcZk+rEERYEEP+oM5BqpyfpaM9WR
 0THk87bABN6rfn2mztoJSE6OP0XIvehSYrfPcDJI+cfqDgHT9qO4Gfp1G0ou5u49RBa3
 F6I8PXcAutsRH86lftKOoZfTnHJoY9BHSvxbBC8/P9+G4z9SRquzYDhC49TZhw63lfDF
 v/1g==
X-Gm-Message-State: APjAAAWcnMWAfOpNEV/9XY+BdZZExTyGUswi7yaoODGx7VC0VI5DVqZe
 /JtdO6FJLhAEFFxg1GywMVablE1gPLUTTCvNFD8FMQ==
X-Google-Smtp-Source: APXvYqzwq1c/f3iU/6McN47sanbfs6+K94D3u3y+MZc1uqHfhbbVlYWEzEqgWrb0ovdCbl7YbI2lzGbphBs7d4xr8Z4=
X-Received: by 2002:a17:902:a403:: with SMTP id
 p3mr9818877plq.275.1572978081687; 
 Tue, 05 Nov 2019 10:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20191029224310.164025-1-jkz@google.com>
 <6653ca74-bbad-c63e-860c-161911c16f98@vivier.eu>
In-Reply-To: <6653ca74-bbad-c63e-860c-161911c16f98@vivier.eu>
From: Josh Kunz <jkz@google.com>
Date: Tue, 5 Nov 2019 10:21:10 -0800
Message-ID: <CADgy-2uszA+cmstV3K9sDdRwZX5mvDHoOeiqRaJ1KRRF5DRgCw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Support for NETLINK socket options
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Content-Type: multipart/alternative; boundary="000000000000ccee8305969d7f77"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ccee8305969d7f77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fixes Laurent, sorry for the delay.

Josh

On Tue, Nov 5, 2019 at 1:25 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 29/10/2019 =C3=A0 23:43, Josh Kunz a =C3=A9crit :
> > This change includes support for all AF_NETLINK socket options up to
> about
> > kernel version 5.4 (5.4 is not formally released at the time of writing=
).
> > Socket options that were introduced in kernel versions before the oldes=
t
> > currently stable kernel version are guarded by kernel version macros.
> >
> > This change has been built under gcc 8.3, and clang 9.0, and it passes
> > `make check`. The netlink options have been tested by emulating some
> > non-trival software that uses NETLINK socket options, but they have
> > not been exaustively verified.
> >
> > Signed-off-by: Josh Kunz <jkz@google.com>
> > ---
> >  linux-user/syscall.c | 98 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >
>
> I've updated the coding style and applied to my linux-user branch.
>
> Thanks,
> Laurent
>
>

--000000000000ccee8305969d7f77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the fixes Laurent, sorry for the delay.<div><br=
></div><div>Josh</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, Nov 5, 2019 at 1:25 AM Laurent Vivier &lt;<a =
href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Le 29/10/2019 =C3=A0 23:=
43, Josh Kunz a =C3=A9crit=C2=A0:<br>
&gt; This change includes support for all AF_NETLINK socket options up to a=
bout<br>
&gt; kernel version 5.4 (5.4 is not formally released at the time of writin=
g).<br>
&gt; Socket options that were introduced in kernel versions before the olde=
st<br>
&gt; currently stable kernel version are guarded by kernel version macros.<=
br>
&gt; <br>
&gt; This change has been built under gcc 8.3, and clang 9.0, and it passes=
<br>
&gt; `make check`. The netlink options have been tested by emulating some<b=
r>
&gt; non-trival software that uses NETLINK socket options, but they have<br=
>
&gt; not been exaustively verified.<br>
&gt; <br>
&gt; Signed-off-by: Josh Kunz &lt;<a href=3D"mailto:jkz@google.com" target=
=3D"_blank">jkz@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 linux-user/syscall.c | 98 ++++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 98 insertions(+)<br>
&gt; <br>
<br>
I&#39;ve updated the coding style and applied to my linux-user branch.<br>
<br>
Thanks,<br>
Laurent<br>
<br>
</blockquote></div>

--000000000000ccee8305969d7f77--

