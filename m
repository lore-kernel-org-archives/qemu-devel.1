Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF683C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9AF22DD3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptV2C96I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9AF22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06oE-0003Vq-Fw
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i06nL-0002z9-N2
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i06nK-0001RZ-3i
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:15:39 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:34136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i06nJ-0001Qo-Te
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:15:38 -0400
Received: by mail-oi1-x22f.google.com with SMTP id g128so4530709oib.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mfZI9vKNpxE7fCSQTa0GxMEcN1qepcVPHGFp977KSbM=;
 b=ptV2C96IjnBGuRJms4qZcA07oEeoLGN4lxgILSMglPEcMl5HDO+VdE/jQEfdKpU2k8
 /b1SvYHUvjfoSDtlSDvFehS8im3ADcsncgqhhB8XbAfjC8MkPBYCsmtVfn1+QpCmaapL
 9t7ASiagQevtAjgPb9gQfdqBKnYcoCbZsmeO/23FbxQIogTnt1UCEanwQIQie3It8H/a
 QmE6Yw/c5ileZzOT30vJO2IZb8pkjohEwWskfwc+C0BlGlvhbuYEF64gXhfYlMdofUs8
 fmXz1UAtxE/lCQH5vaRK5hKL+hKNCRQzIuDAvxcIBNOYy4Ulh7lhe5r6ZcXU5wyCmBe0
 f/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mfZI9vKNpxE7fCSQTa0GxMEcN1qepcVPHGFp977KSbM=;
 b=nSeQZX6Sxc7LO4vR15bRwlKHvtM5wWgzIzm0oN58kfHMob1pqowMa9dxxYJp1lU6fy
 HNNmKQ0HLHAiesw2AtQ1S6qW67/ek6AR7MHVmij60bVb/ysKSi0BCkiUCqpt9Pqp4b3f
 Eayypgvp4SbOucRgHoGxp/wn9YFWZBHCcaybPi/EGULBXoFZjfQSdnh0oOq0siJqxo8k
 UD2f+EP+v6cWelXei6rwIX1xaW8s46TGh4u/X61NB5G8/xVDHhu3TtuJp6B4zXkrGrcA
 4ST+p/OY3ouHvWU3PKARb91dv41gf///tQKRgD0cloLNNQ1p4ZDp+Jl6xQiVRY6P92aM
 Uh6w==
X-Gm-Message-State: APjAAAVBN5W/XU1xsDZlNLde59wJ/atYwphXgtY1L0oyTKLWEYV9U8Ts
 y9mckj1j3X4R2xjKDr9QWTcVKZsPxboZGBiyuzg=
X-Google-Smtp-Source: APXvYqwSTo3Vk22nl9nZCnukvDZQwwl7GBEwwWxQNx24uzm+U4Xxagy1MCsTTnxwotZhf6aqh3tx/49ZP07O5VJ7ROA=
X-Received: by 2002:aca:fd92:: with SMTP id b140mr549588oii.79.1566317737052; 
 Tue, 20 Aug 2019 09:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
In-Reply-To: <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 20 Aug 2019 18:15:26 +0200
Message-ID: <CAL1e-=hx9bLLOZiwa2UySt98T3HGWhshwwm2j0wTp5JSjJxG-Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 20, 2019 at 5:37 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/20/19 6:49 AM, Aleksandar Markovic wrote:
> >> From: Peter Maydell <peter.maydell@linaro.org>
> >> On Tue, 20 Aug 2019 at 13:50, Aleksandar Markovic
> >> <amarkovic@wavecomp.com> wrote:
> >>> The idea is to provide significant "lexicographic" distance between
> those > groups of functions, rather than having the similar name (wiht
> common root > "ext) for all of them.
> >>
> >> The current naming of the extract/sextract TCG ops is intended to keep
> >> them in line with the extract32/sextract32/extract64/sextract64 utility
> >> functions in bitops.h. I think those ones are reasonably named. The
> >> other ops are a bit more ad-hoc in naming, admittedly...
> >>
> >
> > How about
> >
> > tcg_gen_extract2_i32
> > tcg_gen_extract2_i64
> > tcg_gen_extract2_tl
> > tcg_gen_extrl_i64_i32
> > tcg_gen_extrh_i64_i32
> > tcg_gen_ext_i32_i64
> > tcg_gen_extu_i32_i64
> >
> > to
> >
> > tcg_gen_gather_i32
> > tcg_gen_gather_i64
> > tcg_gen_gather_tl
>
> I'm not sure how "gather" applies.


gather = come together; assemble or accumulate


> To me this sounds like a vector
> scatter/gather operation, where N different addresses are used to load the
> N
> elements of the vector.
>
> When extract2 was named, I was only thinking "extract" because of how the
> AArch64 instruction that implements this operation is named (EXTR), and
> "extr"
> itself was already taken.  We did ask for naming suggestions at the time,
> but
> no better ideas were floated...
>
> Would it be clearer to use the x86 instruction name: SHRD (SHift Right
> Doubleword)?
>
> > tcg_gen_pick_l_i64_i32
> > tcg_gen_pick_h_i64_i32
>
> Hmm, "pick" doesn't mean anything to me.


and "extl" does?


> Which makes it better than "gather",
> but only just.
>
> We do have a couple of related operations: tcg_gen_trunc_i64_tl and
> tcg_gen_trunc_tl_i32.  It's easy to see tcg_gen_extrl_i64_i32 as
> "truncate",
> because that's what it does.  But it's harder to see tcg_gen_extrh_i64_i32
> as
> "truncate high".  Is tcg_gen_shr32_trunc_i64_i32 too unwieldy?
>
> Or perhaps we could leave these alone.  Changing the others gives us the
> desired (or at least increased) lexicographic distance.
>
> > tcg_gen_extend_s_i32_i64
> > tcg_gen_extend_0_i32_i64
>
> These should not drift too far from the other extension names,
>
>     tcg_gen_ext{8,16}{u,s}_i32
>     tcg_gen_ext{8,16,32}{u,s}_i64
>
> What if we use the AArch64 mnemonics: zxt (zero-extend) and sxt
> (sign-extend)?
>  This would give us
>
>     tcg_gen_zxt8_i32
>     tcg_gen_sxt8_i32
>     (etc)
>     tcg_gen_zxt_i32_i64
>     tcg_gen_sxt_i32_i64
>
>
Perhaps the whole "extend" front-end segment should be tweaked to be
consistent.

In general, Z/S scheme in these cases looks better than U/S scheme to me.
The prevalent terms are "zero-extend" and "sign-extend", and involving
Unsigned/Signed just widens the semantic gap.

I used "0" and "s" to make the visual distinction easier (it is easier to
spot).

I was hoping we would remove "sextract" (well, it is funny a little bit
definitely, but if there are zillion occurrences, and used everyday, it
just stops being funny, and is somewhat distracting...), however it looks
we will get "sextend", and "sextend2", and "sex_h" and "sex_l"...

Aleksandar


>
> r~
>
>
