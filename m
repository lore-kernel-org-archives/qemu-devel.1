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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD8DC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692962098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0bfKto5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692962098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsOs-0002mz-0T
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kUsNk-00023c-Hy
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kUsNi-0006Sv-Fc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603203173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQORXr+W0G3w8RAwCfB1V1CmhRt24VDP8rcD0UYScEw=;
 b=V0bfKto5Ppmva8U7SkmOSBUwBndEiBHU8eX9zUCRHXsHiUhRFmegY/EV8lcVPliaxtjBlZ
 LASwPIxoYefCGWTer/o2lHRFrO/Xt5YqdntTpCUVGlAmckqeIZ/2/jW8YkOsuolodlXD4C
 W/XVFkEU8gLc2+UxI7n9fNFZ25cSEls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-2XgsLyhaOP2_l5-7GO82Yw-1; Tue, 20 Oct 2020 10:12:49 -0400
X-MC-Unique: 2XgsLyhaOP2_l5-7GO82Yw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58F6E1006C8F;
 Tue, 20 Oct 2020 14:12:48 +0000 (UTC)
Received: from [10.36.114.141] (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90FBF5D9CD;
 Tue, 20 Oct 2020 14:12:47 +0000 (UTC)
Subject: Re: [PATCH 2/4] target/s390x: Improve ADD LOGICAL WITH CARRY
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201017022901.78425-1-richard.henderson@linaro.org>
 <20201017022901.78425-3-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <91224b3b-0e0d-9071-401d-3773fa42687f@redhat.com>
Date: Tue, 20 Oct 2020 16:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201017022901.78425-3-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 17.10.20 04:28, Richard Henderson wrote:
> Now that ADD LOGICAL outputs carry, we can use that as input directly.
> It also means we can re-use CC_OP_ZC and produce an output carry
> directly from ADD LOGICAL WITH CARRY.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/internal.h    |  2 --
>  target/s390x/cc_helper.c   | 26 ---------------
>  target/s390x/helper.c      |  2 --
>  target/s390x/translate.c   | 66 ++++++++++++++++++--------------------
>  target/s390x/insn-data.def |  8 ++---
>  5 files changed, 35 insertions(+), 69 deletions(-)
> 
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index 55c5442102..f5f3ae063e 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -170,7 +170,6 @@ enum cc_op {
>      CC_OP_LTGT0_64,             /* signed less/greater than 0 (64bit) */
>  
>      CC_OP_ADD_64,               /* overflow on add (64bit) */
> -    CC_OP_ADDC_64,              /* overflow on unsigned add-carry (64bit) */
>      CC_OP_SUB_64,               /* overflow on subtraction (64bit) */
>      CC_OP_SUBU_64,              /* overflow on unsigned subtraction (64bit) */
>      CC_OP_SUBB_64,              /* overflow on unsigned sub-borrow (64bit) */
> @@ -179,7 +178,6 @@ enum cc_op {
>      CC_OP_MULS_64,              /* overflow on signed multiply (64bit) */
>  
>      CC_OP_ADD_32,               /* overflow on add (32bit) */
> -    CC_OP_ADDC_32,              /* overflow on unsigned add-carry (32bit) */
>      CC_OP_SUB_32,               /* overflow on subtraction (32bit) */
>      CC_OP_SUBU_32,              /* overflow on unsigned subtraction (32bit) */
>      CC_OP_SUBB_32,              /* overflow on unsigned sub-borrow (32bit) */
> diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
> index 59da4d1cc2..cd2c5c4b39 100644
> --- a/target/s390x/cc_helper.c
> +++ b/target/s390x/cc_helper.c
> @@ -144,16 +144,6 @@ static uint32_t cc_calc_add_64(int64_t a1, int64_t a2, int64_t ar)
>      }
>  }
>  
> -static uint32_t cc_calc_addc_64(uint64_t a1, uint64_t a2, uint64_t ar)
> -{
> -    /* Recover a2 + carry_in.  */
> -    uint64_t a2c = ar - a1;
> -    /* Check for a2+carry_in overflow, then a1+a2c overflow.  */
> -    int carry_out = (a2c < a2) || (ar < a1);
> -
> -    return (ar != 0) + 2 * carry_out;
> -}
> -
>  static uint32_t cc_calc_sub_64(int64_t a1, int64_t a2, int64_t ar)
>  {
>      if ((a1 > 0 && a2 < 0 && ar < 0) || (a1 < 0 && a2 > 0 && ar > 0)) {
> @@ -240,16 +230,6 @@ static uint32_t cc_calc_add_32(int32_t a1, int32_t a2, int32_t ar)
>      }
>  }
>  
> -static uint32_t cc_calc_addc_32(uint32_t a1, uint32_t a2, uint32_t ar)
> -{
> -    /* Recover a2 + carry_in.  */
> -    uint32_t a2c = ar - a1;
> -    /* Check for a2+carry_in overflow, then a1+a2c overflow.  */
> -    int carry_out = (a2c < a2) || (ar < a1);
> -
> -    return (ar != 0) + 2 * carry_out;
> -}
> -
>  static uint32_t cc_calc_sub_32(int32_t a1, int32_t a2, int32_t ar)
>  {
>      if ((a1 > 0 && a2 < 0 && ar < 0) || (a1 < 0 && a2 > 0 && ar > 0)) {
> @@ -485,9 +465,6 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
>      case CC_OP_ADD_64:
>          r =  cc_calc_add_64(src, dst, vr);
>          break;
> -    case CC_OP_ADDC_64:
> -        r =  cc_calc_addc_64(src, dst, vr);
> -        break;
>      case CC_OP_SUB_64:
>          r =  cc_calc_sub_64(src, dst, vr);
>          break;
> @@ -513,9 +490,6 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
>      case CC_OP_ADD_32:
>          r =  cc_calc_add_32(src, dst, vr);
>          break;
> -    case CC_OP_ADDC_32:
> -        r =  cc_calc_addc_32(src, dst, vr);
> -        break;
>      case CC_OP_SUB_32:
>          r =  cc_calc_sub_32(src, dst, vr);
>          break;
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index db87a62a57..4f4561bc64 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -403,14 +403,12 @@ const char *cc_name(enum cc_op cc_op)
>          [CC_OP_LTGT0_32]  = "CC_OP_LTGT0_32",
>          [CC_OP_LTGT0_64]  = "CC_OP_LTGT0_64",
>          [CC_OP_ADD_64]    = "CC_OP_ADD_64",
> -        [CC_OP_ADDC_64]   = "CC_OP_ADDC_64",
>          [CC_OP_SUB_64]    = "CC_OP_SUB_64",
>          [CC_OP_SUBU_64]   = "CC_OP_SUBU_64",
>          [CC_OP_SUBB_64]   = "CC_OP_SUBB_64",
>          [CC_OP_ABS_64]    = "CC_OP_ABS_64",
>          [CC_OP_NABS_64]   = "CC_OP_NABS_64",
>          [CC_OP_ADD_32]    = "CC_OP_ADD_32",
> -        [CC_OP_ADDC_32]   = "CC_OP_ADDC_32",
>          [CC_OP_SUB_32]    = "CC_OP_SUB_32",
>          [CC_OP_SUBU_32]   = "CC_OP_SUBU_32",
>          [CC_OP_SUBB_32]   = "CC_OP_SUBB_32",
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 9bf4c14f66..570b3c88c8 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -600,12 +600,10 @@ static void gen_op_calc_cc(DisasContext *s)
>          dummy = tcg_const_i64(0);
>          /* FALLTHRU */
>      case CC_OP_ADD_64:
> -    case CC_OP_ADDC_64:
>      case CC_OP_SUB_64:
>      case CC_OP_SUBU_64:
>      case CC_OP_SUBB_64:
>      case CC_OP_ADD_32:
> -    case CC_OP_ADDC_32:
>      case CC_OP_SUB_32:
>      case CC_OP_SUBU_32:
>      case CC_OP_SUBB_32:
> @@ -665,12 +663,10 @@ static void gen_op_calc_cc(DisasContext *s)
>          gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, cc_src, cc_dst, dummy);
>          break;
>      case CC_OP_ADD_64:
> -    case CC_OP_ADDC_64:
>      case CC_OP_SUB_64:
>      case CC_OP_SUBU_64:
>      case CC_OP_SUBB_64:
>      case CC_OP_ADD_32:
> -    case CC_OP_ADDC_32:
>      case CC_OP_SUB_32:
>      case CC_OP_SUBU_32:
>      case CC_OP_SUBB_32:
> @@ -1442,30 +1438,40 @@ static DisasJumpType op_addu64(DisasContext *s, DisasOps *o)
>      return DISAS_NEXT;
>  }
>  
> -static DisasJumpType op_addc(DisasContext *s, DisasOps *o)
> +/* Compute carry into cc_src. */
> +static void compute_carry(DisasContext *s)
>  {
> -    DisasCompare cmp;
> -    TCGv_i64 carry;
> -
> -    tcg_gen_add_i64(o->out, o->in1, o->in2);
> -
> -    /* The carry flag is the msb of CC, therefore the branch mask that would
> -       create that comparison is 3.  Feeding the generated comparison to
> -       setcond produces the carry flag that we desire.  */
> -    disas_jcc(s, &cmp, 3);
> -    carry = tcg_temp_new_i64();
> -    if (cmp.is_64) {
> -        tcg_gen_setcond_i64(cmp.cond, carry, cmp.u.s64.a, cmp.u.s64.b);
> -    } else {
> -        TCGv_i32 t = tcg_temp_new_i32();
> -        tcg_gen_setcond_i32(cmp.cond, t, cmp.u.s32.a, cmp.u.s32.b);
> -        tcg_gen_extu_i32_i64(carry, t);
> -        tcg_temp_free_i32(t);
> +    switch (s->cc_op) {
> +    case CC_OP_ADDU:

Can you add a comment that we have the carry right in out hands already?
Took me while to figure that out.

Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb


