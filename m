Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F6C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EAA20753
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKK1DCgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EAA20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMuqY-0000sn-Vt
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 10:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jMupn-0008Li-36
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jMupl-0002D0-TR
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:40:42 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jMupl-0002Ck-NE
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:40:41 -0400
Received: by mail-pj1-x1044.google.com with SMTP id np9so848512pjb.4
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qSs6aVXgfVxsbetnxnVlFP1D/yjO9Cukdr5zl7Y/0/M=;
 b=TKK1DCgu1lG0NjoHaf/L0zC2eoZ/yeqPPA/8kDzS0+jCtdx8dwsjirEbLX38UAhufO
 4xSEK8omC7Z+Q2QAbi8U/F0ZEKvYyrmrhRDz5VS1OLrdxjB0f084Josj1oiwUa41U3HJ
 PL6VCjgwFTppPq4q0DEpfIqRSNSeq3k41B6BtKvWbWYrWqf3zUSS5tXhZI0AO3WH9KmI
 nMVN/DvvfFJ4jBXXamFfVq3OTXPaGwLb6IkPdXAYZd1IVv4xtwkyRBWkm4IAz42P+4CI
 Bdyy11FnqCjucbpdKk7ASLCbFeD09KYnsMpnhVs92O+pzbEcWgFHRZivF/RlOXUvfo+s
 Z2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qSs6aVXgfVxsbetnxnVlFP1D/yjO9Cukdr5zl7Y/0/M=;
 b=WHUBBNyHi3AsZ8Bw8VuT5LoltT2JCFIBLa/QeI/FAPGM96vFdI2gOKDTGJuphpMOkb
 q3g9dSTC0NYN0FivtUQFANvN6Vwl7J9BvG+WPwZdSWf2ZcqeXpZcf/CYso7vygzzY98i
 2P27i0bOAd2aGJxZSfy7kIoTrWRcmkJ1xBHPN7ylkDXgeYPLGnXx/vuJwJO+JhSpgNd7
 TmEWMlium2r5RC5S/IPOFUaRGC1YPbImWlZL5utNzfbsK8c0h0bsLLivyJrZE/pukjKY
 hJkVIx2Vi9LZeGzpIfKxNTx4H5GNvRlMglFnJDadQDPSG/szuS1+zsqay+00Mwu5CW+Y
 pPzA==
X-Gm-Message-State: AGi0PuYlheYjtR096b+cqk+/m6RveOAjCKeHo01OIaDhC0kTQs/Syg/l
 +zI73I9qwQWn/MfkDMmWo6uKpg==
X-Google-Smtp-Source: APiQypL4rhBcZmJRrxkrL5sEzojjkOMGwB2tOq1Y5/JLM9ZzFMW9ytHo9LOKt4Ip+tgZymRdzQNelQ==
X-Received: by 2002:a17:90a:3767:: with SMTP id
 u94mr6035201pjb.23.1586529640237; 
 Fri, 10 Apr 2020 07:40:40 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h16sm1923047pfk.38.2020.04.10.07.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 07:40:39 -0700 (PDT)
Subject: Re: [PATCH v1 05/11] tests/docker: add docs FEATURE flag and use for
 test-misc
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de495415-ff68-1fc4-340c-c861ed6b27d0@linaro.org>
Date: Fri, 10 Apr 2020 07:40:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 2:15 PM, Alex Bennée wrote:
> The test-misc docker test fails on a number of images which don't have
> the prerequisites to build the docs. Use the FEATURES flag so we can
> skip those tests.
> 
> As the sphinx test fails to detect whatever feature we need to get
> hxtool to work we drop them from debian9 so the windows build doesn't
> attempt to build the docs.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian10.docker   | 2 ++
>  tests/docker/dockerfiles/debian9.docker    | 2 --
>  tests/docker/dockerfiles/fedora.docker     | 2 +-
>  tests/docker/dockerfiles/travis.docker     | 2 +-
>  tests/docker/dockerfiles/ubuntu.docker     | 2 +-
>  tests/docker/dockerfiles/ubuntu1804.docker | 2 +-
>  tests/docker/test-misc                     | 2 ++
>  7 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


