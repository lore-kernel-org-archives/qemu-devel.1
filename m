Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2576FC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEFC2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPvPYeFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEFC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3op-0008E4-LD
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK31e-0003Vv-9I
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK31c-0005zB-9C
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:16:50 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK31c-0005yc-1b
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:16:48 -0400
Received: by mail-pf1-x442.google.com with SMTP id y72so10647031pfb.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Bgy4XE/eZ6UU38NhtgYxs1nh1iQwZ1ytqpBpjWUapu8=;
 b=HPvPYeFR1eUM0lVILctrBC2oPDSm6uX4xhZBkkNPRWd23rtL0XEi7artAEiRYcCh1F
 53ZCcho5yOADLwsRpDCzry/Wr+5PSUikT3CujR4BE5XWVSLQgoas28cLBnOAcQxjkmUP
 cScV9Y/ki9cD1TeKJEX1IGUh1y9wdv18INiM6KCHZTK27RHP1EiXsFaDT2AKXCG1MlNy
 AINnz7tcrfY7zVkkX6Z6GvpdSR+ZjQGuo1rF8Ab8FTxPd90LDqrVn8O/IQ+YhCvAOrwT
 WAF/GfotgsneJqG8sdMAA0u6/T13TM64M/LyQwLZBZoLYdkywrXTra7OiHT+kPzhSueV
 0zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bgy4XE/eZ6UU38NhtgYxs1nh1iQwZ1ytqpBpjWUapu8=;
 b=hoxnfJ+om9xbWmwN3LQZG81qDP74Cj70s7WC1AHzoeDAYwMcL9yiN5sjAmntGRgiAG
 ZLEJvRgMSNqTQXrfjIV/1ir62mEr4JG5ju+pMGAf1esT2INmnQ386AwmAOy6wTCtgIvn
 BLNje5tPvIMnCpC0fLSJ4wJLChkQYBPIXvRKmqrOfo318emOpw60Djenk0QlrI3ocAly
 wRg8tmLBcnnr3HMiIfgkehUL+kMuHnF5fVWkjkfWCL6/Dh9p/EIlriBifY0jsS4zafLD
 Ld3o/oU7H3yF7mdeDNgGkfphTgtMrW/TW17VZcs0a+ZmPTkqfPADlfwPQ4wC99SnWNZV
 Uecg==
X-Gm-Message-State: APjAAAVWw7Q5AX43loPZIM7FmfUqBGcPq9PtvrpGS70725yZ+UyZ8Bne
 5mlSli0+EpipF0r8yft1UhdNtQ==
X-Google-Smtp-Source: APXvYqy1FQtSb1UVjb59xyyC+RVB6FzUpvVixZCNwImjVXhCYUfpHAtJhrkHU3U8k/DuYPM52RcMzg==
X-Received: by 2002:aa7:9e8d:: with SMTP id p13mr32603059pfq.171.1571069807080; 
 Mon, 14 Oct 2019 09:16:47 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y4sm16238962pfr.118.2019.10.14.09.16.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 09:16:46 -0700 (PDT)
Subject: Re: [PATCH v5 42/55] tests/tcg: move "virtual" tests to EXTRA_TESTS
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-43-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c7e62a0d-1515-bc35-c716-812654da6892@linaro.org>
Date: Mon, 14 Oct 2019 09:16:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-43-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, robert.foley@futurewei.com,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> Otherwise clever expanders like the plugins test get unstuck.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/Makefile.target                 | 4 +++-
>  tests/tcg/aarch64/Makefile.softmmu-target | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


