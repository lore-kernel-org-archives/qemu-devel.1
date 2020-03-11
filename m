Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B4EC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435CB20873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtvVESd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435CB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuZ5-0002ln-H2
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuXm-0001Y9-KJ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuXl-0004YI-It
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:08:38 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45287)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBuXl-0004XM-C7
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:08:37 -0400
Received: by mail-pl1-x643.google.com with SMTP id b22so561252pls.12
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=p1lIF2kImK0p1JTHV0AhyUMpa3evnQy4rG4CBXktNko=;
 b=CtvVESd3tw0NijHFXXjcu97T7cCnkrVFAWXhSwC7BfkyT06ojgnnPE8hHYLqgVkoeG
 iE303sgMtTeR3PyIIlK5FntOlAoHGbCaDixKdath1U303sGn694+z6c4wVmt68heB47f
 /s8XHlyZPYCDjrYVOCKd+vTCi3ewkE/P8UxoqWLVwyGMJLLI7KNH5X7Vf2Q8XwpUKHBQ
 UIiKZV3MZLuZ9sX35IQMe3YV+Ai12PHNFsnaEKZ7wEWHcCOwxaw6sxF7ZZWOY4+Ts/EJ
 erF1M4uXjCVexrJh/TTUauDGMd84ioKfu19Wo0sO9n3h25n8VwU5uO8lG8TGLo696RMG
 3NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p1lIF2kImK0p1JTHV0AhyUMpa3evnQy4rG4CBXktNko=;
 b=b60peszlXQDmjfS6rG2dVmHZV3omqv1Ct5O77D5v9EH2lfsbqHdQzTibJzUJbXF65d
 cEou3ifgj1+TmbKs8mgh/mC4XjpnvAfWTEA/Pi2qCf72A/mgXf0T108IRPRv7c/xozCh
 gpCQAFm+HKoTLKSa3YmS0ojyZ963wSSSrOdEkxjNxeSHIjQcxKYrqFaeHa9Kd2LfH6QI
 HbmpWwwV/TMe6f9iLL11VqA48g5aH79hF/ChdYNb5N5Ew8pFn1VW7A+FtMMpydhDR2Mc
 cloSRYhQu3rmG14KqLvWlzkNMuOkfCXW4LS5xoFnQGRCMEncPNb6EmoVcgcbgqU6EFkM
 1jvA==
X-Gm-Message-State: ANhLgQ2ShRtbODBlLeHgnRDeI0uXOpilGqPAenD1nbAGFIqHieUsnnBm
 7zLrYwyj3pT1kXwnMYfqoAYd9w==
X-Google-Smtp-Source: ADFU+vvdkN9hLv/ScXqKtCdkXxiwbt+h0RK/sMMZ8oKN7uhBF05KCSkeP/z+x6eaB1ny2jiyoFGxqA==
X-Received: by 2002:a17:902:7886:: with SMTP id
 q6mr1597614pll.237.1583906916303; 
 Tue, 10 Mar 2020 23:08:36 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y7sm9582675pfq.159.2020.03.10.23.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:08:35 -0700 (PDT)
Subject: Re: [PATCH v4 06/18] scripts/qapi/parser.py: improve doc comment
 indent handling
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <58c7c296-083b-1152-878a-e27199714a33@linaro.org>
Date: Tue, 10 Mar 2020 23:08:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
> Make the handling of indentation in doc comments more sophisticated,
> so that when we see a section like:
> 
> Notes: some text
>        some more text
>           indented line 3
> 
> we save it for the doc-comment processing code as:
> 
> some text
> some more text
>    indented line 3
> 
> and when we see a section with the heading on its own line:
> 
> Notes:
> 
> some text
> some more text
>    indented text
> 
> we also accept that and save it in the same form.
> 
> The exception is that we always retain indentation as-is for Examples
> sections, because these are literal text.
> 
> If we detect that the comment document text is not indented as much
> as we expect it to be, we throw a parse error.  (We don't complain
> about over-indented sections, because for rST this can be legitimate
> markup.)
> 
> The golden reference for the doc comment text is updated to remove
> the two 'wrong' indents; these now form a test case that we correctly
> stripped leading whitespace from an indented multi-line argument
> definition.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: Update doc-good.out as per final para.
> ---
>  scripts/qapi/parser.py         | 81 +++++++++++++++++++++++++++-------
>  tests/qapi-schema/doc-good.out |  4 +-
>  2 files changed, 67 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

