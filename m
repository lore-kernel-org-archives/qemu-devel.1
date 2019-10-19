Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7FBCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 20:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94004222BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 20:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQwQu1sX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94004222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLvCq-0008NX-H0
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 16:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iLvC7-0007o0-0A
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 16:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iLvC5-0008P8-2A
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 16:19:22 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iLvC4-0008OO-Ri
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 16:19:21 -0400
Received: by mail-qt1-x842.google.com with SMTP id c17so11406745qtn.8
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PZQzluOVyJEmST9imR48/KfTg9g7jiJlKgC/pSKQi0s=;
 b=sQwQu1sXFYSROZXoB4SXYGr/OiT5JwHmO5R1umygvd8MZUYsEIxL2Ek1lxd14VHbZX
 EiI6ggfwi5O17yxRW85cmqOEbIn3ksWdbs8xFXWsJoC913wcowIhlC32d3FD/XqqaQNf
 8HyQ/GV5vpHVDrrWloWpsARpxeIsKmLynnClbQ4yfmdR/mI48eWiPKxOFYOOyinKAYr8
 5UNBpfr7l0FNzh9dOq1WoT7o/yIB2dfNkzL+UK2lw9FhMuQDKz4uBzkZ6eNdsNWcIMvV
 9yMf3eR40nxxXQgUq2D3nJGLUV6t9+xIB3gxCo6u+okLGegjHONNLquJ4790JD/2yu4w
 SBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PZQzluOVyJEmST9imR48/KfTg9g7jiJlKgC/pSKQi0s=;
 b=UzO1Jy+duh+c4S3fnS9K7Ohut6RBHb9IRtM8UcVarxITinkfddWhA2y7FNFpWL3GNH
 /9Nxhv5AlEJA2yzCX35VhCh8shmIpGWK974UXHl8GyMC8YV9HRa3i3Z/C7RjWV2QKtML
 sjHCoicYgFnC7r4GAjx9dklZYQxWgXc4UXnroljYXnMKBNcRU90CmjSGHNAKK9KFvVA/
 yfXFwBRAMLHRm5u3K4t0Pv9kYwPs13YcRBP/PW5ZjAS0pa3yhhirvyHOdlUHpjr84q7r
 HRh0Hc0UvQRk4Ohh4oB+SFPK33Cojv8oRIa3Q+W8Os7NOrduY+kNapN/VgN1NN0iSWCU
 k8pg==
X-Gm-Message-State: APjAAAXwV75USJjmjRztKRCL9TI5Q9yUskgu7/I5mvEYodM8nEDUyJHT
 mA9uFlIgN1zV+3vRpaVvixXntWnCu2PE12YUgP3rTg==
X-Google-Smtp-Source: APXvYqxxCOUTn/Ejip7pVpv7PpEl3tz6rx5UVUTXBKrekCuRbpyNuSiUDABzwLBKACsOtw0+k956GW3VU53c0Q7r86M=
X-Received: by 2002:ac8:3f66:: with SMTP id w35mr16729411qtk.382.1571516358653; 
 Sat, 19 Oct 2019 13:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191014161843.84845-1-mrolnik@gmail.com>
 <20191014161843.84845-5-mrolnik@gmail.com>
 <CAL1e-=g9ER4tuqEL2ubqb7oAbatcVR8x+A0LAydSwBJEnk9_ow@mail.gmail.com>
 <CAK4993gm=8tVXyprjHPMiNZuKZRkx0iDYnXh76cQfMwUayqcWQ@mail.gmail.com>
 <CAL1e-=hGJQqVnvAu=ZJRV-AdoAWpkSvdf5ex=b7EwkodUGKpUg@mail.gmail.com>
 <CAK4993jaqFrzcmAyz7neJoq5cQgnB_o35dZhdh9_uVyOfKGG-Q@mail.gmail.com>
 <CAL1e-=ixhb1z8h9f6DrNAuEn69pPaV2qvvd=BvVnFKCdW+XMwg@mail.gmail.com>
 <CAK4993h6p2ZHx7a_JZhP_GE21UjfDmBJoSoBSPSo0pDwRmyK=Q@mail.gmail.com>
 <CAL1e-=gjP5CJ5x-e9MCw5T2-y41KuWD=CiSVecCFB1StsP5nFw@mail.gmail.com>
 <CAK4993j44GK=zyuGbo86Li=7Gt2BrwWuzdLe3rggnOtMPR7f2Q@mail.gmail.com>
 <CAL1e-=g4H84RAX231Gg1+MXMh-YzRV0fuUj4u98QASLJ1xzd=A@mail.gmail.com>
 <CAL1e-=jm=zKZBHuPBzyf2-dh3swKNrzi7fhKwvtfsteZg4cR4Q@mail.gmail.com>
