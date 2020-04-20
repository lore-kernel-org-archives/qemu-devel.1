Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB234C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F5320775
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGxldGO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F5320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYJG-0005aw-Rn
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60938 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQYIV-0004wx-LO
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:25:24 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQYIU-0001qX-Ll
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:25:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37550)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQYIU-0001pn-8M
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:25:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id k1so12714135wrx.4
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=c9Z+R+BQwgTZ+Wzj6wtfASf618/7PJfmSymaypa6pQM=;
 b=vGxldGO4Og0n749xO9L2qPr4FBINKwCAyY69gV2dzh6iNvhLE328AHDmxErO4Jq09a
 mUDzQaNZgmIkvrmxuiJO/0mY7ohcEd8gW9nbup5TmbzQIuzKpIypuqDjJ5l2LUQB33pm
 vY8f80UkfIuJeRHcirQ9AOxk54KEqe5ZgaEeyfbloL5li6m+5MLTJa5VmDew8EXYIYUo
 d7dPZwSc1yLyDoQLYab4wT2exKz8f6roCmzh6/hFlnTBIZ74yzybEvLgLzGivbUz/4QA
 KqzPJPJG81F8C0uekAGs/FFLE6EdiwC3p7qJSAsWjECRlYhbY6KDgGytvQ8RniCIYGph
 jJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=c9Z+R+BQwgTZ+Wzj6wtfASf618/7PJfmSymaypa6pQM=;
 b=iZzFWgfemBKndAI0cxl9+KkUwAYwvc9cCnmFBrjeNNALEgDaahKfysgPqJu3hwRs/+
 9T55uVNhY1FYb1+I7TFqPfMx3kVOJp94uIQFP5wojauK0Uo+xiItzf6nIrdM3IG13kZM
 ruyJBYoxlqZlXNGgz7inQiXflRJ0wMIX10WH7jKOKTEVGhWmuFM9OWF7fWuZxXjxnVdZ
 jic9bm6DSna8AtM5r4jyroS+uaypmOYrIht0jBfR7EavSnvJITleniLnHvPrqhNKFDsq
 s4q9MApqapblT9MiIn6nmZ9fcSPz2GXn5nwxaZ8rGHE/AH6BwM7ADK0LQpb7ihy4DvW/
 AIeA==
X-Gm-Message-State: AGi0Pubk4ilbZzC8xPHLSUrBBG4dCJPUIr7kllSXkaE09VkLhH6J07Dq
 eY7bJ8bRs6XA31fKm13GsrqjVw==
X-Google-Smtp-Source: APiQypI7frLRRkVeSK3t3iTDHFeSSJ3Y4Mbx/u7iDdoNNFKm4DCSN8eT0mxG+4cO/OcX9dz5WY7fmw==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr18848295wrv.75.1587396319883; 
 Mon, 20 Apr 2020 08:25:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q1sm1562312wrn.70.2020.04.20.08.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 08:25:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8FD01FF7E;
 Mon, 20 Apr 2020 16:25:17 +0100 (BST)
References: <20200418155651.3901-1-richard.henderson@linaro.org>
 <20200418155651.3901-2-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/3] tcg: Improve vector tail clearing
