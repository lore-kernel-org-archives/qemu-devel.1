Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A602FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E9620854
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MR+EhkwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E9620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKlPr-0001QD-74
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 11:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKlP2-0000gq-Nt
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKlP1-0004Ng-CF
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:39:56 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKlP1-0004Mr-2F
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:39:55 -0400
Received: by mail-pg1-x542.google.com with SMTP id w3so7605187pgt.5
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6YQ153NOOjUMl+pO/gDPGLBVsCywgtV0r9bpuBebW4Q=;
 b=MR+EhkwXXfX63TmC7yls0Q9us9u7s2EeGHgdQJJDwsRBGvsspcSVkE/YCtry0R2huq
 GVydMEqm/f5CBdaZhqhhHzY3qZhw4Po44u2orqcGo4JJLxsulk5O2OIo5xO/UIjL5mXx
 HmEhG9tO5Tm5veriH9UCh/zDbZBKmZwOlWQHSLVl96F8V5NYq6abUGsL3Ow4m36UU2oo
 D1gD4eAkyjTEDK12FekalYkgebzYvhHfoVII3Rq6sXk7TRzC215GFOBzRoPbc19QVS9L
 5D/iasJPMLPbJMpZreu6DKM9Gd8bfAF/N/MHDDDjWq3BOC5RaS6h5/NxznWM6+ZVK5Vv
 kXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6YQ153NOOjUMl+pO/gDPGLBVsCywgtV0r9bpuBebW4Q=;
 b=geYzdXeGisFY9yCZ46yLegvG5UZeY9vppn5Mz1NM+a7oR9hvaCGwJiwXvsF6tbvBuo
 W5SMyA5ZmxvwA+Z2/PAeuRSznB3cM5IJiU6zvR/NPOt70HQbNy2Xb6mVa845B3YOVZkm
 +jUz1l//JZnWcze5auV9fi3ziXNh+u2Eis47q13DX8DEZ5XvoMmi9Y4F8IFaub961rFV
 mxVYld3P3IhTDrb36kNnqh0yarX5z0QqgpMSKTE9nhWSrfYU3PJs92f02idsy9vhiR5R
 ckcPlZm16RKJ092Gg1WH6Y6LKbki9KZz9xW+6fi6SiUtQ9Er97bJQhH4S1UV9f3zP8SW
 JERA==
X-Gm-Message-State: APjAAAWWPpYKX5Vt+R6I0d4Cvpvcs3HzQ6lrxUkJtE050nN8LDgCZuAI
 rh39VWBIpGK1Byv+5fk7YrG5SA==
X-Google-Smtp-Source: APXvYqx0V/r2P4EjH/htlrY4j8iCWKpIve6Y1Q3VxHoEdjQsM16Kc0TlKSFLMgV1GRLrpaAu83d+Dg==
X-Received: by 2002:a65:500c:: with SMTP id f12mr15798271pgo.233.1571240393813; 
 Wed, 16 Oct 2019 08:39:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 2sm30815025pfa.43.2019.10.16.08.39.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Oct 2019 08:39:53 -0700 (PDT)
Subject: Re: [PATCH v2] target/arm/arch_dump: Add SVE notes
To: Andrew Jones <drjones@redhat.com>
References: <20191004120313.5347-1-drjones@redhat.com>
 <f23153f2-35be-f74d-ad7b-d9c324cba1cf@linaro.org>
 <20191010061600.pwhos4huazbsv6kn@kamzik.brq.redhat.com>
 <6451070f-9488-cc8f-2f4b-a7577e11f447@linaro.org>
 <20191016091314.cu76t3ovwofsfart@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f517a663-45ad-0ec0-785f-7540fc99acb5@linaro.org>
Date: Wed, 16 Oct 2019 08:39:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016091314.cu76t3ovwofsfart@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 2:13 AM, Andrew Jones wrote:
> On Thu, Oct 10, 2019 at 01:33:02PM -0400, Richard Henderson wrote:
>> Ah, I wonder if you changed things around with the ifdefs due to the pregs.
>> There's no trivial solution for those.  It'd be nice to share the bswapping
>> subroutine that you add in the SVE KVM patch set, and size the temporary array
>> using ARM_MAX_VQ.
> 
> How about something like this squashed in?

Looks good.


r~


