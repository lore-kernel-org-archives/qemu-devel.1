Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6520C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807FE21743
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtKl4N0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807FE21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvmGa-0002ck-PT
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 13:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34786)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvmFo-0002Ce-3i
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvmFn-0006Py-66
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:31:08 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvmFn-0006PN-0o
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:31:07 -0400
Received: by mail-pl1-x644.google.com with SMTP id y8so1704497plr.12
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tVKbRGuIm21zFPhY/ggcKxcxU9bVhWAuCLXVfXVkKzg=;
 b=PtKl4N0FdMVjv6HLGNjGuwniqPWWxL/+llc7y/tP7OB5Zxi4gjnjIhVhGAhBVSRXb+
 Yovw6V9bLGLREDFzAThtOt6EHSu/XL7szI+SRcqnuindQu2nMoVaB0aDPvXWEqqQwQnX
 XysMjQgQbPQQE5s6lhOoexCh4cPreDkvQy4C3Lu6cXQa7hSbg83ikyR0KFBs1VX/ZDez
 VTvtOuiUlnaW6Tyc4QtK6p2C/fv7J83i7vIAQ+HeefCe3E8AOhXrSjcmiKwXtybQsNK1
 6BlWtHMz2nwRvHtTRYXApCimgTcTfaNJ+JVTMQsYrnKh4IQj71m2m+9OVC9lwKMsy0MV
 UoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tVKbRGuIm21zFPhY/ggcKxcxU9bVhWAuCLXVfXVkKzg=;
 b=hBrX9ZLnNQin+Iq2KTxS7Zr5URgq67P7abUZF9j4ddkr1f55EgL+zaya5i+wL4OrXQ
 dNcs1SbcGMSdOZ6N6qJfROFWbkU34S2HMC1Y6KqWFuV8oVjthHf73dmfjxXTKq0chFtY
 j93lj7lI7uhIUo6J6xWdXQnv7g98iQVzWxgH0AkeIXaAJ1plTCCtSgYVnZTaI1rHBg4y
 yCVUJaMY/8nkj0Ue+F+mzxcpZ9avHmURtg3h5cY9bo1WH4LNve4G6CPtAYrQ8mkniQP0
 f94rfv8NJAiTkXQIB00TE6lTz/YLmqjMY/cJKv7ytjD5MvVfhgQK+XCXcrXKAwR1DlJQ
 qkAg==
X-Gm-Message-State: APjAAAVwKDAn1aFOPRb4o6sQpg9A0Qipy3VtBcNl/a77Oa0UuHKnYfC5
 SDr7uuI/Zl2zm13yhWxUvaGbmw==
X-Google-Smtp-Source: APXvYqxbVjwwVGhJVc1W//TTkzb+JOppp9ANwlLEg8HyjfP1i/dH+euJGV2QUjh2D+s1OckUcdi7ow==
X-Received: by 2002:a17:902:36e:: with SMTP id
 101mr4500345pld.51.1565285466078; 
 Thu, 08 Aug 2019 10:31:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 195sm147843513pfu.75.2019.08.08.10.31.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 10:31:05 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190808164117.23348-1-alex.bennee@linaro.org>
 <20190808164117.23348-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <25d1668b-1256-2ba6-0fce-d8675e21f43f@linaro.org>
Date: Thu, 8 Aug 2019 10:31:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808164117.23348-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v1 2/7] fpu: move inline helpers into a
 separate header
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 9:41 AM, Alex Bennée wrote:
> +static inline void set_float_detect_tininess(int val, float_status *status)
> +{
> +    status->float_detect_tininess = val;
> +}
> +static inline void set_float_rounding_mode(int val, float_status *status)
> +{
> +    status->float_rounding_mode = val;
> +}
> +static inline void set_float_exception_flags(int val, float_status *status)
> +{
> +    status->float_exception_flags = val;
> +}

Can you please fix the spacing at the same time?  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

