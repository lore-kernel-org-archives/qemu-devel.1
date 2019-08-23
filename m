Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B7AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750CE206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmnqtftN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750CE206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DRL-00008M-5A
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DP4-0006ct-2y
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DP3-0005ZK-2a
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:31:09 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1DP2-0005Ys-Tj
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:31:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id g2so6894020pfq.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V/AjrV59P1NHShm5e2W+azDxhSKVmZ9Ld6wDgXeXJxw=;
 b=mmnqtftNsRXhz/7YLIWfBWUdoFg9pElLL+GUNSlQhuzTPmi+/paDbyZCmvJdrKa1dL
 n79DRd/KDeqM+tv9UyLyHMObqOOMpRnwUBvkSUJLvr9D7MCSxNL0NGfmR/Qu+v8KhFq9
 QE3oF9NkJfgXFH7Ppkjxn4RDKcTs00KwCKTqO2RJZD4/dbG2WsKpwoBzepzD8LmGbKtK
 MjrPv4a+tQdkbwIyXJeXL2VaAhcVyTaVWBo/52GniMuXGEgkSLZDdd3n4C4za4UL8asZ
 GbkJcH6cnCy76AjIdiGQJr+hsUDAL+qxzqgB/yWrV4Ms+QqILkNTqrrBPq8guAxCA/6+
 O87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V/AjrV59P1NHShm5e2W+azDxhSKVmZ9Ld6wDgXeXJxw=;
 b=d66ZFuXcalAIfX98R3amAilcCLpzblU6o0/6y7tQ8ZtIdLQLvOsLODos26WnHtYxgR
 QrfT9xXqQhFKyUyUE1pk0hq1HRT210ebt5VgCIXWbJIP24REOzzfzYm3nbJFPjblzN5V
 JaI+THx5DvvSbz8laYa/1QBvDRnNwF2VlMuk7jihJsxt10FMzIJyJtqc4okdxTJC7g9v
 yy3DbQWf1p+dkMa8SepryzI1S/2cKbVbqzss7AolJUEgC0FhujXuHAU5jz22gqsy7Mgi
 ETCfi+V9c4k5OyNGVexC+1S5wAR4MJ8mTcgdjhD8MTfro8ang0POjNdl+r3/zW5scLFQ
 LuOA==
X-Gm-Message-State: APjAAAV6mtHKzYSZNH0Hjqd3qX3GvHLIEQA2aLj7GksN9Ck2dHFfcOhK
 1IYxy+3JWWlaYtd6X2CpZLdGQQ==
X-Google-Smtp-Source: APXvYqwRFgE1X6Me50UqWEeVQF+SbjJVYY+sdd1ZZxhniwkUPg8bqVYHb50MH/Tzro8uRfH8VFa0vg==
X-Received: by 2002:aa7:8a99:: with SMTP id a25mr6547578pfc.127.1566581466972; 
 Fri, 23 Aug 2019 10:31:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i137sm4217522pgc.4.2019.08.23.10.31.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 10:31:06 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190823143249.8096-1-philmd@redhat.com>
 <20190823143249.8096-7-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <08147950-75bc-9145-bb32-d1b4c7f84648@linaro.org>
Date: Fri, 23 Aug 2019 10:31:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823143249.8096-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 6/6] hw/net/xilinx_axi: Use
 object_initialize_child for correct ref. counting
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 7:32 AM, Philippe Mathieu-Daudé wrote:
> As explained in commit aff39be0ed97:
> 
>   Both functions, object_initialize() and object_property_add_child()
>   increase the reference counter of the new object, so one of the
>   references has to be dropped afterwards to get the reference
>   counting right. Otherwise the child object will not be properly
>   cleaned up when the parent gets destroyed.
>   Thus let's use now object_initialize_child() instead to get the
>   reference counting here right.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/net/xilinx_axienet.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


