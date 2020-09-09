Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69210C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE68721D7D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ4Zxe3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE68721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzii-0002cd-1x
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFzhZ-0001Eg-P5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:59:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFzhY-0001Qr-4u
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:59:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so2827733wrw.11
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jTAsveQpj73tdHzgw33L8agoeafzUcq2R5xsluBe9JU=;
 b=YJ4Zxe3PZVzw1AiQ/JCvErktm1ZAONSw8q4YuPwOnf1IkQTyyZMIgerMWiJNJqwU9u
 w8nb3g3vYO3NSRYke9YaXNu0laJ/yWME/9Mz3s7k1Fcx7li5qECUv77RJoxHiYnn3pWm
 PtSJ80GH2S99Cahhynqzftvnc+nOg9PdhJTXxbRmmC4+rArLIFYl2UM52UhgH+46LxnH
 a+4G/O9USddhGa6Mxnyk09Zfhq5/00usQavZiTkRy+2FTfqqgqzJ7o23ZY8BXUT2/+zF
 gw0Cg00P1cVJuVzPWhlAsfcgEk4Yl/I1SFk1Dknhw9Rc+pCQdMhKRrsmpBm8gqe9MmHD
 mtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jTAsveQpj73tdHzgw33L8agoeafzUcq2R5xsluBe9JU=;
 b=GxzEGvo4Zu3PxHawTqvHa4y6Ziw5IH3BPvs+fw07wo+fOmTc68VEpCVZ8DdHA6elnc
 hc1o4k1pwFroQI1Qrd4MdR2LAJBzqKZe0ul+OCod7TeOz1yJ201RlyYra0a9TBprjwNd
 bk8zGVhVTvwiIkLnypwu/dLLgL7GVsdGkhhpoYKc2Bt9jLPwI1U4akEDMB2+JZ8qwS/H
 3GPYkwtwx0VkP7uRgN5CIZLsvBOFTdzRheoea/3U2xysx8JL12v3pSNZKnQHALA95+Q1
 ezzFwFKMdJms2UScii1p2H7swA6zndkYukA5Xf4WbIw0iW/1Eo5c+LcEQ7EaXHheOhgm
 sqtQ==
X-Gm-Message-State: AOAM532gQ+tqBD9WRUOwR4cuoisfeHtwVyuFA3aTAvtrvtMZjjqfSt+l
 27tgc4wybXyIHYk8c4gpWXI=
X-Google-Smtp-Source: ABdhPJzKB1Hz4JUI6H5yYrd/4m/76hPCOXN3t5HJ4WwWPXJUFneHF52E1be32ppimB2xDVEb1OCoMg==
X-Received: by 2002:a5d:458e:: with SMTP id p14mr3818917wrq.61.1599656390489; 
 Wed, 09 Sep 2020 05:59:50 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l16sm4746780wrb.70.2020.09.09.05.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 05:59:49 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] docs/system/deprecated: mark
 ppc64abi32-linux-user for deprecation
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200909112742.25730-1-alex.bennee@linaro.org>
 <20200909112742.25730-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b7a0d0af-6ce7-9573-60f3-c146da72c5b1@amsat.org>
Date: Wed, 9 Sep 2020 14:59:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909112742.25730-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
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
Cc: fam@euphon.net, berrange@redhat.com,
 "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 richard.henderson@linaro.org, cota@braap.org, aurelien@aurel32.net,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 1:27 PM, Alex Bennée wrote:
> It's buggy and we are not sure anyone uses it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  docs/system/deprecated.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 851dbdeb8ab..a158e765c33 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -424,6 +424,13 @@ linux-user mode) is deprecated and will be removed in a future version
>  of QEMU. Support for this CPU was removed from the upstream Linux
>  kernel in 2018, and has also been dropped from glibc.
>  
> +``ppc64abi32`` CPUs (since 5.2.0)
> +'''''''''''''''''''''''''''''''''
> +
> +The ``ppc64abi32`` architecture has a number of issues which regularly
> +trip up our CI testing and is suspected to be quite broken. For that
> +reason the maintainers strongly suspect no one actually uses it.
> +
>  Related binaries
>  ----------------

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