In-Reply-To: <CAL1e-=jm=zKZBHuPBzyf2-dh3swKNrzi7fhKwvtfsteZg4cR4Q@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sat, 19 Oct 2019 23:18:25 +0300
Message-ID: <CAK4993g_J1h8edJtib1s3R4v6TyGkzPyGfOqOHAjT_z4U+K=YQ@mail.gmail.com>
Subject: Re: [PATCH v32 04/13] target/avr: Add instruction translation -
 Registers definition
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 9:08 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Friday, October 18, 2019, Aleksandar Markovic <aleksandar.m.mail@gmail=
.com> wrote:
>>
>>
>>
>> On Friday, October 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>>
>>> On Fri, Oct 18, 2019 at 4:23 PM Aleksandar Markovic
>>> <aleksandar.m.mail@gmail.com> wrote:
>>> >
>>> >
>>> >
>>> > On Friday, October 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote=
:
>>> >>
>>> >>
>>> >>
>>> >> On Fri, Oct 18, 2019 at 11:52 AM Aleksandar Markovic <aleksandar.m.m=
ail@gmail.com> wrote:
>>> >>>
>>> >>>
>>> >>>
>>> >>> On Thursday, October 17, 2019, Michael Rolnik <mrolnik@gmail.com> w=
rote:
>>> >>>>
>>> >>>> On Thu, Oct 17, 2019 at 11:17 PM Aleksandar Markovic
>>> >>>> <aleksandar.m.mail@gmail.com> wrote:
>>> >>>> >>
>>> >>>> >>
>>> >>>> >> >> +static TCGv cpu_Cf;
>>> >>>> >> >> +static TCGv cpu_Zf;
>>> >>>> >> >> +static TCGv cpu_Nf;
>>> >>>> >> >> +static TCGv cpu_Vf;
>>> >>>> >> >> +static TCGv cpu_Sf;
>>> >>>> >> >> +static TCGv cpu_Hf;
>>> >>>> >> >> +static TCGv cpu_Tf;
>>> >>>> >> >> +static TCGv cpu_If;
>>> >>>> >> >> +
>>> >>>> >> >
>>> >>>> >> >
>>> >>>> >> > Hello, Michael,
>>> >>>> >> >
>>> >>>> >> > Is there any particular reason or motivation beyond modelling=
 status register flags as TCGv variables?
>>> >>>> >>
>>> >>>> >>
>>> >>>> >>
>>> >>>> >> I think it's easier this way as I don't need to convert flag va=
lues to
>>> >>>> >> bits or bits to flag values.
>>> >>>> >
>>> >>>> >
>>> >>>> > Ok. But, how do you map 0/1 flag value to the value of a TCGv va=
riable and vice versa? In other words, what value or values (out of 2^32 va=
les) of a TCGv variable mean the flag is 1? And the same question for 0.
>>> >>>> >
>>> >>>> > Is 0110000111000010100 one or zero?
>>> >>>> >
>>> >>>> > Besides, in such arrangement, how do you display the 8-bit statu=
s register in gdb, if at all?
>>> >>>>
>>> >>>> each flag register is either 0 or 1,....
>>> >>>>
>>> >>>>
>>> >>>>
>>> >>>
>>> >>> Michael,
>>> >>>
>>> >>> If this is true, why is there a special handling of two flags in th=
e following code:
>>> >>>
>>> >>>
>>> >>> static inline uint8_t cpu_get_sreg(CPUAVRState *env)
>>> >>> {
>>> >>> uint8_t sreg;
>>> >>> sreg =3D (env->sregC & 0x01) << 0
>>> >>> | (env->sregZ =3D=3D 0 ? 1 : 0) << 1
>>> >>> | (env->sregN) << 2
>>> >>> | (env->sregV) << 3
>>> >>> | (env->sregS) << 4
>>> >>> | (env->sregH) << 5
>>> >>> | (env->sregT) << 6
>>> >>> | (env->sregI) << 7;
>>> >>> return sreg;
>>> >>> }
>>> >>> static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
>>> >>> {
>>> >>> env->sregC =3D (sreg >> 0) & 0x01;
>>> >>> env->sregZ =3D (sreg >> 1) & 0x01 ? 0 : 1;
>>> >>> env->sregN =3D (sreg >> 2) & 0x01;
>>> >>> env->sregV =3D (sreg >> 3) & 0x01;
>>> >>> env->sregS =3D (sreg >> 4) & 0x01;
>>> >>> env->sregH =3D (sreg >> 5) & 0x01;
>>> >>> env->sregT =3D (sreg >> 6) & 0x01;
>>> >>> env->sregI =3D (sreg >> 7) & 0x01;
>>> >>> }
>>> >>>  ?
>>> >>>
>>> >> Aleksandar,
>>> >>
>>> >> If I understand your question correctly cpu_get_sreg assembles SREG =
value to be presented by GDB, and cpu_set_sreg sets flags values when GDB m=
odifies SREG.
>>> >>
>>> >> Michael
>>> >
>>> >
>>> >
>>> >
>>>
>>> Why is handling of sregC and sregZ flags different than handling of oth=
er flags? This contradicts your previos statement that 1 (in TCGv) means 1 =
(flag), and 0 (in TCGv) means 0 (flag)?
>>> >
>>> >
>>> > Whatever is the explanation, ot should be included, in my opinion, in=
 code comments.
