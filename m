Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92460C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DB22080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SM3zMMvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DB22080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm3wk-0006VG-J8
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 19:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm3w8-0005zT-Ds
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:27:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm3w6-0000PO-OU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:27:12 -0400
Received: by mail-pf1-x443.google.com with SMTP id 64so3541463pfv.11
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=JdXUoNo/3Ew0R0tJFilMe806eXL0Sv3NfxTC4ikA1ec=;
 b=SM3zMMvfP9xqxJqZlX+Gy2xPC8+Z3Bje3Rx2r1tEq9JcttOhgImZ+e05/uCQyWqz5O
 jb3t5w4/4hE/x/jN0wOjPOKyo8YQnKJmWYJqpPrJcsVmcZQbxJ2bYMphD9N4XUPkTNxk
 hwKVL4eQc224fHD267FwUYANG2BnRr0/b1MusqAMjy8CLATQ95yrhKqYR65KvVCgnMVR
 KfdBdbyc0lx8j5wdWCKO9H7KfvakiKxkLgZCFD6ifvo3A9m/tEwaOI70FAZPoCddvOwc
 f2S9/PXdQqtcjMIRPsLbhvsnoh4sEQSY8VRtfZ1AWX0R79gJ4bRUQScIDI9EREROEJZw
 tQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JdXUoNo/3Ew0R0tJFilMe806eXL0Sv3NfxTC4ikA1ec=;
 b=heTIwD4WhsRAFnd2C1zxAPGaJMAdv4f/2ZMGp4zn2fLSK+VqlHFURyvo626LVMBrLO
 nsajafCTbCel8L3A2TPdwUE5WQ2ZkQcDEYu9x4rWY359CKqRVnGIMA8fMMATE7gXmiHg
 9mhYq8b1L/+T+pIGlV6r9ZLEDEhSUCpsaitB0acZz3WTw0egqwyu5bQ496aCJbx2wOjT
 aiOqJaZRiFlwkqpNySQqXmfxSfFyYuI0fYrocHcRtJJ1jQ84LbggledlOb+Rzkc7mb5G
 u/ZArxwBNwb5cAt+jxRxAaRSKQjtHpHZqPt29U9JOqiyIywCqV7QWdAzxysJwwLGvKJU
 zR4A==
X-Gm-Message-State: AOAM530rxuqbEbnuM0Rf91YHi+yQFlfXaAAD0ZkUeEWw9anurCcMm1Wv
 XhIlLyObb/bi69Wif09A+VMcnj6n4ms=
X-Google-Smtp-Source: ABdhPJydXRRH0Se3se97ikqdmg7jv7sPQvHcjKZm0BS7xm4sNHV3JB6ePKeJhufB6qQhtZjK9V/59A==
X-Received: by 2002:a62:5c85:: with SMTP id q127mr5434197pfb.311.1592522829054; 
 Thu, 18 Jun 2020 16:27:09 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id f23sm3430365pja.8.2020.06.18.16.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 16:27:08 -0700 (PDT)
Subject: Re: [PATCH 2/6] target/ppc: add vmulld instruction
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-3-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4341c9e1-162f-d640-e733-d69d2f894353@linaro.org>
Date: Thu, 18 Jun 2020 16:27:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200613042029.22321-3-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 9:20 PM, Lijun Pan wrote:
> vmulld: Vector Multiply Low Doubleword.
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
>  target/ppc/helper.h                 | 1 +
>  target/ppc/int_helper.c             | 1 +
>  target/ppc/translate/vmx-impl.inc.c | 1 +
>  target/ppc/translate/vmx-ops.inc.c  | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 2dfa1c6942..c3f087ccb3 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -185,6 +185,7 @@ DEF_HELPER_3(vmuloub, void, avr, avr, avr)
>  DEF_HELPER_3(vmulouh, void, avr, avr, avr)
>  DEF_HELPER_3(vmulouw, void, avr, avr, avr)
>  DEF_HELPER_3(vmuluwm, void, avr, avr, avr)
> +DEF_HELPER_3(vmulld, void, avr, avr, avr)
>  DEF_HELPER_3(vslo, void, avr, avr, avr)
>  DEF_HELPER_3(vsro, void, avr, avr, avr)
>  DEF_HELPER_3(vsrv, void, avr, avr, avr)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index be53cd6f68..afbcdd05b4 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -533,6 +533,7 @@ void helper_vprtybq(ppc_avr_t *r, ppc_avr_t *b)
>          }                                                               \
>      }
>  VARITH_DO(muluwm, *, u32)
> +VARITH_DO(mulld, *, s64)

>From this implementation, I would say that both vmuluwm and vmulld can be
implemented with tcg_gen_gvec_mul().

I guess vmuluwm was missed when many of the other vmx operations were converted
to gvec.

Please first convert vmuluwm to tcg_gen_gvec_mul, then implement vmulld in the
same manner.


r~

