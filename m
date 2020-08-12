Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8F1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 21:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BF720781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 21:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbeqsBjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BF720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5yOD-0005vW-9t
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 17:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5yNR-0005Gg-UY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:33:42 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5yNO-0006Gt-Cl
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:33:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id bh1so1669540plb.12
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C5MvkIBVFLX8HRTh+OLegEEsjltSHnz6HzBtZTno2sU=;
 b=pbeqsBjORuu/+EgIYzzFaL7/c6+ThCvNOAENbW6j/meSz1meM5XEWq2qiX97MPS7s2
 QmQfSzpu+iEw8WelV6L5SP0/sD4rkX3tS3rvVtDy1nb1O/Pf9ZEcw4xNNhkIyKnrd4vP
 a2jEEFpFkFrFnS1w2Kw8xx+FMLaH3kaufzCgSlhD64vkAobAQor8kWuqSKOwcifpm32b
 gui65SBQywSpS0bU1O684ETL+R7ouKhB791ENtXOvTK5/dR+SAvh2lFm8cOfXDywY9QB
 BNFTYf1e3804/uDLmiNt0tOcB/rYLvBo55J4CoWwthPvL5oo6UwbAome5/h0n5ogyVkP
 Xx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C5MvkIBVFLX8HRTh+OLegEEsjltSHnz6HzBtZTno2sU=;
 b=YdKR8o1yNPNgKOJxXERwY1vzlU/Ehmf5I2k0CuY49IN/o7ScvJNp0L//07l/YdnXhm
 raC0jRGKoBAf1GlyykV0MslmhI6f+6B2hGSH17uEyCNQ3Vtaa0++Z53qFq7i/eC9rFvp
 NWN8apVEV3oj9KIrauCjgpzfW0a1I5nKnNNbu2+L2uKJj6EtgE3cEaA7d6wwYaJPQnEE
 Ak6H6DeVhgSLU+lxcersxydP5VA1lBQuQR7kw3Qdho16LxqiQ8LnTHi13ku192VW6auu
 pACMyXBXU2Vo42rMDNZzSopD+RNDwsCZopOwdVS0VPyfDFlRfSO7TOhZg3JxVfyae2BL
 ZvlQ==
X-Gm-Message-State: AOAM530uD10ldA1MyQk9H1UGbHfxJOxWEps7GLgQSwwcto4ju9K96LXT
 iRdcvkL1+aXr2LKhvbU9oX8ux6XK1Pg=
X-Google-Smtp-Source: ABdhPJzsuvEQlI5kKGuCaaSrts0bPC1ClDJjuhYv3k0taoegT7scYSk17Hu0FnE2tE8aK6/lPXVGWg==
X-Received: by 2002:a17:90b:23c8:: with SMTP id
 md8mr2074702pjb.176.1597268016017; 
 Wed, 12 Aug 2020 14:33:36 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f27sm3385524pfk.217.2020.08.12.14.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 14:33:35 -0700 (PDT)
Subject: Re: [PATCH v2] target/ppc: Integrate icount to purr, vtb, and tbu40
To: Gustavo Romero <gromero@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20200811153235.4527-1-gromero@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5944440c-73ac-8c21-9f02-fee91a3a2dfd@linaro.org>
Date: Wed, 12 Aug 2020 14:33:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811153235.4527-1-gromero@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, clg@kaod.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 8:32 AM, Gustavo Romero wrote:
> Currently if option '-icount auto' is passed to the QEMU TCG to enable
> counting instructions the VM crashes with the following error report when
> Linux runs on it:
> 
> qemu-system-ppc64: Bad icount read
> 
> This happens because read/write access to the SPRs PURR, VTB, and TBU40
> is not integrated to the icount framework.
> 
> This commit fixes that issue by making the read/write access of these
> SPRs aware of icount framework, adding the proper gen_io_start() calls
> before calling the helpers to load/store these SPRs in TCG and ensuring
> that the associated TBs end immediately after, accordingly to what's in
> docs/devel/tcg-icount.rst.
> 
> Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>
> ---
>  target/ppc/translate_init.inc.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

