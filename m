Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A22AC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B4222BE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcoH2dqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B4222BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1u4-00053G-9J
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48887)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr1tr-0004XX-64
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr1tq-0003ZO-5i
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:12:51 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr1tp-0003Wb-TS
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:12:50 -0400
Received: by mail-pl1-x641.google.com with SMTP id az7so24862422plb.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BmLIE9Ovo08lpzAVrvhfHtSERwe6Cb9atoTkj7O6iXo=;
 b=HcoH2dqY8N5RRk0PFLM+si06AXGx/3Pan1na1dlx3H/ceo1mxLCV1lw+UXgyFS9bFO
 gxDpBqJkekyPVBtrOvBqxm963TtY4WewdQvHg8mcib+u6+Wwf4TPt6Ei/vFaZXh88BGY
 u6QUYeMB6v5neTJlb7lISg/gBPErs0nUz8iBobb2d0pasUa/d3GHxEptfVLQQTq+Bwcp
 J0ZXjxhPj9jpHY5lDY0Z3IeTCtIyH/QCX+0c3xHJWLElTOFxws/tBXKxMopd7B+9QZMD
 9rHkvBu3SuRKvB9YtsOOYL4THRt4ZZjlHfSBmiliD4uYfED3tCzW16AfE5tITXeA77XP
 G+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BmLIE9Ovo08lpzAVrvhfHtSERwe6Cb9atoTkj7O6iXo=;
 b=BK7fDtUL4i15AIe1M/PfuZFYV+X+BgcpdN1vEDzvj5gD2WfmfBhIZzM5uVZRdTC7Hn
 3HSVQz8HORDe3CWGmIhKNFsUUaHd+5QCqXlIE9GUIKrA6g6NZvSAim2vPsi0SgRj+ZXs
 YKdxJAERmjqm0ObBtzgtBBgQXL8hvF0w6bPK23qNIiv6xPTM0+g3ghvbjSRAo2blFVEX
 FQE+tEaPVXEn+9JnON+9Pm3mMQv4FcyJNAqKznJSRWcCr80zNoPHJknEPasFw0iNNga1
 vbTrDinFEFnlh0eICNd3uFnNOnDJjVWKa+MILnIzkxWUXkd10Eabijhkb9fW8qUi0Sam
 Bamg==
X-Gm-Message-State: APjAAAVPYrpDpo6LCvHpQoZhYNfDJOL+fLQdgR8T7LPdB8BaXSSfj+AH
 pjiWgcZUpgkE+oYkAF1+C9jt8g==
X-Google-Smtp-Source: APXvYqzQJ6qy5UicRl7mfdx2dsb4J4HZqXwIluewRa7QZ3LJPmub1s7nQyYjY5tFo8Y7FJ/ITwSImQ==
X-Received: by 2002:a17:902:20e9:: with SMTP id
 v38mr98001660plg.62.1564153968462; 
 Fri, 26 Jul 2019 08:12:48 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id r1sm59807643pfq.100.2019.07.26.08.12.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 08:12:47 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190726113950.7499-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9dc175a9-3617-3bb3-a03a-3def2ebda02c@linaro.org>
Date: Fri, 26 Jul 2019 08:12:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726113950.7499-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v5] target/arm: generate a custom MIDR for
 -cpu max
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 4:39 AM, Alex Bennée wrote:
> While most features are now detected by probing the ID_* registers
> kernels can (and do) use MIDR_EL1 for working out of they have to
> apply errata. This can trip up warnings in the kernel as it tries to
> work out if it should apply workarounds to features that don't
> actually exist in the reported CPU type.
> 
> Avoid this problem by synthesising our own MIDR value.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> ---
> v2
>   - don't leak QEMU version into ID reg
> v3
>   - move comment into one block
>   - explicit setting of more fields
> v4
>   - minor reword of comment
> v5
>   - VARIANT->PARTNUM and extra words
> ---
>  target/arm/cpu.h   |  6 ++++++
>  target/arm/cpu64.c | 19 +++++++++++++++++++
>  2 files changed, 25 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

