Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2B7C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D189221E2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkyKnIOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D189221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwFt-0000vO-Ge
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwFE-0000TR-V8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:17:45 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwFD-0003hD-H3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:17:44 -0400
Received: by mail-pl1-x641.google.com with SMTP id t11so958102plr.5
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Mps6aZz7qGfJaPYK9tO+h0iSODZrt2Op2W30nTrP7b0=;
 b=xkyKnIOVt6zm0wzInA4lUssR7FUe7RaHdwcnd0w1Kyzlscu5qOjeFSFh3RT2tNtKy/
 m5EYsnD4+aqhOhxvuCm3gcDXnmNpcsqH8/BEQWSxFYcEMrmSg5xEorldx/GeWWVbE0ra
 SqXnkAJ084/56KGNPVCMb7hXbKGG+jw4+Wh/ZusGZNBTMiKXrsKDvUxH62S+85hqJWf5
 OUNePZhJK0KZZ/4nDIVjhuKCoQd0tMtoIo0SIddX0eV3pslgT24tJ9EEjfwrDM4mUExt
 04nmM+OXkfjrS7+l4lo0xTvS05CHmZMMKdnUbIVMB5EUp9X8igM5rIkeTxm+Ow6hpwKs
 WxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mps6aZz7qGfJaPYK9tO+h0iSODZrt2Op2W30nTrP7b0=;
 b=d0Q7M+OuUgggzfh2ITCRjO/UnCk0sYlS0gEtTJmPljIPDQMtuY8POvJt4/7PA6eTOY
 QxC8D8GOZ/ujqLEhSYAdQgkgCujUQImAbaqrAgfCJnjK6fwUlOpHysz65/zpUPN51UG/
 slTTPH/Pi3F+5ukAwCEApweerm/7iKU7OasPP40zMkUmXeydhD4aeoNtO9P8Fj0sOzgr
 jw8JCxEPZQpqgpY4vbQp4qUSFFHlPBZHMT/QXjPhgrq2wwy+/PJ1Pm93vTdDfqHaUhQl
 VmN0+Eifj5Hyb9kS561KvDiXo2n2GBoDMguv+kU3JSqUaDYyxswDx98ntijF8MjfZbqr
 1guw==
X-Gm-Message-State: AOAM531u9+BRILSP78Y6MSav3bdaz/0jfej+boTIrfCp+UGEY4SLD3zl
 6rZ4W3VZE8Ak9Ps/TMLYo4PE0w==
X-Google-Smtp-Source: ABdhPJz+SM3/u8G/9ofWbR3ZMKuztJVllIeHhM4aq3++FfrKxlo/Xmm0OlYAnZt7Nqi3GtQz2QHmeA==
X-Received: by 2002:a17:90b:fd0:: with SMTP id
 gd16mr6287926pjb.122.1598451461901; 
 Wed, 26 Aug 2020 07:17:41 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id o6sm2442289pjs.41.2020.08.26.07.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 07:17:41 -0700 (PDT)
Subject: Re: [RFC PATCH v3 08/34] Hexagon (target/hexagon) GDB Stub
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-9-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0fb7e0ec-f25a-4f5e-5192-2036b9bbd493@linaro.org>
Date: Wed, 26 Aug 2020 07:17:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-9-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> GDB register read and write routines
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  target/hexagon/internal.h |  2 ++
>  target/hexagon/cpu.c      |  2 ++
>  target/hexagon/gdbstub.c  | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
>  create mode 100644 target/hexagon/gdbstub.c


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

