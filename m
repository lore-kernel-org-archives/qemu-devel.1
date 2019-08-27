Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48016C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150B6204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow5OeZ1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150B6204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Yt6-0007eY-4J
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 06:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1i2Yrk-0006ml-4a
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1i2Yrh-0007nz-Oh
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:38:18 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1i2Yrh-0007nj-Jm
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:38:17 -0400
Received: by mail-io1-xd42.google.com with SMTP id b10so36089457ioj.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lAFynBoPeamUxKHQ7z1U8AQZ4hIm5l/+UvFyWTkFH/0=;
 b=Ow5OeZ1yIojMpozzRqDmVirtrJ9lpVzlY6iyYA7ja4ox6SSiliTb1dSZv1j+qa08Zb
 ih7hi0M2ZtmyLHL2y8iXn6ZGnLfDrEVaHwcBy5xj7nKmUbhy/viR9jveeaRVGxBPj9AI
 CHGJDkwrktoFlGzLw9gQRpNd9H8tZDgf6d94BTeyAAzKH+xx/FgX25snBqtv5kIfMC+K
 GwlA63yt008AnPDW2AYpRI13bNbTjfVGq4db2P40bdQ7UiMsUq2e8xeYLSlxVZtXAUtZ
 L2iWuXKcgJH/s5mfIm4SJreQMpqEH/8xBkHNKTwObhINn9Gj6y6OzuhSkpPqtHV7H5Fh
 FRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lAFynBoPeamUxKHQ7z1U8AQZ4hIm5l/+UvFyWTkFH/0=;
 b=RTkrCBFzd+4fzMzMXpHQ7aieQzd94nZmhEYQwtQ+ttq1gEWyLvT+8xWAm7jhKN+7Xd
 aEwQfR1S+LerZ9YUjmWYPCizQZVn/oBENlgnQ25sXoAENNXsXo5YSA9kzCI79rnl4yXz
 Xp3mW3V2E699fPlR2yMKIKXLVPab69q6d4fX0kzEZyxClX1Qtt4ss/IJPKRYkkEmWIyE
 owjU62FwOmObEd7WLPmjqv4+25kl7Ec44OhUqwFgZez/9WfV2DJtHie2XG042AF/9Pd2
 3q4EdWvvgn7KE1XHOSf+eURpRulfCQCDS4U1CaYyQHMwA9Kyc0672bctGfPox7dqPmEX
 DKyA==
X-Gm-Message-State: APjAAAVzJseERNL0RGpyzkS+yT/B1+y8nurd3g14rn/XwmZwA3nve0w8
 qpOEyzGe1eKGgdhMVHVm/m9nFdtczsx7FMJBXQM=
X-Google-Smtp-Source: APXvYqz0I8W+hMwTPH23EA3e0pv9APYRr/ZVw8iTvOUTcdr7DPiUxw1ffwIU/lcIOEQy++N64NMqxU0vsMe68s0mqac=
X-Received: by 2002:a5d:9746:: with SMTP id c6mr25355832ioo.235.1566902296494; 
 Tue, 27 Aug 2019 03:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190826151536.6771-1-richard.henderson@linaro.org>
 <20190826151536.6771-3-richard.henderson@linaro.org>
In-Reply-To: <20190826151536.6771-3-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 27 Aug 2019 12:38:05 +0200
Message-ID: <CABoDooMofJrpZD_ePwUieW-42hG47QPKVi44QRk53axi3RBp4g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Factor out
 unallocated_encoding for aarch32
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 5:15 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make this a static function private to translate.c.
> Thus we can use the same idiom between aarch64 and aarch32
> without actually sharing function implementations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/translate-vfp.inc.c |  3 +--
>  target/arm/translate.c         | 22 ++++++++++++----------
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index 5065d4524c..3e8ea80493 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -108,8 +108,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
>
>      if (!s->vfp_enabled && !ignore_vfp_enabled) {
>          assert(!arm_dc_feature(s, ARM_FEATURE_M));
> -        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                           default_exception_el(s));
> +        unallocated_encoding(s);
>          return false;
>      }
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 2aac9aae68..66311580c0 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1231,6 +1231,13 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
>      s->base.is_jmp = DISAS_NORETURN;
>  }
>
> +static void unallocated_encoding(DisasContext *s)
> +{
> +    /* Unallocated and reserved encodings are uncategorized */
> +    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> +                       default_exception_el(s));
> +}
> +
>  /* Force a TB lookup after an instruction that changes the CPU state.  */
>  static inline void gen_lookup_tb(DisasContext *s)
>  {
> @@ -1261,8 +1268,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
>          return;
>      }
>
> -    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> +    unallocated_encoding(s);
>  }
>
>  static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
> @@ -7574,8 +7580,7 @@ static void gen_srs(DisasContext *s,
>      }
>
>      if (undef) {
> -        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                           default_exception_el(s));
> +        unallocated_encoding(s);
>          return;
>      }
>
> @@ -9196,8 +9201,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>              break;
>          default:
>          illegal_op:
> -            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                               default_exception_el(s));
> +            unallocated_encoding(s);
>              break;
>          }
>      }
> @@ -10882,8 +10886,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>      }
>      return;
>  illegal_op:
> -    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> +    unallocated_encoding(s);
>  }
>
>  static void disas_thumb_insn(DisasContext *s, uint32_t insn)
> @@ -11706,8 +11709,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>      return;
>  illegal_op:
>  undef:
> -    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> +    unallocated_encoding(s);
>  }
>
>  static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
> --
> 2.17.1
>

