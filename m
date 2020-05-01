Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CF6C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 20:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910B52166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 20:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEO7mcLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910B52166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUcPK-0000nd-Iq
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 16:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUcOG-0008A9-JL
 for qemu-devel@nongnu.org; Fri, 01 May 2020 16:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUcOD-000894-0j
 for qemu-devel@nongnu.org; Fri, 01 May 2020 16:36:08 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:54500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUcOC-00080D-FB
 for qemu-devel@nongnu.org; Fri, 01 May 2020 16:36:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id y6so348994pjc.4
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 13:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/fVDaFXjrB25feDhWDJprPdbGiyblYbXb+/Ys0qYGnM=;
 b=LEO7mcLvmcQLpCkIHSj7lJw29+Dkub4tarlYCbJjJlTXQTOO/TlS7sGLog/LYyqQBl
 4VC5N82KzFDkk3o/XLMFZsBnP/SWlpo2C2wFU6UsCGopaI++N+0uGx5P1o3Oq+Jo80CR
 ZwYHfqqMk+fxbhAGPpd8QCb9wLFLxjqym5HrWyWD81daEdBKmoufm39XXSgA+IbBdU9+
 eeFCaZ5vGOM2e3YhjrDPUD0LejiIHXF7GECqmaRwy8+2RH0FncJXEfYbxUGDoDOhQTL7
 96xNSWxPw00n4OgW4eYQtW/ijbmDm/yYjPOv9Tw7OKBsfsk4cubnk0vJ6aW7WeefxmsL
 S7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/fVDaFXjrB25feDhWDJprPdbGiyblYbXb+/Ys0qYGnM=;
 b=Sq9IER9FJninSrxlTuE0NxauMdYN5IoHk9xxk67ne1XUrcMRXAtBQgYSjWGM/3GN29
 ihcUJZBAXvTrRM3Vv5CjuiqClUtee7pCoPFUezMORFy5gShs0P0wU6/BheIsACrOq1fL
 vN+9cuQoJFlOU3C71U67Cy7G28SSt6OgTBVAoGR+4WyagCicVfQLaVEZpnMghESL6L81
 c6FFkOu4pBi0LdoocOhMMfYIG2CRE5saYzt20tLuIMl4nRwAgcG6g4z2kOkSq6LxiVjq
 VzGd0gKTxyoPr+ljKErpI6cdm10UuSm4NopOqyCeD1jMOdeLTbqSLXfnTAZe/qPRhCe9
 t+CQ==
X-Gm-Message-State: AGi0PuZnvxfGRuFRKzqw3uwu6f4gD5Os67NrJgo9R7whvxUEXh4EIGvU
 YWwnUUv3bFZKpctY5G+UTruGoA==
X-Google-Smtp-Source: APiQypLY3AX5vAZw2kaOswKrOKrgGd4asPWzF/8RVJ4mTpD3Yk6/mRkS6i8Z7DbCjLa1pPK+2FK4wQ==
X-Received: by 2002:a17:90a:24a7:: with SMTP id
 i36mr1740013pje.32.1588365359927; 
 Fri, 01 May 2020 13:35:59 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id gl4sm434821pjb.42.2020.05.01.13.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 13:35:59 -0700 (PDT)
Subject: Re: About hardfloat in ppc
To: luoyonggang@gmail.com
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87sggmjgit.fsf@linaro.org>
 <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
 <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
 <CAE2XoE-f_rkcnpQO1cHPUgdaWNAOvBRyUX1aj27UePd0Hkr=KQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2004301721420.29315@zero.eik.bme.hu>
 <AM4PR07MB3506C091776962655FCE11E9CAAA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <FEA0FBA9-F5B7-4995-A2F3-5D8053637379@gmail.com>
 <CAE2XoE_N_oWJwwGVfh+9mOh3dYR6JXk5XJKzv8fr2A4iE9h1OA@mail.gmail.com>
 <alpine.BSF.2.22.395.2005011347390.29385@zero.eik.bme.hu>
 <CAE2XoE-0=SgjeXddZXDOYPeUC1xsD5V=A5xBoa1yHS8gL2=MQg@mail.gmail.com>
 <874kszkdhm.fsf@linaro.org> <d84e50f5-493e-7c8a-bf39-c94c18875171@linaro.org>
 <CAE2XoE-W=v5ifho_ze3Xg2Fx1v+VtQ_KvWSf7AuXns5ZYoRoTg@mail.gmail.com>
 <851c309c-37f2-ea4a-b471-52bddde527c7@linaro.org>
 <CAE2XoE-sSkTf4c0-C3KeMG+B_8MNXJ=+im3E1tuW-z9ffTNshQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c06227ff-f447-bb83-9360-8bef78393ea8@linaro.org>
