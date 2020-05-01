Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9178DC35280
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E83206F0
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcFj7h3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E83206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUbVn-0001dt-Im
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUbUf-00008b-RC
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUbQA-00014I-LW
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:38:41 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUbQA-00012k-4X
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:34:02 -0400
Received: by mail-wr1-x42d.google.com with SMTP id g13so12627508wrb.8
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iI8uNwoxupS2UdWEUpXgZmj3PzGoIzxWPdUtyV5DeXE=;
 b=IcFj7h3yllFXf0RJONPsIv2IV6Bh5XJGGR4z9N6xKHwyzFmNPX+fmJYOiDjV7JMYlD
 5QgxHl2h1S56fo/cuB+Fi4VPWj9j+g+n8TZiKUJMu7E+zxKzqCUeNnccqWeU7Ccb3V0F
 Cj5nycOmdOFjH0b9AqQwOGZFRRV+6SpWXw7Pj3gibA0AfB2Kw01ew/ZV4uwBQhp4075s
 AG1FcG62ayWmo1PHS/3VB9OX2aBhcRGtj0dSYp6Ao543PmWEBEIUIIjlyBcbWkVndvqb
 6Z3kwk8eexYEVMdgzcL+can/6Mr14n1d76g8WjOfVGGKRcUPOVCiHL/IwSRg7DYtB906
 M2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iI8uNwoxupS2UdWEUpXgZmj3PzGoIzxWPdUtyV5DeXE=;
 b=N2gzhpd4HrZeFQQBZGaAD0Wtpq/Ygyh/fhco697MucuQlerxCh1+aHDCecl5nWxGhy
 +7B6J8NO3oW+S0ABqC5GqPqHDUgsgn3maTl5E57ZYQg2QG7pl8CxlV528ny4SgTtt6Sz
 pTZvj0KNBFUVkiZlk2Lf7NSy7H1MqTviRIHBr0WlkYGLgrPHlweyqhoBQAVvTdBaXE+6
 +RF+hQ8Rdxn5cl5m1vC24x8lHaYQ+yPZKX2wqLt6hpFbJzBF5UAOwY+VWFx5Zy/ez6gf
 Eln3GqPstjCTyIKaMxT1wxzUAep1WN1h5jRWUery16AKxz5AYaCu+Y2YYgKjm7lwcCYo
 M4dg==
X-Gm-Message-State: AGi0PuZqHuPaiajrpy8zpFtsWJctiOCO1a2J46A1+6+y4Tl3PsTTH/hP
 cTOszxyX666T905pFGQ3bNRBlA==
X-Google-Smtp-Source: APiQypJg/bphgreX2vnXa/qOQWnxW4VD6Fy3kMLL3lUPYl+ZhNwAh6FhG/EIcP5ITJmnH4ClG88NfQ==
X-Received: by 2002:a5d:6582:: with SMTP id q2mr5681826wru.343.1588361640271; 
 Fri, 01 May 2020 12:34:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y11sm4288641wrh.59.2020.05.01.12.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 12:33:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 534C81FF7E;
 Fri,  1 May 2020 20:33:58 +0100 (BST)
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
 <d84e50f5-493e-7c8a-bf39-c94c18875171@linaro.org>
 <CAE2XoE9Q-0S_SDA-vV7desU8or_D8wPAkz30xQ_4TGfpXO=D3w@mail.gmail.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: About hardfloat in ppc
In-reply-to: <CAE2XoE9Q-0S_SDA-vV7desU8or_D8wPAkz30xQ_4TGfpXO=D3w@mail.gmail.com>
Date: Fri, 01 May 2020 20:33:58 +0100
Message-ID: <877dxvih5l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> On Fri, May 1, 2020 at 10:18 PM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 5/1/20 6:10 AM, Alex Benn=C3=A9e wrote:
>> >
>> > =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writ=
es:
>> >
>> >> On Fri, May 1, 2020 at 7:58 PM BALATON Zoltan <balaton@eik.bme.hu>
>> wrote:
>> >>
>> >>> On Fri, 1 May 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>> >>>> That's what I suggested,
>> >>>> We preserve a  float computing cache
>> >>>> typedef struct FpRecord {
>> >>>>  uint8_t op;
>> >>>>  float32 A;
>> >>>>  float32 B;
>> >>>> }  FpRecord;
>> >>>> FpRecord fp_cache[1024];
>> >>>> int fp_cache_length;
>> >>>> uint32_t fp_exceptions;
>> >>>>
>> >>>> 1. For each new fp operation we push it to the  fp_cache,
>> >>>> 2. Once we read the fp_exceptions , then we re-compute
>> >>>> the fp_exceptions by re-running the fp FpRecord sequence.
>> >>>> and clear  fp_cache_length.
>> >>>
>> >>> Why do you need to store more than the last fp op? The cumulative bi=
ts
>> can
>> >>> be tracked like it's done for other targets by not clearing fp_status
>> then
>> >>> you can read it from there. Only the non-sticky FI bit needs to be
>> >>> computed but that's only determined by the last op so it's enough to
>> >>> remember that and run that with softfloat (or even hardfloat after
>> >>> clearing status but softfloat may be faster for this) to get the bits
>> for
>> >>> last op when status is read.
>> >>>
>> >> Yeap, store only the last fp op is also an option. Do you means that
>> store
>> >> the last fp op,
>> >> and calculate it when necessary?  I am thinking about a general fp
>> >> optmize method that suite
>> >> for all target.
>> >
>> > I think that's getting a little ahead of yourself. Let's prove the
>> > technique is valuable for PPC (given it has the most to gain). We can
>> > always generalise later if it's worthwhile.
>>
>> Indeed.
>>
>> > Rather than creating a new structure I would suggest creating 3 new tcg
>> > globals (op, inA, inB) and re-factor the front-end code so each FP op
>> > loaded the TCG globals. The TCG optimizer should pick up aliased loads
>> > and automatically eliminate the dead ones. We might need some new
>> > machinery for the TCG to avoid spilling the values over potentially
>> > faulting loads/stores but that is likely a phase 2 problem.
>>
>> There's no point in new tcg globals.
>>
>> Every fp operation can raise an exception, and therefore every fp operat=
ion
>> will flush tcg globals to memory.  Therefore there is no optimization to=
 be
