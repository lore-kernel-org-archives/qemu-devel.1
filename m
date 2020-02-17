Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49437C34026
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CE320637
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSYO6TfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CE320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m7Q-0003Y4-5c
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m6G-0001oM-6m
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m6F-0003nH-6w
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:30:36 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m6E-0003mx-Uc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:30:35 -0500
Received: by mail-pf1-x443.google.com with SMTP id s1so9413045pfh.10
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7GVwEPrGRBOVA6ZFOuDDyIrgiUMedS/JXLa5oU/r9e0=;
 b=aSYO6TfLVD5F95Kd4+SqKGgI+WCmQ1LzNtP8ueTwVPsPdW/6Ozbw5H0K17dCrwye2+
 OVCOm2Ip8sZNXLT2Kj56CJ3awcJzryXyIBQj2tYXEZX2C8HklKU626E8rF6dA+5Z9g8N
 P9QezQkQKT9PSgIZqINGn27+Rc4qy6ea0NvqIr18TUkgfvOmdxFiqiYIiZWuYMEwfAQW
 JlJwrg6EXkeQc73hTj+K0d7mwDKjn6m6um2iPMjVlMXZntiCQq8alIzRDdQrQHFPnUhJ
 ZOPBlywbDO858Wo6671P40sQ8D2y1XQDQ5U4FGAvf2DgHUSJWigb9my1kL/g9D9Fl2ih
 jb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7GVwEPrGRBOVA6ZFOuDDyIrgiUMedS/JXLa5oU/r9e0=;
 b=KLtNnjkVFCozyQUQkE2lkabIDWKr+DBwzvSOVXyX2JFuyswZvVRZxJ1UkUGlIzwyrf
 wnEHymOcc8sZDuWKjtFDpodj1OtQqAnCq7vZTxylKibjB0fscICZSc/Y1IDdHAovk5bT
 uLVg+96aggCkg5wr4oEIPqhV3Id56Wxfi7dJpGu1AkuNaoOKLHLzVjU77wA7V1Shf/Rs
 YLAvDpJlBEEKC+HHmZkbdHKQCSNBuqbfm0CazBtCsppp9EkGuHp3HqtagP5t8JFMQ/wk
 Y9soHqjab7PpPI4fuEQyJP33BDrnY2kpJbslGfMpVtNuMcYEiKrBF2+RfjY+9h24hM4a
 qtKg==
X-Gm-Message-State: APjAAAWAle7dM6wLCJcu1sisMbCGoHkqa6kbz4YB5Q2mxN9yN35FpzOf
 0eisBm7rS3+KTDkfT0pftBx4ug==
X-Google-Smtp-Source: APXvYqwBhrAMkEscqtHVYxP+5Z4Xg67VMLKVhYly+OnX4KSHZe7b+9/B/GmlBYyz62g9gSA4kjcIeA==
X-Received: by 2002:a63:7013:: with SMTP id l19mr18779373pgc.58.1581967833959; 
 Mon, 17 Feb 2020 11:30:33 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f81sm1147193pfa.118.2020.02.17.11.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:30:33 -0800 (PST)
Subject: Re: [PATCH v5 47/79] m68k/q800: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-48-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5bfefa9a-5c07-6c3f-5767-3c2ea68d1e38@linaro.org>
Date: Mon, 17 Feb 2020 11:30:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-48-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> Switch to using generic main RAM allocation. To do this set
> MachineClass::default_ram_id to m68k_mac.ram and use
> MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Laurent Vivier <laurent@vivier.eu>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


