Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218EAC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EA0208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ix2fD45g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EA0208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionPH-0008Kr-Nj
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iomlP-00037p-NQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iomlO-0007LN-Hm
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:11:07 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iomlO-0007Kb-AY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:11:06 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so18927907wma.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JBtnW38xXFl77T1JUBLmdP4GEJWaN4c6Sz81fJCaRAg=;
 b=ix2fD45gp1sywu3oqGtyac8TpZzkxyPt55BeriKPyPvpWdcRbQnrfmw0So5r64sTAv
 SETnG32lqHzJdOcxxG3pr6bwHhsMaZGcAmzfpXTOfkPUCEpn3WsqOhtx5KiYEYu8SneN
 GsbQlorgGlrvKhl+SOkTVx/s8tZbk5OQ3mcRJWwG8Q86+tMBrIg2DgQAH25LFe+INcFB
 nFP9UnD1ZEs1gr3Ik+94oe4OJZOM1HoQuk4skWL4PBqlXFsJmogarlNGpny6WhdPF0pT
 ycsZ0Nli0c5heSaU4zk8Vhw/PXlddQdJE8pgZvqScRduTtNbSWP2DpaOKH8E96Ui5d8N
 fOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JBtnW38xXFl77T1JUBLmdP4GEJWaN4c6Sz81fJCaRAg=;
 b=IAw84VXqMBDSjkA+Z3UhNDjnnfLiOtk05dUFk16i3j3vAZKIj/ap3MyVoqBsG5dB4D
 qA4mfg0a21EhzPpmXx9m17YctnCZBE7qwGMbBJHkEbRuLiRZFq/P3NTe2efzcezUKlhw
 h9cqozWodDBjGlj1ZQk3jsG8mxgsgHzfjt5bkwUwerH/8GOSbzqEnJywGEJXJB6+6dpL
 GhIHLBJMJEOIAmm2aJNWJOXBXiSWF8eLqKGpQhuYzAsKvO2SfMFU2rV0bIjsC3XPGu5n
 l69Oq6HQ3UF2B/sW++GCfi8hDhyEsCbf1mgDziLrLly9hA/deIPW1noHwwuO0psrUpFY
 wNzA==
X-Gm-Message-State: APjAAAW4qAtFxQHBoMaqY4kDX8QWPWatLE0SdnJaikczZNjd3W/NNwfl
 c/dH+Ipuj1rtHYyV7qlegPoo8A==
X-Google-Smtp-Source: APXvYqwdsR+TiOMcqBfMrO7I5RF3rziP9Ju7x7D0c5D+prJHTHK1dY/rKw/W/0zGB2VklW8NPVWslg==
X-Received: by 2002:a1c:1b41:: with SMTP id b62mr38861376wmb.53.1578395465400; 
 Tue, 07 Jan 2020 03:11:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r62sm27568657wma.32.2020.01.07.03.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 03:11:04 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B1EE1FF87;
 Tue,  7 Jan 2020 11:11:03 +0000 (GMT)
References: <20200106123746.18201-1-kraxel@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] freebsd: use python37
In-reply-to: <20200106123746.18201-1-kraxel@redhat.com>
Date: Tue, 07 Jan 2020 11:11:03 +0000
Message-ID: <878smj5xo8.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> FreeBSD seems to use python37 by default now, which breaks the build
> script.  Add python to the package list, to explicitly pick the version,
> and also adapt the configure command line.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Queued to testing/next, thanks.

> ---
>  tests/vm/freebsd | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 1825cc58218b..33a736298a9a 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -32,6 +32,7 @@ class FreeBSDVM(basevm.BaseVM):
>          "git",
>          "pkgconf",
>          "bzip2",
> +        "python37",
>=20=20
>          # gnu tools
>          "bash",
> @@ -63,7 +64,7 @@ class FreeBSDVM(basevm.BaseVM):
>          mkdir src build; cd src;
>          tar -xf /dev/vtbd1;
>          cd ../build
> -        ../src/configure --python=3Dpython3.6 {configure_opts};
> +        ../src/configure --python=3Dpython3.7 {configure_opts};
>          gmake --output-sync -j{jobs} {target} {verbose};
>      """


--=20
Alex Benn=C3=A9e

