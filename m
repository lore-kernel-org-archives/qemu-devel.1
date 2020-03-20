Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AF8C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C5C20774
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR7cMxQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C5C20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFCtf-0000Jb-T7
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 04:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFCsp-00080i-BR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFCso-0004hL-3c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:19:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jFCsn-0004gd-RW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:19:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id h4so6341462wru.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=xpC08osBziP1OVO9e35zkt1C6tWSLxP/go0HIn23TeA=;
 b=pR7cMxQ3Zsszedqms5dENI8j6Ckcl9QYHFE0ACfio/yO8CQR7Yg9EHNtsYXVZVRW+a
 MX3e/mIe/W2EOelZa+Q3zlbpieWIRXKptXbL5MSXpqzqOvb+bWTR1AeNmGdKapXfiQK5
 lcUdSTZpY2RM46pPlhYQxamyI+Zm8ulTZ0/8g1m8QIlI7S/MjsuQ1fJqVkztEEFz1BDQ
 ficIfFk1LnOtFYt8cVq6PLPxba8pmtKFXObOIY8vNjw4guvXQhF29083K0nQLCDeVSMr
 w3SSJZrFpKIeretGPPqPZkT2rK9+6ZD6Bj6rHRpc43gyGm+/xJLRU+AsUhjWl+HAeu4S
 SbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=xpC08osBziP1OVO9e35zkt1C6tWSLxP/go0HIn23TeA=;
 b=tPzEqjtb0puiu5O6v3h7609KI52izahnC5n5eQ5lyxZWkSdtHyBgIrXWIz2xf+onR9
 7UNwTEuJ1YtaF8NHDUGszy4T7QWtZZ9m7uR4GHwHXceiITqHTJmUV11Iq3VMGHIjxoXu
 8Q0uliXyw6Vjiej+YSLCJY9agEdYRMFh904tnfzPcVM3k+5Xu1ZAkwsUBjsMuh6bnnN5
 l6aIATov55W4SmO/ueFNyTRxnnyHC9rPby5mWs1YkHMyKEq0/vGb9+/y8AF8vJsCnSKJ
 RpLCxwZp8Qp1eUEN7ZDC4pIAehSl9g8XAoanlL2T6oVq7tfJD1Rw/QTN7sJHHkry+mvm
 yF8Q==
X-Gm-Message-State: ANhLgQ2ar3OgDX9l71aYKg2ti/gwpQc2NXLMAMZNg4JrOFRaMPfW6WET
 UyU1L6k1/hlF7yucG6ucd2ebGs2EAOmb7oRZD28=
X-Google-Smtp-Source: ADFU+vs5EBQ2b+Ayhw4RfmkHi+SHCQNsvh+NxymaB4srrd72wbwWkQP6/av/jm4xYTN+O8SAaif54vX3tgWc7CUetvk=
X-Received: by 2002:adf:efc2:: with SMTP id i2mr7813792wrp.420.1584692396566; 
 Fri, 20 Mar 2020 01:19:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:600c:2c05:0:0:0:0 with HTTP; Fri, 20 Mar 2020 01:19:55
 -0700 (PDT)
In-Reply-To: <20200319112911.353244-1-marcandre.lureau@redhat.com>
References: <20200319112911.353244-1-marcandre.lureau@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 20 Mar 2020 09:19:55 +0100
Message-ID: <CAHiYmc6KK3Qiox4byg9FRMCtpMLsvzftOHF05pDTAKK6OvzZgA@mail.gmail.com>
Subject: Re: [PULL 0/1] Slirp patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000602d4305a144f311"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: "samuel.thibault@ens-lyon.org" <samuel.thibault@ens-lyon.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000602d4305a144f311
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D0=B5=D1=82=D0=B2=D1=80=D1=82=D0=B0=D0=BA, 19. =D0=BC=D0=B0=D1=80=D1=
=82 2020., Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> The following changes since commit f57587c7d47b35b2d9b31def3a74d8
> 1bdb5475d7:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-03-17'
> into staging (2020-03-19 10:18:07 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/slirp-pull-request
>
> for you to fetch changes up to 9f6b9fcc153f6d4f2e10193014d2eaf7329fa181:
>
>   slirp: update submodule to v4.2.0 + mingw-fix (2020-03-19 12:17:43 +010=
0)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>   slirp: update submodule to v4.2.0 + mingw-fix
>
>  slirp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.25.0.rc2.1.g09a9a1a997
>
>
>

Marc-Andre, hi.

This pull request has a very unusual form to me. In its cover letter, it
appears as if only one line of code is changed, while the patch 1/1
strangely suggests that there are number of underlying patches. I am really
puzzled how this pill request is created at all, and what is its real
content.

Did you use some novel method for creating pull requests? What is the
intended content of the pull request?

Yours,
Aleksandar

--000000000000602d4305a144f311
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=87=D0=B5=D1=82=D0=B2=D1=80=D1=82=D0=B0=D0=BA, 19. =D0=BC=D0=B0=
=D1=80=D1=82 2020., Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">The following changes since commit f57587c7d47b35b2d9b31def3a74d8=
<wbr>1bdb5475d7:<br>
<br>
=C2=A0 Merge remote-tracking branch &#39;remotes/armbru/tags/pull-<wbr>qapi=
-2020-03-17&#39; into staging (2020-03-19 10:18:07 +0000)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 <a href=3D"https://github.com/elmarco/qemu.git" target=3D"_blank">ht=
tps://github.com/elmarco/<wbr>qemu.git</a> tags/slirp-pull-request<br>
<br>
for you to fetch changes up to 9f6b9fcc153f6d4f2e10193014d2ea<wbr>f7329fa18=
1:<br>
<br>
=C2=A0 slirp: update submodule to v4.2.0 + mingw-fix (2020-03-19 12:17:43 +=
0100)<br>
<br>
------------------------------<wbr>------------------------------<wbr>----<=
br>
<br>
------------------------------<wbr>------------------------------<wbr>----<=
br>
<br>
Marc-Andr=C3=A9 Lureau (1):<br>
=C2=A0 slirp: update submodule to v4.2.0 + mingw-fix<br>
<br>
=C2=A0slirp | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
-- <br>
2.25.0.rc2.1.g09a9a1a997<br>
<br>
<br>
</blockquote><div><br></div><div><br></div><div>Marc-Andre, hi.</div><div><=
br></div><div>This pull request has a very unusual form to me. In its cover=
 letter, it appears as if only one line of code is changed, while the patch=
 1/1 strangely suggests that there are number of underlying patches. I am r=
eally puzzled how this pill request is created at all, and what is its real=
 content.</div><div><br></div><div>Did you use some novel method for creati=
ng pull requests? What is the intended content of the pull request?</div><d=
iv><br></div><div>Yours,</div><div>Aleksandar</div><div><br></div><div>=C2=
=A0</div>

--000000000000602d4305a144f311--

