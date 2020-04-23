Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC51C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 19:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F3B20728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 19:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kq1q7o6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F3B20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRhnP-0004AU-Gi
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 15:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRhmh-0003P7-Ul
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 15:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRhmh-0000Bk-61
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 15:45:19 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jRhmg-000085-Oa
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 15:45:18 -0400
Received: by mail-pg1-x541.google.com with SMTP id o15so3412160pgi.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S318y3xgVDniaeGVpSw6IZJ8haGz6GY0bz9DK96kyFU=;
 b=kq1q7o6RArA2Imnyk75F1qYBV5eyJlon1scRNUm16he15ss6J4uyv1HMWThmB+nzZk
 MEOzw+88VL2TkLr4+hu4Sv9W/kAeV+rVvp+3KjyBgDrONCNJ22z/xZ6g8/mE4x+thW7/
 2ANcv2Lg3lewbUBvfoUCP8pAQzauww6UlG7Y4obUZJxo+02xWMonvKgpkvLWO442S1zf
 LmD8qzj0jd6ZRu2Gf20UldJqKXxL+VaYTAMK6EXgzJ7h2f5ANqzOPBhtKZ4mYBmuSwxh
 XjtNb2x1r/lboXOhZ+mF299TT2xBIo4EiYoccIBJoVnb9raLGcCDswul6lqzhJazJIWO
 FdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S318y3xgVDniaeGVpSw6IZJ8haGz6GY0bz9DK96kyFU=;
 b=ml0mXN0FW/yvAR5muQVOKcm04ZjHFNOXqJc0GBtuMHeaaTtNGuDyFCyl1zlbIroe6b
 TW2wcWDKrMV7arzMqeWJuh7cVYOu7ZWAbqeawMdko/3rMfirnEBWgzctNWJuGaEhUMpu
 5B7QYqMwnnyV6gqi94duhI1tbEQ7EKSUJG/72ix65L77vK48i1Fg+EjeHdbsQTYhDR+p
 DxmjvdbwuDTvIqorHQYuIsZo4n24WzLSHUCKAKzrl1ImBTpKGlX4baXgFYCmJFYfqdGW
 VqGzNQovNCrm7mMF8uBB/CeZ+mqVkhJu1xgOPEVa7qNh3o6e94VB5AeUn6Zp6qESooPr
 K4mg==
X-Gm-Message-State: AGi0PuZrH3xGiaU2xA+xIGzdODXai3/hLNKeTQhQQBs0jRSB/OGZutte
 8cHdDv/VpDyCfQh0uiryAXzRHAEy6jQ=
X-Google-Smtp-Source: APiQypKkx4a33a4bDcjOl9s70vzZN8BIBsNITlTzrv+SNZLjjK0z/rULlMx6mOH9lxjdD4kRn/FdTQ==
X-Received: by 2002:a63:145a:: with SMTP id 26mr5792067pgu.238.1587671115561; 
 Thu, 23 Apr 2020 12:45:15 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id f6sm3305995pfn.189.2020.04.23.12.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 12:45:14 -0700 (PDT)
Subject: Re: [PATCH] linux-user/riscv: fix up struct target_ucontext definition
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
References: <20200412020830.607-1-zhiwei_liu@c-sky.com>
 <f6dc4fa7-fed5-28a1-5922-68e9a0510de5@c-sky.com>
 <bf6b46c3-cc39-1b4a-4ae4-9de894721f04@linaro.org>
 <07931c1c-c7b3-510a-d3cf-5fb6bc877e87@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4b752be1-009d-8a25-9da7-3159d1a24e1c@linaro.org>
Date: Thu, 23 Apr 2020 12:45:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <07931c1c-c7b3-510a-d3cf-5fb6bc877e87@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-riscv@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu,
 wxy194768@alibaba-inc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 6:55 PM, LIU Zhiwei wrote:
> As far as I know, Guo Ren and Greentime are supporting RVV on Linux, based on
> the v0.7.1 QEMU implementation.
> The main problem is that VLEN is not a  fixed number.

Neither is the SVE vector length fixed.

That's one of the reasons I pointed you at the AArch64 sigcontext for ideas.

> When the Linux kernel released with RVV, I will push a new sigcontext structure
> here.

Yep.


r~

