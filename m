Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62364C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 22:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F06F2074F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntVHP/bB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F06F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMg2E-0000fk-9V
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 18:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1jMg1X-00008J-UB
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 18:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1jMg1W-0003mV-S7
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 18:51:51 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1jMg1W-0003l1-NF
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 18:51:50 -0400
Received: by mail-io1-xd42.google.com with SMTP id n20so101404ioa.4
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tUXF79ar3uH86bC5a8AmzCUDFFKLUqqKyI5CT3tnPDc=;
 b=ntVHP/bB2vk6AV2ZjmeXg3q64AzBtHq53nGda2rAdaDhKMKQFJ1+BEK1WiwmBeamED
 lalno6NUQ1HixXfXkQdjmDIVyBDijRdB2f96ri5Q+zMQWFP6yvUM+WRYzxnS5srD5iwZ
 PVwF9/CXHFWJP83XX75Txb4sDoev6xx02CQsdOFko8u3JM+0LRp0961zlxyZpGS6WRNW
 q0QmJ02YXTGbrdZRjGg5bjxnNg+aV21KNCG6+9vECMuOfhKPnV76WUlP8Fj7nZsCyv8b
 I37sUjJQF0rGBUuDVOxskcRDzAotO2Pycj6F80dYL0iCbv9QDJ0qiTfH/97JqabofQFW
 YbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tUXF79ar3uH86bC5a8AmzCUDFFKLUqqKyI5CT3tnPDc=;
 b=eOSOpaJj0SufZBRd8Jar0Q+l4G6IySEOTa69EKoVZcGtRKvXyqTjrM2zFleqS89G2+
 zYhXGL4tLc9uYwFgpb9vuh1YbXVkp9pPAtnck4VdHbCT1rXrUGqyVALU05GcYHHNJbXC
 vudaR4PQjwV/MZbSXpTWrCUx4Ajm7R7J6HEZJM6RfTUNaHdwKdeHpVQFgkJilLq1TmwE
 /1cb4decxAsZd6GdA5qp4Uaa0TKsvmXv0+IHs44VJGaZXTHapdKEdijMQVCPyyCDYCvs
 DIT9i9sZmuWaUyrJWantfGpRp/QFjV/vYQaDHRTmsvGyZnZ8p1GG+SbxYgnFFvfOGF8n
 Zs8w==
X-Gm-Message-State: AGi0PuY4QDrfDLvZNClZZFEaiRoCJFGu9MI6Ej5TTosn9HE5bvN7THW0
 eiccF0u1PCTSN8qf58vzVCuQqGiTDlCOEcdlTjs=
X-Google-Smtp-Source: APiQypJlWgneDJHWsgWgLcdZsOJ9Q75RHbUOHb8C+UQ4jezz+aPAWfp3/4TrEAuNnl8apJEh6ru6PsssbP21AxJyZLQ=
X-Received: by 2002:a02:9988:: with SMTP id a8mr1842098jal.3.1586472709225;
 Thu, 09 Apr 2020 15:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-8-alex.bennee@linaro.org>
In-Reply-To: <20200409211529.5269-8-alex.bennee@linaro.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 10 Apr 2020 00:51:35 +0200
Message-ID: <CABLmASE7JW5q46ADfm77kVq_wqAXGNgLyxXqTKgswLmh1fLnCQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/11] configure: disable PIE for Windows builds
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000047810305a2e376f8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Bug 1871798 <1871798@bugs.launchpad.net>,
 James Le Cuirot <chewi@aura-online.co.uk>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000047810305a2e376f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2020 at 11:18 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> It seems on some compilers the test can pass but still give you
> broken binaries.
>
> [AJB untested - please could windows users test]
>
> Fixes: d2cd29e30736
> Fixes: https://bugs.launchpad.net/qemu/+bug/1871798
> Cc: Bug 1871798 <1871798@bugs.launchpad.net>
> Cc: James Le Cuirot <chewi@aura-online.co.uk>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configure b/configure
> index a207cce82bc..e9c5f630c14 100755
> --- a/configure
> +++ b/configure
> @@ -807,6 +807,7 @@ MINGW32*)
>      audio_drv_list=3D""
>    fi
>    supported_os=3D"yes"
> +  pie=3D"no"
>  ;;
>  GNU/kFreeBSD)
>    bsd=3D"yes"
> --
> 2.20.1
>

Solves my issue! So,

Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>

--00000000000047810305a2e376f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 9, 2020 at 11:18 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank"=
>alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">It seems on some compilers the test can pass but sti=
ll give you<br>
broken binaries.<br>
<br>
[AJB untested - please could windows users test]<br>
<br>
Fixes: d2cd29e30736<br>
Fixes: <a href=3D"https://bugs.launchpad.net/qemu/+bug/1871798" rel=3D"nore=
ferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1871798</a><=
br>
Cc: Bug 1871798 &lt;<a href=3D"mailto:1871798@bugs.launchpad.net" target=3D=
"_blank">1871798@bugs.launchpad.net</a>&gt;<br>
Cc: James Le Cuirot &lt;<a href=3D"mailto:chewi@aura-online.co.uk" target=
=3D"_blank">chewi@aura-online.co.uk</a>&gt;<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0configure | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/configure b/configure<br>
index a207cce82bc..e9c5f630c14 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -807,6 +807,7 @@ MINGW32*)<br>
=C2=A0 =C2=A0 =C2=A0audio_drv_list=3D&quot;&quot;<br>
=C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0supported_os=3D&quot;yes&quot;<br>
+=C2=A0 pie=3D&quot;no&quot;<br>
=C2=A0;;<br>
=C2=A0GNU/kFreeBSD)<br>
=C2=A0 =C2=A0bsd=3D&quot;yes&quot;<br>
-- <br>
2.20.1<br></blockquote><div><br></div><div>Solves my issue! So,</div><div><=
br></div><div>Tested-by: Howard Spoelstra &lt;<a href=3D"mailto:hsp.cat7@gm=
ail.com" target=3D"_blank">hsp.cat7@gmail.com</a>&gt;<br></div></div></div>

--00000000000047810305a2e376f8--

