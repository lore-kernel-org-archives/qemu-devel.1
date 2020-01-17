Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAFBC33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B8420748
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIsLRNL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B8420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWiz-0000qn-Sp
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1isWiI-0000HE-2T
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1isWiD-0001NI-5O
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:51:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60112
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1isWiC-0001MQ-TB
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579287075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=292Git6R94q2oGXqINjEWoc5xYAK0WY5rvnnIejLkxA=;
 b=dIsLRNL/UNDG+SlPPUyaD1qohQNWaOlpExUt+f1m9Tq1EXIXvX7DmQS3Wa8Nx1CbiBR7VH
 Z7abmEayJwIAMBMbAlrxtvL5ZeBYL4gPKRvGmxlebge5vWuFKrCCcEJ9MwSzvzFr6avruS
 wfs5tIdHh1f11O6o//ThwV+KLxhLDuc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-_kDhJy-sP_-uQVsPG-46NA-1; Fri, 17 Jan 2020 13:51:12 -0500
Received: by mail-wr1-f69.google.com with SMTP id 90so10789929wrq.6
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d3bt8IA53NAZRIw3/FFlJLOBd8XyHQY+XI0MRbkyPLU=;
 b=N3xpkfSZzK4mgaGqLHxR6dBHpyj/l+6dqrUrGDraRylNvvj5GkFNtLL/KSv2bgdRjq
 cnbpSYuKn976cKnu4Iv50u5NlxMmikprzRrXGNvYWgHGfjOEEmXXLQMQVPRmI3b+YukG
 NO/ViOWENK1iciwwv1htPiPt6AZ67bhXg8Z/QMCzYs9SmUS6upxpCT/hAVVLSpYYqMBa
 eUsFgDLGzyPRjcg2yMgYhNcy8FpfXYF5yHLG4H/MOVHn8totkUV+3ebt/SXuNvimsqLj
 DZLgE4GZno2fqmlyinQFd0HxGkY+3oHPVYBwMdCLVi7SALMYnLRdnjNgcnU4AYcskynD
 cC0g==
X-Gm-Message-State: APjAAAX4Y4U6I2sOxMvcAVkkjkgARgjp2S9i4mofL+m8QbHDbnehY51g
 +OcAiGg74HloR8+QGJAWXj4fVc97zD9UOjHbTQyxM3OzE/QzSWLYuJkqtqZ3TqF+kRu07UFE4rj
 vPIvH8IR9ZZgwiiwiK04nEvsbnH05gIE=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr4534060wrp.17.1579287071123;
 Fri, 17 Jan 2020 10:51:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPpzKNp/OGqG6GZbMAtKsTb94TReDiFgJEs5O2KmxwzJW05qYw26lrz6l3qiQhUKBY0P6a9f6noffnvtiTIdc=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr4534031wrp.17.1579287070877;
 Fri, 17 Jan 2020 10:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20200117015322.12953-1-richard.henderson@linaro.org>
In-Reply-To: <20200117015322.12953-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 17 Jan 2020 19:50:59 +0100
Message-ID: <CAP+75-WqE4j7kRkSae+fQHn9N0=L+OTZz5xUziZkn9Z-1uAs9Q@mail.gmail.com>
Subject: Re: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
To: Richard Henderson <richard.henderson@linaro.org>
X-MC-Unique: _kDhJy-sP_-uQVsPG-46NA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Helge Deller <deller@gmx.de>, dave.anglin@bell.net,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 17, 2020 at 2:53 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The PA-RISC 1.1 specification says that LDCW must be aligned mod 16
> or the operation is undefined.  However, real hardware only generates
> an unaligned access trap for unaligned mod 4.

This Linux kernel commit seems relevant:

https://github.com/torvalds/linux/commit/14e256c107304#diff-e85862c7227599c=
b24e36494f75948d5R159-R164

  /* From: "Jim Hull" <jim.hull of hp.com>
  I've attached a summary of the change, but basically, for PA 2.0, as
  long as the ",CO" (coherent operation) completer is specified, then the
  16-byte alignment requirement for ldcw and ldcd is relaxed, and instead
  they only require "natural" alignment (4-byte for ldcw, 8-byte for
  ldcd). */

(I couldn't find the original post on
http://lists.parisc-linux.org/pipermail/parisc-linux/)

Maybe you can point to it in the description.

> Match real hardware, but diagnose with GUEST_ERROR a violation of the
> specification.
>
> Reported-by: Helge Deller <deller@gmx.de>
> Suggested-by: John David Anglin <dave.anglin@bell.net>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Helge, can you please test this against your failing kernel?
> You will of course want to add -D logfile -d guest_errors to
> you qemu command-line.
>
>
> r~
>
> ---
>  target/hppa/helper.h    | 2 ++
>  target/hppa/op_helper.c | 9 +++++++++
>  target/hppa/translate.c | 6 +++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/target/hppa/helper.h b/target/hppa/helper.h
> index 38d834ef6b..2d483aab58 100644
> --- a/target/hppa/helper.h
> +++ b/target/hppa/helper.h
> @@ -17,6 +17,8 @@ DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, voi=
d, env, tl, tr)
>  DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tr)
>  DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
>
> +DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
> +
>  DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tr, env, tl, i32, i32)
>
>  DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
> index f0516e81f1..345cef2c08 100644
> --- a/target/hppa/op_helper.c
> +++ b/target/hppa/op_helper.c
> @@ -153,6 +153,15 @@ void HELPER(stby_e_parallel)(CPUHPPAState *env, targ=
et_ulong addr,
>      do_stby_e(env, addr, val, true, GETPC());
>  }
>
> +void HELPER(ldc_check)(target_ulong addr)
> +{
> +    if (unlikely(addr & 0xf)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Undefined ldc to address unaligned mod 16: "
> +                      TARGET_FMT_lx "\n", addr);
> +    }
> +}
> +
>  target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
>                            uint32_t level, uint32_t want)
>  {
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 2f8d407a82..669381dc1d 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2942,7 +2942,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a=
)
>
>  static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
>  {
> -    MemOp mop =3D MO_TEUL | MO_ALIGN_16 | a->size;
> +    MemOp mop =3D MO_TE | MO_ALIGN | a->size;
>      TCGv_reg zero, dest, ofs;
>      TCGv_tl addr;
>
> @@ -2958,8 +2958,12 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst =
*a)
>
>      form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
>               a->disp, a->sp, a->m, ctx->mmu_idx =3D=3D MMU_PHYS_IDX);
> +
> +    gen_helper_ldc_check(addr);
>      zero =3D tcg_const_reg(0);
>      tcg_gen_atomic_xchg_reg(dest, addr, zero, ctx->mmu_idx, mop);
> +    tcg_temp_free(zero);
> +
>      if (a->m) {
>          save_gpr(ctx, a->b, ofs);
>      }
> --
> 2.20.1
>
>


