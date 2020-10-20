Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E8CC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34BA2224B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLab3CN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34BA2224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsSZ-0005Qw-Qe
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kUsRn-000514-TT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kUsRl-00079A-Of
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603203424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlh4Vdz2R0fJvCLW7btf+gmKavgG680AWxwuavZC7sA=;
 b=bLab3CN3xqVJRdC4LPgT7zw2upJBa3ozamAskf4I3wDzpHq3h24WjRFsLWPGyzH5YC/oiP
 xv/cC/LYeVST4s73KJIQ7X8bI4qCiLOa2QH5aLOUNfL66mjgGocyXDdGzhpEckLRKJa6Ig
 VhSiO3TDkLDueeYSdffDUjBBSvZcbJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-ibh9LanjOtyt01nCzTRlCw-1; Tue, 20 Oct 2020 10:17:02 -0400
X-MC-Unique: ibh9LanjOtyt01nCzTRlCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7A85186DD32;
 Tue, 20 Oct 2020 14:17:01 +0000 (UTC)
Received: from [10.36.114.141] (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E7F027BA8;
 Tue, 20 Oct 2020 14:17:00 +0000 (UTC)
Subject: Re: [PATCH 4/4] target/s390x: Improve SUB LOGICAL WITH BORROW
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201017022901.78425-1-richard.henderson@linaro.org>
 <20201017022901.78425-5-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e2bd9942-6fe3-1570-cdc1-2cfd1519e4be@redhat.com>
Date: Tue, 20 Oct 2020 16:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201017022901.78425-5-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.10.20 04:29, Richard Henderson wrote:
> Now that SUB LOGICAL outputs carry, we can use that as input directly.
> It also means we can re-use CC_OP_ZC and produce an output carry
> directly from SUB LOGICAL WITH BORROW.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/internal.h    |  2 --
>  target/s390x/cc_helper.c   | 32 -----------------
>  target/s390x/helper.c      |  2 --
>  target/s390x/translate.c   | 74 ++++++++++++++++++++------------------
>  target/s390x/insn-data.def |  8 ++---
>  5 files changed, 44 insertions(+), 74 deletions(-)
> 
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index 4077047494..11515bb617 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -172,14 +172,12 @@ enum cc_op {
>  
>      CC_OP_ADD_64,               /* overflow on add (64bit) */
>      CC_OP_SUB_64,               /* overflow on subtraction (64bit) */
> -    CC_OP_SUBB_64,              /* overflow on unsigned sub-borrow (64bit) */
>      CC_OP_ABS_64,               /* sign eval on abs (64bit) */
>      CC_OP_NABS_64,              /* sign eval on nabs (64bit) */
>      CC_OP_MULS_64,              /* overflow on signed multiply (64bit) */
>  
>      CC_OP_ADD_32,               /* overflow on add (32bit) */
>      CC_OP_SUB_32,               /* overflow on subtraction (32bit) */
> -    CC_OP_SUBB_32,              /* overflow on unsigned sub-borrow (32bit) */
>      CC_OP_ABS_32,               /* sign eval on abs (64bit) */
>      CC_OP_NABS_32,              /* sign eval on nabs (64bit) */
>      CC_OP_MULS_32,              /* overflow on signed multiply (32bit) */
> diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
> index c7728d1225..e7039d0d18 100644
> --- a/target/s390x/cc_helper.c
> +++ b/target/s390x/cc_helper.c
> @@ -164,19 +164,6 @@ static uint32_t cc_calc_sub_64(int64_t a1, int64_t a2, int64_t ar)
>      }
>  }
>  
> -static uint32_t cc_calc_subb_64(uint64_t a1, uint64_t a2, uint64_t ar)
> -{
> -    int borrow_out;
> -
> -    if (ar != a1 - a2) {	/* difference means borrow-in */
> -        borrow_out = (a2 >= a1);
> -    } else {
> -        borrow_out = (a2 > a1);
> -    }
> -
> -    return (ar != 0) + 2 * !borrow_out;
> -}
> -
>  static uint32_t cc_calc_abs_64(int64_t dst)
>  {
>      if ((uint64_t)dst == 0x8000000000000000ULL) {
> @@ -237,19 +224,6 @@ static uint32_t cc_calc_sub_32(int32_t a1, int32_t a2, int32_t ar)
>      }
>  }
>  
> -static uint32_t cc_calc_subb_32(uint32_t a1, uint32_t a2, uint32_t ar)
> -{
> -    int borrow_out;
> -
> -    if (ar != a1 - a2) {	/* difference means borrow-in */
> -        borrow_out = (a2 >= a1);
> -    } else {
> -        borrow_out = (a2 > a1);
> -    }
> -
> -    return (ar != 0) + 2 * !borrow_out;
> -}
> -
>  static uint32_t cc_calc_abs_32(int32_t dst)
>  {
>      if ((uint32_t)dst == 0x80000000UL) {
> @@ -450,9 +424,6 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
>      case CC_OP_SUB_64:
>          r =  cc_calc_sub_64(src, dst, vr);
>          break;
> -    case CC_OP_SUBB_64:
> -        r =  cc_calc_subb_64(src, dst, vr);
> -        break;
>      case CC_OP_ABS_64:
>          r =  cc_calc_abs_64(dst);
>          break;
> @@ -472,9 +443,6 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
>      case CC_OP_SUB_32:
>          r =  cc_calc_sub_32(src, dst, vr);
>          break;
> -    case CC_OP_SUBB_32:
> -        r =  cc_calc_subb_32(src, dst, vr);
> -        break;
>      case CC_OP_ABS_32:
>          r =  cc_calc_abs_32(dst);
>          break;
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index fa3aa500e5..7678994feb 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -405,12 +405,10 @@ const char *cc_name(enum cc_op cc_op)
>          [CC_OP_LTGT0_64]  = "CC_OP_LTGT0_64",
>          [CC_OP_ADD_64]    = "CC_OP_ADD_64",
>          [CC_OP_SUB_64]    = "CC_OP_SUB_64",
> -        [CC_OP_SUBB_64]   = "CC_OP_SUBB_64",
>          [CC_OP_ABS_64]    = "CC_OP_ABS_64",
>          [CC_OP_NABS_64]   = "CC_OP_NABS_64",
>          [CC_OP_ADD_32]    = "CC_OP_ADD_32",
>          [CC_OP_SUB_32]    = "CC_OP_SUB_32",
> -        [CC_OP_SUBB_32]   = "CC_OP_SUBB_32",
>          [CC_OP_ABS_32]    = "CC_OP_ABS_32",
>          [CC_OP_NABS_32]   = "CC_OP_NABS_32",
>          [CC_OP_COMP_32]   = "CC_OP_COMP_32",
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 48494a86cc..0d8235a5fb 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -601,10 +601,8 @@ static void gen_op_calc_cc(DisasContext *s)
>          /* FALLTHRU */
>      case CC_OP_ADD_64:
>      case CC_OP_SUB_64:
> -    case CC_OP_SUBB_64:
>      case CC_OP_ADD_32:
>      case CC_OP_SUB_32:
> -    case CC_OP_SUBB_32:
>          local_cc_op = tcg_const_i32(s->cc_op);
>          break;
>      case CC_OP_CONST0:
> @@ -663,10 +661,8 @@ static void gen_op_calc_cc(DisasContext *s)
>          break;
>      case CC_OP_ADD_64:
>      case CC_OP_SUB_64:
> -    case CC_OP_SUBB_64:
>      case CC_OP_ADD_32:
>      case CC_OP_SUB_32:
> -    case CC_OP_SUBB_32:
>          /* 3 arguments */
>          gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, cc_src, cc_dst, cc_vr);
>          break;
> @@ -4744,29 +4740,49 @@ static DisasJumpType op_subu64(DisasContext *s, DisasOps *o)
>      return DISAS_NEXT;
>  }
>  
> -static DisasJumpType op_subb(DisasContext *s, DisasOps *o)
> +/* Compute borrow (0, -1) into cc_src. */
> +static void compute_borrow(DisasContext *s)
>  {
> -    DisasCompare cmp;
> -    TCGv_i64 borrow;
> -
> -    tcg_gen_sub_i64(o->out, o->in1, o->in2);
> -
> -    /* The !borrow flag is the msb of CC.  Since we want the inverse of
> -       that, we ask for a comparison of CC=0 | CC=1 -> mask of 8 | 4.  */
> -    disas_jcc(s, &cmp, 8 | 4);
> -    borrow = tcg_temp_new_i64();
> -    if (cmp.is_64) {
> -        tcg_gen_setcond_i64(cmp.cond, borrow, cmp.u.s64.a, cmp.u.s64.b);
> -    } else {
> -        TCGv_i32 t = tcg_temp_new_i32();
> -        tcg_gen_setcond_i32(cmp.cond, t, cmp.u.s32.a, cmp.u.s32.b);
> -        tcg_gen_extu_i32_i64(borrow, t);
> -        tcg_temp_free_i32(t);
> +    switch (s->cc_op) {
> +    case CC_OP_SUBU:
> +        break;
> +    default:
> +        gen_op_calc_cc(s);
> +        /* fall through */
> +    case CC_OP_STATIC:
> +        /* The carry flag is the msb of CC; compute into cc_src. */
> +        tcg_gen_extu_i32_i64(cc_src, cc_op);
> +        tcg_gen_shri_i64(cc_src, cc_src, 1);
> +        /* fall through */
> +    case CC_OP_ADDU:

Can you give me a hint how we're converting the carry into a borrow?

Can we apply something similar to compute_carry()?

> +        tcg_gen_subi_i64(cc_src, cc_src, 1);
> +        break;


-- 
Thanks,

David / dhildenb


