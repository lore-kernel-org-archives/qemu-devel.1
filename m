Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83288C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54F720739
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZnlMwVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54F720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGhk-0000If-Mp
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNGga-0008Au-4e
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:32:56 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNGgY-0000r0-AK
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:32:55 -0400
Received: by mail-ej1-x641.google.com with SMTP id h26so5226626ejq.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HYqdIbOoTheDTV8u5Qczn50miE9P8/jKJv0lqfBZDiY=;
 b=HZnlMwVhCd4uLEvZINdHODBiVDwD6rDlwYwkCMdc/dNjzJiawNwjh+MgKIof5FcMSj
 ltWq7h7VQWAidZDEs7204WWwCzas6ZBaYQf0xw3B+F9j8E85hzxef5vyJ66hxmBzDMwC
 9NIlnjhscs7U7Nz3sA+vsDM3v9vjhjOSoFqHaVy8H/lPi7FfvqmAVAPDSFtpkM60Kd7R
 SfFTdLV3ALuLTDIAtLw9hsKn5nJ1vLg1HQqM2KNIKVdOHcuSyllFXPwMPN1TnLuytiOi
 rCZ7vyKlSDaeo/y4cnk+1F1k9F+M5dU3P5+kGthj+INUHNzXfoLanVyzOHZIEfjrO/ow
 RlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HYqdIbOoTheDTV8u5Qczn50miE9P8/jKJv0lqfBZDiY=;
 b=Rk8VqO1nV2RURHPolUEtOGSp/wngdvYFbfE0bLtpmXfFSx1uJZw0svqHLSVGORpYi3
 gsfU3dbRyMN2j5ECchgkDO+jAr2rnV8jeHcfODvJryfaMfW37A1tpW+tUQRLxNplakPb
 eisC6/x/iQwloy+9Hqj3jq734bqjfVjvehUzpjUKjFhfjtG0C1i3B2Adv9rKMRd4McJp
 +CWzS9oR+vm41sk0xJwn9eJEu0OSFrRl0I1hhrFZ/mKB+s/WZ6lp5lEWG03VdIYKCh6s
 hDJGIXoEPjVu0G3H6AD7h80uZuFHlQmXOpXrAV/X0eStX814P+WlewNX0h6ecmLrOiMw
 45bw==
X-Gm-Message-State: AOAM5306kjpPqfBn1GUFw0euJqNAP2u8wdYzjIX121/+NstdzGrB3c3w
 lakcG50mRYQTd1/yLWFME8KDKWTBm6TXvvCco/k=
X-Google-Smtp-Source: ABdhPJxmjbhz4ZNLuDsong9RIaV9ffktaZ0wpEUxp5OmJlrVsGsJFRc3+1d5KLvF9b5SvrTaSE1I8DrV6kyCRDuQmog=
X-Received: by 2002:a17:906:249b:: with SMTP id
 e27mr4109037ejb.105.1601389972757; 
 Tue, 29 Sep 2020 07:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200929134237.514286-1-marcandre.lureau@redhat.com>
 <cce22078-e0b8-fef9-ea62-a25767dfbbc5@redhat.com>
In-Reply-To: <cce22078-e0b8-fef9-ea62-a25767dfbbc5@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Sep 2020 18:32:40 +0400
Message-ID: <CAJ+F1C+OLuDJ4fvudc52uv+bSg1-b8ihsVmRy2nsuHOKKd5Pcw@mail.gmail.com>
Subject: Re: [PATCH] build-sys: fix git version from -version
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007922f905b074a8f2"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007922f905b074a8f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 29, 2020 at 6:07 PM Eric Blake <eblake@redhat.com> wrote:

> On 9/29/20 8:42 AM, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Typo introduced with the script.
> >
> > Fixes: 2c273f32d3 ("meson: generate qemu-version.h")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   scripts/qemu-version.sh | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> > index 03128c56a2..430a7fc581 100755
> > --- a/scripts/qemu-version.sh
> > +++ b/scripts/qemu-version.sh
> > @@ -9,7 +9,7 @@ version=3D"$3"
> >   if [ -z "$pkgversion" ]; then
> >       cd "$dir"
> >       if [ -e .git ]; then
> > -        pkgversion=3D$(git describe --match 'v*' --dirty | echo "")
>
> This always produces pkgversion=3D"" (the git describe output is ignored
> when it is piped to echo).
>
> > +        pkgversion=3D$(git describe --match 'v*' --dirty || echo "")
>
> But this just looks weird. $(echo "") is the same as "".  The REAL goal
> here appears to be that you want 'set -e' to not die if git describe has
> a non-zero exit status.  But that's shorter to write as:
>
> pkgversion=3D$(git describe --match 'v*' --dirty || :)
>
> or even
>
> pkgversion=3D$(git describe --match 'v*' --dirty) || :
>
>
>
Works for me too. I am sending v2.

thanks

--=20
Marc-Andr=C3=A9 Lureau

--0000000000007922f905b074a8f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2020 at 6:07 PM Eri=
c Blake &lt;<a href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 9/29/2=
0 8:42 AM, <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank"=
>marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Typo introduced with the script.<br>
&gt; <br>
&gt; Fixes: 2c273f32d3 (&quot;meson: generate qemu-version.h&quot;)<br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 =C2=A0scripts/qemu-version.sh | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh<br>
&gt; index 03128c56a2..430a7fc581 100755<br>
&gt; --- a/scripts/qemu-version.sh<br>
&gt; +++ b/scripts/qemu-version.sh<br>
&gt; @@ -9,7 +9,7 @@ version=3D&quot;$3&quot;<br>
&gt;=C2=A0 =C2=A0if [ -z &quot;$pkgversion&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cd &quot;$dir&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -e .git ]; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgversion=3D$(git describe --match &#39;=
v*&#39; --dirty | echo &quot;&quot;)<br>
<br>
This always produces pkgversion=3D&quot;&quot; (the git describe output is =
ignored <br>
when it is piped to echo).<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgversion=3D$(git describe --match &#39;=
v*&#39; --dirty || echo &quot;&quot;)<br>
<br>
But this just looks weird. $(echo &quot;&quot;) is the same as &quot;&quot;=
.=C2=A0 The REAL goal <br>
here appears to be that you want &#39;set -e&#39; to not die if git describ=
e has <br>
a non-zero exit status.=C2=A0 But that&#39;s shorter to write as:<br>
<br>
pkgversion=3D$(git describe --match &#39;v*&#39; --dirty || :)<br>
<br>
or even<br>
<br>
pkgversion=3D$(git describe --match &#39;v*&#39; --dirty) || :<br>
<br>
<br></blockquote><div><br></div><div>Works for me too. I am sending v2.</di=
v><div><br></div><div>thanks<br></div></div><div class=3D"gmail_quote"><br>=
</div><div class=3D"gmail_quote">-- <br></div><div dir=3D"ltr" class=3D"gma=
il_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000007922f905b074a8f2--