>> done at the tcg opcode level.
>>
>> However, every fp operation calls a helper function, and the quickest
>> thing to
>> do is store the inputs to env->(op, inA, inB, inC) in the helper before
>> performing the operation.
>>
> I thinks there is a possibility to add the tcg ops to optimize the floati=
ng
> point; For example
> WebAssembly doesn't support for float point exception and fp round mode at
> all, I suppose most fp execution are no need care about
>  round mode  and fp expcetion, and for this path we can use tcg-op to
> abstract it,
> and for all other condition we can downgrading to soft-float. As a final
> path to optmize to fp accel of
> QEMU, we can split the tcg-op into two path. one is hard-float with result
> cache for lazy fp flags calculating
> And one is pure soft-float path.

We have talked about adding support for floating point TCG ops in the
past but I think we would need to be a fair bit farther down the road
before we can attempt that. The overhead of the helper call is
relatively minimal compared to that of the executing the operation
itself. As you can see from all the various front end wrappings around
the softfloat code there is a fair amount of implementation details
you'd need to abstract away into the TCG generation code to make it
useful for all our guests.

> For lazy fp flags calculating, cause we have stick flags
> ```
>     float_flag_invalid   =3D  1,
>     float_flag_divbyzero =3D  4,
>     float_flag_overflow  =3D  8,
>     float_flag_underflow =3D 16,
>     float_flag_inexact   =3D 32,
> ```
> We can skip the calculation of these flags when these flags are already
> marked to 1.
> For these five flags, we can split to 5 calculating function, One function
> only check one of the flags.
> And once the flags are set to 1, then we won't call the functon any more,
> unless the flag are cleared.
> We will reduce a lot of branch prediction. And the function would only be
> called when the
> fp flags are requested.
> This is my final goal to optimize fp in QEMU, before that, we can do
> simpler things to optimize fp in QEMU
>
> And besides these type of optimization, we can also offloading the fp
> exception calculating to other CPU core, so
> we can making single threading performance be better, cause single core
> performance are hard to improve, but multiple core
> system are more and more used in these days, for Ryzen 2/ Threadripper we
> even have 64-core /128 threads.

I would take some convincing that offloading exception calculation to
another thread would make a difference - surely there would be
inter-thread syncing required? Our main approach to threading has been
trying to improve scalability for softmmu so we can emulate more vCPUs
in the system.

>
>
>
>>
>> > Next you will want to find places that care about the per-op bits of
>> > cpu_fpscr and call a helper with the new globals to re-run the
>> > computation and feed the values in.
>>
>> Before we even get to this deferred fp operation thing, there are several
>> giant
>> improvements to ppc emulation that can be made:
>>
>> Step 1 is to rearrange the fp helpers to eliminate helper_reset_fpstatus=
().
>> I've mentioned this before, that it's possible to leave the steady-state=
 of
>> env->fp_status.exception_flags =3D=3D 0, so there's no need for a separa=
te
>> function
>> call.  I suspect this is worth a decent speedup by itself.
>>
> I would like to start the fp optimize from here.
>
>
>>
>> Step 2 is to notice when all fp exceptions are masked, so that no
>> exception can
>> be raised, and set a tb_flags bit.  This is the default fp environment t=
hat
>> libc enables and therefore extremely common.
>>
>> Currently, ppc has 3 helpers called per fp operation.  If step 1 is hand=
led
>> correctly, then we're down to 2 fp helpers per fp operation.  If no
>> exceptions
>> need raising, then we can perform the entire operation with a single
>> function call.
>>
>> We would require a parallel set of fp helpers that (1) performs the
>> operation
>> and (2) does any post-processing of the exception bits straight away, but
>> (3)
>> without raising any exceptions.  Sort of like helper_fadd +
>> do_float_check_status, but less.  IIRC the only real extra work is
>> categorizing
>> invalid exceptions.  We could even plausibly extend softfloat to do that
>> while
>> it is recording the invalid exception.
>>
>> Step 3 is to improve softfloat.c with Yonggang Luo's idea to compute
>> inexact
>> from the inverse hardfloat operation.  This would let us relax the
>> restriction
>> of only using hardfloat when we have already have an accrued inexact
>> exception.
>>
>> Only after all of these are done is it worth experimenting with caching =
the
>> last fp operation.
>>
>>
>> r~
>>


--=20
Alex Benn=C3=A9e

