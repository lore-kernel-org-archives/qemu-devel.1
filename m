Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADB72310F
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyW0hXMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADB72310F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3kg6-0006ks-G0
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 14:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3kfI-0006E9-Ug
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:30:56 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:33926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3kfH-0001CG-ET
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:30:56 -0400
Received: by mail-pf1-x435.google.com with SMTP id u185so25580836pfu.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2LRCFxIuAS3F37Go6N8n16BOh9PKGBFRaNdssvZtZ+0=;
 b=NyW0hXMeSGNGu8G4fZF4A8HzQdzUZtXL578IOsgR8V66nJF6jGUSk0jbxPAP7b4WIv
 UEjW4mx4pdOarBZq6Ro214tyQ7FRNI2XjAu7/MkdRwCLhukgs49PWxPCqxsGJOr73mmW
 XPOYBvs2tVn5Dnj4/t57h1WWd3iMRzTS1EaFdEwXuOGVepFbOPxmiLu63vEiMfuGN/gT
 mcDZWxFzpC/h2DtlTWpAgK1TL2+4Ezk/oxau0BvuDf1gVy1eJF7rbJXABnI74eOHhW63
 vWjxBUfjZa7GqZfDIhOg02rnrCLosEfz92h9dbtb2vl/CBhIWObVzYZZSN9j5gwNSZIE
 Y4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2LRCFxIuAS3F37Go6N8n16BOh9PKGBFRaNdssvZtZ+0=;
 b=P5fc5AdZcraVED5R1dwsVsZ2NLF/w0PC8ER01wRYWJ1gfcaHguLx6ucew35XrIKxYv
 4CciDWACQ4QKkHPFHaQGawWaHarTBWTG87bXY0FfUjTuGXmTf9JWtK8Q9DvHV0JiQ2wX
 D1Bk31pHLfwVzpQWYGj2RYQORu6xlsoCsY/lWkPgI4ZzixbmT2qV/dv0YFlgnUB2BGI6
 C8ONsHd0J5pMKYuolVPTnzN69OJILIGO3NPcmdq+QpbVcGxMLYv/3/pd+GLTWFbzyi2y
 rQegK9/VNCP2+KyN/IIVQbb7WWeVj/WFLKEA0wAPnU40w8AY/ttJflgnMaz2Y/qKoA7Z
 2Pxw==
X-Gm-Message-State: AOAM531RIU5XYhIn0CI3ehJzNsSeBiTm+EXI4VHZmq63akTjyICZcjE8
 L3xOMDnCgSg6q3gJvIcTnn9jFQ==
X-Google-Smtp-Source: ABdhPJz3kCYj5b900EtYk1cydv2CU1YKOE+qcmTUjqCygOs29Hhyf3ECpGEVZxW1LFuKxoGY14Dv4g==
X-Received: by 2002:a63:380d:: with SMTP id f13mr8223568pga.16.1596738653790; 
 Thu, 06 Aug 2020 11:30:53 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f89sm8285381pje.11.2020.08.06.11.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 11:30:53 -0700 (PDT)
Subject: Re: [RFC v3 07/71] target/riscv: rvv-1.0: remove vxrm and vxsat
 fields from fcsr register
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-8-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <63094cf9-c0d6-05b2-28a5-37de657edacf@linaro.org>
Date: Thu, 6 Aug 2020 11:30:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104709.13235-8-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:46 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Remove VXRM and VXSAT fields from FCSR register as they are only
> presented in VCSR register.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Actually, there's a related clause in fs() that should be removed:

    /* loose check condition for fcsr in vector extension */
    if ((csrno == CSR_FCSR) && (env->misa & RVV)) {
        return 0;
    }


r~

