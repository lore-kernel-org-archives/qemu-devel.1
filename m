Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BC7C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808AC206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7a+Lm1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808AC206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXoP-0007Ln-MZ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52166 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jQXmg-0005UT-NN
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:52:43 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jQXmg-0002tU-0f
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:52:30 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45731)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jQXmf-0002sj-Eo
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:52:29 -0400
Received: by mail-pl1-x641.google.com with SMTP id t4so4019408plq.12
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J+uwfEwyRnK8DOL9JKG81u9mxQBFG59HTmCjsFLrV6o=;
 b=T7a+Lm1I8/Ninpijn6kXG8hQFXulrNN8JVW2Ejwu8cFf1745EvAS4grKxdj4F3HYTh
 V6aaKQH+6zQUP6DpykClExswA7yzi46Erh6+pHn+rImAa3I23u+VFY7dbFwC8rhOB22A
 prRWQr//Pv0PipYBmllPoHnh7yauRGGjtTiikcmtON/C83a+8L6AuaO9QBVe8ey4Z7D8
 cYht1i2Cgqgr2g/lIWgQlt0bASnTX0jsVeEEBY1gLEPI0m8lHHZQI87xVh8JFsXAj9WZ
 Twg7EJUPigPkmrMmXD6PcTjjpaf25pm2OwuOCXCaCBW3QTKgRzUMBEFdGAa5S2CCpJCe
 KN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J+uwfEwyRnK8DOL9JKG81u9mxQBFG59HTmCjsFLrV6o=;
 b=dQqBRstxdBnakvuTHAJtJkPWzZHgu+KouVrHVgDOZ7YNiFkqjgMgJ2xmqSVwV5xw3m
 FLsVBZjz4slaUasEBJfLho6minzuIFY9bwFiHpJ2McoFWsBsfbhTEihMlbw3HBBtP0Aw
 tDbfxjF604Kxkkjz95Zfl1UH6XkGRr6havUq/c8jQkl7VGyOLPtzx6TnXoQQb3yRyoAr
 QJZNked9U231Inr3+bXFxWnp/NQ9tFtA/Pu9/tqM/O3g7H7Y7azDyrhB4D9LMZJVVKr+
 dlrHn94+cuwI9qbbESbx+FR3nphysAplVKURrEXBTPy+S9bOu0zkUe4zb11Ghozbsqil
 kdCg==
X-Gm-Message-State: AGi0PuYF1IOHDhw5PsT6xXDYFOEKE4T49wScl9LYInkL3BLwsyWg14+Z
 wURdnXat4s9HAzqt+KlBLwxmcg==
X-Google-Smtp-Source: APiQypLniQ1IPquR0CbJf0QHMFDE4Ok9/JZCP+jCDa2/OHtoEdoXzbFQWUGES4Dfk+ZmcZBIVLKafQ==
X-Received: by 2002:a17:902:aa84:: with SMTP id
 d4mr17581824plr.158.1587394348049; 
 Mon, 20 Apr 2020 07:52:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n23sm1366924pjq.18.2020.04.20.07.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 07:52:27 -0700 (PDT)
Subject: Re: [PATCH 7/7] tcg: Add tcg_gen_gvec_dup_tl
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-8-richard.henderson@linaro.org>
 <9dbf61fc-7689-605f-a4ee-0b17e852192a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e90bcb7b-f26b-4a17-7d9e-022a7da41223@linaro.org>
Date: Mon, 20 Apr 2020 07:52:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9dbf61fc-7689-605f-a4ee-0b17e852192a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, zhiwei_liu@c-sky.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 12:30 AM, David Hildenbrand wrote:
>> +#if TARGET_LONG_BITS == 64
>> +# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
>> +#else
>> +# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
>> +#endif
>> +
> 
> Any user in mind?

riscv -- the in-progress patches have some ifdefs that could be avoided.


r~

