Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41E9C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B635D2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxoMbnox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B635D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47C8-0007Lp-Ry
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j47BA-0006WY-AB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j47B7-000509-2W
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:01:04 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j47B6-0004zM-Sy
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:01:01 -0500
Received: by mail-ot1-x344.google.com with SMTP id p8so20345118oth.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 10:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=kS9eBKBSvayrPqy7SXrTn3XSaEf7U95QAVMX44wiCFs=;
 b=mxoMbnoxePDq6TYW6VIUe6FA6/sGyifp7JPJjszQtK4iES3g8yXprd6SmtSX1+5inZ
 zWqc2UCK61d/xxAguuwoWun2BLlZqviJm+Cy2hXT3YEjV2xOzpJdpYbID25guuntGsut
 lLcbFCt0LMq3+lB7eQIHsCFfFdYzCY3JNrb7mnOqtUPb4vMLbmMB/KM9ubvfrI3Mzpwv
 4GSHJ/wyooZpIHyi6IXrgPlbZFvSua+uGXbI0BfNzgbaq1JDQAxlP290OAibb0nsG6Rf
 tR/hn1Zj2NM1t569PdgAZzsliHMQ/P99myIAOSMaVnKnQR1KXypiTnv5/qzHNX3AOJUG
 MNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=kS9eBKBSvayrPqy7SXrTn3XSaEf7U95QAVMX44wiCFs=;
 b=s0xUKUg+xKUIYjdGuPuCP3DvBcPwh2P0Y8EMoHTp9K1H+E29qqrWVtZK/vQBoImZ9o
 Znq/6q2uV6UqGdU33UWv0QIIynAOKOD5kGHD4F4TeZU0ox9i+65Dez+R34Rb6cR7IoBU
 hCoRzxzzn4C/hDVSubcBfF9NaOFvxO3uj2MCHQcDEnXOr1w6JBojDQFIcwxT0jdL/cTK
 IWmIpJgj8qxOzL3zHszOq7R/AoW2jsL1XcWP7XXB0n0PnJ2dK8PSzMtbII+Wqot+QaL7
 6BIx/vY9HQylBb7NroB8SHy1+6eOmrwqipKj14EHsK7OudQtcrVy1bQettB5ZxCMAAJn
 eRmQ==
X-Gm-Message-State: APjAAAXvSba0fJOfhqDy1iL0yofJ/7jZFKIT0KXwkikOy2VqjqDUME7+
 d/TQa32Sjjc0nyZqk+MCfra5uvm+mpsHqXd6m1A=
X-Google-Smtp-Source: APXvYqwFCmftfaRf4Dj+G020lqurvmIIrVvMEP76yKbQYQ8/BiJGG5D5x64FjU9sPftsoHK50G2Jlvty4Y2A7bYuvkQ=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr15689839otb.121.1582048859717; 
 Tue, 18 Feb 2020 10:00:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 10:00:59 -0800 (PST)
In-Reply-To: <20191221155306.49221-1-jhogan@kernel.org>
References: <20191221155306.49221-1-jhogan@kernel.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 19:00:59 +0100
Message-ID: <CAL1e-=j3V=1rVrvpyo6NDcvVfU6PCs3SzgBoqF+818txc8NHnQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Orphan MIPS KVM CPUs
To: James Hogan <jhogan@kernel.org>
Content-Type: multipart/alternative; boundary="0000000000004d03d9059edd7412"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Paul Burton <paulburton@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004d03d9059edd7412
Content-Type: text/plain; charset="UTF-8"

On Saturday, December 21, 2019, James Hogan <jhogan@kernel.org> wrote:

> I haven't been active for 18 months, and don't have the hardware set up
> to test KVM for MIPS, so mark it as orphaned and remove myself as
> maintainer. Hopefully somebody from MIPS can pick this up.
>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: qemu-devel@nongnu.org
> ---


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 740401bcbb86..a798ad2b0b8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -363,9 +363,8 @@ S: Maintained
>  F: target/arm/kvm.c
>
>  MIPS KVM CPUs
> -M: James Hogan <jhogan@kernel.org>
>  R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> -S: Maintained
> +S: Orphan
>  F: target/mips/kvm.c
>
>  PPC KVM CPUs
> --
> 2.24.0
>
>
>

--0000000000004d03d9059edd7412
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, December 21, 2019, James Hogan &lt;<a href=3D"mailto:j=
hogan@kernel.org">jhogan@kernel.org</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">I haven&#39;t been active for 18 months, and don&#39;t have the h=
ardware set up<br>
to test KVM for MIPS, so mark it as orphaned and remove myself as<br>
maintainer. Hopefully somebody from MIPS can pick this up.<br>
<br>
Signed-off-by: James Hogan &lt;<a href=3D"mailto:jhogan@kernel.org">jhogan@=
kernel.org</a>&gt;<br>
Cc: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.com">al=
eksandar.rikalo@rt-rk.com</a>&gt;<br>
Cc: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelien@aur=
el32.net</a>&gt;<br>
Cc: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com">amark=
ovic@wavecomp.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a><br>
---</blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);font=
-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovic=
 &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-size:14=
px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=3D=
"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;</s=
pan><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0MAINTAINERS | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 740401bcbb86..a798ad2b0b8a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -363,9 +363,8 @@ S: Maintained<br>
=C2=A0F: target/arm/kvm.c<br>
<br>
=C2=A0MIPS KVM CPUs<br>
-M: James Hogan &lt;<a href=3D"mailto:jhogan@kernel.org">jhogan@kernel.org<=
/a>&gt;<br>
=C2=A0R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.co=
m">aleksandar.rikalo@rt-rk.com</a>&gt;<br>
-S: Maintained<br>
+S: Orphan<br>
=C2=A0F: target/mips/kvm.c<br>
<br>
=C2=A0PPC KVM CPUs<br>
-- <br>
2.24.0<br>
<br>
<br>
</blockquote>

--0000000000004d03d9059edd7412--

