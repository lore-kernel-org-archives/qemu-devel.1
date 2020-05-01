Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D963C47257
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07E724956
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urs/xAh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07E724956
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUY2q-0007mb-1w
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUXzw-00036R-Jg
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUXzv-0001iy-Mg
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:54:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUXzv-0001iS-7k
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:54:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id j26so2924357ots.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zm1Gkqv2rY1Z2i0K0zq+IyASfM+aLDKV0+p2jpsiqX4=;
 b=urs/xAh5NWvp6iUey/zgkvjqKc7sSnRsNARMGSG97NZP5jKIM6BVYXwDGZhLULXddw
 1yJbY98slkgb2r8InB1fU9eOLOIkEHY2AWw0UDaC91Xl1A9CEWtJ/1tLYpVZG5RJZ104
 NKh4nAT989nSGV9EXoWwxszfw5ylZngxBiEIvkF5PiKvcXfu/ESxIqPoNNTJqAOMRMs4
 GqxlK42AXcULU919jo7dNKYnDkDB2N5peqyheliWqsvcfSwCgozoyb6DOTFOdDn0eZEY
 Nepug9ZzR7sr7NN4CwV5HTMsTinlOBnoNkXRJQ63foLA6KyOvz+zVp0qM+ciFsWyBjEg
 QghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zm1Gkqv2rY1Z2i0K0zq+IyASfM+aLDKV0+p2jpsiqX4=;
 b=o2D29+M14+FqLRKo6fRG/hKzzBOgut6MZIHIQGS/tVNQIn1KUcsAimPYgMijAbPEam
 m9vmEdbmbbxv6ohrYbieNBF3+7M75bQyXiF6BkNe0rZy7vQMyURlGtAicBdlKzF4QCmF
 e3f2wBnCGHcP4T66dq8xavpqd5/5vJEU3mAfHxX6EYrsmp56Kb3rau1qhYODTQxNvOi1
 MLkPkjk2XVHHEgpG0Np2RKw32LXg0bOFnmVgmFh/XyJA+MwQHUIO8tI32LmAxpGQnDrQ
 Wb/PAclA6qNZlBJkD0NpuV1dJYNmptayPSEKJnERm9Y120A8VjYgYfJ4MVMX4x2EGQ3q
 Sptw==
X-Gm-Message-State: AGi0PuZa4cW7W5+lNPn+Sh797Oy7+tdFKnIeYvkjyUynn6jGQfRhSkdr
 YyAtrcnTlxDW0KRg9NB5j3Q0PXPM4tS55b2+8itYOg==
X-Google-Smtp-Source: APiQypJaoLqbwuDMO5TVR5/tVwqQ1MZJqT/6UUKRZUQHcrjUfPgTLp8m2J9ekr63XftnqfzjinPcowdfURRYnqmWGjE=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr3910923otc.221.1588348481543; 
 Fri, 01 May 2020 08:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-24-peter.maydell@linaro.org>
 <366a2e79-d963-bfdc-fcc6-2a63026fa1db@linaro.org>
In-Reply-To: <366a2e79-d963-bfdc-fcc6-2a63026fa1db@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2020 16:54:30 +0100
Message-ID: <CAFEAcA9kb2fpMcd-eLvdTD8dVjk=Ed9nKv2iHr_u_tpbBCa5HA@mail.gmail.com>
Subject: Re: [PATCH 23/36] target/arm: Convert Neon 64-bit element 3-reg-same
 insns
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 21:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/30/20 11:09 AM, Peter Maydell wrote:
> > +
> > +    rn = tcg_temp_new_i64();
> > +    rm = tcg_temp_new_i64();
> > +    rd = tcg_temp_new_i64();
> > +
> > +    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
> > +        neon_load_reg64(rn, a->vn + pass);
> > +        neon_load_reg64(rm, a->vm + pass);
> > +        fn(rd, rm, rn);
> > +        neon_store_reg64(rd, a->vd + pass);
> > +    }
> > +
> > +    tcg_temp_free_i64(rn);
> > +    tcg_temp_free_i64(rm);
> > +    tcg_temp_free_i64(rd);
> > +
> > +    return true;
> > +}
> > +
> > +#define DO_3SAME_64(INSN, FUNC)                                         \
> > +    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
> > +    {                                                                   \
> > +        return do_3same_64(s, a, FUNC);                                 \
> > +    }
>
> You can morph this into the gvec interface like so:
>
> #define DO_3SAME_64(INSN, FUNC) \
>     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,
>                                 uint32_t rn_ofs, uint32_t rm_ofs,
>                                 uint32_t oprsz, uint32_t maxsz)
>     {
>         static const GVecGen3 op = { .fni8 = FUNC };
>         tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
>                        oprsz, maxsz, &op);
>     }
>     DO_3SAME(INSN, gen_##INSN##_3s)
>
> The .fni8 function tells gvec that we have a helper that processes the
> operation in 8 byte chunks.  It will handle the pass loop for you.

This doesn't quite work, because these are shift ops and
so the operands are passed to the helper in the order
rd, rm, rn. Reshuffling the order of arguments to
tcg_gen_gvec_3() fixes this, though.

I guess I should call the macro DO_3SAME_SHIFT64, I hadn't
noticed it was shift specific because the only thing we do
with it is shifts.

thanks
-- PMM

