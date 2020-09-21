Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E172CC4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A542193E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgAMDHh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A542193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRxo-0003GO-7x
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKRsh-0007tR-Hx
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:53:47 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKRsd-0001Fp-Kr
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:53:47 -0400
Received: by mail-pf1-x441.google.com with SMTP id z19so10198495pfn.8
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xrKLlzI8aJhsK8iwSgACbP42nRb4osGQVIu3769c4B8=;
 b=vgAMDHh7xuVq+PTmd0eEc/4pOjnsVmAvWO/Sf9r2NXupQkPuSrOJwVTtlgQaPkDOjE
 5blYp2ltj28/LdARMVAKiddWieZynnXQIzmueY85JahElvip6ETg76xRD4DwUnj3YE1c
 Q1RDt7VNWekj92IE0ULw9CL+K5lGl1W21jL8LccxsQcGwQdE1T4WhUYWFLiyziRbCnx7
 pMKd+ZAWZ3f69U5NadHV0e+yssRrV/CNK1NBwFvznyspk+l4jgP5PBrFEWTGIGiwFyLo
 vjc1TqYnXwdQxcQxncZUXKL7s53E1D0bN86+l9eccIhRtPzRt1JUA/fBWpm1bMMZ24i6
 o2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xrKLlzI8aJhsK8iwSgACbP42nRb4osGQVIu3769c4B8=;
 b=V8QMUy4FFQxUYTaop1Nv/4maA43947K3RWtqVPMAFjaPZJYehPo6MU8xpltxn4eVJP
 66/Hp/fmc3Du8ZIk+Gk6PEJYanPC8gd84xid3fQo0y2y5kt06rqXF0RSdBKe5G/1UA0A
 tuz6I2DgZU1670CsqwOS2tggaycCMmbou85nfC9MGbghrBdvD6rBa6ikAMq+FMkN/kQB
 u1Ff03/o0+srEMQBLPrACAMFlX0ajvi5QWa421HHRUVrkWXu4fQNsVvx7fk7lp/bShPq
 /uivrOFgy+YF8P+9Mat/iQwDVZ4hfsOyyoLVqWCBWQnu7KDXfONz4UG1U74cOGPyoM5k
 SfKw==
X-Gm-Message-State: AOAM53298TFPyIFM9NzaiMIMRDaJ9fjwjLYe0dSdFAqaRrLvaCBgwd2a
 R1VVjL1jn/+wxq6PzlkJp+3hDA==
X-Google-Smtp-Source: ABdhPJxpmBfzRZaAZrgDM1OObJT7uYaSNd/QRbqk6ZUyRhStJSlGwthuqRVdn/VsZ8rbgqtDJ1kMtA==
X-Received: by 2002:a17:902:aa8c:b029:d2:11a4:8612 with SMTP id
 d12-20020a170902aa8cb02900d211a48612mr1366226plr.3.1600718022062; 
 Mon, 21 Sep 2020 12:53:42 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ep4sm264054pjb.39.2020.09.21.12.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 12:53:41 -0700 (PDT)
Subject: Re: [PATCH v4 04/11] disas: Move host asm annotations to tb_gen_code
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-5-richard.henderson@linaro.org>
 <87d02fnd1y.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8e1ac018-dac8-b049-aae3-059f86698f3a@linaro.org>
Date: Mon, 21 Sep 2020 12:53:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87d02fnd1y.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 12:29 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Instead of creating GStrings and passing them into log_disas,
>> just print the annotations directly in tb_gen_code.
>>
>> Fix the annotations for the slow paths of the TB, after the
>> part implementing the final guest instruction.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I guess what we loose in the inline annotation we gain in simpler code.
> We can always grep stuff out of the logs if we need to:

What information do you think we're losing?


r~

