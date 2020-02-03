Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6220C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819AE2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="CddWl4m8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819AE2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaSW-00058m-L0
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iyaRm-0004hN-A6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iyaRk-0004Wk-4X
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:03:21 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32]:36247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iyaRj-0004Uk-QM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:03:20 -0500
Received: by mail-io1-xd32.google.com with SMTP id d15so16439850iog.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 04:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qkb5jeFlmWvhiEbbzIc4ZXFRs3rgR9xgmq4JyjuCiig=;
 b=CddWl4m8MKC5EBlBY3V+9rpv53g7bpA2rkqWU+ix9wzblm+h+0DwPxuOm/M7OdyMDm
 b0rhKMdMLH807i8RgqkydjI6D57Zx44PWu2O5niBUjGQLpAY2WS/aJR0zkG4aVbdS+j2
 FcdskZSV8CQehVmcZQxjVt1iRlM7USWB00rxaFRb6xdU9ciy4dMoe6Mw+X08G/tCbzjd
 uGAtin2xKvSUWXsEsxVdxvNCqM0KAYz12V+4Ai3Sw7CtDkgdWqEGDAkfQKJ/hlj09Sor
 Hq1HoojYYG9OxRTv9VlDY1HefgNtbk/yl2D0hqKkSCzf2e9JNiTjM2GASQdM0hPfAOup
 D8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qkb5jeFlmWvhiEbbzIc4ZXFRs3rgR9xgmq4JyjuCiig=;
 b=kVUhleBsRdSbhW/GGNdvIEBnUvd0vNLrrRgbct2k21uDMB5WakJ/XgTyCQbdOSz7/A
 osXFRKyefAPL/x38JPLrn4Rlai9bohiXcDR+F6zAJDfEWOs6rTyhXBVVDqF/p+cz75r9
 l5OefBLdLmcwyJ9kxF4P+QTN2QW+zjDlGLX927gHQs+Xjl1zOUelaq9eCxPjV6w56Uom
 fXbtdK/04EHbY94DxxnxTDleGy1Dy+t12fBgd8JCSQXZHUYapxHk1onUlV1yDP3q/BSX
 65HlddkQ6atRDBqLRp1exp4ghPmChZVokjoc1xa+VFWLf05mJeyS6c31hviTnTtTUGuP
 U9HQ==
X-Gm-Message-State: APjAAAVFEuiUT9+vgX9MVGLLRXj4KL9Un44qtiq7NwEm1nblFhly+IDQ
 LsizggDzcQDMdZVf4KiBFHypmBTkZ74E6hGdx5j80w==
X-Google-Smtp-Source: APXvYqx5XCPCZ4KYgbRqPI1scSwTJLvIXQurpl30ilUIpftV2OWMZZ9mVcnCbcS81cFfyPAp9GukCuQ/OOs5mpXZMw4=
X-Received: by 2002:a02:6a10:: with SMTP id l16mr18880367jac.77.1580731396784; 
 Mon, 03 Feb 2020 04:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20200123070913.626488-1-mst@redhat.com>
 <20200123070913.626488-18-mst@redhat.com>
 <CAFEAcA98iqJkTp4F6qmO5f4VYNhE3Fs4toBuV1qNtujAo6=OJg@mail.gmail.com>
 <20200203013334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200203013334-mutt-send-email-mst@kernel.org>
From: Corey Minyard <cminyard@mvista.com>
Date: Mon, 3 Feb 2020 12:03:04 +0000
Message-ID: <CALQyB5EtG2SZ2EBpwXkcAEzkpMNJxjw5s-ZmNJGK-cV9FFKogw@mail.gmail.com>
Subject: Re: [PULL v3 17/18] i386:acpi: Remove _HID from the SMBus ACPI entry
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000064215a059daab5ac"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000064215a059daab5ac
Content-Type: text/plain; charset="UTF-8"

I checked a few days ago and someone had already beat me to it.

-corey

On Mon, Feb 3, 2020, 06:34 Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Jan 30, 2020 at 07:05:16PM +0000, Peter Maydell wrote:
> > On Thu, 23 Jan 2020 at 07:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > From: Corey Minyard <cminyard@mvista.com>
> > >
> > > Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not required
> > > on enumerated buses (like PCI in this case), _ADR is required (and is
> > > already there).  And the _HID value is wrong.  Linux appears to ignore
> > > the _HID entry, but Windows 10 detects it as 'Unknown Device' and there
> > > is no driver available.  See
> https://bugs.launchpad.net/qemu/+bug/1856724
> >
> > Is this commit in fact a fix for LP:1856724 ? If so, we could
> > usefully add a comment to that bug noting the commit which
> > fixes it and mark the bug 'fix committed', since it seems
> > to affect various users who would like to know the status.
> >
> > thanks
> > -- PMM
>
> Right. Corey could you do that pls?
>
>

--00000000000064215a059daab5ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I checked a few days ago and someone had already beat me =
to it.<div dir=3D"auto"><br></div><div dir=3D"auto">-corey</div></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb=
 3, 2020, 06:34 Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">ms=
t@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu,=
 Jan 30, 2020 at 07:05:16PM +0000, Peter Maydell wrote:<br>
&gt; On Thu, 23 Jan 2020 at 07:11, Michael S. Tsirkin &lt;<a href=3D"mailto=
:mst@redhat.com" target=3D"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt=
; wrote:<br>
&gt; &gt;<br>
&gt; &gt; From: Corey Minyard &lt;<a href=3D"mailto:cminyard@mvista.com" ta=
rget=3D"_blank" rel=3D"noreferrer">cminyard@mvista.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not req=
uired<br>
&gt; &gt; on enumerated buses (like PCI in this case), _ADR is required (an=
d is<br>
&gt; &gt; already there).=C2=A0 And the _HID value is wrong.=C2=A0 Linux ap=
pears to ignore<br>
&gt; &gt; the _HID entry, but Windows 10 detects it as &#39;Unknown Device&=
#39; and there<br>
&gt; &gt; is no driver available.=C2=A0 See <a href=3D"https://bugs.launchp=
ad.net/qemu/+bug/1856724" rel=3D"noreferrer noreferrer" target=3D"_blank">h=
ttps://bugs.launchpad.net/qemu/+bug/1856724</a><br>
&gt; <br>
&gt; Is this commit in fact a fix for LP:1856724 ? If so, we could<br>
&gt; usefully add a comment to that bug noting the commit which<br>
&gt; fixes it and mark the bug &#39;fix committed&#39;, since it seems<br>
&gt; to affect various users who would like to know the status.<br>
&gt; <br>
&gt; thanks<br>
&gt; -- PMM<br>
<br>
Right. Corey could you do that pls?<br>
<br>
</blockquote></div>

--00000000000064215a059daab5ac--

