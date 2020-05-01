Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6B8C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4936C20757
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EYnibef9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4936C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWZG-00018j-Ft
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWYA-00086P-11
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWV5-0002I3-AA
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:21:57 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:40728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUWV4-0002Hg-TY
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:18:46 -0400
Received: by mail-pg1-x530.google.com with SMTP id n16so4612728pgb.7
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ejEHBn71IHHor/hnSMxhGvJvic5y+N+sgCgrlPnIcXE=;
 b=EYnibef9GRYeq+AHA7rFH11trUjUSxtUscR6gAxPkGRkYYNqp9CCjdgzr9bOhxWn3x
 DCT2Ai9zN7XS26VZphnW7f8tT0oeP5vm3peXqiEpbOZ6LSYTu0sticNGPtyNeUGRrvg+
 E/ZnuC7RI0y4sAGfgftlSNojFf5OD0ECnbrziKj5SXmRY/vysWWecvRFjVmanw7Gw0Jg
 xzc4R/SxIuHYl7MmwlDq/XVvgl5lykIP2fGzrowdVMNmBy1fPsSb5EDEAlS8KR8d6jUB
 K9ABvVb9NxxiJa4eeVg+dIAj5KB8xkzRfVNluAl7sY/BSKLpgrAhbDAZEYAa8fN5WZ8Y
 RFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ejEHBn71IHHor/hnSMxhGvJvic5y+N+sgCgrlPnIcXE=;
 b=UdHi7lBp6vHio2FeqMrPGcMAFOgz5gcNpJbvIilwoyjapIlrwTr8+I/nCaxyM4mk0j
 BB5gqOuG9HbXQclMrO41cMXIJO9UMcdlv3Lfc/11dmSSKxczkf4sVEpWqsP41hu2ex8y
 +QO/0PNDyUPAct1741eNNwFALsOYVDrownvrLg3YD4nRPMTHITv1gd4DgmU9t3AqGktu
 +2yXLMy0Hwgmh7VkQ2HaZyDDrRjUWCu5qnbXmRbi/qQ8RLiU3TyrAaXD8Ua8elOBJRLM
 TjE0Z8ywXzcugbVi6tZroEWp9mGENE8/JRJRRlxFGYgmDlllMckIQITg816UzRrHVTfy
 aD6g==
X-Gm-Message-State: AGi0PuaIiA/i3o7cYQHAy4wfAAiA4YYa2wjgTo6SvxwbXsIVtb+nklBW
 2yIOYRfbrXxQVuJ1iXIyo9WnEw==
X-Google-Smtp-Source: APiQypKk+O8qYzk9wuEyPh8FKAE8I6Eh2c0rge/7TX5kbLJ4uOrrFKacPZ+lLLu4Lecn4r0HURlHyQ==
X-Received: by 2002:a63:1210:: with SMTP id h16mr4267881pgl.328.1588342724953; 
 Fri, 01 May 2020 07:18:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h14sm2460771pfq.46.2020.05.01.07.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 07:18:44 -0700 (PDT)
Subject: Re: About hardfloat in ppc
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 luoyonggang@gmail.com
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
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
 <874kszkdhm.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d84e50f5-493e-7c8a-bf39-c94c18875171@linaro.org>
Date: Fri, 1 May 2020 07:18:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <874kszkdhm.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::530
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 6:10 AM, Alex Bennée wrote:
> 
> 罗勇刚(Yonggang Luo) <luoyonggang@gmail.com> writes:
> 
>> On Fri, May 1, 2020 at 7:58 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>>> On Fri, 1 May 2020, 罗勇刚(Yonggang Luo) wrote:
>>>> That's what I suggested,
>>>> We preserve a  float computing cache
>>>> typedef struct FpRecord {
>>>>  uint8_t op;
>>>>  float32 A;
>>>>  float32 B;
>>>> }  FpRecord;
>>>> FpRecord fp_cache[1024];
>>>> int fp_cache_length;
>>>> uint32_t fp_exceptions;
>>>>
>>>> 1. For each new fp operation we push it to the  fp_cache,
>>>> 2. Once we read the fp_exceptions , then we re-compute
>>>> the fp_exceptions by re-running the fp FpRecord sequence.
>>>> and clear  fp_cache_length.
>>>
>>> Why do you need to store more than the last fp op? The cumulative bits can
>>> be tracked like it's done for other targets by not clearing fp_status then
>>> you can read it from there. Only the non-sticky FI bit needs to be
>>> computed but that's only determined by the last op so it's enough to
>>> remember that and run that with softfloat (or even hardfloat after
>>> clearing status but softfloat may be faster for this) to get the bits for
>>> last op when status is read.
>>>
>> Yeap, store only the last fp op is also an option. Do you means that store
>> the last fp op,
>> and calculate it when necessary?  I am thinking about a general fp
>> optmize method that suite
>> for all target.
> 
> I think that's getting a little ahead of yourself. Let's prove the
> technique is valuable for PPC (given it has the most to gain). We can
> always generalise later if it's worthwhile.

Indeed.

> Rather than creating a new structure I would suggest creating 3 new tcg
> globals (op, inA, inB) and re-factor the front-end code so each FP op
> loaded the TCG globals. The TCG optimizer should pick up aliased loads
> and automatically eliminate the dead ones. We might need some new
> machinery for the TCG to avoid spilling the values over potentially
> faulting loads/stores but that is likely a phase 2 problem. 

There's no point in new tcg globals.

Every fp operation can raise an exception, and therefore every fp operation
will flush tcg globals to memory.  Therefore there is no optimization to be
done at the tcg opcode level.

However, every fp operation calls a helper function, and the quickest thing to
do is store the inputs to env->(op, inA, inB, inC) in the helper before
performing the operation.


> Next you will want to find places that care about the per-op bits of
> cpu_fpscr and call a helper with the new globals to re-run the
> computation and feed the values in.

Before we even get to this deferred fp operation thing, there are several giant
improvements to ppc emulation that can be made:

Step 1 is to rearrange the fp helpers to eliminate helper_reset_fpstatus().
I've mentioned this before, that it's possible to leave the steady-state of
env->fp_status.exception_flags == 0, so there's no need for a separate function
call.  I suspect this is worth a decent speedup by itself.

Step 2 is to notice when all fp exceptions are masked, so that no exception can
be raised, and set a tb_flags bit.  This is the default fp environment that
libc enables and therefore extremely common.

Currently, ppc has 3 helpers called per fp operation.  If step 1 is handled
correctly, then we're down to 2 fp helpers per fp operation.  If no exceptions
need raising, then we can perform the entire operation with a single function call.

We would require a parallel set of fp helpers that (1) performs the operation
and (2) does any post-processing of the exception bits straight away, but (3)
without raising any exceptions.  Sort of like helper_fadd +
do_float_check_status, but less.  IIRC the only real extra work is categorizing
invalid exceptions.  We could even plausibly extend softfloat to do that while
it is recording the invalid exception.

Step 3 is to improve softfloat.c with Yonggang Luo's idea to compute inexact
from the inverse hardfloat operation.  This would let us relax the restriction
of only using hardfloat when we have already have an accrued inexact exception.

Only after all of these are done is it worth experimenting with caching the
last fp operation.


r~

