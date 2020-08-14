Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FFDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922E5206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7JcLd9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922E5206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Wv4-00011f-Qw
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6Vyx-0002hj-W6
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:26:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53731
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6Vyv-0004lH-A2
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597397196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h3hqQPkf5N0sio7MjU4cGO6oWg6GXe1YGB2hIzXLT64=;
 b=O7JcLd9nv/DP2ANBkFs9J10u7sf5Sruli0rPoYovvcTQTHGjnTwNg4I1yFlyFdC8ZK0iRw
 Qz/WQiKT3WAx6s+EKVPHIDqJ24sbaZpd8h037fy6achmQwwCP0smBKNeUO5c/Y147eS5PM
 YoQAcEy8OvTbTzaxSJNgNutHPVB9qF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-IvyvnnL5MnSKD1JUfkxYNA-1; Fri, 14 Aug 2020 05:26:32 -0400
X-MC-Unique: IvyvnnL5MnSKD1JUfkxYNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E8F1DDE0;
 Fri, 14 Aug 2020 09:26:31 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FC9750EBB;
 Fri, 14 Aug 2020 09:26:28 +0000 (UTC)
Date: Fri, 14 Aug 2020 11:26:26 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 2/3] target/arm: Implement an IMPDEF pauth algorithm
Message-ID: <20200814092626.g63wbmvt5yvadeeb@kamzik.brq.redhat.com>
References: <20200813200243.3036772-1-richard.henderson@linaro.org>
 <20200813200243.3036772-3-richard.henderson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200813200243.3036772-3-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 03:37:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 01:02:42PM -0700, Richard Henderson wrote:
