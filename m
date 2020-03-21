Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F69FC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1950A20714
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7QgK3Ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1950A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFchq-0006nZ-8A
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFccK-0004m1-HK
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFccJ-0007Sq-4k
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:48:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jFccI-0007SQ-TX
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:48:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id d1so9175033wmb.2
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XQd8pmNhhI+eQ94v2/2BihPN+z4AUMekdyJKkYZBzdU=;
 b=t7QgK3UioOTCZqaykPfc1r/Asr7Ae9KZMKvvZOb/1Nr6mKG8Vgv5/0KMPzpxNCoOST
 qzfAkuZxXoshLnCDzflpi7VOUHLJxrqBpRDVjzOagZHB7QRZMgLdhbD1lBcFSrULpm3M
 7HCEefnsttoYZoH260MlpyNwP84jkkLeAejYZEP5ns4kG7JLHm6qvbonGIc/W414WCw8
 rZJpOAovXjaOhMnwqCx0kKnwGt/FeAa3wPa9C61hl3OKFJYGg6rLjZZg8Ah1sltbwG2+
 NnR5h/Fz4zP+fD3UhVKNRd+z2gSvowF2E8ocZnesYLoeMVLHgKfxWF8vaF4rOLHTN/0I
 N7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XQd8pmNhhI+eQ94v2/2BihPN+z4AUMekdyJKkYZBzdU=;
 b=KpL+u8RPspnCPIAVRbK7ytmKnlQ4FXawczpdZoODoRI7jR/cjTR+FwEgoSifA/6lK5
 24Evq3Ah1hyipQqRiuBeLHSjOJZiJ45mpc0xn1vzsuGNKdTWOsxS65IeO7oTFPYkaYRe
 yVedsy7z2Ktcij5V3M0N6jOCPKVKwhisSsemkiKikMPnjiFXOnTCYteT8cCDFj1KRYVI
 p58c/ngo03BFTZ0LiBRUUAAaPXlbYQ8giinbD0YNXehD9llykK2FOXehFT1QdeuCcPck
 ITW7y+a7drxwd/Miv+uXPgudjqNk1/i9q5pxCoQiuqDHS/tnfQYu6gSxAiB1T6eBYAJz
 5VNA==
X-Gm-Message-State: ANhLgQ1Y+FUiFh+xEHMJQaj00mldXdil11VUr5oZg61rb31XhwGCHLWN
 Lr31IuRCeIcFMTEGUjghXa91SJX68Yg7iOxiM9k=
X-Google-Smtp-Source: ADFU+vufErNA73U15u/x6xaM8MkKM0INGJwrMhnFbHEq/mpqtYrm9mmR5LHLJ4VpSkkm6Q9Zfw5bbTXH7yLQ7i3oSNs=
X-Received: by 2002:a1c:4987:: with SMTP id
 w129mr14732616wma.168.1584791317303; 
 Sat, 21 Mar 2020 04:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200320190553.9363-1-philmd@redhat.com>
 <20200320190553.9363-3-philmd@redhat.com>
In-Reply-To: <20200320190553.9363-3-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 21 Mar 2020 12:48:20 +0100
Message-ID: <CAHiYmc4qm+zvty8TbbYmwaPBP1gYpz97rq6gmAxNA08cAEQ4dQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 2/4] tests/docker: Install gcrypt devel package in
 Debian image
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000082d91105a15bfb5d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000082d91105a15bfb5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

8:06 PM Pet, 20.03.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =
=D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Apparently Debian Stretch was listing gcrypt as a QEMU dependency,
> but this is not the case anymore in Buster, so we need to install
> it manually (it it not listed by 'apt-get -s build-dep qemu' in
> the common debian10.docker anymore).
>
>  $ ../configure $QEMU_CONFIGURE_OPTS
>
>   ERROR: User requested feature gcrypt
>          configure was not able to find it.
>          Install gcrypt devel >=3D 1.5.0
>
> Fixes: 698a71edbed & 6f8bbb374be
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

If the problem is caused by Debian Buster change in behavior, I think you
should not enumerate QEMU commits as something that is fixed by this patch.
That implies that something was wrong with these commits, while they were,
I suppose, fine at the moment of their integration.

Very confusing!

If you think that these commit ids deserve to be mentioned, you should say:
"Related commits are..." or similar.

Regards,
Aleksandar

>  tests/docker/dockerfiles/debian-amd64.docker | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker
b/tests/docker/dockerfiles/debian-amd64.docker
> index d4849f509f..957f0bc2e7 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -16,6 +16,7 @@ RUN apt update && \
>      apt install -y --no-install-recommends \
>          libbz2-dev \
>          liblzo2-dev \
> +        libgcrypt20-dev \
>          librdmacm-dev \
>          libsasl2-dev \
>          libsnappy-dev \
> --
> 2.21.1
>
>

--00000000000082d91105a15bfb5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">8:06 PM Pet, 20.03.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Apparently Debian Stretch was listing gcrypt as a QEMU dependency,<br>
&gt; but this is not the case anymore in Buster, so we need to install<br>
&gt; it manually (it it not listed by &#39;apt-get -s build-dep qemu&#39; i=
n<br>
&gt; the common debian10.docker anymore).<br>
&gt;<br>
&gt; =C2=A0$ ../configure $QEMU_CONFIGURE_OPTS<br>
&gt;<br>
&gt; =C2=A0 ERROR: User requested feature gcrypt<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0configure was not able to find it.<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Install gcrypt devel &gt;=3D 1.5.0<b=
r>
&gt;<br>
&gt; Fixes: 698a71edbed &amp; 6f8bbb374be<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@redhat.com">philmd@redhat.com</a>&gt;<br>
&gt; ---</p>
<p dir=3D"ltr">If the problem is caused by Debian Buster change in behavior=
, I think you should not enumerate QEMU commits as something that is fixed =
by this patch. That implies that something was wrong with these commits, wh=
ile they were, I suppose, fine at the moment of their integration.</p>
<p dir=3D"ltr">Very confusing!</p>
<p dir=3D"ltr">If you think that these commit ids deserve to be mentioned, =
you should say: &quot;Related commits are...&quot; or similar.</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; =C2=A0tests/docker/dockerfiles/debian-amd64.docker | 1 =
+<br>
&gt; =C2=A01 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/dock=
er/dockerfiles/debian-amd64.docker<br>
&gt; index d4849f509f..957f0bc2e7 100644<br>
&gt; --- a/tests/docker/dockerfiles/debian-amd64.docker<br>
&gt; +++ b/tests/docker/dockerfiles/debian-amd64.docker<br>
&gt; @@ -16,6 +16,7 @@ RUN apt update &amp;&amp; \<br>
&gt; =C2=A0 =C2=A0 =C2=A0apt install -y --no-install-recommends \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libbz2-dev \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0liblzo2-dev \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 libgcrypt20-dev \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0librdmacm-dev \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libsasl2-dev \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libsnappy-dev \<br>
&gt; -- <br>
&gt; 2.21.1<br>
&gt;<br>
&gt;<br>
</p>

--00000000000082d91105a15bfb5d--

