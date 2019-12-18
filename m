Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3B6C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A90206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdbO/SBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A90206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihevR-0006w4-64
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iheuY-0006Kx-FL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iheuX-00010N-7m
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:23:06 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iheuW-0000uK-OQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:23:05 -0500
Received: by mail-pf1-x443.google.com with SMTP id y14so1734921pfm.13
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0LaDis55yTgfxkxt4kH4JxiDjjx7xs1BGFeMPP9ls4k=;
 b=GdbO/SBcj+w1mRUJJZnwlayR/OK6KNlV6PttRKqKAXdHxOg+AV3ai6NBooP7GHVmfV
 jb+qYF5wOE3vVShz36Xs9swNhi/9EG13OgCc+d8ygR1+f4ce93X5lI7wckuiJc1divLP
 NC4xXIh3HQ1aJqK/jI2reszoy0BhVhaiOLhhhrJPggefQm5Ee9BIT+VV1F7B7GejjDnZ
 BHwDWX9h2oPFGmh9J02y/GbIAqvgZ8EQfUhtd9l/j6HRJwi2jpPdBBbFpUWuGp9xilvf
 zKHaGRw4A0//uuPvzZC80QRfC1jUI6aB4+VUk+RCZf9CG9wO+KZaf4lFNbK+KpksB4zd
 jFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0LaDis55yTgfxkxt4kH4JxiDjjx7xs1BGFeMPP9ls4k=;
 b=a0yuTDwT9vyc04W+ExZwl86s6VaOab+1bCgPAkOpG5RC6H3wqNLqcNWSHCnsIMQUl4
 RAPishVxzr7EVDsRgfNKyiv3lY1bGEruTAAIRkm2hqtjtGnqtThNKwBONMDb7XrKBKHH
 Ieq6Jg2bwEbwAfYmkg1HW/QDh2fjsw4c1Wd9i2jrkipUFoNjZNfxPhhUT5Hs3LWZ65sJ
 JL7GLbDEbPdJXcJWpbFHsRUMjSifDJNqn4c8GMY7K1nOi2uO4xRpKlGB/65iR6kmoVFe
 DX4yk2CZtAixJ874korRYwxDXrzZVtlNt6dfzIK+Y532xYABKbhVMeHn20tpAfPlE20Y
 N3tQ==
X-Gm-Message-State: APjAAAUWFvozeILQEgYNqEc8P3f7orgQWfsrCheIpUW+fHXfJkP58arf
 32WwdTVH/46NKcmXRe2apd0TVQ==
X-Google-Smtp-Source: APXvYqybLE8+gjgKM71h8YTE5qzKgmHmveeum7USJal9uWOJROTrl0fzLVML3WjLs0oDEPqzV5qGzw==
X-Received: by 2002:a62:1d52:: with SMTP id d79mr4843359pfd.144.1576696983535; 
 Wed, 18 Dec 2019 11:23:03 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id q22sm4473049pfg.170.2019.12.18.11.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 11:23:02 -0800 (PST)
Subject: Re: [PATCH 3/7] configure: Do not force pie=no for non-x86
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191218031920.6414-1-richard.henderson@linaro.org>
 <20191218031920.6414-4-richard.henderson@linaro.org>
 <19a90c1c-3407-522c-72c7-1612ba66147c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <73905ca5-bc1f-27ed-8315-c8b73c58cabc@linaro.org>
Date: Wed, 18 Dec 2019 09:23:00 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <19a90c1c-3407-522c-72c7-1612ba66147c@redhat.com>
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
Cc: berrange@redhat.com, i@maskray.me, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 9:05 PM, Thomas Huth wrote:
> On 18/12/2019 04.19, Richard Henderson wrote:
>> PIE is supported on many other hosts besides x86.
>>
>> The default for non-x86 is now the same as x86: pie is used
>> if supported, and may be forced via --enable/--disable-pie.
> 
> The original commit that introduce this code (40d6444e91c) said:
> 
>  "Non-x86 are not changed, as they require TCG changes"
> 
> ... are these "TCG changes" in place nowadays? Did you check on non-x86
> systems? If so, please mention this in the commit message.

I have no idea what those "tcg changes" would be.  I have checked aarch64
(bionic) and ppc64le (centos 7).  I'll update the commit message.


r~