In-reply-to: <20200418155651.3901-2-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 16:25:17 +0100
Message-ID: <87imhudvs2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Better handling of non-power-of-2 tails as seen with Arm 8-byte
> vector operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-op-gvec.c | 82 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 63 insertions(+), 19 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 5a6cc19812..43cac1a0bf 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -326,11 +326,34 @@ void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aof=
s, uint32_t bofs,
>     in units of LNSZ.  This limits the expansion of inline code.  */
>  static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
>  {
> -    if (oprsz % lnsz =3D=3D 0) {
> -        uint32_t lnct =3D oprsz / lnsz;
> -        return lnct >=3D 1 && lnct <=3D MAX_UNROLL;
> +    uint32_t q, r;
> +
> +    if (oprsz < lnsz) {
> +        return false;
>      }
> -    return false;
> +
> +    q =3D oprsz / lnsz;
> +    r =3D oprsz % lnsz;
> +    tcg_debug_assert((r & 7) =3D=3D 0);
> +
> +    if (lnsz < 16) {
> +        /* For sizes below 16, accept no remainder. */
> +        if (r !=3D 0) {
> +            return false;
> +        }
> +    } else {
> +        /*
> +         * Recall that ARM SVE allows vector sizes that are not a
> +         * power of 2, but always a multiple of 16.  The intent is
> +         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
> +         * In addition, expand_clr needs to handle a multiple of 8.
> +         * Thus we can handle the tail with one more operation per
> +         * diminishing power of 2.
> +         */
> +        q +=3D ctpop32(r);
> +    }
> +
> +    return q <=3D MAX_UNROLL;
>  }
>=20=20
>  static void expand_clr(uint32_t dofs, uint32_t maxsz);
> @@ -402,22 +425,31 @@ static void gen_dup_i64(unsigned vece, TCGv_i64 out=
, TCGv_i64 in)
>  static TCGType choose_vector_type(const TCGOpcode *list, unsigned vece,
>                                    uint32_t size, bool prefer_i64)
>  {
> -    if (TCG_TARGET_HAS_v256 && check_size_impl(size, 32)) {
> -        /*
> -         * Recall that ARM SVE allows vector sizes that are not a
> -         * power of 2, but always a multiple of 16.  The intent is
> -         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
> -         * It is hard to imagine a case in which v256 is supported
> -         * but v128 is not, but check anyway.
> -         */
> -        if (tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece)
> -            && (size % 32 =3D=3D 0
> -                || tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) {
> -            return TCG_TYPE_V256;
> -        }
> +    /*
> +     * Recall that ARM SVE allows vector sizes that are not a
> +     * power of 2, but always a multiple of 16.  The intent is
> +     * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
> +     * It is hard to imagine a case in which v256 is supported
> +     * but v128 is not, but check anyway.
> +     * In addition, expand_clr needs to handle a multiple of 8.
> +     */
> +    if (TCG_TARGET_HAS_v256 &&
> +        check_size_impl(size, 32) &&
> +        tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece) &&
> +        (!(size & 16) ||
> +         (TCG_TARGET_HAS_v128 &&
> +          tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) &&
> +        (!(size & 8) ||
> +         (TCG_TARGET_HAS_v64 &&
> +          tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)))) {
> +        return TCG_TYPE_V256;
>      }
> -    if (TCG_TARGET_HAS_v128 && check_size_impl(size, 16)
> -        && tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece)) {
> +    if (TCG_TARGET_HAS_v128 &&
> +        check_size_impl(size, 16) &&
> +        tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece) &&
> +        (!(size & 8) ||
> +         (TCG_TARGET_HAS_v64 &&
> +          tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)))) {
>          return TCG_TYPE_V128;
>      }
>      if (TCG_TARGET_HAS_v64 && !prefer_i64 && check_size_impl(size, 8)
> @@ -432,6 +464,18 @@ static void do_dup_store(TCGType type, uint32_t dofs=
, uint32_t oprsz,
>  {
>      uint32_t i =3D 0;
>=20=20
> +    tcg_debug_assert(oprsz >=3D 8);
> +
> +    /*
> +     * This may be expand_clr for the tail of an operation, e.g.
> +     * oprsz =3D=3D 8 && maxsz =3D=3D 64.  The first 8 bytes of this sto=
re
> +     * are misaligned wrt the maximum vector size, so do that first.
> +     */
> +    if (dofs & 8) {
> +        tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);
> +        i +=3D 8;
> +    }
> +
>      switch (type) {
>      case TCG_TYPE_V256:
>          /*


--=20
Alex Benn=C3=A9e

