Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFC1C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B8F24125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yg/2iR5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B8F24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu1UU-0003eL-S8
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 16:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu1TO-0002cD-3c
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu1TM-0005xS-Sd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:54:09 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu1TM-0005x4-L1
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:54:08 -0500
Received: by mail-pj1-x1042.google.com with SMTP id bg7so2270996pjb.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 13:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=26BZ4BJcqwIB8Do1wC8utEo1iAhIC58jhKfVcZPLEVA=;
 b=yg/2iR5HrcNKfKYT029sEmf4T8QS0YM/e4GkYwstsMcO/CSbQdZgSTH1c/uOeFhPM1
 +NIVSxw9XV+NqC8e+fbJ2PPevYkFoUuxB0tVqSKiggLVJf7Bz0vj72/qWB0L/N3nNdWs
 xqFyZEE1WWfTP1eTLA+RfbuenmrNZTFvq1zKQd718jqAb4Q75sKmBYATIcwmw0fW7oVw
 l9Ebn0w+B2OZdqyL6OgQprTlpeaalxCVLy4Pi3tjysCo/yaF70nXAeqy4tDPxtepPcSe
 rsMg2/JZSuMEvJyakTmVLWQOODYHtBjPeqU1cwVe5zoVb71o8IB+g4AYYDamh5ExiK/P
 ax9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=26BZ4BJcqwIB8Do1wC8utEo1iAhIC58jhKfVcZPLEVA=;
 b=lXA2cpjiW8dTbA58vSxCBCSrugCmp0YF3YuqNZuDOMjBL94d2au86bnYFKOvxYjCzg
 /nbMmpY32eROLsfRsWiOrlUUZWA6Gmhh15quPJFr4SgEyng+vs5Sb1au6j/BmgK0xkD+
 n0sVIlqYBl28CY7L+I2508Jyv14F96q8UDRhw/5jo7rPWGKLYfTZWlaQj9x/bPM5+Mh6
 a02m+SdmDwLs5er1xBjoLuJdsPKfSUHIvLT+LIm4gBm4eCtIM4D5YKAAfxoDoagM2IPu
 l6vtbsxEzJI+sL2a2CmR7JO6MD68HDjzhCamD31XaXWKRaaIQILJsWFzOXdbvxKJJiNk
 5uTg==
X-Gm-Message-State: APjAAAVAHAw75M+/jIkoMRO51Kom4vx8sJpZ6gWUbJlSihKa/9FelXlZ
 AFxfo0TAVHpsXZsDsVgZi5KfLQ==
X-Google-Smtp-Source: APXvYqwjs8JF1KSlMzxhDzksgsQ2iC6K5k/lO2DKoSHkAuGQFiQS8Amro122/ZKsG9wMDV+sVvAVtw==
X-Received: by 2002:a17:902:b611:: with SMTP id
 b17mr7441962pls.23.1579643647425; 
 Tue, 21 Jan 2020 13:54:07 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id y7sm45448859pfb.139.2020.01.21.13.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 13:54:06 -0800 (PST)
Subject: Re: [PATCH 2/5] docs/sphinx: Add new hxtool Sphinx extension
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200121191033.28195-1-peter.maydell@linaro.org>
 <20200121191033.28195-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5fa9a519-d9c8-13b6-2d38-efa12c29780d@linaro.org>
Date: Tue, 21 Jan 2020 11:53:58 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121191033.28195-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 9:10 AM, Peter Maydell wrote:
> Some of our documentation includes sections which are created
> by assembling fragments of texinfo from a .hx source file into
> a .texi file, which is then included from qemu-doc.texi or
> qemu-img.texi.
> 
> For Sphinx, rather than creating a file to include, the most natural
> way to handle this is to have a small custom Sphinx extension which
> reads the .hx file and process it.  So instead of:
>  * makefile produces foo.texi from foo.hx
>  * qemu-doc.texi says '@include foo.texi'
> we have:
>  * qemu-doc.rst says 'hxtool-doc:: foo.hx'
>  * the Sphinx extension for hxtool has code that runs to handle that
>    Sphinx directive which reads the .hx file and emits the appropriate
>    documentation contents
> 
> This is pretty much the same way the kerneldoc extension works right
> now. It also has the advantage that it should work for third-party
> services like readthedocs that expect to build the docs directly with
> sphinx rather than by invoking our makefiles.
> 
> In this commit we implement the hxtool extension.
> 
> Note that syntax errors in the rST fragments will be correctly
> reported to the user with the filename and line number within the
> hx file.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

This doesn't seem to work for me.

make[1]: Leaving directory '/home/rth/qemu/qemu/slirp'
CONFDIR="/home/rth/qemu/run/etc/qemu" sphinx-build  -W -b html -D
version=4.2.50 -D release="4.2.50 (rth)" -d .doctrees/devel-html
/home/rth/qemu/qemu/docs/devel docs/devel
Running Sphinx v1.8.5

Extension error:
Could not import extension hxtool (exception: cannot import name ExtensionError)
make: *** [Makefile:1022: docs/devel/index.html] Error 2

> @@ -221,3 +221,4 @@ texinfo_documents = [
>  # find everything.
>  kerneldoc_bin = os.path.join(qemu_docdir, '../scripts/kernel-doc')
>  kerneldoc_srctree = os.path.join(qemu_docdir, '..')
> +hxtool_srctree = os.path.join(qemu_docdir, '..')

I wondered if there was something more needed here?

> diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py

The actual code looks fine.


r~

