Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458ABC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1268D20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="czqUf3QM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1268D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Xrb-0000Hd-8j
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1Xqv-0008GG-PU
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1Xqu-00032A-D8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:53:33 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1Xqu-00030x-4P
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:53:32 -0500
Received: by mail-pf1-x441.google.com with SMTP id n7so5698059pfn.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 07:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9lFy3+MRR7TYYly5eGGTBavGK2tFmldkiIzr326jGWQ=;
 b=czqUf3QM3gjnueyJNa0yGj3Iw49keeCxC2H+pHMxhlJ83KMMtbB8uVvrctrDHX5nbN
 onSactF5wakAyH0HbT0j0ao5CHSxv5Pa/frwy457R3PIXA3wH8dH6XXwe1Av1BsIreFu
 9kXkYWUt/w7Eb+8RAS0S86lf0mzdPh8vR5AZqxh1BpKxKlUZ5hsgqnJPMJg0DMR9iYjl
 rZ/TinAZLblY+88ULd+9Re46+doBzhpfiGnu/y6yPh4YlchvIrr2tP/efyHggbGsWD0z
 1YpTRcY0F4o72jkVDyLUdIhGe70vNAGVeo+u86qc2m1g5xIML4yAvC4fQiMDEsdG79AZ
 nX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9lFy3+MRR7TYYly5eGGTBavGK2tFmldkiIzr326jGWQ=;
 b=JddOdylBUi45OhHvHyILR6LwqDk5DeYyXGQH40UD6HDQZOkuo4lQYDXaecMe0vm+0I
 W5Ec+fG0QoyXnX1A3BStDNL/uPRdzMXNA9oWvUXoFsPzttq2xGIsAeP8bKe4yzqcQBDD
 jAnlLB511BVgf0m3a03LVr9krk5c0uZ8BdXDe80zXUmR1Kaz0mbOa1Oqhra6waGrMrgv
 0FSrhgsix2XG3zBaekvuaJxd8WVwJTf/rdTezIay6SKFWb0rqGqLuHL8w4mt1t8xZFko
 XeZwJW7WfedO0FAl2PNZz9dIttQ3yS/TM56zW47bt4uHlym5YwNYtwTSE5f3DgsZNIeu
 LUpw==
X-Gm-Message-State: APjAAAWQo3gLvJz+gzzGVmUuH/lGGW8+jQf7lWBYfUNV2y4nJOGQK1ab
 vgt7TGzYBQV3tnrZav9d/MfQuQ==
X-Google-Smtp-Source: APXvYqxGoKYN75yWZb6ileXm0lw3EqYrHtO7FrYohtsNpyoeyvWVXYPr3DFXCOt7IQv3N8HbLijkzA==
X-Received: by 2002:a62:342:: with SMTP id 63mr3830595pfd.19.1581436410470;
 Tue, 11 Feb 2020 07:53:30 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f18sm4582819pgn.2.2020.02.11.07.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 07:53:29 -0800 (PST)
Subject: Re: [PATCH v4 1/4] target/riscv: add vector extension field in
 CPURISCVState
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
 <20200210081240.11481-2-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cc4d0b93-013f-5cf5-4ff4-248ab99eec70@linaro.org>
Date: Tue, 11 Feb 2020 07:53:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210081240.11481-2-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 8:12 AM, LIU Zhiwei wrote:
> The 32 vector registers will be viewed as a continuous memory block.
> It avoids the convension between element index and (regno,offset).
> Thus elements can be directly accessed by offset from the first vector
> base address.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I still don't think you need to put stuff into a sub-structure.  These register
names are unique in the manual, and not subdivided there.


r~