Date: Fri, 1 May 2020 13:35:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE-sSkTf4c0-C3KeMG+B_8MNXJ=+im3E1tuW-z9ffTNshQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1032
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
Cc: Dino Papararo <skizzato73@msn.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 10:49 AM, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Sat, May 2, 2020 at 12:51 AM Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 5/1/20 9:29 AM, 罗勇刚(Yonggang Luo) wrote:
>     > On Fri, May 1, 2020 at 10:18 PM Richard Henderson
>     <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>
>     >     Step 1 is to rearrange the fp helpers to eliminate
>     helper_reset_fpstatus().
>     >     I've mentioned this before, that it's possible to leave the
>     steady-state of
>     >     env->fp_status.exception_flags == 0, so there's no need for a
>     separate function
>     >     call.  I suspect this is worth a decent speedup by itself.
>     >
>     > Hi Richard, what kinds of rearrange the fp need to be done? Can you give me a
>     > more detailed example? I am still not get the idea.
> 
>     See target/openrisc, helper_update_fpcsr.
> 
>     This is like target/ppc helper_float_check_status, in that it is called after
>     the primary fpu helper, after the fpu result is written back to the
>     architectural register, to process fpu exceptions.
> 
>     Note that if get_float_exception_flags returns non-zero, we immediately reset
>     them to zero.  Thus the exception flags are only ever non-zero in between the
>     primary fpu operation and the update of the fpscr.
> 
> According to 
> ```
> void HELPER(update_fpcsr)(CPUOpenRISCState *env)
> {
>     int tmp = get_float_exception_flags(&env->fp_status);
> 
>     if (tmp) {
>         set_float_exception_flags(0, &env->fp_status);
>         tmp = ieee_ex_to_openrisc(tmp);
>         if (tmp) {
>             env->fpcsr |= tmp;
>             if (env->fpcsr & FPCSR_FPEE) {
>                 helper_exception(env, EXCP_FPE);
>             }
>         }
>     }
> }
> ```
> The openrisc also clearing the flags before each fp operation?

No.  Please re-read my description above.

OpenRISC is clearing the flags *after* each fp operation, at the same time that
it processes the flags from the current fp operation.

There are two calls at runtime for openrisc, e.g. do_fp2:

    fn(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->a));
    gen_helper_update_fpcsr(cpu_env);

Whereas for ppc there are between 2 and 5 calls at runtime, e.g. in _GEN_FLOAT_ACB:

>     gen_reset_fpstatus();                           [1]
>     get_fpr(t0, rA(ctx->opcode));                   
>     get_fpr(t1, rC(ctx->opcode));                   
>     get_fpr(t2, rB(ctx->opcode));                   
>     gen_helper_f##op(t3, cpu_env, t0, t1, t2);      [2]
>     if (isfloat) {                                  
>         gen_helper_frsp(t3, cpu_env, t3);           [3]
>     }                                               
>     set_fpr(rD(ctx->opcode), t3);                   
>     if (set_fprf) {                                 
>         gen_compute_fprf_float64(t3);               [4]
>     }                                               
>     if (unlikely(Rc(ctx->opcode) != 0)) {           
>         gen_set_cr1_from_fpscr(ctx);                [5]
>     }                                               

For step 1, we're talking about removing the call to gen_reset_fpstatus.

It might be worth adding a debugging check to the beginning of each helper of
the form [2] to assert that the exception flags are in fact zero.  This check
might be removed later, in relation to future improvements, but it can help
ensure that the value of set_fprf is correct, and validate that step 1 isn't
breaking anything.


r~

