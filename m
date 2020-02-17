Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932ABC34024
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E5521D7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZeQHj3QF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E5521D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lKg-0008Gl-Fk
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lJg-0007Qb-EX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lJf-00077Y-G2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:40:24 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lJf-00076z-97
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:40:23 -0500
Received: by mail-pg1-x543.google.com with SMTP id j15so9656308pgm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6n40oCiP1U+IGVIZZzS++QXdB4p4byRZaYiViIkTUjs=;
 b=ZeQHj3QFkyc2Ce2xTtS0xa++pmCEVybx6YMEkBP/u9BkCDn7CwQZtMdqAq8aEHz4PO
 /dvD7TWEQHp4w3xFWAzPQnigVwHyWxfhAOlTUEh4THiGlAT4BTLqB4v/0unQmMIxcdov
 7ntGBhlke1j7DYW/yRxlq+rBFaC65NgdS0SpMGqWWzh/g06Bv8c/CqGxquPsBVkBzhg/
 alM/4PmTIcmcUoS0AM1rgY9OKbzEp+N4bjpdW0bC18ed+rMRoLCjXDM8fB5wGOYK5Wzh
 IDQN7P1WWol0gzyL+NBx+rMmOjZSaHsbiXA7rhyfLq/ifvGE3DXbIAu4bvg84gDHK/N/
 c6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6n40oCiP1U+IGVIZZzS++QXdB4p4byRZaYiViIkTUjs=;
 b=cWY4gWCjBn8GYa3y+mDIvNB/EeLwLL1zpOnZnQIgHLf2vBXBPAN2On/9bhkcVKQrO4
 MxJ0oH6ppRgQNHqL9Nv5SP/joWGDmPHUt7LOV21uMMtESqcIKksZnSeeqc5T2Y8mx0Xf
 /o831LOGAAvv0U7U7FnzhiCh2GD9z/ebxdLmAZmFQLWmVPWvwoP3zyhGZA9pVm4TUFO/
 acih7inX54LPcgmnC3uLWjDlsLMB3UmaXfyA/wAi00BnEGWK3uSRLkOTmSpbt52ohzkE
 cFFogYeii/A9rR+0wAXBbkB/c6KP0Hb8svwO3wF4vuH0bSBnhIsvec7XKoS1TIMQ4EIo
 OpRg==
X-Gm-Message-State: APjAAAVZyxiuVuPInYBwgB7KSkMN+6Gq4d/YadZxlAQK+oQyqXaORXMh
 IIKVFzr3tnZiFTEafxQiidQJEK+6tB8=
X-Google-Smtp-Source: APXvYqxl0y4l0tHbyEAhcAwT5JAmJVEBQkQVrfxA9d1AYMY4Qxz8AIf7PGjfZrJVExNN0My24URcbw==
X-Received: by 2002:a65:6909:: with SMTP id s9mr19149049pgq.80.1581964822181; 
 Mon, 17 Feb 2020 10:40:22 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d3sm1087826pfn.113.2020.02.17.10.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:40:21 -0800 (PST)
Subject: Re: [PATCH v5 74/79] exec: drop bogus mem_path from
 qemu_ram_alloc_from_fd()
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-75-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <53ecb8c4-38b0-67f5-4a6b-6ea42827ff79@linaro.org>
Date: Mon, 17 Feb 2020 10:40:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-75-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
> Function will report error that will mention global mem_path,
> which was valid the only if legacy -mem-path was used and
> only in case of main RAM.
> 
> However it doesn't work with hostmem backends
> (for example:
> "
>   qemu: -object memory-backend-file,id=ram0,size=128M,mem-path=foo:
>     backing store (null) size 0x200000 does not match 'size' option 0x8000000
> ")
> and couldn't possibly work in general FD case the function
> is supposed to handle.
> 
> Taking in account that main RAM was converted into
> memory-backend-foo object, there is no point in printing
> file name (from inappropriate place) as failing path is
> a part of backend's error message.
> 
> Hence drop bogus mem_path usage from qemu_ram_alloc_from_fd(),
> it's a job of its user to add file name to error message if applicable.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  exec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

