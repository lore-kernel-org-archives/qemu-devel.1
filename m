Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65145C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D506620936
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjhtBa8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D506620936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDdO-00040A-OV
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIDZ6-0000YR-IL
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:12:20 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIDZ4-0002Xt-A8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:12:20 -0400
Received: by mail-lf1-x141.google.com with SMTP id z17so3671928lfi.12
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=382OmEUOh9T1M2M+u1zApcVHk+zFBYi0iGT767/VReo=;
 b=YjhtBa8joCTT9mUhtxU6oZxHQp587DcuebnRIrsvoYqxBpmP7uQpZD4/6Ryr2pLA3Q
 DRwSD7JTKZR3kXDXiGYWRhliUiKHeFfnZ6EHyYbT3afxDdRWxmRASAG+D9Y6C2gxGdaN
 s8X9WAfjfx7t6cFMzUv6pTAnMtr8tBuL3vCGBM217PoSb7jVu9odF9OwEMdpEUborQDK
 zQdA5+HCTACPQXMcxTLTrd3QVgdvmgx6zXj2VLoVeJY3sG+UjJcnP4Ft87wFOKnfC71y
 +eZX5gmnqPHXqDyLzmTnjvEVZz+i59ct4hBKBDVhCQTOhaer2L/GdT1joWRGuMZUzrjA
 +qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=382OmEUOh9T1M2M+u1zApcVHk+zFBYi0iGT767/VReo=;
 b=WSDsY1zcYNhLTxA7smt4Gtf9jVX3Iy1jk90qZIlqLX6u9BQWifXWFxxYWoQJjA7DL5
 rhLYbSCVryHSy9UADxq2BZBuxJuLkG4wi0SLekFo3/LirBfrzZvZOwwkyBHZl+Uj41PK
 F0KkavK9qJoxBaN2lq84nRWHnfKrB6AOZEMOrtA8Wg9NyfOj9W7OH1CRJSpSn9Y5Pf1n
 Vib4g6gU/6L5fuOIXI+Pa8WEWO9Kgqg65VoNZkxdQAOQFUCS1QfbjM3AkwzRwcYY0ygb
 RYsyVUD+wS/GcnGrBWQsB2LggKS/JuNd1JNI7HtyMqaySQ6lQOe/zHgHJrtBPyPKxTFC
 FP4g==
X-Gm-Message-State: AOAM5302x5JZuowYPR8jQ80G5vZfZsuxal1aXLZ1kPIX82ZaJjTYyNOE
 uWgH12akwI4srryvlpi2tAQ4judB1kpz2NyKFrw=
X-Google-Smtp-Source: ABdhPJxzXQGS/pLFig4bhvGGV11sf7pnAdrqSzuk02n5VRk6nUcgH4n+k13xt/1ygTawjyjybEV2oPoikwkqTAMFlS8=
X-Received: by 2002:a19:a407:: with SMTP id q7mr5796163lfc.377.1600186335780; 
 Tue, 15 Sep 2020 09:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-2-richard.henderson@linaro.org>
 <eced490f-0250-3516-5d75-c6c3ff6e97be@linaro.org>
 <CABgObfbWzf7DLgx23+yMqYqnMUaiJ=0WKaW4zvzkA4u5T9fQXQ@mail.gmail.com>
 <4813770a-34a4-72ce-17f7-7ea451a7af99@linaro.org>
In-Reply-To: <4813770a-34a4-72ce-17f7-7ea451a7af99@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 16 Sep 2020 00:12:01 +0800
Message-ID: <CAE2XoE_he2L85WgAg5NBWKLT+FFy6RJDULsL-QWBH0jbhxZTpw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] capstone: Convert Makefile bits to meson bits
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001e674505af5c6a2b"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x141.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001e674505af5c6a2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 10:27 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/14/20 11:27 PM, Paolo Bonzini wrote:
> > Looks good. Can you just add a "# Submodules" heading above the test?
> >
> > I would also like to remove the "yes" value (that is, the default fails
> if the
> > internal copy is not there) but it can be done later for all submodules=
.
>
> Unless you simply plan to rename {no, yes} to {disabled, enabled}, as for
> the
> Feature objects, why?
>
> That seems to be the only sensible value for --enable-foo, without the
> =3Dsystem
> or =3Dgit specifiers.  We *should* fail if no system library nor internal
> copy is
> present.
>
I suggest remove the capstone=3Dsystem option cause the system library may
not satisfy the requirements of qemu
and create in-consistence expereince when bug or error happens about
capstone. We either have git submodule capstone
or nothing at all

>
>
> r~
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001e674505af5c6a2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15, 2020 at 10:27 PM Rich=
ard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.h=
enderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 9/14/20 11:27 PM, Paolo Bonzini wrote:<br>
&gt; Looks good. Can you just add a &quot;# Submodules&quot; heading above =
the test?<br>
&gt; <br>
&gt; I would also like to remove the &quot;yes&quot; value (that is, the de=
fault fails if the<br>
&gt; internal copy is not there) but it can be done later for all submodule=
s.<br>
<br>
Unless you simply plan to rename {no, yes} to {disabled, enabled}, as for t=
he<br>
Feature objects, why?<br>
<br>
That seems to be the only sensible value for --enable-foo, without the =3Ds=
ystem<br>
or =3Dgit specifiers.=C2=A0 We *should* fail if no system library nor inter=
nal copy is<br>
present.<br></blockquote><div>I suggest remove the=20

capstone=3Dsystem option cause the system library may not satisfy the requi=
rements of qemu</div><div>and create in-consistence expereince when bug or =
error happens about capstone. We either have git submodule capstone</div><d=
iv>or nothing at all=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
<br>
r~<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000001e674505af5c6a2b--

