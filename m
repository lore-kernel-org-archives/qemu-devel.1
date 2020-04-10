Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F20EC2D0EC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 18:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0814220673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 18:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pa4Qk8tK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0814220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMyU7-000729-5Z
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 14:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jMyTJ-0006ch-DZ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 14:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jMyTI-00088P-Ff
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 14:33:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:56187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jMyTI-00087t-9Q
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 14:33:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id e26so3305291wmk.5
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ci6JZ12PwqQXXO1BXNweR14vVD5NizacD92STKUo0lU=;
 b=pa4Qk8tKtLFcxgDTwwyt+VEtrx3CYRCm2Gig3mbAXzG3ClnFArWXA7aBvTaRKdUMzp
 VqoKGwL4+XJ7DAQyXSX8yXJZu41Crdmjy+8ZDMbjNyvqrBub6pcF5TjhJWQrez1SncgB
 3hQiNgS8kcNIq3Raax45ya1kg/sA3ZN5WxfiB5zWIDDIi36B3Tpyxku+ho/mlbf3g4iH
 vgpz11jwGB8ddqDJ4tf3zZXirK4aY11iLC/hT288tezXyBC0NOjmk5W03hXiz7htnDll
 tTYBt7+GiiQpcvzDK5ZNsN0bCmVjoXhZITY3OyROHKVjrvhNbmK0lzZ/h415Y3wNqk/A
 /B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ci6JZ12PwqQXXO1BXNweR14vVD5NizacD92STKUo0lU=;
 b=LdlJD49FW9+kjrCx37QbCIwrOEHQOCKRyIufqWQV6EGt2k7uXYgOhrEYLcd0OknWQd
 t7+eGk0/e+Zijnx2fCLlo2NWBPXPUwePTLGWjBDdOlRpfubhWzHduVGAp6cFQc2p1WNb
 Q7pznFMVRHXY+yBNFmbxAAF8O1sT44JnYK4WDGZoUfzF1z0QLTqws99Fjz86lgv8vwsS
 /4Uq+hZlNc9vvC9WHl/fnJUhvAmwh7xgHbBefGcC9jdfykub61/N6ct2854raX5daIYB
 5zvHgcLuBcSd0+5Nz4VnwD0QwuB78b5yXJFR0cxkCCyF9SPgTVDIUOMIUMKfledc+eFU
 VAPw==
X-Gm-Message-State: AGi0PuZbmi6QPZwo1tVxEIIOjZaY98LXFRXVeaEMkqjwb4hvl8jb4REc
 X0SM8VNFTAMjIB3QyNVw0GjklBa3UzEM5RAlgRI=
X-Google-Smtp-Source: APiQypLyJ1HDQghQupJ28FUNBI6pAS+Oe/6v/Qldq2whNln6cB8/00Zu1UorirFNmTwN9ZzFjeUNN4TBM7FNOjvWTQM=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr5994443wmc.129.1586543623113; 
 Fri, 10 Apr 2020 11:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200407155118.20139-1-alex.bennee@linaro.org>
 <20200407155118.20139-9-alex.bennee@linaro.org>
 <CAHiYmc7Eu0XsCe_bkV=tP_S3wyWy4St1RR2AphE7Obko-18mNQ@mail.gmail.com>
 <45a7fe3b-cede-c8e9-fe98-99914bef0e97@linaro.org>
 <CAFEAcA_aE5uA9eaZWU9cr8tZR3x=dmqWBx5FO8QD8K3n+Fsv5w@mail.gmail.com>
In-Reply-To: <CAFEAcA_aE5uA9eaZWU9cr8tZR3x=dmqWBx5FO8QD8K3n+Fsv5w@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 10 Apr 2020 20:33:26 +0200
Message-ID: <CAHiYmc7cQ5jyxWCKZiHQ6PDGO48kReEZ6b75XgQrmHQVETqZqw@mail.gmail.com>
Subject: Re: [PULL 08/13] softfloat: Fix BAD_SHIFT from
 normalizeFloatx80Subnormal
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000013957005a2f3f93b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000013957005a2f3f93b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

18:14 Pet, 10.04.2020. Peter Maydell <peter.maydell@linaro.org> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> But I think some submaintainers don't bother to add r-by tags
> for things they review in the process of assembling their
> tree because they see it as implicit in the process.
>

I think that was precisely the case in this patch.

May I wish you, Peter, the best health, and thanks UK for giving the world
Dr. John Campbell from northern England, whose videos I watch every day
with the closest possible attention, and the highest admiration.

Aleksandar

> thanks
> -- PMM

--00000000000013957005a2f3f93b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">18:14 Pet, 10.04.2020. Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:</p>
<p dir=3D"ltr">&gt; But I think some submaintainers don&#39;t bother to add=
 r-by tags<br>
&gt; for things they review in the process of assembling their<br>
&gt; tree because they see it as implicit in the process.<br>
&gt;</p>
<p dir=3D"ltr">I think that was precisely the case in this patch.</p>
<p dir=3D"ltr">May I wish you, Peter, the best health, and thanks UK for gi=
ving the world Dr. John Campbell from northern England, whose videos I watc=
h every day with the closest possible attention, and the highest admiration=
.</p>
<p dir=3D"ltr">Aleksandar</p>
<p dir=3D"ltr">&gt; thanks<br>
&gt; -- PMM<br>
</p>

--00000000000013957005a2f3f93b--