>>> >
>>> > Please, Michael, let's first clarify the issue from the question abov=
e.
>>> >
>>> > Thanks, Aleksandar
>>> >
>>> >
>>> there is a comment here
>>> https://github.com/michaelrolnik/qemu-avr/blob/master/target/avr/cpu.h#=
L122-L129
>>> >
>>
>>
>>
>> ...but it does explain WHY of my question.
>
>
> I meant to say  "does not", not "does".
>
> Michael, don't be discouraged by lenghty review process, just be persiste=
nt and available for communication with reviewers.
>
> Sincerely,
> Aleksandar
>
>

Aleksandar,

I will try to explain my reasoning for the current implementation.
1. Many (or even the majority) of instructions modify flags, i.e. the
flags value should be computed regardless whether they are used or
not.
2. SREG as a whole is almost never used except
    a. GDB
    b. IN, OUT, SBI, CBI, SBIC, SBIS instructions as 1 out of 8
possible registers.

So, as we can see flags are calculated more times then they are used.
This leads us to two following conclusions
1. don't maintain SREG as one register but as a set of 8 different register=
s
2. try to minimize number of calculations for these flags

All flags except Z (zero) are calculated fully and kept as one bit
Z just holds the result of last computation, so Z flag is set when
sregZ register is 0 otherwise the flag is not set.
that's why there is difference between Z and others.

so, you are right, there is no need to treat C differently. I will
send an update later.

Thanks.

Michael Rolnik




>>
>>
>> The reason I insist on your explanation is that when we model a cpu or a=
 device in QEMU, a goal is that the model is as close to the hardware as po=
ssible. One may not, for pletora of reasons, succeed in reaching that goal,=
 or, I can imagine, on purpose depart from that goal for some reason - perh=