> 
> Thanks,
> drew
> 
> diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
> index b02e398430b9..7c7fd23f4d94 100644
> --- a/target/arm/arch_dump.c
> +++ b/target/arm/arch_dump.c
> @@ -182,6 +182,7 @@ static int aarch64_write_elf64_sve(WriteCoreDumpFunction f,
>      struct aarch64_note *note;
>      ARMCPU *cpu = env_archcpu(env);
>      uint32_t vq = sve_current_vq(env);
> +    uint64_t tmp[ARM_MAX_VQ * 2], *r;
>      uint32_t fpr;
>      uint8_t *buf;
>      int ret, i;
> @@ -198,31 +199,14 @@ static int aarch64_write_elf64_sve(WriteCoreDumpFunction f,
>      note->sve.flags = cpu_to_dump16(s, 1);
>  
>      for (i = 0; i < 32; ++i) {
> -#ifdef HOST_WORDS_BIGENDIAN
> -        uint64_t d[vq * 2];
> -        int j;
> -
> -        for (j = 0; j < vq * 2; ++j) {
> -            d[j] = bswap64(env->vfp.zregs[i].d[j]);
> -        }
> -#else
> -        uint64_t *d = &env->vfp.zregs[i].d[0];
> -#endif
> -        memcpy(&buf[sve_zreg_offset(vq, i)], &d[0], vq * 16);
> +        r = sve_bswap64(tmp, &env->vfp.zregs[i].d[0], vq * 2);
> +        memcpy(&buf[sve_zreg_offset(vq, i)], r, vq * 16);
>      }
>  
>      for (i = 0; i < 17; ++i) {
> -#ifdef HOST_WORDS_BIGENDIAN
> -        uint64_t d[DIV_ROUND_UP(vq * 2, 8)];
> -        int j;
> -
> -        for (j = 0; j < DIV_ROUND_UP(vq * 2, 8); ++j) {
> -            d[j] = bswap64(env->vfp.pregs[i].p[j]);
> -        }
> -#else
> -        uint64_t *d = &env->vfp.pregs[i].p[0];
> -#endif
> -        memcpy(&buf[sve_preg_offset(vq, i)], &d[0], vq * 16 / 8);
> +        r = sve_bswap64(tmp, r = &env->vfp.pregs[i].p[0],
> +                        DIV_ROUND_UP(vq * 2, 8));
> +        memcpy(&buf[sve_preg_offset(vq, i)], r, vq * 16 / 8);
>      }
>  
>      fpr = cpu_to_dump32(s, vfp_get_fpsr(env));
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 5b9c3e4cd73d..b3092e5213e6 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -975,6 +975,31 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
>  void aarch64_sve_change_el(CPUARMState *env, int old_el,
>                             int new_el, bool el0_a64);
>  void aarch64_add_sve_properties(Object *obj);
> +
> +/*
> + * SVE registers are encoded in KVM's memory in an endianness-invariant format.
> + * The byte at offset i from the start of the in-memory representation contains
> + * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means the
> + * lowest offsets are stored in the lowest memory addresses, then that nearly
> + * matches QEMU's representation, which is to use an array of host-endian
> + * uint64_t's, where the lower offsets are at the lower indices. To complete
> + * the translation we just need to byte swap the uint64_t's on big-endian hosts.
> + */
> +static inline uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
> +{
> +#ifdef HOST_WORDS_BIGENDIAN
> +    int i;
> +
> +    for (i = 0; i < nr; ++i) {
> +        dst[i] = bswap64(src[i]);
> +    }
> +
> +    return dst;
> +#else
> +    return src;
> +#endif
> +}
> +
>  #else
>  static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
>  static inline void aarch64_sve_change_el(CPUARMState *env, int o,
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 876184b8fe4d..e2da756e65ed 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -876,30 +876,6 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
>      return 0;
>  }
>  
> -/*
> - * SVE registers are encoded in KVM's memory in an endianness-invariant format.
> - * The byte at offset i from the start of the in-memory representation contains
> - * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means the
> - * lowest offsets are stored in the lowest memory addresses, then that nearly
> - * matches QEMU's representation, which is to use an array of host-endian
> - * uint64_t's, where the lower offsets are at the lower indices. To complete
> - * the translation we just need to byte swap the uint64_t's on big-endian hosts.
> - */
> -static uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
> -{
> -#ifdef HOST_WORDS_BIGENDIAN
> -    int i;
> -
> -    for (i = 0; i < nr; ++i) {
> -        dst[i] = bswap64(src[i]);
> -    }
> -
> -    return dst;
> -#else
> -    return src;
> -#endif
> -}
> -
>  /*
>   * KVM SVE registers come in slices where ZREGs have a slice size of 2048 bits
>   * and PREGS and the FFR have a slice size of 256 bits. However we simply hard
> 


