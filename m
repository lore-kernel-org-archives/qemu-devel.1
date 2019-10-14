Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4784ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CE220854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmGCFyej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CE220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2DH-000720-RF
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK2CK-0006Zj-Pa
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK2CJ-0002LI-Bb
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:23:48 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK2CJ-0002Km-4W
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:23:47 -0400
Received: by mail-pg1-x543.google.com with SMTP id w3so3396214pgt.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zUxkJm21JyxGkQB/PNe3pLRGe8oxyMZXemkl3o/Mb9E=;
 b=XmGCFyej7q7xlvlD7NB8DSuUIFYpY5EXH5o1qjeuWslans6Qse2fJza7JmvSc8aomT
 YnQbHa6oT91IauOstdAayV/+PYDQMGwinCo1893Q+KghlWLEYk/cFVhHPhqvTso7hpBO
 VpldTZyHjSJE1Akl31pRQSWXir/K69RxDszIDAQkUSTWG0WxeOQCgfB9l5nZXP/tE1kB
 nS9r+eGE1gBydlTNJBAhkfe2m2LdkHiLuoRcMeaHL4medOzFMdVfS0ntcRj6T1iF9V/D
 6v4WEfl8EtOHh+Oo5Y4l9cjKov9xS8w4My2U/NaGVyrGl+3AcGyYBj8+t6dPujh0DmLJ
 vjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zUxkJm21JyxGkQB/PNe3pLRGe8oxyMZXemkl3o/Mb9E=;
 b=GRqyBr7FGw9eninGulcHI8qxHl2+fytvPQacRM5R/63nJnLpD9Sk+vBIHYCfsXUqXs
 0QlsWTHNbrFNHKXBHqSrvO4ntGVdspM0aal4b6zeNvgwh6S2gE99Iw/CX9dwmwpZ8L/E
 HwmYRbM24U/0koRPbWMDMaEwV/zJ6bl8UKNXlWbYc7nIP7b+Wgs6PHtbl82ExhtkK583
 +nKvTtjHHh+iRLyJb/1koDH4KuiSiDRokmdUCCNC98m8UNo8BkXHt3YW8j67w4RjrDKk
 XQulbpV72qp4eSSWGdVDXBbEzYD8PpZs8cDnHTTHKfkOKdTdV54sTTEnyYC7F41K9Bgd
 fLmw==
X-Gm-Message-State: APjAAAUi49XntiveyNgPYQ+S9Or+5JByJXJZHokyVnYTdrLH6ZCwtHlW
 tE7RAUaS/2WnL3ikVu2999dpfQ==
X-Google-Smtp-Source: APXvYqwXVFG28gDycJWqxT2PHGqBeKqz9gX3XIHCvn/EQ+FbciD3BP+ljs78RewAx7mpVfxOTzY5Mw==
X-Received: by 2002:a17:90a:bd82:: with SMTP id
 z2mr37850620pjr.15.1571066625635; 
 Mon, 14 Oct 2019 08:23:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j24sm18526447pff.71.2019.10.14.08.23.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 08:23:44 -0700 (PDT)
Subject: Re: [PATCH v5 14/55] plugin-gen: add module for TCG-related code
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5ca526aa-8e62-5e76-8ccc-fcf504959888@linaro.org>
Date: Mon, 14 Oct 2019 08:23:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-15-alex.bennee@linaro.org>
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
Cc: robert.foley@futurewei.com, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> We first inject empty instrumentation from translator_loop.
> After translation, we go through the plugins to see what
> they want to register for, filling in the empty instrumentation.
> If if turns out that some instrumentation remains unused, we
> remove it.
> 
> This approach supports the following features:
> 
> - Inlining TCG code for simple operations. Note that we do not
>   export TCG ops to plugins. Instead, we give them a C API to
>   insert inlined ops. So far we only support adding an immediate
>   to a u64, e.g. to count events.
> 
> - "Direct" callbacks. These are callbacks that do not go via
>   a helper. Instead, the helper is defined at run-time, so that
>   the plugin code is directly called from TCG. This makes direct
>   callbacks as efficient as possible; they are therefore used
>   for very frequent events, e.g. memory callbacks.
> 
> - Passing the host address to memory callbacks. Most of this
>   is implemented in a later patch though.
> 
> - Instrumentation of memory accesses performed from helpers.
>   See the corresponding comment, as well as a later patch.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [AJB: add alloc_tcg_plugin_context, use glib, rm hwaddr]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - introduce alloc_tcg_plugin_context
>   - allocate GPtrArray for tracking insns
> v4
>   - remove hwaddr variants of callbacks
>   - pass full 32bit meminfo
>   - remove now unused code
>   - move plugin_gen_from into .c file
> v5
>   - fix offsets when storing mem callbacks.
>   - remove #if 0 code no longer needed
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

