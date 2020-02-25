Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96058C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6075221744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ue7ou9G1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6075221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6gu0-0004yx-Hd
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 15:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6gsu-0004Nc-KT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6gss-0004PT-BQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:32:51 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6gss-0004L0-3L
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:32:50 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so619134wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 12:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=54ty86/XXajQXqVquLtgWNqdbYtlxJcUhZ3ui5nduv0=;
 b=ue7ou9G1cGMrPPeWQYu6jFjmNK0du5mdGaV5bsoxVod9f23sMG3MXguDRPMsLxxNC9
 OIbZZhXm4L86iAMQd2BYmpN+GbTMEV+U33rxIOx/5eR54k7cmjKBxNkK/Br7AOxqiN62
 kMsUFRZu1euxqd1wdEcuCl8Nj3epJQAynwu8YnmX8Ae+pHOEDuY+tQrZjxpQtd9DDXJy
 8nov+V5ulIu+DsDXL3MBMbxnJJ7isbIWI0I+CtTsAqUi//L81M4sQO7R2EGjP8WGiPAP
 6UUb1Yg0aa2mrxrZ33UAJCFjICPq+EB6sM3Ms+ueecZw8gBCp8dH6kn03W0LEXTWPurM
 Qqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=54ty86/XXajQXqVquLtgWNqdbYtlxJcUhZ3ui5nduv0=;
 b=CWaHxoNw5N8S19jVCI71O2F/Awca04/i9v+WZaNE7HkiyhLtxpsDZjHf1585DQqeJa
 b8q1ZixRt9SbXrt9OeSwfT+wCII3jiQKwhOggFff7FF23FQVqilMVJrV23yzNE6deWFu
 JGNvPoBwdmHbA4m11DiUnW0mQJlVojobAqmwYbhjXuBRdvk5DbBTx3+A6jO9aEny+DHu
 olYs10bVAVdjrbKJgUPVqh/ipjfpWGE9wPSxe2+mnkSHmRKojkMXKEk7QxW6eKk7bj6C
 xaZASd3glgZ9iyiEzjTrvYod3V94gzjZ0FqaF9F0gzZTkGnyosNdoejWpYDvE93C/PTh
 Gupw==
X-Gm-Message-State: APjAAAUPHfUbgtyXOR2y+flg05XFXGaXgWKF6x58dWS1tnZ5PhzgdXro
 AzBdHtQL2bBgcgp7Ms0Tx4XP2g==
X-Google-Smtp-Source: APXvYqz1NhBjAke6gF8Cfs0IIcSZiP86QqfOxZLaudp8tS/WPlItf9rb61uiJhIq5/HAoOexoNAzJg==
X-Received: by 2002:a05:600c:10d2:: with SMTP id
 l18mr953877wmd.122.1582662768704; 
 Tue, 25 Feb 2020 12:32:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x21sm5237479wmi.30.2020.02.25.12.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 12:32:47 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A2CA01FF87;
 Tue, 25 Feb 2020 20:32:46 +0000 (GMT)
References: <20200225143923.22297-1-peter.maydell@linaro.org>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH RISU] aarch64.risu: Add patterns for v8.3-RCPC and
 v8.4-RCPC insns
In-reply-to: <20200225143923.22297-1-peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 20:32:46 +0000
Message-ID: <87v9nuxv9t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add patterns for the new instructions in the v8.3-RCPC and
> v8.4-RCPC extensions.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is what I used for testing the RCPC QEMU patches I sent out
> the other day. Did I get the @ section syntax here right?

Yep ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>
>  aarch64.risu | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/aarch64.risu b/aarch64.risu
> index c4eda7a..8f08cd0 100644
> --- a/aarch64.risu
> +++ b/aarch64.risu
> @@ -3019,3 +3019,35 @@ SM3TT2B A64_V 1100 1110 010 rm:5 10 imm:2 11 rn:5 =
rd:5
>  XAR A64_V 1100 1110 100 rm:5 imm:6 rn:5 rd:5
>=20=20
>  @
> +
> +# v8.3-RCPC instructions
> +@v8_3_rcpc
> +
> +# LDAPR, LDAPRH, LDAPRB
> +# As usual, the $rn !=3D $rt constraint is risu-imposed, not architectur=
al
> +LDAPR A64 sz:2 111000 101 11111 1100 00 rn:5 rt:5 \
> +!constraints { $rn !=3D 31 && $rn !=3D $rt } \
> +!memory { align(1 << $sz); reg_plus_imm($rn, 0); }
> +
> +@
> +
> +# v8.4-RCPC instructions
> +# As usual, the $rn !=3D $rt constraint is risu-imposed, not architectur=
al
> +@v8_4_rcpc
> +STLUR A64 sz:2 011001 00 0 imm:9 00 rn:5 rt:5 \
> +!constraints { $rn !=3D 31 && $rn !=3D $rt } \
> +!memory { align(1 << $sz); reg_plus_imm($rn, $imm); }
> +
> +LDAPUR A64 sz:2 011001 01 0 imm:9 00 rn:5 rt:5 \
> +!constraints { $rn !=3D 31 && $rn !=3D $rt } \
> +!memory { align(1 << $sz); reg_plus_imm($rn, $imm); }
> +
> +LDAPURS64 A64 sz:2 011001 10 0 imm:9 00 rn:5 rt:5 \
> +!constraints { $rn !=3D 31 && $rn !=3D $rt && $sz !=3D 3 } \
> +!memory { align(1 << $sz); reg_plus_imm($rn, $imm); }
> +
> +LDAPURS32 A64 sz:2 011001 11 0 imm:9 00 rn:5 rt:5 \
> +!constraints { $rn !=3D 31 && $rn !=3D $rt && $sz < 2 } \
> +!memory { align(1 << $sz); reg_plus_imm($rn, $imm); }
> +
> +@


--=20
Alex Benn=C3=A9e

