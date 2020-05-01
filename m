Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B567DC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC2920708
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8SUZhn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC2920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWm1-0008MC-1C
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWkq-00073m-7W
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWkl-0005Jk-6d
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:35:04 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUWkk-0005A3-Oy
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:34:58 -0400
Received: by mail-pg1-x543.google.com with SMTP id n11so4619564pgl.9
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4PQ7nkSEXWtbyNdko7w+HLJAfFyqq3bU/lbtNNTkx3g=;
 b=E8SUZhn90M0znzTVcO8c7k6/A0LvJ8ecBExWbu8l8fUdfrm2Ot7ENapM+keugTLXMd
 MuCPNy8HXWyLHtWVg2xw0teLgopPcK5O7Bjy9waP7UoupLgJY00Swvf4GjQw97wx+ak2
 hL9qXf40FG6SSa/5ZW8cKFH0aH9XcXwB8BJTpUPQzvskc5tvAzuT5E8+vVLofg1ONUe5
 N29+Eyedd5du0nkB7lWvgvt1mGZq/cK5JJqOnkhOLwmFAeFqLt60Ee8eDOEWLFnkfqN5
 VwJlW32ddHA2kle0+pScOW6djf0q0eFnY5Wr5rCDilABeg46m1QHJgviDsLS7yTVbjxP
 S2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4PQ7nkSEXWtbyNdko7w+HLJAfFyqq3bU/lbtNNTkx3g=;
 b=rw/jngqTGUDD+JhOeKefnmI7l6h4mDUa9QnVT9eipd3x+5D+20JVwk14/ZWqCmx3Hs
 grxkNZqdKoh5amI9ZyBx2Exa45Z2jNvWgfvX1BE3HVwlKELHU2+MJCX7NMcVdpwJ9GJ5
 NLYod5+BDbU0XhmBNR3z9+u+0T5uA0zWJhEOyJcC67a/2I53Q9N3LB5DRdc/zFkMxKoe
 upRrCuG6bf4qFSBLxyGCqRSL1jXdE0XyvjRCrc3gBnZhEiUMXSmWPSW/vk9C5h1arnfr
 RHYNwL0KXJNRCWcyzPNcaObVRJrF3fZ1U+WJf+MnrCpxWuqi26oKFthVwD5weWSkP4Ph
 f4PQ==
X-Gm-Message-State: AGi0PuZznZW+afEblPu6f3HKZu3099hWZ/6EFJ9BSkiVTs27gHJhSKu1
 TkKEJkilqtpZtzXWMjizb2Pgrg==
X-Google-Smtp-Source: APiQypJt5drQFsCsVjztCWF3TDWIxlVHabdif+lhhICbwgCeqjmywSaQA+hme4vcuhcB8PETN6ZJqg==
X-Received: by 2002:a62:4e88:: with SMTP id c130mr4554669pfb.122.1588343696942; 
 Fri, 01 May 2020 07:34:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y14sm2387680pff.205.2020.05.01.07.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 07:34:56 -0700 (PDT)
Subject: Re: [PATCH v1 2/9] gdbstub: Introduce gdb_get_float64() to get 64-bit
 float registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200430190122.4592-1-alex.bennee@linaro.org>
 <20200430190122.4592-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <35d5ab54-4378-5f8d-6202-d33eee895d0b@linaro.org>
Date: Fri, 1 May 2020 07:34:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430190122.4592-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:01 PM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> When converted to use GByteArray in commits 462474d760c and
> a010bdbe719, the call to stfq_p() was removed. This call
> serialize a float.
> Since we now use a GByteArray, we can not use stfq_p() directly.
> Introduce the gdb_get_float64() helper to load a float64 register.
> 
> Fixes: 462474d760c ("target/m68k: use gdb_get_reg helpers")
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200414163853.12164-3-philmd@redhat.com>
> ---
>  include/exec/gdbstub.h          | 11 +++++++++++
>  target/m68k/helper.c            |  3 ++-
>  target/ppc/gdbstub.c            |  4 ++--
>  target/ppc/translate_init.inc.c |  2 +-
>  4 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 20e1072692..4a2b8e3089 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -134,6 +134,17 @@ static inline int gdb_get_float32(GByteArray *array, float32 val)
>  
>      return sizeof(buf);
>  }
> +
> +static inline int gdb_get_float64(GByteArray *array, float64 val)
> +{
> +    uint8_t buf[sizeof(CPU_DoubleU)];
> +
> +    stfq_p(buf, val);
> +    g_byte_array_append(array, buf, sizeof(buf));
> +
> +    return sizeof(buf);
> +}

I think we'd be better off *removing* ldfl_p/ldfq_p/stfl_p/stfq_p and
everything that specializes on them, like this.


r~

