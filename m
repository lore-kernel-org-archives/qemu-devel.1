Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1A1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 03:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764172071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 03:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk7e7qZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764172071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZRMt-0001Cg-Lx
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 22:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZRLz-0000mi-4N
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 22:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZRLy-00016z-16
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 22:17:27 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:34460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZRLx-00016t-SX
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 22:17:25 -0500
Received: by mail-ot1-x32a.google.com with SMTP id w11so14685549ote.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 19:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=M4ar/0LxKuDybs+xFTnxc9gpvZ9TwdYOQK/ea8LFv5U=;
 b=Sk7e7qZ90C5AMJpYyx2hZpiCAMoRfefHnWvknDmZsH2P6lbf1MmBd4dlt0rDpghCvQ
 O3GcSgZ9DwkZ2bPMHS7jSLFQkJJJpRhB8AZDHD4UEZo+GHkivaB7L/WLqIz/g3mm74UL
 mcxk0MwbvLdtLEwao5+okb4OjbXQUtKbbJs4wdeih9njNDQo/e6MmNWFJOmX8juBBXi/
 Tztdu5qCJ95MDai2pGfNKEqAtRY1SjOndOXDobphUGZJncdL7gxjvn7BTxj8v6iuJ8Vv
 9drsOv4b2zqoc6hEMrxykmKDEQPBmh/BWedX2bvo5ut+OVyDPRvcE0GcGfXOpAnBya4c
 YzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=M4ar/0LxKuDybs+xFTnxc9gpvZ9TwdYOQK/ea8LFv5U=;
 b=NYZB6F3zx5cD/rrgABgPis9TzFNlPnggcPMIGzSbP/p5eOLvLSJwvjLoUimp3ATMJt
 djzFw8GYDVJ/TH8tlK8D3P9GUQRBKCetasqn3lcm9Ml6Bhm4Shj3l/ixaikhAUbavtQp
 z3nn9Nsa8FNIS30vAKC8Gbvrio8uXDcqPndAe3ng2uboOvfksYeN3j6nAMcPUQwiqIHN
 hvOapwdPIKbnTHbom7wRsTBT+RYcmz8bcp6DQih6Ys/DT27pcnOie3UOiNxviKc7nUvs
 zSuwgb5/iMzq6km+cV+zuLyMcoUqjhVxvSGoJYxG6mzaKBpKmhKIkrr0wjPM2nPXAnAB
 FzjA==
X-Gm-Message-State: APjAAAXO9rcoOc2pgN6gV14KiN9JLm5okO0placFQu8cWlheR/EpGux9
 v70QcdeT54nHPq6mmjgibDdqTaJjdj19KwOdoa0=
X-Google-Smtp-Source: APXvYqzdG2wZgkklJPF7cwQZoNyGSc8awYNDgfDzwd+5qkjGXXAloYSOanPeRfuitZAFJ1dTWIFkcTyb+vnv2czM3+A=
X-Received: by 2002:a05:6830:44c:: with SMTP id
 d12mr702112otc.121.1574738244971; 
 Mon, 25 Nov 2019 19:17:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Mon, 25 Nov 2019 19:17:24
 -0800 (PST)
In-Reply-To: <20191124050225.30351-18-mrolnik@gmail.com>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-18-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 26 Nov 2019 04:17:24 +0100
Message-ID: <CAL1e-=gBBFRxAsDnRyQqiZSLWhMmfyp2YXge4E12VaEmEG=a9g@mail.gmail.com>
Subject: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b4b15c0598375147"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b4b15c0598375147
Content-Type: text/plain; charset="UTF-8"

On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Include AVR maintaners in MAINTAINERS file
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..ad2d9dd04a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -163,6 +163,15 @@ S: Maintained
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
>
> +AVR TCG CPUs
> +M: Michael Rolnik <mrolnik@gmail.com>
> +S: Maintained
> +F: target/avr/
> +F: hw/misc/avr_mask.c
> +F: hw/char/avr_usart.c
> +F: hw/timer/avr_timer16.c
> +F: hw/avr/
> +


I had a strange feeling that something is missing here, and I finally
realized what that was:

R: Sarah Harris <S.E.Harris@kent.ac.uk>

https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04225.html



 CRIS TCG CPUs
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000b4b15c0598375147
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, November 24, 2019, Michael Rolnik &lt;<a href=3D"mailto:=
mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">Include AVR maintaners in MAINTAINERS file<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 5e5e3e52d6..ad2d9dd04a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -163,6 +163,15 @@ S: Maintained<br>
=C2=A0F: hw/arm/smmu*<br>
=C2=A0F: include/hw/arm/smmu*<br>
<br>
+AVR TCG CPUs<br>
+M: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blan=
k">mrolnik@gmail.com</a>&gt;<br>
+S: Maintained<br>
+F: target/avr/<br>
+F: hw/misc/avr_mask.c<br>
+F: hw/char/avr_usart.c<br>
+F: hw/timer/avr_timer16.c<br>
+F: hw/avr/<br>
+</blockquote><div><br></div><div>I had a strange feeling that something is=
 missing here, and I finally realized what that was:=C2=A0</div><div><br></=
div><div>R:=C2=A0<span style=3D"color:rgb(34,34,34);font-size:14px;line-hei=
ght:22.1200008392334px">Sarah Harris &lt;</span><a href=3D"mailto:S.E.Harri=
s@kent.ac.uk" style=3D"font-size:14px;line-height:22.1200008392334px" targe=
t=3D"_blank">S.E.Harris@kent.ac.uk</a><span style=3D"color:rgb(34,34,34);fo=
nt-size:14px;line-height:22.1200008392334px">&gt;</span></div><div>=C2=A0</=
div><div><a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-10/m=
sg04225.html" target=3D"_blank">https://lists.gnu.org/archive/<wbr>html/qem=
u-devel/2019-10/<wbr>msg04225.html</a><br></div><div><br></div><div><br></d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0CRIS TCG CPUs<br>
=C2=A0M: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com" =
target=3D"_blank">edgar.iglesias@gmail.com</a>&gt;<br>
=C2=A0S: Maintained<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--000000000000b4b15c0598375147--

