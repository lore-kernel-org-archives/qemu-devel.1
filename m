Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E3C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 22:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9C220872
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 22:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9DCxa5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9C220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8BHU-0004mg-Qv
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 18:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8BGf-00045M-VB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8BGe-0000K0-UO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:39:17 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8BGe-0000JU-Oa
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:39:16 -0400
Received: by mail-qt1-x843.google.com with SMTP id u40so27344489qth.11
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t6xvNJ5c14LG5X4spDXlUQXxe7XoibIsGyOYyGqXl/M=;
 b=N9DCxa5mJwzLMxVtgA656yOowqGnwokLFYTnd764OKMhURFYWOoC9AQdL3cQoOtqtw
 SuCUFl0Llk5p4BgzT/N4bsM+Kl9hAngfPSJNiemgQSayHAUixamGwMNkYAyRQjBJ/7nH
 v1OpWKKpWPSv/YbxFpwLMDTz7ehbFF9IQdzvByE/r+lzC/fHIGmtB8GfPfZN5GU4aaOb
 pLR7IZiODa/bISL7GX1ZGAPpjWr7T/OtZjXs+PjT/6D8Y5A4ahb5hmp2qdwzfS7wnhBM
 vO4+xfJ5NlKnwcSkzBNNgGqWlGeyrj1qGzf7ZTO6BH0xXdOhwBhTYZiouYwz4OroT1Cc
 I1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t6xvNJ5c14LG5X4spDXlUQXxe7XoibIsGyOYyGqXl/M=;
 b=Fwi5SrmC5gK0sMKa1u7HOXZeYUq6CUop5zAxALF8F7sbQV3S72jnbktCPPlsNWKTcx
 z0AQjZ0Jh4A+K7HN3m6b6FT0Kuk0OXE6cylJMRKiT05eC1bc7ewzmYmZ+GUaKcKaKMwE
 J2AcIROqri3brzrcqWFCX76n8HOu+JMrs3/VSohmYJGH8SsDmRefF8htnz3NaK2uoe1e
 sQJE2/+uDQ8Wk6gZNmiaqpM//4gjuy9oS5RvGZq879Wz1H4ZvVj92bKc6qA/KppT4Tpp
 OyBS/zm7lg7oyp/Sv33ectjANq1pwH/u27SSjdPYCpRjpP9fo93S9+D/j/GFsNLkXYDl
 smoQ==
X-Gm-Message-State: APjAAAUDt/03+/8vxnoL+y8WfVNBY2PdAffHfNIdP5v7ulIhO3GA3Bsj
 pzTWxDmUmJzwxFc7XBu2hfhB4w==
X-Google-Smtp-Source: APXvYqxNFwSXamkUDtF/VcOLInxECJKMfGhc35brRRgn06jVt7c68tGbLMWktf3X+uqqoDv3kSkk/w==
X-Received: by 2002:aed:2381:: with SMTP id j1mr15838416qtc.373.1568241555906; 
 Wed, 11 Sep 2019 15:39:15 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id y7sm9781075qkf.56.2019.09.11.15.39.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 15:39:15 -0700 (PDT)
To: Chih-Min Chao <chihmin.chao@sifive.com>, liuzhiwei <zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-2-git-send-email-zhiwei_liu@c-sky.com>
 <CAEiOBXUveMJGpavU7_zK0UTdNniQvnXnw5MvE-hu7yHCSw8MPQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b9c89438-5346-e2ee-403b-3bc1fa1637bc@linaro.org>
Date: Wed, 11 Sep 2019 18:39:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEiOBXUveMJGpavU7_zK0UTdNniQvnXnw5MvE-hu7yHCSw8MPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: Re: [Qemu-devel] [PATCH v2 01/17] RISC-V: add vfp field in
 CPURISCVState
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, riku.voipio@iki.fi,
 laurent@vivier.eu, wxy194768@alibaba-inc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wenmeng_zhang@c-sky.com, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 10:51 AM, Chih-Min Chao wrote:
> Could  the VLEN be configurable in cpu initialization but not fixed in
> compilation phase ?
> Take the integer element as example  and the difference should be the
> stride of vfp.vreg[x] isn't continuous

Do you really want an unbounded amount of vector register storage?

>     uint8_t *mem = malloc(size)
>     for (int idx = 0; idx < 32; ++idx) {
>         vfp.vreg[idx].u64 = (void *)&mem[idx * elem];
>         vfp.vreg[idx].u32 = (void *)&mem[idx * elem];
>         vfp.vreg[idx].u16 = (void *)&mem[idx * elem];
>    }

This isn't adjusting the stride of the elements.  And in any case this would
have to be re-adjusted for every vsetvl.


r~

