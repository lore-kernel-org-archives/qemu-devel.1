Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8259C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7559E2154A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIhjPBGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7559E2154A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaDs2-00074v-LL
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 02:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iaDpR-0005Wj-R5
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iaDdy-0005zE-2e
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:51:16 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a]:37401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iaDdx-0005xz-De
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:51:13 -0500
Received: by mail-il1-x12a.google.com with SMTP id t9so3657456iln.4
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 22:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7PiNnpu6R5mAebSKIZ9qBhShRzwjqqVibfrnq7IgSfc=;
 b=CIhjPBGBi1YJ94Ghpv8+p+A4u91pXjgQ805DlydyeiIe2ugts6aXCNVYKu+JHjMYIk
 ENppQIC7+iaSMkSiuSscN93JC8u/sY5tLMEP52ywHozcW9osnInrRGWiYnbQ20Wc3+tA
 5iTce3yKmY4PDZr55SfKR6CxGuRHnvI3BHjQG3kbjRSfYPQ6VvgHWoP/f+PRns1wR1Bj
 ZI0tZDt4e6ayZ3anHF4235tT6IIAiV2j8+FrtN3jBfPCJSEfXJgsyW9GJjhdSrGqQ4aJ
 CEzE+8Bn05DWlcYvRQyA9VJx+K5ralyy6CcbJbkiKZ/7VVlnaggYG0jCSoBCzLyAQOjH
 rf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7PiNnpu6R5mAebSKIZ9qBhShRzwjqqVibfrnq7IgSfc=;
 b=fR6l7804txXNvV4bJLAL64VbFQhhvOWFLVRjLkyVABTPkzX7kkFqME83rr0ESmw0yw
 4FkWvFpcS90Yo0kDmn5Vcl/fjFXQKP8vOOdT/wmXfO3uiv5QwqEQV8hxuflqzpmGs+VW
 w8nM68xACrb6LEyNjwBB7iikHt/gOPtuAxQo9s5yd4EXpULYNcuqE/HNP5kNIw1P2TJg
 2w9H6MvHHQDa5kXJSeMyfbBrtU4TN0M0l9v6LVA+2EnTcp1sXGdddsd8YaKuPS4KBjWb
 RZZPh+8aJFQAOrlx9WMeqBqevqKGkzRS+5pCFYwW2gEQyOA+6zxFdzt8edj4mC7KF6it
 M9cg==
X-Gm-Message-State: APjAAAUUgKGmD6IUWigJ2OZtDShj7wI//t9NCKo4kX90RyD5gdvvjw7C
 3kK9MueMa+Yb9iHwMvDyLJ3lW5jN8vwtYY5H0rY=
X-Google-Smtp-Source: APXvYqzu9vk6T8Xagl3NdEpglE6ub3KL5lcUxB73NS64J93BsAKSg9e/KvXKDb1QajFzzGQ6UBcY2lU3JrxfoAKrsuI=
X-Received: by 2002:a92:8459:: with SMTP id l86mr49442805ild.236.1574923872097; 
 Wed, 27 Nov 2019 22:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
 <20191126141924.GQ556568@redhat.com>
 <09273ecd-be76-ab61-304f-7ea0f1f0b107@redhat.com>
 <20191127150520.GG2131806@redhat.com>
 <20191127161210.ractqwwymzkpbu6n@sirius.home.kraxel.org>
 <20191127163219.GI2131806@redhat.com>
In-Reply-To: <20191127163219.GI2131806@redhat.com>
From: Aaron Zakhrov <aaron.zakhrov@gmail.com>
Date: Thu, 28 Nov 2019 12:21:00 +0530
Message-ID: <CAApBzg9c9rwgAd1forny9QGgz8-fA60QBcRQbsMSmTwB_h12pQ@mail.gmail.com>
Subject: Re: [RFC 00/10] R300 QEMU device V2
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f1da1a05986289d6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12a
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
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f1da1a05986289d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested my code with the vgabios-ati.bin rom file and it seems to get
passed the earlier issue I had.
I have cleaned up my code and have sent a new patch series. The new one is
pretty big but it contains only the necessary header files and it should be
a little easier to review

On Wed, Nov 27, 2019 at 10:02 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
wrote:

> On Wed, Nov 27, 2019 at 05:12:10PM +0100, Gerd Hoffmann wrote:
> >   Hi,
> >
> > > It does become a slight usability issue, as any users need to go and
> find
> > > the suitable BIOS in order to use the device. No downstream OS vendor=
s
> are
> > > going to be able to distribute this BIOS either
> > >
> > > I don't know if we have hit this problem before & if we have any
> > > general policies about it ?
> >
> > Booting from lsi scsi adapter used to work with a vendor bios only
> > loooooong ago.  Fixed by adding an lsi driver to seabios.
> >
> > Building a r300 vgabios shouldn't be too hard, we already have
> > support in seavgabios for the other ati variants emulated by qemu.
>
> That sounds reasonable, so it is fine to add r300 to QEMU without the BIO=
S.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000f1da1a05986289d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I tested my code with the vgabios-ati.bin rom file and it =
seems to get passed the earlier issue I had.<div>I have cleaned up my code =
and have sent a new patch series. The new one is pretty big but it contains=
 only the necessary header files and it should be a little easier to review=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Wed, Nov 27, 2019 at 10:02 PM Daniel P. Berrang=C3=A9 &lt;<a href=
=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Nov 27, 2019 at =
05:12:10PM +0100, Gerd Hoffmann wrote:<br>
&gt;=C2=A0 =C2=A0Hi,<br>
&gt; <br>
&gt; &gt; It does become a slight usability issue, as any users need to go =
and find<br>
&gt; &gt; the suitable BIOS in order to use the device. No downstream OS ve=
ndors are<br>
&gt; &gt; going to be able to distribute this BIOS either<br>
&gt; &gt; <br>
&gt; &gt; I don&#39;t know if we have hit this problem before &amp; if we h=
ave any<br>
&gt; &gt; general policies about it ?<br>
&gt; <br>
&gt; Booting from lsi scsi adapter used to work with a vendor bios only<br>
&gt; loooooong ago.=C2=A0 Fixed by adding an lsi driver to seabios.<br>
&gt; <br>
&gt; Building a r300 vgabios shouldn&#39;t be too hard, we already have<br>
&gt; support in seavgabios for the other ati variants emulated by qemu.<br>
<br>
That sounds reasonable, so it is fine to add r300 to QEMU without the BIOS.=
<br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--000000000000f1da1a05986289d6--

