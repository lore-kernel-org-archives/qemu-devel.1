Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A83C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1C12080C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bb1iVOUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1C12080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htCbh-0007j7-ME
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32935)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htCa5-0006R3-CR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htCa4-0006Eo-Aw
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:01:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htCa4-0006ET-4A
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:01:24 -0400
Received: by mail-pl1-x644.google.com with SMTP id t14so32318888plr.11
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4PD3dMdu5TYb+5hSet5uBV3XoQ0A6kdX7rIHlx5c1OE=;
 b=bb1iVOUFg3y255s8a63INQLUQ68Pz8HWF/8BQqh2t7mfTfgx6CM5Efsnn1c54sjse6
 0pgUBU5rsQ9e9olkyZ9nuXwL/ozqGrxD2QPCEEsw4qNfq4TL/m/kppTvDMwTeTKEF1dH
 RBzxNg3CP/WsOS09xZ4JsMGBXXelC9uE5oWPadjCNaEJLgrjfzcP2aTtMSZi6HWL8IwS
 o5LBqs5rTEm0lq61Au9EymkCgL627Aj4/W0+/XXWoySQQ/SveoTw2EFEeo1eRVeYQTzs
 FI83v7iQJXhVQ3TD0vTVTZ3hkspXgPT6xNtKIXjD7ag3OLjxwNClLR7BBZxSs4WkWq8i
 4fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4PD3dMdu5TYb+5hSet5uBV3XoQ0A6kdX7rIHlx5c1OE=;
 b=GW98zvQCKzZpw2wQMEfbaj1mDAD2IqV2ho0JVngeGRIaViHW9/RrMiCH48lGki5DzT
 ZQAvKDNxYgB7N0bDOv29usdhc1FVctYz0CFLhMGT6YT8Wm40PofKPU8grKvuDQHN3h6u
 LZ9yiz0Km0wZ5STQscvcI0pv+DQ0ZMv6G1YxQs1E5t0bTR1OcgDWLxk+hPGZfL6l709i
 YJjZWzeNb1zejT1vEsM0MwkRh+DJu2Q8vH9m1XElMo/M6HeDGVWZhOT3tSZ94RXO2IV0
 2yUS7MVoGWlDZ/3KMY2TGDsUJu5Ov5wBg5gWqiUo2qymKgL/b5iLOmI4GwUA4naRtvXg
 Y4Lg==
X-Gm-Message-State: APjAAAUXTA3axyOVbiSzJz9FrD2osfie+nL+1Ns9PFtYdS1qU49kteCW
 z4gQiQn59js8Xj9GIhmTTXtFgg==
X-Google-Smtp-Source: APXvYqxqEb3R2RuQBvX+NGAKkUHlSFfhYrnH6FSncVpFb0KBShmiwBzyBwMmdFNq/fQVcmcoOUa7Mw==
X-Received: by 2002:a17:902:bf09:: with SMTP id
 bi9mr118824088plb.143.1564671682626; 
 Thu, 01 Aug 2019 08:01:22 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q21sm1433665pgm.39.2019.08.01.08.01.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 08:01:21 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6ca3ae24-7063-40ac-ed2f-b6fd7bf499fd@linaro.org>
Date: Thu, 1 Aug 2019 08:01:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v4 06/54] trace: expand mem_info:size_shift
 to 4 bits
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
Cc: bobby.prani@gmail.com, cota@braap.org, aaron@os.amperecomputing.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> This will allow us to trace 32k-long memory accesses (although our
> maximum is something like 256 bytes at the moment).
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [AJB: expanded to 3->4 bits]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/trace-events b/trace-events
> index aeea3c2bdbf..63bb192ade6 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -149,7 +149,7 @@ vcpu guest_cpu_reset(void)
>  # Access information can be parsed as:
>  #
>  # struct mem_info {
> -#     uint8_t size_shift : 2; /* interpreted as "1 << size_shift" bytes */
> +#     uint8_t size_shift : 4; /* interpreted as "1 << size_shift" bytes */
>  #     bool    sign_extend: 1; /* sign-extended */
>  #     uint8_t endianness : 1; /* 0: little, 1: big */
>  #     bool    store      : 1; /* wheter it's a store operation */
> 

Adjusting the comment doesn't do anything, and neither the before or the after
match the actual code:

#define TRACE_MEM_SZ_SHIFT_MASK 0x7 /* size shift mask */

Is this a victim of a rebase, with the changes to trace/mem-internal.h moved to
a different patch?


r~

