Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3196C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42A02146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffPmCUnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42A02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBulU-0007sj-TH
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBukv-0007Sx-PR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuku-00038r-Lc
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:22:13 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBuku-00034I-EJ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:22:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id j20so593160pll.6
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=glAuGEOeKhL7BOY3e+gTLKbI3m6nxvr6f8jqThJd+Wo=;
 b=ffPmCUnKDbVFi4DAwQW7374X/OBmQ2mWPwrMfsxaD/VRZzsaSujtgysjJ+2mGo/CuB
 ZrSCOrz5Z6m52D7acgInEOOmfppBUJOhZU3RIVnMkWXpw25qoWSkRFvYptIdsBUZlyac
 SLo/HC7AEaglb8kSsw84d34BFHlWsnkXelu6VYfToQzlmdU1DYoL0bABT7AVMPgp3QAD
 7nelTwy5jfL/2bws2+bjZm6LIxXT0jtOKw8NknBys4nyKdpgVT7LgUVxVgyqrb9zLyhb
 JIccxI1W4QbBptlGt7YPWnYyQ96f2PQcG9jTVhSP9cN6Q7gZYjm1ulwO1xfYl9zsJt8i
 o0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=glAuGEOeKhL7BOY3e+gTLKbI3m6nxvr6f8jqThJd+Wo=;
 b=p3+zy1hiYjQ7CoaJHWGfPPMtsVR61yudoS4ZEHHQHuH76I8j6VQSKrGUToffQMOTT7
 DmfMFtRZ6f9GlyV6QBNKS3kCK1vETEV8y+gWswgUpkcJH+ogiIFVByzXdrvWqJXap76B
 Joqa7AOgj8MV5/xvADYk79H1IrLbmVawoOubXo2q504CwocFhdBW4ivgdlaHUlQJjWpT
 H8R5KQHtOZhYQWtPBxtCQcdTdtvp6W9TS6XKDCNkaz4F0MLwPTKmlQRSMAUO7W4hHiO7
 7g9iG2BTOJ8/Ib9uzcKPJG32neHS4cToSM0RXfpvQ2uUUoLyAcQTn1MD2eZvyZ4R6APh
 4vjQ==
X-Gm-Message-State: ANhLgQ0KfHyAU/v2H5fgkqubRq/JXQehEk/I3I4Q+5QoRbK6iwI4T3Cl
 uQeo0SfxNdZAhJSfsmDbhklCng==
X-Google-Smtp-Source: ADFU+vvG53nQr6RT82QsIR2MAcOBZC74Ltbs50JOjxlNsE6oGHDLaZNrEB4GKyFYTvjF1/f2CVpqUQ==
X-Received: by 2002:a17:902:208:: with SMTP id 8mr1696551plc.198.1583907731025; 
 Tue, 10 Mar 2020 23:22:11 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d1sm42082319pfc.3.2020.03.10.23.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:22:10 -0700 (PDT)
Subject: Re: [PATCH v4 10/18] qapi: Use rST markup for literal blocks
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <407bf09a-5925-737c-8194-8c4e9fca727e@linaro.org>
Date: Tue, 10 Mar 2020 23:22:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:43 AM, Peter Maydell wrote:
> There are exactly two places in our json doc comments where we
> use the markup accepted by the texi doc generator where a '|' in
> the first line of a doc comment means the line should be emitted
> as a literal block (fixed-width font, whitespace preserved).
> 
> Since we use this syntax so rarely, instead of making the rST
> generator support it, instead just convert the two uses to
> rST-format literal blocks, which are indented and introduced
> with '::'.
> 
> (The rST generator doesn't complain about the old style syntax,
> it just emits it with the '|' and with the whitespace not
> preserved, which looks odd, but means we can safely leave this
> change until after we've stopped generating texinfo.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/block-core.json  | 16 +++++++++-------
>  qapi/qapi-schema.json |  6 ++++--
>  2 files changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