> Without hardware acceleration, a cryptographically strong
> algorithm is too expensive for pauth_computepac.
> 
> Even with hardware accel, we are not currently expecting
> to link the linux-user binaries to any crypto libraries,
> and doing so would generally make the --static build fail.
> 
> So choose XXH64 as a reasonably quick and decent hash.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Move the XXH64 bits to xxhash.h (ajb).
>     Create isar_feature_aa64_pauth_arch and fixup a comment
>     in isar_feature_aa64_pauth that no longer applies.
> ---
>  include/qemu/xxhash.h     | 82 +++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu.h          | 15 +++++--
>  target/arm/pauth_helper.c | 41 +++++++++++++++++---
>  3 files changed, 129 insertions(+), 9 deletions(-)
> 
> diff --git a/include/qemu/xxhash.h b/include/qemu/xxhash.h
> index 076f1f6054..93ba1a0425 100644
> --- a/include/qemu/xxhash.h
> +++ b/include/qemu/xxhash.h
> @@ -119,4 +119,86 @@ static inline uint32_t qemu_xxhash6(uint64_t ab, uint64_t cd, uint32_t e,
>      return qemu_xxhash7(ab, cd, e, f, 0);
>  }
>  
> +/*
> + * Component parts of the XXH64 algorithm from
> + * https://github.com/Cyan4973/xxHash/blob/v0.8.0/xxhash.h
> + *
> + * The complete algorithm looks like
> + *
> + *  i = 0;
> + *  if (len >= 32) {
> + *      v1 = seed + PRIME64_1 + PRIME64_2;
> + *      v2 = seed + PRIME64_2;
> + *      v3 = seed + 0;
> + *      v4 = seed - XXH_PRIME64_1;
> + *      do {
> + *          v1 = XXH64_round(v1, get64bits(input + i));
> + *          v2 = XXH64_round(v2, get64bits(input + i + 8));
> + *          v3 = XXH64_round(v3, get64bits(input + i + 16));
> + *          v4 = XXH64_round(v4, get64bits(input + i + 24));
> + *      } while ((i += 32) <= len);
> + *      h64 = XXH64_mergerounds(v1, v2, v3, v4);
> + *  } else {
> + *      h64 = seed + PRIME64_5;
> + *  }
> + *  h64 += len;
> + *
> + *  for (; i + 8 <= len; i += 8) {
> + *      h64 ^= XXH64_round(0, get64bits(input + i));
> + *      h64 = rol64(h64, 27) * PRIME64_1 + PRIME64_4;
> + *  }
> + *  for (; i + 4 <= len; i += 4) {
> + *      h64 ^= get32bits(input + i) * PRIME64_1;
> + *      h64 = rol64(h64, 23) * PRIME64_2 + PRIME64_3;
> + *  }
> + *  for (; i < len; i += 1) {
> + *      h64 ^= get8bits(input + i) * PRIME64_5;
> + *      h64 = rol64(h64, 11) * PRIME64_1;
> + *  }
> + *
> + *  return XXH64_avalanche(h64)
> + *
> + * Exposing the pieces instead allows for simplified usage when
> + * the length is a known constant and the inputs are in registers.
> + */
> +#define PRIME64_1   0x9E3779B185EBCA87ULL
> +#define PRIME64_2   0xC2B2AE3D27D4EB4FULL
> +#define PRIME64_3   0x165667B19E3779F9ULL
> +#define PRIME64_4   0x85EBCA77C2B2AE63ULL
> +#define PRIME64_5   0x27D4EB2F165667C5ULL
> +
> +static inline uint64_t XXH64_round(uint64_t acc, uint64_t input)
> +{
> +    return rol64(acc + input * PRIME64_2, 31) * PRIME64_1;
> +}
> +
> +static inline uint64_t XXH64_mergeround(uint64_t acc, uint64_t val)
> +{
> +    return (acc ^ XXH64_round(0, val)) * PRIME64_1 + PRIME64_4;
> +}
> +
> +static inline uint64_t XXH64_mergerounds(uint64_t v1, uint64_t v2,
> +                                         uint64_t v3, uint64_t v4)
> +{
> +    uint64_t h64;
> +
> +    h64 = rol64(v1, 1) + rol64(v2, 7) + rol64(v3, 12) + rol64(v4, 18);
> +    h64 = XXH64_mergeround(h64, v1);
> +    h64 = XXH64_mergeround(h64, v2);
> +    h64 = XXH64_mergeround(h64, v3);
> +    h64 = XXH64_mergeround(h64, v4);
> +
> +    return h64;
> +}
> +
> +static inline uint64_t XXH64_avalanche(uint64_t h64)
> +{
> +    h64 ^= h64 >> 33;
> +    h64 *= PRIME64_2;
> +    h64 ^= h64 >> 29;
> +    h64 *= PRIME64_3;
> +    h64 ^= h64 >> 32;
> +    return h64;
> +}
> +
>  #endif /* QEMU_XXHASH_H */
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 44901923c8..776bf30cbc 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3767,10 +3767,8 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
>  static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
>  {
>      /*
> -     * Note that while QEMU will only implement the architected algorithm
> -     * QARMA, and thus APA+GPA, the host cpu for kvm may use implementation
> -     * defined algorithms, and thus API+GPI, and this predicate controls
> -     * migration of the 128-bit keys.
> +     * Return true if any form of pauth is enabled, as this
> +     * predicate controls migration of the 128-bit keys.
>       */
>      return (id->id_aa64isar1 &
>              (FIELD_DP64(0, ID_AA64ISAR1, APA, 0xf) |
> @@ -3779,6 +3777,15 @@ static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
>               FIELD_DP64(0, ID_AA64ISAR1, GPI, 0xf))) != 0;
>  }
>  
> +static inline bool isar_feature_aa64_pauth_arch(const ARMISARegisters *id)
> +{
> +    /*
> +     * Return true if pauth is enabled with the architected QARMA algorithm.
> +     * QEMU will always set APA+GPA to the same value.
> +     */
> +    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) != 0;
> +}
> +
>  static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
>  {
>      return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
> diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
> index 6dbab03768..6ec4f83ff0 100644
> --- a/target/arm/pauth_helper.c
> +++ b/target/arm/pauth_helper.c
> @@ -24,6 +24,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/helper-proto.h"
>  #include "tcg/tcg-gvec-desc.h"
> +#include "qemu/xxhash.h"
>  
>  
>  static uint64_t pac_cell_shuffle(uint64_t i)
> @@ -207,8 +208,8 @@ static uint64_t tweak_inv_shuffle(uint64_t i)
>      return o;
>  }
>  
> -static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
> -                                 ARMPACKey key)
> +static uint64_t __attribute__((noinline))
> +pauth_computepac_architected(uint64_t data, uint64_t modifier, ARMPACKey key)
>  {
>      static const uint64_t RC[5] = {
>          0x0000000000000000ull,
> @@ -272,6 +273,36 @@ static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
>      return workingval;
>  }
>  
> +/*
> + * The XXH64 algorithm from
> + * https://github.com/Cyan4973/xxHash/blob/v0.8.0/xxhash.h
> + */
> +static uint64_t __attribute__((noinline))
> +pauth_computepac_impdef(uint64_t data, uint64_t modifier, ARMPACKey key)

Out of curiosity, why do we need to make these computepac functions
noinline?

> +{
> +    uint64_t v1 = QEMU_XXHASH_SEED + PRIME64_1 + PRIME64_2;
> +    uint64_t v2 = QEMU_XXHASH_SEED + PRIME64_2;
> +    uint64_t v3 = QEMU_XXHASH_SEED + 0;
> +    uint64_t v4 = QEMU_XXHASH_SEED - PRIME64_1;
> +
> +    v1 = XXH64_round(v1, data);
> +    v2 = XXH64_round(v2, modifier);
> +    v3 = XXH64_round(v3, key.lo);
> +    v4 = XXH64_round(v4, key.hi);
> +
> +    return XXH64_avalanche(XXH64_mergerounds(v1, v2, v3, v4));
> +}
> +
> +static uint64_t pauth_computepac(CPUARMState *env, uint64_t data,
> +                                 uint64_t modifier, ARMPACKey key)
> +{
> +    if (cpu_isar_feature(aa64_pauth_arch, env_archcpu(env))) {
> +        return pauth_computepac_architected(data, modifier, key);
> +    } else {
> +        return pauth_computepac_impdef(data, modifier, key);
> +    }
> +}

I think this patch should come before the last one. As it stands, when
bisecting between the last one and this one a user could attempt to
enable pauth-imdef, but it wouldn't do anything, or it would potentially
break things. However, this patch shouldn't change anything if it comes
first.

> +
>  static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
>                               ARMPACKey *key, bool data)
>  {
> @@ -292,7 +323,7 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
>      bot_bit = 64 - param.tsz;
>      ext_ptr = deposit64(ptr, bot_bit, top_bit - bot_bit, ext);
>  
> -    pac = pauth_computepac(ext_ptr, modifier, *key);
> +    pac = pauth_computepac(env, ext_ptr, modifier, *key);
>  
>      /*
>       * Check if the ptr has good extension bits and corrupt the
> @@ -341,7 +372,7 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
>      uint64_t pac, orig_ptr, test;
>  
>      orig_ptr = pauth_original_ptr(ptr, param);
> -    pac = pauth_computepac(orig_ptr, modifier, *key);
> +    pac = pauth_computepac(env, orig_ptr, modifier, *key);
>      bot_bit = 64 - param.tsz;
>      top_bit = 64 - 8 * param.tbi;
>  
> @@ -442,7 +473,7 @@ uint64_t HELPER(pacga)(CPUARMState *env, uint64_t x, uint64_t y)
>      uint64_t pac;
>  
>      pauth_check_trap(env, arm_current_el(env), GETPC());
> -    pac = pauth_computepac(x, y, env->keys.apga);
> +    pac = pauth_computepac(env, x, y, env->keys.apga);
>  
>      return pac & 0xffffffff00000000ull;
>  }
> -- 
> 2.25.1
> 
>

Thanks,
drew 


