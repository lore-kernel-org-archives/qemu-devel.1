Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AF8C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4541A206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhydB2b8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4541A206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY54M-0003op-FB
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jY51c-0008Tu-0i
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:47:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59664
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jY51a-0002zI-TY
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589190422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bgZmycoPbq4gzAb3l/dx8bJaPJ/GVtQMBk2CTamvgho=;
 b=fhydB2b85axwHjSNESA4SlOYT5HBSh8a4QBkT2nW4FNuYP8t2GgNOZ2arMCmvGrio3vBJH
 4WJ3SmsVeubeuoDz3/52o5Qxdvfi6AU4JyTT7XRmx/EcN3ZNimhLFXUS5sJXseUfzxBqpP
 gIUXCKxEc/71E/5wSpzarEVL+I6f7jY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-3QVhheW0Nx6YY7XmMEw1IQ-1; Mon, 11 May 2020 05:46:58 -0400
X-MC-Unique: 3QVhheW0Nx6YY7XmMEw1IQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97483461;
 Mon, 11 May 2020 09:46:57 +0000 (UTC)
Received: from [10.36.114.224] (ovpn-114-224.ams2.redhat.com [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90D8E5D9DA;
 Mon, 11 May 2020 09:46:56 +0000 (UTC)
Subject: Re: [PATCH v3 09/10] target/s390x: Use tcg_gen_gvec_rotl{i,s,v}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200508151055.5832-1-richard.henderson@linaro.org>
 <20200508151055.5832-10-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <b7bc681a-fbef-e305-b993-77baea4d2f2c@redhat.com>
Date: Mon, 11 May 2020 11:46:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508151055.5832-10-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.05.20 17:10, Richard Henderson wrote:
> Merge VERLL and VERLLV into op_vesv and op_ves, alongside
> all of the other vector shift operations.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

RHEL8 boots just fine and this survives my (still not upstream yet)

    tests/tcg: target/s390x: Test VECTOR ELEMENT ROTATE LEFT LOGICAL

Reviewed-by: David Hildenbrand <david@redhat.com>

> ---
>  target/s390x/helper.h           |  4 --
>  target/s390x/translate_vx.inc.c | 66 +++++----------------------------
>  target/s390x/vec_int_helper.c   | 31 ----------------
>  target/s390x/insn-data.def      |  4 +-
>  4 files changed, 11 insertions(+), 94 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index b5813c2ac2..b7887b552b 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -198,10 +198,6 @@ DEF_HELPER_FLAGS_4(gvec_vmlo16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_vmlo32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
>  DEF_HELPER_FLAGS_3(gvec_vpopct8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
>  DEF_HELPER_FLAGS_3(gvec_vpopct16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
> -DEF_HELPER_FLAGS_4(gvec_verllv8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
> -DEF_HELPER_FLAGS_4(gvec_verllv16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
> -DEF_HELPER_FLAGS_4(gvec_verll8, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
> -DEF_HELPER_FLAGS_4(gvec_verll16, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
>  DEF_HELPER_FLAGS_4(gvec_verim8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_verim16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
> index 12347f8a03..eb767f5288 100644
> --- a/target/s390x/translate_vx.inc.c
> +++ b/target/s390x/translate_vx.inc.c
> @@ -1825,63 +1825,6 @@ static DisasJumpType op_vpopct(DisasContext *s, DisasOps *o)
>      return DISAS_NEXT;
>  }
>  
> -static void gen_rll_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> -{
> -    TCGv_i32 t0 = tcg_temp_new_i32();
> -
> -    tcg_gen_andi_i32(t0, b, 31);
> -    tcg_gen_rotl_i32(d, a, t0);
> -    tcg_temp_free_i32(t0);
> -}
> -
> -static void gen_rll_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> -{
> -    TCGv_i64 t0 = tcg_temp_new_i64();
> -
> -    tcg_gen_andi_i64(t0, b, 63);
> -    tcg_gen_rotl_i64(d, a, t0);
> -    tcg_temp_free_i64(t0);
> -}
> -
> -static DisasJumpType op_verllv(DisasContext *s, DisasOps *o)
> -{
> -    const uint8_t es = get_field(s, m4);
> -    static const GVecGen3 g[4] = {
> -        { .fno = gen_helper_gvec_verllv8, },
> -        { .fno = gen_helper_gvec_verllv16, },
> -        { .fni4 = gen_rll_i32, },
> -        { .fni8 = gen_rll_i64, },
> -    };
> -
> -    if (es > ES_64) {
> -        gen_program_exception(s, PGM_SPECIFICATION);
> -        return DISAS_NORETURN;
> -    }
> -
> -    gen_gvec_3(get_field(s, v1), get_field(s, v2),
> -               get_field(s, v3), &g[es]);
> -    return DISAS_NEXT;
> -}
> -
> -static DisasJumpType op_verll(DisasContext *s, DisasOps *o)
> -{
> -    const uint8_t es = get_field(s, m4);
> -    static const GVecGen2s g[4] = {
> -        { .fno = gen_helper_gvec_verll8, },
> -        { .fno = gen_helper_gvec_verll16, },
> -        { .fni4 = gen_rll_i32, },
> -        { .fni8 = gen_rll_i64, },
> -    };
> -
> -    if (es > ES_64) {
> -        gen_program_exception(s, PGM_SPECIFICATION);
> -        return DISAS_NORETURN;
> -    }
> -    gen_gvec_2s(get_field(s, v1), get_field(s, v3), o->addr1,
> -                &g[es]);
> -    return DISAS_NEXT;
> -}
> -
>  static void gen_rim_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b, int32_t c)
>  {
>      TCGv_i32 t = tcg_temp_new_i32();
> @@ -1946,6 +1889,9 @@ static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
>      case 0x70:
>          gen_gvec_fn_3(shlv, es, v1, v2, v3);
>          break;
> +    case 0x73:
> +        gen_gvec_fn_3(rotlv, es, v1, v2, v3);
> +        break;
>      case 0x7a:
>          gen_gvec_fn_3(sarv, es, v1, v2, v3);
>          break;
> @@ -1977,6 +1923,9 @@ static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
>          case 0x30:
>              gen_gvec_fn_2i(shli, es, v1, v3, d2);
>              break;
> +        case 0x33:
> +            gen_gvec_fn_2i(rotli, es, v1, v3, d2);
> +            break;
>          case 0x3a:
>              gen_gvec_fn_2i(sari, es, v1, v3, d2);
>              break;
> @@ -1994,6 +1943,9 @@ static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
>          case 0x30:
>              gen_gvec_fn_2s(shls, es, v1, v3, shift);
>              break;
> +        case 0x33:
> +            gen_gvec_fn_2s(rotls, es, v1, v3, shift);
> +            break;
>          case 0x3a:
>              gen_gvec_fn_2s(sars, es, v1, v3, shift);
>              break;
> diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.c
> index 0d6bc13dd6..5561b3ed90 100644
> --- a/target/s390x/vec_int_helper.c
> +++ b/target/s390x/vec_int_helper.c
> @@ -515,37 +515,6 @@ void HELPER(gvec_vpopct##BITS)(void *v1, const void *v2, uint32_t desc)        \
>  DEF_VPOPCT(8)
>  DEF_VPOPCT(16)
>  
> -#define DEF_VERLLV(BITS)                                                       \
> -void HELPER(gvec_verllv##BITS)(void *v1, const void *v2, const void *v3,       \
> -                               uint32_t desc)                                  \
> -{                                                                              \
> -    int i;                                                                     \
> -                                                                               \
> -    for (i = 0; i < (128 / BITS); i++) {                                       \
> -        const uint##BITS##_t a = s390_vec_read_element##BITS(v2, i);           \
> -        const uint##BITS##_t b = s390_vec_read_element##BITS(v3, i);           \
> -                                                                               \
> -        s390_vec_write_element##BITS(v1, i, rol##BITS(a, b));                  \
> -    }                                                                          \
> -}
> -DEF_VERLLV(8)
> -DEF_VERLLV(16)
> -
> -#define DEF_VERLL(BITS)                                                        \
> -void HELPER(gvec_verll##BITS)(void *v1, const void *v2, uint64_t count,        \
> -                              uint32_t desc)                                   \
> -{                                                                              \
> -    int i;                                                                     \
> -                                                                               \
> -    for (i = 0; i < (128 / BITS); i++) {                                       \
> -        const uint##BITS##_t a = s390_vec_read_element##BITS(v2, i);           \
> -                                                                               \
> -        s390_vec_write_element##BITS(v1, i, rol##BITS(a, count));              \
> -    }                                                                          \
> -}
> -DEF_VERLL(8)
> -DEF_VERLL(16)
> -
>  #define DEF_VERIM(BITS)                                                        \
>  void HELPER(gvec_verim##BITS)(void *v1, const void *v2, const void *v3,        \
>                                uint32_t desc)                                   \
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 2bc77f0871..91ddaedd84 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -1147,8 +1147,8 @@
>  /* VECTOR POPULATION COUNT */
>      F(0xe750, VPOPCT,  VRR_a, V,   0, 0, 0, 0, vpopct, 0, IF_VEC)
>  /* VECTOR ELEMENT ROTATE LEFT LOGICAL */
> -    F(0xe773, VERLLV,  VRR_c, V,   0, 0, 0, 0, verllv, 0, IF_VEC)
> -    F(0xe733, VERLL,   VRS_a, V,   la2, 0, 0, 0, verll, 0, IF_VEC)
> +    F(0xe773, VERLLV,  VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
> +    F(0xe733, VERLL,   VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
>  /* VECTOR ELEMENT ROTATE AND INSERT UNDER MASK */
>      F(0xe772, VERIM,   VRI_d, V,   0, 0, 0, 0, verim, 0, IF_VEC)
>  /* VECTOR ELEMENT SHIFT LEFT */
> 


-- 
Thanks,

David / dhildenb


