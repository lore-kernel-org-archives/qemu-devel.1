Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1886DC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D883C20674
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFYR1VC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D883C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVd8z-00073e-EV
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael.goffioul@gmail.com>) id 1iVcAK-0007ZJ-1B
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael.goffioul@gmail.com>) id 1iVcAI-0004gd-Tx
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:01:35 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:32981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <michael.goffioul@gmail.com>)
 id 1iVcAC-0004fC-IF; Fri, 15 Nov 2019 09:01:28 -0500
Received: by mail-pf1-x42c.google.com with SMTP id c184so6735573pfb.0;
 Fri, 15 Nov 2019 06:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=96GNJAm9RKsC/N5GfKUlT10rQYojQswtEI+FU+oycSE=;
 b=nFYR1VC7VfoELPLqeMlNLP1llrgbkwZxRrJnNHRoI85cb4fBS6e7YM+8yNqY9im0Ny
 G9ZvLwt6MkK4tID65se07FNl7ZO0bdHl1QFnbv0P7wiSl6l7/V23AP10XCu1iOMzDrPx
 NxnVnhajAT85zfVKxHUtdyffKky232jOyy+TdKIlsqHVuwc0X5J5HqYljOtUUwOSL6PZ
 tUzqlPtA9Na23Jw55q2y69vvEiPAhdZMWbE7mp35e3t+CPGgwLXeD++7jFQY9Ha3/bN4
 KFMWiODWyBRk96myRUXS7Jdqm4ycJ3bOu/mLSVXeT0P8//VuucMwpQXqrqUD0rox2zdH
 IbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=96GNJAm9RKsC/N5GfKUlT10rQYojQswtEI+FU+oycSE=;
 b=F2BX22QBCCMGue1Ov1/YfVNScnoX87KuTO/eW92dv7oEKf3zp4uQjrLNwZTUd+SVcf
 NXwaEj9vPA4X7M/GmkSvbHQbHJb2yDSpgJ29z/0W2TSTrJxiL032BYPEgxLXfk20ObrH
 /cwtAgRSpe812cw/AYOrOyO4McE7bKPekG9Y+Xx7CLBc6zVXYNoCZDFUz+2Kq9e4WA6d
 QNS2uL74qFSyMLAl86PhaZ/F5YPjGutu3SPBzFFJJ54jz50yKqTlt+PE9awDVF06cEm6
 MKqU/dhZUNuVCWMnm4bZRy9qLbYzQTr64vEE7vx1utRhLcXFUVJco+z2JO5J9KumIjkF
 gnIA==
X-Gm-Message-State: APjAAAW1twqiCHtUbO6grPecNvlKDbjpY/RD4tqYFlspJDrbnpP+rBb2
 Qg/UeGoJREDv4Jt/Li8DZJN1p6ADg3YP+2o+t2g=
X-Google-Smtp-Source: APXvYqzjWMsnZN8deEBM8ZWpk4Ql1YWVy/FtzqS5bbbRWC+6pSY5mHc93gufRfs9I4WxSSebLHxrIQ9FGU+2SUBH8rU=
X-Received: by 2002:a17:90a:ba89:: with SMTP id
 t9mr20177726pjr.29.1573826487071; 
 Fri, 15 Nov 2019 06:01:27 -0800 (PST)
MIME-Version: 1.0
References: <CAB-99Lv3LySps4MOoKEj7Sp0CBouv-KgZp2osbiokSq_Gdfj5Q@mail.gmail.com>
 <CAFEAcA-RXurz2OB24i1wypumCDWf5s__mC33mFzBA3SCsm4_VA@mail.gmail.com>
In-Reply-To: <CAFEAcA-RXurz2OB24i1wypumCDWf5s__mC33mFzBA3SCsm4_VA@mail.gmail.com>
From: Michael Goffioul <michael.goffioul@gmail.com>
Date: Fri, 15 Nov 2019 09:01:15 -0500
Message-ID: <CAB-99LsMY5R11VN=2aOq0CDcvm5sN5rTjCAZumOsZ-uWjXgujQ@mail.gmail.com>
Subject: Re: Invalid ARM instruction for clang-compiled Android code
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b33e6905976308cb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
X-Mailman-Approved-At: Fri, 15 Nov 2019 10:01:37 -0500
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
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b33e6905976308cb
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 15, 2019 at 6:03 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> Richard, I think we're tripping over the check you added
> in commit af2882289951e. Specifically:
>
> +    /* We UNDEF for these UNPREDICTABLE cases.  */
> +    if (a->rd == 15 || a->rn == 15 || a->rt == 15
> +        || a->rd == a->rn || a->rd == a->rt
> +        || (s->thumb && (a->rd == 13 || a->rt == 13))
> +        || (mop == MO_64
> +            && (a->rt2 == 15
> +                || a->rd == a->rt2 || a->rt == a->rt2
> +                || (s->thumb && a->rt2 == 13)))) {
> +        unallocated_encoding(s);
> +        return true;
> +    }
>
> in the mop == MO_64 subclause we check for
>  a->rt == a->rt2
> so we will UNDEF for rt == rt2, as in this example. But the
> pseudocode in the spec doesn't say that rt == rt2 is
> an UNPREDICTABLE case. (It is an UNDPREDICTABLE
> case for LDREXD, but STREXD lets you write the same
> register twice if you want to.) Or am I misreading this?
>

BTW, I can confirm that removing the check "a->rt == a->rt2" seems to fix
my problem.

--000000000000b33e6905976308cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Nov 15, 2019 at 6:03 AM Peter May=
dell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.o=
rg</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Richard, I think we&#39;re tripping over the c=
heck you added<br>
in commit af2882289951e. Specifically:<br>
<br>
+=C2=A0 =C2=A0 /* We UNDEF for these UNPREDICTABLE cases.=C2=A0 */<br>
+=C2=A0 =C2=A0 if (a-&gt;rd =3D=3D 15 || a-&gt;rn =3D=3D 15 || a-&gt;rt =3D=
=3D 15<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || a-&gt;rd =3D=3D a-&gt;rn || a-&gt;rd =3D=3D=
 a-&gt;rt<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || (s-&gt;thumb &amp;&amp; (a-&gt;rd =3D=3D 13=
 || a-&gt;rt =3D=3D 13))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || (mop =3D=3D MO_64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (a-&gt;rt2 =3D=3D 15<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || a-&gt;rd =3D=3D=
 a-&gt;rt2 || a-&gt;rt =3D=3D a-&gt;rt2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || (s-&gt;thumb &a=
mp;&amp; a-&gt;rt2 =3D=3D 13)))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unallocated_encoding(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
<br>
in the mop =3D=3D MO_64 subclause we check for<br>
=C2=A0a-&gt;rt =3D=3D a-&gt;rt2<br>
so we will UNDEF for rt =3D=3D rt2, as in this example. But the<br>
pseudocode in the spec doesn&#39;t say that rt =3D=3D rt2 is<br>
an UNPREDICTABLE case. (It is an UNDPREDICTABLE<br>
case for LDREXD, but STREXD lets you write the same<br>
register twice if you want to.) Or am I misreading this?<br></blockquote><d=
iv><br></div><div>BTW, I can confirm that removing the check &quot;a-&gt;rt=
 =3D=3D a-&gt;rt2&quot; seems to fix my problem.</div><div><br></div></div>=
</div>

--000000000000b33e6905976308cb--

