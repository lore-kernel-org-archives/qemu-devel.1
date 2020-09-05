Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4AEC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9D02074B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFP5ciWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9D02074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfpC-0006LA-O9
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfoT-0005ul-T3
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:33:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfoS-0000Ga-Ef
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:33:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id k15so10803844wrn.10
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Yzh8Y+S8EaE6sLjYA7IgZtmWRBf5mrrHYpN3uy3Mqcs=;
 b=PFP5ciWKohdxWQULO1iV8+Bn+9+NX2aLhLv+PBGo1PiOEZcOfA4Tb5Kxyg3UD/W54l
 ICYT4nLcPpmVZ05GzYKTwPvcaTEPFO4zRvBcid9L0MbNW68EIPZL8pEiPz5pvQ8crAkQ
 nSNxdLrq7Ch0PuIkCVoSLR2Zv/zw0dDD/ApwmTgocTtBqxy4Sh7Yg5LiDMJunNOwRCx3
 1r0NKseoQPK61MEYIA+kDJbvnQpbfXWL5mxiEIKKxCupSoE7VC5I1BqQxOawPCFKFHIb
 hg7ibDF4zCoKqoOk0ZUoH+/K4uVPoVvcyg3mC8qbfMGtMDwaGz9CrcOBvjP2BI3M3ZlP
 JjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Yzh8Y+S8EaE6sLjYA7IgZtmWRBf5mrrHYpN3uy3Mqcs=;
 b=cTwN1fZZ/5c2sRj8hj15fVOv6OI24wuDQAhFiE86DicAguWOxhcMoFnYziVdDQYcvG
 1mq9VTjdKr7tbz2YPeWooBOm8PMA8JjVdur9jlo7LVu3KhMhanoMONffB1gid3yUTXum
 /qc9PZCB+ttMkW4vuBE09HO3XUgAMipfgAZkd1sgxU507ZAF0lzCAk0FYuuOuUt/PO0J
 YAY0lMGRS/g4j1m0IDi4NnBCD+HjU/oOnd8/sL0OPBB1sIesey3MKpkKPoeg4dMPXIYy
 DV2tt4spRUhBwmJcFYg+No/Wpfav8qC6M3/dsTRkexU5J21wAQs6PFs2R58R1js4HX5z
 cEeQ==
X-Gm-Message-State: AOAM533EW1eVwSY8Q36HbNAIz66GliCKJm2PpRReBn0BmGmI1Hgg6PTQ
 +i8fr6pgzy7AiT0ITj8v2Wo=
X-Google-Smtp-Source: ABdhPJz3DrOXRD5hVQN41yNdh4hgVFUyCtroLARM8hNxH5fc+hfVcZQIJ3eADyqNixg4K1p0FM3m9w==
X-Received: by 2002:adf:f88b:: with SMTP id u11mr13365017wrp.376.1599341611174; 
 Sat, 05 Sep 2020 14:33:31 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o5sm18446695wmc.33.2020.09.05.14.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 14:33:30 -0700 (PDT)
Subject: Re: [PATCH] tests: fixes test-vmstate.c compile error on msys2
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200905063813.1875-1-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a68e6325-693a-2bc5-b18a-0d38d789fec4@amsat.org>
Date: Sat, 5 Sep 2020 23:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200905063813.1875-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.107,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/5/20 8:38 AM, Yonggang Luo wrote:
> ../tests/test-vmstate.c: In function 'int_cmp':
> ../tests/test-vmstate.c:884:5: error: unknown type name 'uint'; did you mean 'uInt'?
>   884 |     uint ua = GPOINTER_TO_UINT(a);
>       |     ^~~~
>       |     uInt
> ../tests/test-vmstate.c:885:5: error: unknown type name 'uint'; did you mean 'uInt'?
>   885 |     uint ub = GPOINTER_TO_UINT(b);
>       |     ^~~~
>       |     uInt
> make: *** [Makefile.ninja:5461：tests/test-vmstate.exe.p/test-vmstate.c.obj] 错误 1
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/test-vmstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index f7b3868881..f8de709a0b 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -881,8 +881,8 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>  /* ID comparison function */
>  static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>  {
> -    uint ua = GPOINTER_TO_UINT(a);
> -    uint ub = GPOINTER_TO_UINT(b);
> +    guint ua = GPOINTER_TO_UINT(a);
> +    guint ub = GPOINTER_TO_UINT(b);
>      return (ua > ub) - (ua < ub);
>  }
>  
> 


