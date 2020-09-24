Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CE4C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725222311A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFuMtyTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725222311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLM9E-0007T4-HJ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLM7W-0006Jz-SI
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLM7U-0003ON-PD
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600934208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5aPisZRYkpg1xYCI+zDsQZ0a3O3loihKLPNz4/XbhwI=;
 b=FFuMtyTFGdOBdplTGXZ9wE4ZOmKi/Gp5AlqxK5uGLn0mr0/MgWt+FYp1XRrQSPREXeaSYt
 f4t9q6D/vZbfMe0BVJ3mgHsjh4Mg2CZtyH5YWcqk8ztTaKb1apKu2lvwUQ00GR0Jm1DekU
 peUUvIRd2rd4lBE3m05hEBuOWY4S2+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-vJqQIELWPxuIOYSy5Z78xQ-1; Thu, 24 Sep 2020 03:56:46 -0400
X-MC-Unique: vJqQIELWPxuIOYSy5Z78xQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EACF5107AD65;
 Thu, 24 Sep 2020 07:56:44 +0000 (UTC)
Received: from [10.36.114.4] (ovpn-114-4.ams2.redhat.com [10.36.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B829D100238E;
 Thu, 24 Sep 2020 07:56:43 +0000 (UTC)
Subject: Re: [PATCH 6/8] softfloat: Implement float128_muladd
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200924012453.659757-1-richard.henderson@linaro.org>
 <20200924012453.659757-7-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <7045a238-b702-0031-735a-caa6d726e160@redhat.com>
Date: Thu, 24 Sep 2020 09:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924012453.659757-7-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: alex.bennee@linaro.org, bharata@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[...]

>  /*----------------------------------------------------------------------------
>  | Packs the sign `zSign', the exponent `zExp', and the significand formed
>  | by the concatenation of `zSig0' and `zSig1' into a quadruple-precision
> @@ -7205,6 +7253,312 @@ float128 float128_mul(float128 a, float128 b, float_status *status)
>  
>  }
>  

I do wonder if a type for Int256 would make sense - instead of manually
passing these arrays.

> +static void shortShift256Left(uint64_t p[4], unsigned count)
> +{
> +    int negcount = -count & 63;

That's the same as "64 - count", right? (which I find easier to get)

> +
> +    if (count == 0) {
> +        return;
> +    }
> +    g_assert(count < 64);
> +    p[0] = (p[0] << count) | (p[1] >> negcount);
> +    p[1] = (p[1] << count) | (p[2] >> negcount);
> +    p[2] = (p[2] << count) | (p[3] >> negcount);
> +    p[3] = (p[3] << count);
> +}
> +
> +static void shift256RightJamming(uint64_t p[4], int count)
> +{
> +    uint64_t in = 0;
> +
> +    g_assert(count >= 0);
> +
> +    count = MIN(count, 256);
> +    for (; count >= 64; count -= 64) {
> +        in |= p[3];
> +        p[3] = p[2];
> +        p[2] = p[1];
> +        p[1] = p[0];
> +        p[0] = 0;
> +    }
> +
> +    if (count) {
> +        int negcount = -count & 63;

dito

> +
> +        in |= p[3] << negcount;
> +        p[3] = (p[2] << negcount) | (p[3] >> count);
> +        p[2] = (p[1] << negcount) | (p[2] >> count);
> +        p[1] = (p[0] << negcount) | (p[1] >> count);
> +        p[0] = p[0] >> count;
> +    }
> +    p[3] |= (in != 0);

Took ma a bit longer to understand, but now I know why the function name
has "Jamming" in it :)

[...]

> +
> +float128 float128_muladd(float128 a_f, float128 b_f, float128 c_f,
> +                         int flags, float_status *status)
> +{
> +    bool inf_zero, p_sign, sign_flip;
> +    uint64_t p_frac[4];
> +    FloatParts128 a, b, c;
> +    int p_exp, exp_diff, shift, ab_mask, abc_mask;
> +    FloatClass p_cls;
> +
> +    float128_unpack(&a, a_f, status);
> +    float128_unpack(&b, b_f, status);
> +    float128_unpack(&c, c_f, status);
> +
> +    ab_mask = float_cmask(a.cls) | float_cmask(b.cls);
> +    abc_mask = float_cmask(c.cls) | ab_mask;
> +    inf_zero = ab_mask == float_cmask_infzero;
> +
> +    /* If any input is a NaN, select the required result. */
> +    if (unlikely(abc_mask & float_cmask_anynan)) {
> +        if (unlikely(abc_mask & float_cmask_snan)) {
> +            float_raise(float_flag_invalid, status);
> +        }
> +
> +        int which = pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, status);
> +        if (status->default_nan_mode) {
> +            which = 3;
> +        }
> +        switch (which) {
> +        case 0:
> +            break;
> +        case 1:
> +            a_f = b_f;
> +            a.cls = b.cls;
> +            break;
> +        case 2:
> +            a_f = c_f;
> +            a.cls = c.cls;
> +            break;
> +        case 3:
> +            return float128_default_nan(status);
> +        }
> +        if (is_snan(a.cls)) {
> +            return float128_silence_nan(a_f, status);
> +        }
> +        return a_f;
> +    }
> +
> +    /* After dealing with input NaNs, look for Inf * Zero. */
> +    if (unlikely(inf_zero)) {
> +        float_raise(float_flag_invalid, status);
> +        return float128_default_nan(status);
> +    }
> +
> +    p_sign = a.sign ^ b.sign;
> +
> +    if (flags & float_muladd_negate_c) {
> +        c.sign ^= 1;
> +    }
> +    if (flags & float_muladd_negate_product) {
> +        p_sign ^= 1;
> +    }
> +    sign_flip = (flags & float_muladd_negate_result);
> +
> +    if (ab_mask & float_cmask_inf) {
> +        p_cls = float_class_inf;
> +    } else if (ab_mask & float_cmask_zero) {
> +        p_cls = float_class_zero;
> +    } else {
> +        p_cls = float_class_normal;
> +    }
> +
> +    if (c.cls == float_class_inf) {
> +        if (p_cls == float_class_inf && p_sign != c.sign) {
> +            /* +Inf + -Inf = NaN */
> +            float_raise(float_flag_invalid, status);
> +            return float128_default_nan(status);
> +        }
> +        /* Inf + Inf = Inf of the proper sign; reuse the return below. */
> +        p_cls = float_class_inf;
> +        p_sign = c.sign;
> +    }
> +
> +    if (p_cls == float_class_inf) {
> +        return packFloat128(p_sign ^ sign_flip, 0x7fff, 0, 0);
> +    }
> +
> +    if (p_cls == float_class_zero) {
> +        if (c.cls == float_class_zero) {
> +            if (p_sign != c.sign) {
> +                p_sign = status->float_rounding_mode == float_round_down;
> +            }
> +            return packFloat128(p_sign ^ sign_flip, 0, 0, 0);
> +        }
> +
> +        if (flags & float_muladd_halve_result) {
> +            c.exp -= 1;
> +        }
> +        return roundAndPackFloat128(c.sign ^ sign_flip,
> +                                    c.exp + 0x3fff - 1,
> +                                    c.frac0, c.frac1, 0, status);
> +    }
> +
> +    /* a & b should be normals now... */
> +    assert(a.cls == float_class_normal && b.cls == float_class_normal);
> +
> +    /* Multiply of 2 113-bit numbers produces a 226-bit result.  */
> +    mul128To256(a.frac0, a.frac1, b.frac0, b.frac1,
> +                &p_frac[0], &p_frac[1], &p_frac[2], &p_frac[3]);
> +
> +    /* Realign the binary point at bit 48 of p_frac[0].  */
> +    shift = clz64(p_frac[0]) - 15;
> +    g_assert(shift == 15 || shift == 16);
> +    shortShift256Left(p_frac, shift);
> +    p_exp = a.exp + b.exp - (shift - 16);
> +    exp_diff = p_exp - c.exp;
> +
> +    uint64_t c_frac[4] = { c.frac0, c.frac1, 0, 0 };
> +
> +    /* Add or subtract C from the intermediate product. */
> +    if (c.cls == float_class_zero) {
> +        /* Fall through to rounding after addition (with zero). */
> +    } else if (p_sign != c.sign) {
> +        /* Subtraction */
> +        if (exp_diff < 0) {
> +            shift256RightJamming(p_frac, -exp_diff);
> +            sub256(p_frac, c_frac, p_frac);
> +            p_exp = c.exp;
> +            p_sign ^= 1;
> +        } else if (exp_diff > 0) {
> +            shift256RightJamming(c_frac, exp_diff);
> +            sub256(p_frac, p_frac, c_frac);
> +        } else {
> +            /* Low 128 bits of C are known to be zero. */
> +            sub128(p_frac[0], p_frac[1], c_frac[0], c_frac[1],
> +                   &p_frac[0], &p_frac[1]);
> +            /*
> +             * Since we have normalized to bit 48 of p_frac[0],
> +             * a negative result means C > P and we need to invert.
> +             */
> +            if ((int64_t)p_frac[0] < 0) {
> +                neg256(p_frac);
> +                p_sign ^= 1;
> +            }
> +        }
> +
> +        /*
> +         * Gross normalization of the 256-bit subtraction result.
> +         * Fine tuning below shared with addition.
> +         */
> +        if (p_frac[0] != 0) {
> +            /* nothing to do */
> +        } else if (p_frac[1] != 0) {
> +            p_exp -= 64;
> +            p_frac[0] = p_frac[1];
> +            p_frac[1] = p_frac[2];
> +            p_frac[2] = p_frac[3];
> +            p_frac[3] = 0;
> +        } else if (p_frac[2] != 0) {
> +            p_exp -= 128;
> +            p_frac[0] = p_frac[2];
> +            p_frac[1] = p_frac[3];
> +            p_frac[2] = 0;
> +            p_frac[3] = 0;
> +        } else if (p_frac[3] != 0) {
> +            p_exp -= 192;
> +            p_frac[0] = p_frac[3];
> +            p_frac[1] = 0;
> +            p_frac[2] = 0;
> +            p_frac[3] = 0;
> +        } else {
> +            /* Subtraction was exact: result is zero. */
> +            p_sign = status->float_rounding_mode == float_round_down;
> +            return packFloat128(p_sign ^ sign_flip, 0, 0, 0);
> +        }
> +    } else {
> +        /* Addition */
> +        if (exp_diff <= 0) {
> +            shift256RightJamming(p_frac, -exp_diff);
> +            /* Low 128 bits of C are known to be zero. */
> +            add128(p_frac[0], p_frac[1], c_frac[0], c_frac[1],
> +                   &p_frac[0], &p_frac[1]);
> +            p_exp = c.exp;
> +        } else {
> +            shift256RightJamming(c_frac, exp_diff);
> +            add256(p_frac, c_frac);
> +        }
> +    }
> +
> +    /* Fine normalization of the 256-bit result: p_frac[0] != 0. */
> +    shift = clz64(p_frac[0]) - 15;
> +    if (shift < 0) {
> +        shift256RightJamming(p_frac, -shift);
> +    } else if (shift > 0) {
> +        shortShift256Left(p_frac, shift);
> +    }
> +    p_exp -= shift;
> +
> +    if (flags & float_muladd_halve_result) {
> +        p_exp -= 1;
> +    }
> +    return roundAndPackFloat128(p_sign ^ sign_flip,
> +                                p_exp + 0x3fff - 1,
> +                                p_frac[0], p_frac[1],
> +                                p_frac[2] | (p_frac[3] != 0),
> +                                status);
> +}

Wow, that's a beast :)


-- 
Thanks,

David / dhildenb