aps that was the case in your implementation, where you modelled a single 8=
-bit status register with 8 TCGv variables.
>>
>> But, even that way of modelling was done inconsistently across bits of t=
he status register. In that light, I want to know the justification for tha=
t, so repeat my question: Why is handling of sregC and sregZ flags differen=
t than handling of other flags in functions cpu_get_sreg() and cpu_get_sreg=
()? This was not explained in any comment or commit message. And is in cont=
radiction with one of your previous answers.
>>
>> Yours,
>> Aleksandar
>>
>>>
>>> >
>>> >
>>> >>>
>>> >>> Thanks,
>>> >>> A.
>>> >>>>
>>> >>>>
>>> >>>>  they are calculated here
>>> >>>> 1. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/a=
vr/translate.c#L146-L148
>>> >>>> 2. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/a=
vr/translate.c#L166
>>> >>>> 3. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/a=
vr/translate.c#L185-L187
>>> >>>> 4. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/a=
vr/translate.c#L205
>>> >>>> 5. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/a=
vr/translate.c#L214-L215
>>> >>>> 6. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/a=
vr/translate.c#L222-L223
>>> >>>> The COU itself never uses SREG at all, only the flags.
>>> >>>>
>>> >>>> As for the GDB it's get assembled/disassembled here
>>> >>>> 1. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/a=
vr/cpu.h#L219-L243
>>> >>>> 2. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/a=
vr/gdbstub.c#L35-L37
>>> >>>> 3. https://github.com/michaelrolnik/qemu-avr/blob/avr-v32/target/a=
vr/gdbstub.c#L66-L68
>>> >>>>
>>> >>>> >
>>> >>>> > A.
>>> >>>> >
>>> >>>> >>
>>> >>>> >> >
>>> >>>> >> > A.
>>> >>>> >> >
>>> >>>> >> >
>>> >>>> >> >
>>> >>>> >> >>
>>> >>>> >> >> +static TCGv cpu_rampD;
>>> >>>> >> >> +static TCGv cpu_rampX;
>>> >>>> >> >> +static TCGv cpu_rampY;
>>> >>>> >> >> +static TCGv cpu_rampZ;
>>> >>>> >> >> +
>>> >>>> >> >> +static TCGv cpu_r[NO_CPU_REGISTERS];
>>> >>>> >> >> +static TCGv cpu_eind;
>>> >>>> >> >> +static TCGv cpu_sp;
>>> >>>> >> >> +
>>> >>>> >> >> +static TCGv cpu_skip;
>>> >>>> >> >> +
>>> >>>> >> >> +static const char reg_names[NO_CPU_REGISTERS][8] =3D {
>>> >>>> >> >> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
>>> >>>> >> >> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
>>> >>>> >> >> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
>>> >>>> >> >> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
>>> >>>> >> >> +};
>>> >>>> >> >> +#define REG(x) (cpu_r[x])
>>> >>>> >> >> +
>>> >>>> >> >> +enum {
>>> >>>> >> >> +    DISAS_EXIT   =3D DISAS_TARGET_0,  /* We want return to =
the cpu main loop.  */
>>> >>>> >> >> +    DISAS_LOOKUP =3D DISAS_TARGET_1,  /* We have a variable=
 condition exit.  */
>>> >>>> >> >> +    DISAS_CHAIN  =3D DISAS_TARGET_2,  /* We have a single c=
ondition exit.  */
>>> >>>> >> >> +};
>>> >>>> >> >> +
>>> >>>> >> >> +typedef struct DisasContext DisasContext;
>>> >>>> >> >> +
>>> >>>> >> >> +/* This is the state at translation time. */
>>> >>>> >> >> +struct DisasContext {
>>> >>>> >> >> +    TranslationBlock *tb;
>>> >>>> >> >> +
>>> >>>> >> >> +    CPUAVRState *env;
>>> >>>> >> >> +    CPUState *cs;
>>> >>>> >> >> +
>>> >>>> >> >> +    target_long npc;
>>> >>>> >> >> +    uint32_t opcode;
>>> >>>> >> >> +
>>> >>>> >> >> +    /* Routine used to access memory */
>>> >>>> >> >> +    int memidx;
>>> >>>> >> >> +    int bstate;
>>> >>>> >> >> +    int singlestep;
>>> >>>> >> >> +
>>> >>>> >> >> +    TCGv skip_var0;
>>> >>>> >> >> +    TCGv skip_var1;
>>> >>>> >> >> +    TCGCond skip_cond;
>>> >>>> >> >> +    bool free_skip_var0;
>>> >>>> >> >> +};
>>> >>>> >> >> +
>>> >>>> >> >> +static int to_A(DisasContext *ctx, int indx) { return 16 + =
(indx % 16); }
>>> >>>> >> >> +static int to_B(DisasContext *ctx, int indx) { return 16 + =
(indx % 8); }
>>> >>>> >> >> +static int to_C(DisasContext *ctx, int indx) { return 24 + =
(indx % 4) * 2; }
>>> >>>> >> >> +static int to_D(DisasContext *ctx, int indx) { return (indx=
 % 16) * 2; }
>>> >>>> >> >> +
>>> >>>> >> >> +static uint16_t next_word(DisasContext *ctx)
>>> >>>> >> >> +{
>>> >>>> >> >> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
>>> >>>> >> >> +}
>>> >>>> >> >> +
>>> >>>> >> >> +static int append_16(DisasContext *ctx, int x)
>>> >>>> >> >> +{
>>> >>>> >> >> +    return x << 16 | next_word(ctx);
>>> >>>> >> >> +}
>>> >>>> >> >> +
>>> >>>> >> >> +
>>> >>>> >> >> +static bool avr_have_feature(DisasContext *ctx, int feature=
)
>>> >>>> >> >> +{
>>> >>>> >> >> +    if (!avr_feature(ctx->env, feature)) {
>>> >>>> >> >> +        gen_helper_unsupported(cpu_env);
>>> >>>> >> >> +        ctx->bstate =3D DISAS_NORETURN;
>>> >>>> >> >> +        return false;
>>> >>>> >> >> +    }
>>> >>>> >> >> +    return true;
>>> >>>> >> >> +}
>>> >>>> >> >> +
>>> >>>> >> >> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
>>> >>>> >> >> +#include "decode_insn.inc.c"
>>> >>>> >> >> +
>>> >>>> >> >> --
>>> >>>> >> >> 2.17.2 (Apple Git-113)
>>> >>>> >> >>
>>> >>>> >>
>>> >>>> >>
>>> >>>> >> --
>>> >>>> >> Best Regards,
>>> >>>> >> Michael Rolnik
>>> >>>>
>>> >>>>
>>> >>>>
>>> >>>> --
>>> >>>> Best Regards,
>>> >>>> Michael Rolnik
>>> >>
>>> >>
>>> >>
>>> >> --
>>> >> Best Regards,
>>> >> Michael Rolnik
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>> Michael Rolnik



--
Best Regards,
Michael Rolnik

