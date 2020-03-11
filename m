Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746AC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E3D20737
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quEuiLWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E3D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC7VN-0007hZ-FV
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 15:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC7Um-00075Z-VU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 15:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC7Ul-0004id-VK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 15:58:24 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jC7Ul-0004i3-Qk; Wed, 11 Mar 2020 15:58:23 -0400
Received: by mail-io1-xd44.google.com with SMTP id t26so3241613ios.11;
 Wed, 11 Mar 2020 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RR3mg5wmMKz/+GwN6HCoqmVSY+wRsxn8EXjNnSDeV6E=;
 b=quEuiLWhNZKcEZfY5Z2C4iuKPD9JyTJwdJ0WNidK1OmctrcE9KpONZW1qVnou0aHtR
 2x9UrwjVgUiliAoUcMQQMsWbLCaP3DiC3XxP0TFKpmUT0n+nPQVidFAxDidAi2XoD8VQ
 fj+8uHXALAldCWuQ2hKxp9ORENdsVZp9sdmieKdSuQzvnAyAh2y8nPcHHt6pfvpZCsez
 M9UdMAGWTFkD2fVBkyeGZOzgXcTiA+tPEk0PBQ67Ku8gFK8ISTH6Qx6wvu+wzrWnZLi9
 r9Ldb0ACnpDPrdEGMGbvf1p9azCE+JasI2fyLu3NRispDt1G3OvHgR/ZWQaITmPpZT3y
 ZbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RR3mg5wmMKz/+GwN6HCoqmVSY+wRsxn8EXjNnSDeV6E=;
 b=ZJhWWpKuVMtuWT9mkMJG4v7y8ZL6HlRzKGGPls0qBbCy3lCQBhnkTfgYSSPJwDZ8CU
 8Kp2OL4G6YcR7xW332dAWDQkm+ec69xcvHE7P/8TxAGbbaRx7ILyNfEwHxj2K5Hne3bT
 aBJ3OSzRMnT1TJdfQghTR4vpnuqjHSUo1W/XUskDS28cEkKNaESvsgKy9c3Gv/it7JF2
 dLkRwTYQdMCbG6hEr3wIKGXlvL0MxKjZLmJQiiR/EO1MMikXByn1jJvNbhuWw2pJRtGp
 r1LdzkwPE9BRiOOyQqrt1W6fcIqYnuSI38iJDZHQRgTDKyJoY0gMWyLJiRCRn7zGyrE3
 NxAQ==
X-Gm-Message-State: ANhLgQ1NV72/ysDsnX6iBkJ6Ukap1R+Tkqer9rIFsB0aJorsCG+7UwiN
 Ey3xnKCLHgeJpKqH4ZOq+Hun5OFG4KG586LDIss=
X-Google-Smtp-Source: ADFU+vvAYgkZ5tnJtYRxFcZw8mPY5UYexVg73TGG0aRUov8o3RO2n6ZTVXVOnwNIrQWpQkava/63ESI69i2R6cdXKqg=
X-Received: by 2002:a6b:740c:: with SMTP id s12mr4504091iog.108.1583956703153; 
 Wed, 11 Mar 2020 12:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-19-nieklinnenbank@gmail.com> <875zfbgff8.fsf@linaro.org>
In-Reply-To: <875zfbgff8.fsf@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 20:58:12 +0100
Message-ID: <CAPan3Wp0AotZrbu=R0gEkwCjkU6Lw43fYUaz3c7BucYvLF0bQA@mail.gmail.com>
Subject: Re: [PATCH v7 18/18] docs: add Orange Pi PC document
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a1936105a099a875"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a1936105a099a875
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 3:00 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>
> > The Xunlong Orange Pi PC machine is a functional ARM machine
> > based on the Allwinner H3 System-on-Chip. It supports mainline
> > Linux, U-Boot, NetBSD and is covered by acceptance tests.
> >
> > This commit adds a documentation text file with a description
> > of the machine and instructions for the user.
>
> Awesome to have such comprehensive documentation for a system. Thanks
> ;-)
>

I'm glad to hear that Alex. Perhaps in another patch series we can begin to
add documentation for other boards as well.

Regards,
Niek


>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --
> Alex Benn=C3=A9e
>


--=20
Niek Linnenbank

--000000000000a1936105a099a875
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 11, 2020 at 3:00 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_=
blank">nieklinnenbank@gmail.com</a>&gt; writes:<br>
<br>
&gt; The Xunlong Orange Pi PC machine is a functional ARM machine<br>
&gt; based on the Allwinner H3 System-on-Chip. It supports mainline<br>
&gt; Linux, U-Boot, NetBSD and is covered by acceptance tests.<br>
&gt;<br>
&gt; This commit adds a documentation text file with a description<br>
&gt; of the machine and instructions for the user.<br>
<br>
Awesome to have such comprehensive documentation for a system. Thanks<br>
;-)<br></blockquote><div><br></div><div>I&#39;m glad to hear that Alex. Per=
haps in another patch series we can begin to add documentation for other bo=
ards as well.</div><div><br></div><div>Regards,</div><div>Niek<br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000a1936105a099a875--

