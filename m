Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E0DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9392465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFZ6Il9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9392465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjUo-0002LS-QO
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ifjUA-0001vY-Pq
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ifjU8-00088C-Vw
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:51:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ifjU8-00086q-M4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:51:52 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so6334138wrw.8
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 03:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VmzYywiMw3+41ZZR+hBQNVxS71g+7eEBc0HirjZY5WE=;
 b=AFZ6Il9b8bt34h6eTjwzh8Tm12tSFoboh8oFgrkbksGxN7zIDSWauE/+sxGYXF4pKB
 +eNRXLm/YMxGp5QyybSvjuKwUQ7yu8q/wDp7OW/ir1NQHbXLga73yvHpcD+a+vgUgXJq
 fTF3xijRDfDVPITWJvB3l7W03ea6EAG/UoZPoF69Cw/VYJxflSS2OB3AHlEXjYh5To3h
 aJth/33d1zwuRWnFGPffW0eyOecwJL7zTnSCrH1P4OV9LL0iFYGmvzo3yPJwEad4VLMd
 +gMhSLwbBLSvvbB4IK8syxDc8ju+YdBF/gPxui/Q6mcHnIJXSO/a6x8IzJ+VOIsm7/v6
 6nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VmzYywiMw3+41ZZR+hBQNVxS71g+7eEBc0HirjZY5WE=;
 b=cs6pGBDBbMkOhZahwEp515lpeBLhdgK5bw117vamVT1Vi7toXOW+GJsroUb1F4O80k
 ysiSdNn7oa5/NBQYSDfXiiF77Zfohwmut+PTBiFpg+7Eu25+mZGLgnHobratcDPwee0N
 N7RGzUr+xQKZFMwwFeuJAoJFq8LX1YLFGyDsjmQxEd6OTodyA4UqYg08FsKTxtGCnm3Z
 ocP7NSd9EznUKwETz6r0f8UgTZAO8gsdGF1GOBx8E6qaLHM1KOtUMbsVJcUA9VEQS6P4
 18IBqvyFMv6op2RUVmDo8jiQhZ4vtxjVNt7ZULy8v1HRGPn4uXRysNhp+xWOZHOdbPSW
 opQw==
X-Gm-Message-State: APjAAAVR7IY7dWYOrtOfiCaBrRqdm71BqMisLUFTrL92r8rA3QTXSvgf
 tjiu54GGx2Zmm3316+ZosRSgfQ==
X-Google-Smtp-Source: APXvYqxzMPEbwwz3LwNYcaJo9wDTWVmoddm6h3+muNsyxrnkjurHieY1EDCLRc6TznChTcIvbENtyg==
X-Received: by 2002:adf:f411:: with SMTP id g17mr11998664wro.89.1576237911350; 
 Fri, 13 Dec 2019 03:51:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm9838042wrq.22.2019.12.13.03.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 03:51:50 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B48461FF87;
 Fri, 13 Dec 2019 11:51:49 +0000 (GMT)
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-4-alex.bennee@linaro.org>
 <c9b4b7e3-9ba3-f40f-7ef3-eb2a34290f82@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v9 03/13] accel: collecting JIT statistics
In-reply-to: <c9b4b7e3-9ba3-f40f-7ef3-eb2a34290f82@linaro.org>
Date: Fri, 13 Dec 2019 11:51:49 +0000
Message-ID: <878sngbfze.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/7/19 11:28 AM, Alex Benn=C3=A9e wrote:
>> @@ -1795,6 +1799,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>>          if (flag & TB_EXEC_STATS) {
>>              tb->tb_stats->stats_enabled |=3D TB_EXEC_STATS;
>>          }
>> +
>> +        if (flag & TB_JIT_STATS) {
>> +            tb->tb_stats->stats_enabled |=3D TB_JIT_STATS;
>> +        }
>
> So, assuming that you really meant this, and not replacing as I was guess=
ing vs
> patch 2, then this is
>
>     tb->tb_stats->stats_enabled |=3D
>         flag & (TB_EXEC_STATS | TB_JIT_STATS);
>
> But I still think it's weird to be wanting to modify the shared structure.
> What does that mean for concurrent code generation?

The idea was to have per translation area granularity on collecting the
stats so we didn't have to burden all areas with the overhead. Currently
this only takes effect when qemu_log_in_addr_range is in effect. However
as the run goes on we could make decisions to disable some or all stats
for stuff that doesn't come up that frequently.

However the current positioning doesn't work as we keep setting the flag
so I think we need to apply get_default_tbstats_flag() inside
tb_get_stats only when we first create the data block.

>
>> +    /*
>> +     * Collect JIT stats when enabled. We batch them all up here to
>> +     * avoid spamming the cache with atomic accesses
>> +     */
>> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
>> +        TBStatistics *ts =3D tb->tb_stats;
>> +        qemu_mutex_lock(&ts->jit_stats_lock);
>> +
>> +        ts->code.num_guest_inst +=3D prof->translation.nb_guest_insns;
>> +        ts->code.num_tcg_ops +=3D prof->translation.nb_ops_pre_opt;
>> +        ts->code.num_tcg_ops_opt +=3D tcg_ctx->nb_ops;
>> +        ts->code.spills +=3D prof->translation.nb_spills;
>> +        ts->code.out_len +=3D tb->tc.size;
>> +
>> +        ts->translations.total++;
>> +        if (phys_page2 !=3D -1) {
>> +            ts->translations.spanning++;
>> +        }
>> +
>> +        g_ptr_array_add(ts->tbs, tb);
>> +
>> +        qemu_mutex_unlock(&ts->jit_stats_lock);
>> +    }
>
> Hmm.  So we're to interpret all of code.field as sums, the average of whi=
ch can
> be obtained by dividing by translations.total.  Ok, but that should proba=
bly be
> mentioned in a comment in/near the structure definition.

OK

> What are we planning to do with the set of all tb's collected here?

Originally we kept track for the coverset calculation as we need to know
where each individual TB goes next. The code was racy so I dropped it
from the series so tracking this now is possibly redundant although it
might be useful in the future.

>
>> @@ -3125,6 +3126,7 @@ static void temp_sync
>>          case TEMP_VAL_REG:
>>              tcg_out_st(s, ts->type, ts->reg,
>>                         ts->mem_base->reg, ts->mem_offset);
>> +            s->prof.translation.nb_spills++;
>>              break;
>>=20=20
>>          case TEMP_VAL_MEM:
>
> This is not a spill in the common compiler definition.
>
> This is "write the temp to its backing storage".  While this does happen =
in the
> course of spilling, the vast majority of these are because we've finished
> modifying a global temp and must now update memory.  Which is not nearly =
the
> same thing as "spill".
>
> A spill in the compiler definition happens in tcg_reg_alloc, right after =
the
> comment "We must spill something".  ;-)

OK I'll fix that.

--=20
Alex Benn=C3=A9e

