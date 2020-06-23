Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2525D20702
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI+hQsau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2525D20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjKe-0006Qa-DT
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 09:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnjJo-0005S0-H9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:50:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnjJl-0002KK-MS
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:50:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id u26so2304212wmn.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=s14FefprESCzbbW/KKMUugzZbUvIG5eqGtUib05qksA=;
 b=VI+hQsaufhjS4I96r9R91hyMB7g/9mYMABFiOEQEKwtRmUvtnl7jK5dl1UiyOL8mCx
 xD/nFVeYt6IA7zeKU1ViI7LXtxrPyG5SmPUNcuuCdg5zZpZJ/2JjRYACDZB28R8j+DZb
 4Q73eLfIjjrw8fC6fRrfSiJcB1zh/SUbc0ovGK+fZ2Dz6Kgf5tcZkaBOKUTolYtCVSL3
 U5OIPCfUClHrx8GVLWX6TNxtt6mC5dNefPqSobf+U6/gnjDzDdurjeCUPz3hWziQ6VQU
 BHp1aSAFX3ql7PixLPr1nzaglCiLwR/+J4dKSn6j66se4JrTi4N0Rkkvy9rqpjqRB5Gk
 p3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=s14FefprESCzbbW/KKMUugzZbUvIG5eqGtUib05qksA=;
 b=uHv6DdFKRJLxA2DCW9+IGmeUow6RZEAfTSk2ukROvT8b1jkVAbHNKRSKwV+8qTIESJ
 pQXzl+MhDhO7ORGYvBsp9JMyeCQqgYGWU3MI/5EIorukmPLa55QdUK+s14igW15w+j9b
 mQttClRUiFUodCxJbPLFnAWH79FwY8i01Yg7H38pvi5Cd8/rX/hDuQpEJir9sTuu4ugu
 UdiJZMQkPHsHyWW+k7bBmkOZxek2tOxhtzq+H7n8iuIfAQT5SIobQhQHGuz/1EqpF9nx
 NtbFySL3CQ0S/FD7bnLbL7Lum5QGXc3t8lu6SDFuY5zAXOlb6fg7ZKzfc4fpOudVuAnj
 7HpQ==
X-Gm-Message-State: AOAM530hsk23ICjQiVqDTvpfK/gx1bDvigpnToG8iAUB/rsaN8i0i/ab
 SGpLVaub4kzem8DXtjXrzRB3Zldeeg2mGCYZgk4=
X-Google-Smtp-Source: ABdhPJzKv5Ejadc6pFecIhkrhFyB5pmwNbv068vXQKbp0c+FsIDAXTne19hkCGqaGNe/ArzAXubP4dfK8Yir0GM5mhw=
X-Received: by 2002:a1c:4444:: with SMTP id r65mr5836002wma.129.1592920228124; 
 Tue, 23 Jun 2020 06:50:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c0d7:0:0:0:0:0 with HTTP; Tue, 23 Jun 2020 06:50:27
 -0700 (PDT)
In-Reply-To: <1592914438-30317-5-git-send-email-chenhc@lemote.com>
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
 <1592914438-30317-5-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 23 Jun 2020 15:50:27 +0200
Message-ID: <CAHiYmc5rCjZXc4Pt4QqD8zykqBo8pxbPAxjQP7rTWi6y=3bjsg@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V5 4/4] MAINTAINERS: Add Loongson-3 maintainer and
 reviewer
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000005a5cfd05a8c0a460"
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005a5cfd05a8c0a460
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 23. =D1=98=D1=83=D0=BD 2020., Huacai =
Chen <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:

> Add myself as a maintainer of Loongson-3 virtual platform, and also add
> Jiaxun Yang as a reviewer.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0cb1fd..293188e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1095,6 +1095,12 @@ F: hw/isa/vt82c686.c
>  F: hw/pci-host/bonito.c
>  F: include/hw/isa/vt82c686.h
>
> +Loongson-3 Virtual Platform
> +M: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> +S: Maintained
> +F: hw/mips/loongson3_virt.c


 hw/intc/loongson_liointc.c is missing.


> +
>  Boston
>  M: Paul Burton <pburton@wavecomp.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> --
> 2.7.0
>
>

--0000000000005a5cfd05a8c0a460
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 23. =D1=98=D1=83=D0=BD 2020.,=
 Huacai Chen &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zltjiangshi@gmail=
.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Add myself as a maintainer of Loo=
ngson-3 virtual platform, and also add<br>
Jiaxun Yang as a reviewer.<br>
<br>
Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@=
lemote.com</a>&gt;<br>
Co-developed-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com"=
>jiaxun.yang@flygoat.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index f0cb1fd..293188e 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1095,6 +1095,12 @@ F: hw/isa/vt82c686.c<br>
=C2=A0F: hw/pci-host/bonito.c<br>
=C2=A0F: include/hw/isa/vt82c686.h<br>
<br>
+Loongson-3 Virtual Platform<br>
+M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote.com<=
/a>&gt;<br>
+R: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">jiaxun.yang@=
flygoat.com</a>&gt;<br>
+S: Maintained<br>
+F: hw/mips/loongson3_virt.c</blockquote><div><br></div><div><span style=3D=
"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">=C2=A0h=
w/intc/loongson_liointc.c is missing.</span><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
+<br>
=C2=A0Boston<br>
=C2=A0M: Paul Burton &lt;<a href=3D"mailto:pburton@wavecomp.com">pburton@wa=
vecomp.com</a>&gt;<br>
=C2=A0R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@syrmia.c=
om">aleksandar.rikalo@syrmia.com</a>&gt;<br>
-- <br>
2.7.0<br>
<br>
</blockquote>

--0000000000005a5cfd05a8c0a460--

