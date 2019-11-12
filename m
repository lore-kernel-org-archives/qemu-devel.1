Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DFDC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1737C20679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxQkiUTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1737C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZcw-0001QQ-9k
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUZWn-0003oC-Tj
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUZWm-0003WZ-Q9
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:00:29 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUZWm-0003WF-J9
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:00:28 -0500
Received: by mail-ot1-x343.google.com with SMTP id f10so14936735oto.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=87WbpLLoTtM+S/A9vSB0avC7Toq4vDPjmBoWgSvrakE=;
 b=dxQkiUTlCpXx46MVeUaA5ky8QJ8ycpCpFlSK/PUL8dOjOEppTNl3/p4qQnJ68wVOVd
 mBc4dj0zxY4R9ReYWKdT//tO1uX0zbL7OD2b4Uto5x0wMnLXhW6wRS5h+uPkJz3q9ziW
 Z3dCd7VjzyLeL1WcnqCwnWAqY87GWebzPBQOkkMZ+SPkrBhzzzzVEBiky7q82SlfNAkX
 jTPEAmKIVjmtR/iXSfTpvn6Q2bYA4GVCkHdGhCj8ln5dG7JKIEuBbrIiTlUkEYZFcxGw
 DFnR+rKwFEVY/GC2pN+MemVFUf8KFReJmZq2pMuV48dhLAS1BGziLP2wtEFOu/2rsYwR
 CwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=87WbpLLoTtM+S/A9vSB0avC7Toq4vDPjmBoWgSvrakE=;
 b=s71+2J0SJt64Fz1ouQwxHChAOEC3Khld2mHe24O/rc2pQm4WjARWL7cBWO2a44jaiN
 fIbKjt11bRIEWhdRMZf0E62Re900ahRQ7myygNvXT9s6wR3nlRkfHNB9qGNJoLunnX/H
 hihXjEaXirZb9xTjsEHmW4BSuKLc/B9jYmdBEvyee8w0JdXpy8+QUTiJ8fSB6+3gcZIA
 1NMIiPT4gbRMz+z5V5H7ynR9rDPp52+K0XOF2BbcyjPRxPHp4YlXz/rTA36ibgddVOq7
 2mHxWR9L/pJ0y5aZTVQjFPH/rsRjwxCRxojJe6vmStFr+/a0lK4Tl//CAiOUcXQoJjFn
 718w==
X-Gm-Message-State: APjAAAWlvtuTtI0qrmoGRWmDbWB6eZdDaEZ5inMuyPmiLaZeAvE45geS
 k0l0Xrrl2++84IUerzyec8FxSXZw06Qx0j4av5pODw==
X-Google-Smtp-Source: APXvYqzFC9EJm/6hdrUaFK3MOtRsB99wp+Yr8WK5NyL6omdnrZGcYYPHo+ZqIAwbyF9fne3YzHZ4wVAdDim0ky5/L/8=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr24021242otk.91.1573578027628; 
 Tue, 12 Nov 2019 09:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20191112164051.16404-1-alex.bennee@linaro.org>
 <20191112164051.16404-2-alex.bennee@linaro.org>
In-Reply-To: <20191112164051.16404-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 17:00:16 +0000
Message-ID: <CAFEAcA9tfXe3hp74xjODSfAO2eJryEkVgP8owoCd0LMxTt-F=Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] docs/devel: rename plugins.rst to tcg-plugins.rst
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 at 16:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This makes it a bit clearer what this is about.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  MAINTAINERS                                 | 1 +
>  docs/devel/{plugins.rst =3D> tcg-plugins.rst} | 0
>  2 files changed, 1 insertion(+)
>  rename docs/devel/{plugins.rst =3D> tcg-plugins.rst} (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff8d0d29f4b..b160d817208 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2369,6 +2369,7 @@ F: tcg/
>  TCG Plugins
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  S: Maintained
> +F: docs/devel/tcg-plugins.rst
>  F: plugins/
>  F: tests/plugin
>
> diff --git a/docs/devel/plugins.rst b/docs/devel/tcg-plugins.rst
> similarity index 100%
> rename from docs/devel/plugins.rst
> rename to docs/devel/tcg-plugins.rst
> -

Don't you also need to update the reference
to 'plugins' in docs/devel/index.rst ?

thanks
-- PMM

